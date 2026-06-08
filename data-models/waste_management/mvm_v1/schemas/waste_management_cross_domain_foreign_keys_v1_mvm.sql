-- Cross-Domain Foreign Keys for Business: Waste Management | Version: v1_mvm
-- Generated on: 2026-05-07 22:44:09
-- Total cross-domain FK constraints: 1131
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, collection, compliance, contract, customer, fleet, hazmat, landfill, maintenance, recycling, service

-- ========= asset --> billing (2 constraint(s)) =========
-- Requires: asset schema, billing schema
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project_expenditure` ADD CONSTRAINT `fk_asset_capital_project_expenditure_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= asset --> collection (3 constraint(s)) =========
-- Requires: asset schema, collection schema
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ADD CONSTRAINT `fk_asset_asset_container_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);

-- ========= asset --> compliance (8 constraint(s)) =========
-- Requires: asset schema, compliance schema
ALTER TABLE `waste_management_ecm`.`asset`.`class` ADD CONSTRAINT `fk_asset_class_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ADD CONSTRAINT `fk_asset_retirement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`retirement` ADD CONSTRAINT `fk_asset_retirement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ADD CONSTRAINT `fk_asset_asset_inspection_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ADD CONSTRAINT `fk_asset_asset_inspection_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ADD CONSTRAINT `fk_asset_asset_inspection_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`inspection_checklist` ADD CONSTRAINT `fk_asset_inspection_checklist_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= asset --> contract (4 constraint(s)) =========
-- Requires: asset schema, contract schema
ALTER TABLE `waste_management_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`lease` ADD CONSTRAINT `fk_asset_lease_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);

-- ========= asset --> customer (7 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `waste_management_ecm`.`asset`.`fixed_asset` ADD CONSTRAINT `fk_asset_fixed_asset_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ADD CONSTRAINT `fk_asset_asset_container_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ADD CONSTRAINT `fk_asset_asset_container_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ADD CONSTRAINT `fk_asset_asset_inspection_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);

-- ========= asset --> fleet (3 constraint(s)) =========
-- Requires: asset schema, fleet schema
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ADD CONSTRAINT `fk_asset_asset_container_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= asset --> hazmat (1 constraint(s)) =========
-- Requires: asset schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`asset`.`asset_container` ADD CONSTRAINT `fk_asset_asset_container_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);

-- ========= asset --> maintenance (3 constraint(s)) =========
-- Requires: asset schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`transfer` ADD CONSTRAINT `fk_asset_transfer_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`asset`.`asset_inspection` ADD CONSTRAINT `fk_asset_asset_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= billing --> asset (10 constraint(s)) =========
-- Requires: billing schema, asset schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ADD CONSTRAINT `fk_billing_surcharge_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= billing --> collection (40 constraint(s)) =========
-- Requires: billing schema, collection schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_container_placement_id` FOREIGN KEY (`container_placement_id`) REFERENCES `waste_management_ecm`.`collection`.`container_placement`(`container_placement_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_haul_manifest_id` FOREIGN KEY (`haul_manifest_id`) REFERENCES `waste_management_ecm`.`collection`.`haul_manifest`(`haul_manifest_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_load_ticket_id` FOREIGN KEY (`load_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`load_ticket`(`load_ticket_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_on_demand_request_id` FOREIGN KEY (`on_demand_request_id`) REFERENCES `waste_management_ecm`.`collection`.`on_demand_request`(`on_demand_request_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_outbound_haul_id` FOREIGN KEY (`outbound_haul_id`) REFERENCES `waste_management_ecm`.`collection`.`outbound_haul`(`outbound_haul_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_pickup_event_id` FOREIGN KEY (`pickup_event_id`) REFERENCES `waste_management_ecm`.`collection`.`pickup_event`(`pickup_event_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rolloff_order_id` FOREIGN KEY (`rolloff_order_id`) REFERENCES `waste_management_ecm`.`collection`.`rolloff_order`(`rolloff_order_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_scale_transaction_id` FOREIGN KEY (`scale_transaction_id`) REFERENCES `waste_management_ecm`.`collection`.`scale_transaction`(`scale_transaction_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_exception_id` FOREIGN KEY (`service_exception_id`) REFERENCES `waste_management_ecm`.`collection`.`service_exception`(`service_exception_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_schedule_id` FOREIGN KEY (`service_schedule_id`) REFERENCES `waste_management_ecm`.`collection`.`service_schedule`(`service_schedule_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_stop_id` FOREIGN KEY (`stop_id`) REFERENCES `waste_management_ecm`.`collection`.`stop`(`stop_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_tipping_fee_rate_id` FOREIGN KEY (`tipping_fee_rate_id`) REFERENCES `waste_management_ecm`.`collection`.`tipping_fee_rate`(`tipping_fee_rate_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_haul_manifest_id` FOREIGN KEY (`haul_manifest_id`) REFERENCES `waste_management_ecm`.`collection`.`haul_manifest`(`haul_manifest_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_load_ticket_id` FOREIGN KEY (`load_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`load_ticket`(`load_ticket_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_on_demand_request_id` FOREIGN KEY (`on_demand_request_id`) REFERENCES `waste_management_ecm`.`collection`.`on_demand_request`(`on_demand_request_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_pickup_event_id` FOREIGN KEY (`pickup_event_id`) REFERENCES `waste_management_ecm`.`collection`.`pickup_event`(`pickup_event_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_rolloff_order_id` FOREIGN KEY (`rolloff_order_id`) REFERENCES `waste_management_ecm`.`collection`.`rolloff_order`(`rolloff_order_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_service_exception_id` FOREIGN KEY (`service_exception_id`) REFERENCES `waste_management_ecm`.`collection`.`service_exception`(`service_exception_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_haul_manifest_id` FOREIGN KEY (`haul_manifest_id`) REFERENCES `waste_management_ecm`.`collection`.`haul_manifest`(`haul_manifest_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_load_ticket_id` FOREIGN KEY (`load_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`load_ticket`(`load_ticket_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_on_demand_request_id` FOREIGN KEY (`on_demand_request_id`) REFERENCES `waste_management_ecm`.`collection`.`on_demand_request`(`on_demand_request_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_pickup_event_id` FOREIGN KEY (`pickup_event_id`) REFERENCES `waste_management_ecm`.`collection`.`pickup_event`(`pickup_event_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_rolloff_order_id` FOREIGN KEY (`rolloff_order_id`) REFERENCES `waste_management_ecm`.`collection`.`rolloff_order`(`rolloff_order_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_stop_id` FOREIGN KEY (`stop_id`) REFERENCES `waste_management_ecm`.`collection`.`stop`(`stop_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_load_ticket_id` FOREIGN KEY (`load_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`load_ticket`(`load_ticket_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_on_demand_request_id` FOREIGN KEY (`on_demand_request_id`) REFERENCES `waste_management_ecm`.`collection`.`on_demand_request`(`on_demand_request_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_pickup_event_id` FOREIGN KEY (`pickup_event_id`) REFERENCES `waste_management_ecm`.`collection`.`pickup_event`(`pickup_event_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_rolloff_order_id` FOREIGN KEY (`rolloff_order_id`) REFERENCES `waste_management_ecm`.`collection`.`rolloff_order`(`rolloff_order_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_service_schedule_id` FOREIGN KEY (`service_schedule_id`) REFERENCES `waste_management_ecm`.`collection`.`service_schedule`(`service_schedule_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`weight_ticket`(`weight_ticket_id`);

-- ========= billing --> compliance (11 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ADD CONSTRAINT `fk_billing_surcharge_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ADD CONSTRAINT `fk_billing_surcharge_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ADD CONSTRAINT `fk_billing_tax_rule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= billing --> contract (22 constraint(s)) =========
-- Requires: billing schema, contract schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_amendment_id` FOREIGN KEY (`amendment_id`) REFERENCES `waste_management_ecm`.`contract`.`amendment`(`amendment_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_term_id` FOREIGN KEY (`billing_term_id`) REFERENCES `waste_management_ecm`.`contract`.`billing_term`(`billing_term_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `waste_management_ecm`.`contract`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `waste_management_ecm`.`contract`.`pricing`(`pricing_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `waste_management_ecm`.`contract`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `waste_management_ecm`.`contract`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `waste_management_ecm`.`contract`.`pricing`(`pricing_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_escalation_clause_id` FOREIGN KEY (`escalation_clause_id`) REFERENCES `waste_management_ecm`.`contract`.`escalation_clause`(`escalation_clause_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `waste_management_ecm`.`contract`.`pricing`(`pricing_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_billing_term_id` FOREIGN KEY (`billing_term_id`) REFERENCES `waste_management_ecm`.`contract`.`billing_term`(`billing_term_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `waste_management_ecm`.`contract`.`pricing`(`pricing_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_service_commitment_id` FOREIGN KEY (`service_commitment_id`) REFERENCES `waste_management_ecm`.`contract`.`service_commitment`(`service_commitment_id`);

-- ========= billing --> customer (19 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `waste_management_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `waste_management_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `waste_management_ecm`.`customer`.`complaint`(`complaint_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `waste_management_ecm`.`customer`.`service_request`(`service_request_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `waste_management_ecm`.`customer`.`complaint`(`complaint_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `waste_management_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `waste_management_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= billing --> fleet (7 constraint(s)) =========
-- Requires: billing schema, fleet schema
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_accident_report_id` FOREIGN KEY (`accident_report_id`) REFERENCES `waste_management_ecm`.`fleet`.`accident_report`(`accident_report_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_accident_report_id` FOREIGN KEY (`accident_report_id`) REFERENCES `waste_management_ecm`.`fleet`.`accident_report`(`accident_report_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= billing --> maintenance (4 constraint(s)) =========
-- Requires: billing schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_downtime_event_id` FOREIGN KEY (`downtime_event_id`) REFERENCES `waste_management_ecm`.`maintenance`.`downtime_event`(`downtime_event_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_downtime_event_id` FOREIGN KEY (`downtime_event_id`) REFERENCES `waste_management_ecm`.`maintenance`.`downtime_event`(`downtime_event_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= billing --> recycling (13 constraint(s)) =========
-- Requires: billing schema, recycling schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_commodity_sale_id` FOREIGN KEY (`commodity_sale_id`) REFERENCES `waste_management_ecm`.`recycling`.`commodity_sale`(`commodity_sale_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_program_id` FOREIGN KEY (`program_id`) REFERENCES `waste_management_ecm`.`recycling`.`program`(`program_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_bale_id` FOREIGN KEY (`bale_id`) REFERENCES `waste_management_ecm`.`recycling`.`bale`(`bale_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_inbound_load_id` FOREIGN KEY (`inbound_load_id`) REFERENCES `waste_management_ecm`.`recycling`.`inbound_load`(`inbound_load_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_outbound_shipment_id` FOREIGN KEY (`outbound_shipment_id`) REFERENCES `waste_management_ecm`.`recycling`.`outbound_shipment`(`outbound_shipment_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_program_id` FOREIGN KEY (`program_id`) REFERENCES `waste_management_ecm`.`recycling`.`program`(`program_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_residue_disposal_id` FOREIGN KEY (`residue_disposal_id`) REFERENCES `waste_management_ecm`.`recycling`.`residue_disposal`(`residue_disposal_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_mrf_facility_id` FOREIGN KEY (`mrf_facility_id`) REFERENCES `waste_management_ecm`.`recycling`.`mrf_facility`(`mrf_facility_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_program_id` FOREIGN KEY (`program_id`) REFERENCES `waste_management_ecm`.`recycling`.`program`(`program_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_commodity_sale_id` FOREIGN KEY (`commodity_sale_id`) REFERENCES `waste_management_ecm`.`recycling`.`commodity_sale`(`commodity_sale_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_contamination_event_id` FOREIGN KEY (`contamination_event_id`) REFERENCES `waste_management_ecm`.`recycling`.`contamination_event`(`contamination_event_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_inbound_load_id` FOREIGN KEY (`inbound_load_id`) REFERENCES `waste_management_ecm`.`recycling`.`inbound_load`(`inbound_load_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_program_id` FOREIGN KEY (`program_id`) REFERENCES `waste_management_ecm`.`recycling`.`program`(`program_id`);

-- ========= billing --> service (32 constraint(s)) =========
-- Requires: billing schema, service schema
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `waste_management_ecm`.`service`.`bundle`(`bundle_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `waste_management_ecm`.`service`.`bundle`(`bundle_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_rate_schedule_id` FOREIGN KEY (`service_rate_schedule_id`) REFERENCES `waste_management_ecm`.`service`.`service_rate_schedule`(`service_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `waste_management_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ADD CONSTRAINT `fk_billing_billing_tipping_fee_schedule_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`run` ADD CONSTRAINT `fk_billing_run_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`run` ADD CONSTRAINT `fk_billing_run_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `waste_management_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `waste_management_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ADD CONSTRAINT `fk_billing_surcharge_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ADD CONSTRAINT `fk_billing_surcharge_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_service_rate_schedule_id` FOREIGN KEY (`service_rate_schedule_id`) REFERENCES `waste_management_ecm`.`service`.`service_rate_schedule`(`service_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ADD CONSTRAINT `fk_billing_tax_rule_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ADD CONSTRAINT `fk_billing_tax_rule_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `waste_management_ecm`.`service`.`bundle`(`bundle_id`);

-- ========= collection --> asset (20 constraint(s)) =========
-- Requires: collection schema, asset schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
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
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ADD CONSTRAINT `fk_collection_transfer_station_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ADD CONSTRAINT `fk_collection_facility_capacity_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ADD CONSTRAINT `fk_collection_destination_facility_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= collection --> compliance (31 constraint(s)) =========
-- Requires: collection schema, compliance schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_ehs_incident_id` FOREIGN KEY (`ehs_incident_id`) REFERENCES `waste_management_ecm`.`compliance`.`ehs_incident`(`ehs_incident_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_regulatory_corrective_action_id` FOREIGN KEY (`regulatory_corrective_action_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_corrective_action`(`regulatory_corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_training_certification_id` FOREIGN KEY (`training_certification_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_certification`(`training_certification_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`district` ADD CONSTRAINT `fk_collection_district_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ADD CONSTRAINT `fk_collection_transfer_station_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ADD CONSTRAINT `fk_collection_facility_capacity_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ADD CONSTRAINT `fk_collection_facility_capacity_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ADD CONSTRAINT `fk_collection_destination_facility_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);

-- ========= collection --> contract (22 constraint(s)) =========
-- Requires: collection schema, contract schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_service_commitment_id` FOREIGN KEY (`service_commitment_id`) REFERENCES `waste_management_ecm`.`contract`.`service_commitment`(`service_commitment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_service_commitment_id` FOREIGN KEY (`service_commitment_id`) REFERENCES `waste_management_ecm`.`contract`.`service_commitment`(`service_commitment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`facility_capacity` ADD CONSTRAINT `fk_collection_facility_capacity_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);

-- ========= collection --> customer (33 constraint(s)) =========
-- Requires: collection schema, customer schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `waste_management_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `waste_management_ecm`.`customer`.`complaint`(`complaint_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `waste_management_ecm`.`customer`.`service_request`(`service_request_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `waste_management_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `waste_management_ecm`.`customer`.`service_request`(`service_request_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `waste_management_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_service_request_id` FOREIGN KEY (`service_request_id`) REFERENCES `waste_management_ecm`.`customer`.`service_request`(`service_request_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `waste_management_ecm`.`customer`.`segment`(`segment_id`);

-- ========= collection --> fleet (33 constraint(s)) =========
-- Requires: collection schema, fleet schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_vehicle_class_id` FOREIGN KEY (`vehicle_class_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_class`(`vehicle_class_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_hos_log_id` FOREIGN KEY (`hos_log_id`) REFERENCES `waste_management_ecm`.`fleet`.`hos_log`(`hos_log_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_pre_post_trip_inspection_id` FOREIGN KEY (`pre_post_trip_inspection_id`) REFERENCES `waste_management_ecm`.`fleet`.`pre_post_trip_inspection`(`pre_post_trip_inspection_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ADD CONSTRAINT `fk_collection_truck_assignment_pre_post_trip_inspection_id` FOREIGN KEY (`pre_post_trip_inspection_id`) REFERENCES `waste_management_ecm`.`fleet`.`pre_post_trip_inspection`(`pre_post_trip_inspection_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ADD CONSTRAINT `fk_collection_truck_assignment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_vehicle_class_id` FOREIGN KEY (`vehicle_class_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_class`(`vehicle_class_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= collection --> hazmat (32 constraint(s)) =========
-- Requires: collection schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_dot_hazmat_classification_id` FOREIGN KEY (`dot_hazmat_classification_id`) REFERENCES `waste_management_ecm`.`hazmat`.`dot_hazmat_classification`(`dot_hazmat_classification_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_transporter_registration_id` FOREIGN KEY (`transporter_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`transporter_registration`(`transporter_registration_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_transporter_registration_id` FOREIGN KEY (`transporter_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`transporter_registration`(`transporter_registration_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_transporter_registration_id` FOREIGN KEY (`transporter_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`transporter_registration`(`transporter_registration_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ADD CONSTRAINT `fk_collection_destination_facility_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);

-- ========= collection --> landfill (20 constraint(s)) =========
-- Requires: collection schema, landfill schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_special_waste_approval_id` FOREIGN KEY (`special_waste_approval_id`) REFERENCES `waste_management_ecm`.`landfill`.`special_waste_approval`(`special_waste_approval_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_special_waste_approval_id` FOREIGN KEY (`special_waste_approval_id`) REFERENCES `waste_management_ecm`.`landfill`.`special_waste_approval`(`special_waste_approval_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_landfill_tipping_fee_schedule_id` FOREIGN KEY (`landfill_tipping_fee_schedule_id`) REFERENCES `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule`(`landfill_tipping_fee_schedule_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_landfill_tipping_fee_schedule_id` FOREIGN KEY (`landfill_tipping_fee_schedule_id`) REFERENCES `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule`(`landfill_tipping_fee_schedule_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_landfill_tipping_fee_schedule_id` FOREIGN KEY (`landfill_tipping_fee_schedule_id`) REFERENCES `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule`(`landfill_tipping_fee_schedule_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_landfill_tipping_fee_schedule_id` FOREIGN KEY (`landfill_tipping_fee_schedule_id`) REFERENCES `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule`(`landfill_tipping_fee_schedule_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_special_waste_approval_id` FOREIGN KEY (`special_waste_approval_id`) REFERENCES `waste_management_ecm`.`landfill`.`special_waste_approval`(`special_waste_approval_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_special_waste_approval_id` FOREIGN KEY (`special_waste_approval_id`) REFERENCES `waste_management_ecm`.`landfill`.`special_waste_approval`(`special_waste_approval_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ADD CONSTRAINT `fk_collection_destination_facility_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);

-- ========= collection --> maintenance (6 constraint(s)) =========
-- Requires: collection schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`collection`.`route_execution` ADD CONSTRAINT `fk_collection_route_execution_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`truck_assignment` ADD CONSTRAINT `fk_collection_truck_assignment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= collection --> recycling (6 constraint(s)) =========
-- Requires: collection schema, recycling schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_mrf_facility_id` FOREIGN KEY (`mrf_facility_id`) REFERENCES `waste_management_ecm`.`recycling`.`mrf_facility`(`mrf_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_program_id` FOREIGN KEY (`program_id`) REFERENCES `waste_management_ecm`.`recycling`.`program`(`program_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_inbound_load_id` FOREIGN KEY (`inbound_load_id`) REFERENCES `waste_management_ecm`.`recycling`.`inbound_load`(`inbound_load_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`transfer_station` ADD CONSTRAINT `fk_collection_transfer_station_mrf_facility_id` FOREIGN KEY (`mrf_facility_id`) REFERENCES `waste_management_ecm`.`recycling`.`mrf_facility`(`mrf_facility_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_inbound_load_id` FOREIGN KEY (`inbound_load_id`) REFERENCES `waste_management_ecm`.`recycling`.`inbound_load`(`inbound_load_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_mrf_facility_id` FOREIGN KEY (`mrf_facility_id`) REFERENCES `waste_management_ecm`.`recycling`.`mrf_facility`(`mrf_facility_id`);

-- ========= collection --> service (34 constraint(s)) =========
-- Requires: collection schema, service schema
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `waste_management_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route` ADD CONSTRAINT `fk_collection_route_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`stop` ADD CONSTRAINT `fk_collection_stop_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`pickup_event` ADD CONSTRAINT `fk_collection_pickup_event_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_exception` ADD CONSTRAINT `fk_collection_service_exception_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `waste_management_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`container_placement` ADD CONSTRAINT `fk_collection_container_placement_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`driver_assignment` ADD CONSTRAINT `fk_collection_driver_assignment_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `waste_management_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`service_schedule` ADD CONSTRAINT `fk_collection_service_schedule_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ADD CONSTRAINT `fk_collection_route_optimization_run_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`route_optimization_run` ADD CONSTRAINT `fk_collection_route_optimization_run_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`on_demand_request` ADD CONSTRAINT `fk_collection_on_demand_request_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `waste_management_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`rolloff_order` ADD CONSTRAINT `fk_collection_rolloff_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`weight_ticket` ADD CONSTRAINT `fk_collection_weight_ticket_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`load_ticket` ADD CONSTRAINT `fk_collection_load_ticket_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`scale_transaction` ADD CONSTRAINT `fk_collection_scale_transaction_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`tipping_fee_rate` ADD CONSTRAINT `fk_collection_tipping_fee_rate_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`outbound_haul` ADD CONSTRAINT `fk_collection_outbound_haul_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`haul_manifest` ADD CONSTRAINT `fk_collection_haul_manifest_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`collection`.`destination_facility` ADD CONSTRAINT `fk_collection_destination_facility_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);

-- ========= compliance --> asset (20 constraint(s)) =========
-- Requires: compliance schema, asset schema
ALTER TABLE `waste_management_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ADD CONSTRAINT `fk_compliance_violation_notice_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`violation_notice` ADD CONSTRAINT `fk_compliance_violation_notice_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ADD CONSTRAINT `fk_compliance_regulatory_corrective_action_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ADD CONSTRAINT `fk_compliance_regulatory_corrective_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_corrective_action` ADD CONSTRAINT `fk_compliance_regulatory_corrective_action_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`environmental_monitoring` ADD CONSTRAINT `fk_compliance_environmental_monitoring_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ADD CONSTRAINT `fk_compliance_monitoring_station_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_station` ADD CONSTRAINT `fk_compliance_monitoring_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`regulated_facility` ADD CONSTRAINT `fk_compliance_regulated_facility_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`monitoring_program` ADD CONSTRAINT `fk_compliance_monitoring_program_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= compliance --> fleet (3 constraint(s)) =========
-- Requires: compliance schema, fleet schema
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= compliance --> hazmat (9 constraint(s)) =========
-- Requires: compliance schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_storage_unit_id` FOREIGN KEY (`storage_unit_id`) REFERENCES `waste_management_ecm`.`hazmat`.`storage_unit`(`storage_unit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`compliance_inspection` ADD CONSTRAINT `fk_compliance_compliance_inspection_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_disposal_record_id` FOREIGN KEY (`disposal_record_id`) REFERENCES `waste_management_ecm`.`hazmat`.`disposal_record`(`disposal_record_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `waste_management_ecm`.`hazmat`.`service_order`(`service_order_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_storage_unit_id` FOREIGN KEY (`storage_unit_id`) REFERENCES `waste_management_ecm`.`hazmat`.`storage_unit`(`storage_unit_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_treatment_record_id` FOREIGN KEY (`treatment_record_id`) REFERENCES `waste_management_ecm`.`hazmat`.`treatment_record`(`treatment_record_id`);
ALTER TABLE `waste_management_ecm`.`compliance`.`ehs_incident` ADD CONSTRAINT `fk_compliance_ehs_incident_waste_shipment_id` FOREIGN KEY (`waste_shipment_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_shipment`(`waste_shipment_id`);

-- ========= contract --> asset (10 constraint(s)) =========
-- Requires: contract schema, asset schema
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ADD CONSTRAINT `fk_contract_pricing_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ADD CONSTRAINT `fk_contract_sla_term_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_origin_facility_id` FOREIGN KEY (`origin_facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= contract --> billing (1 constraint(s)) =========
-- Requires: contract schema, billing schema
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ADD CONSTRAINT `fk_contract_rate_line_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);

-- ========= contract --> collection (1 constraint(s)) =========
-- Requires: contract schema, collection schema
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);

-- ========= contract --> compliance (21 constraint(s)) =========
-- Requires: contract schema, compliance schema
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ADD CONSTRAINT `fk_contract_pricing_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`escalation_clause` ADD CONSTRAINT `fk_contract_escalation_clause_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ADD CONSTRAINT `fk_contract_sla_term_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ADD CONSTRAINT `fk_contract_sla_term_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_monitoring_program_id` FOREIGN KEY (`monitoring_program_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_program`(`monitoring_program_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ADD CONSTRAINT `fk_contract_municipality_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= contract --> customer (12 constraint(s)) =========
-- Requires: contract schema, customer schema
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ADD CONSTRAINT `fk_contract_agreement_type_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `waste_management_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ADD CONSTRAINT `fk_contract_sla_term_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `waste_management_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `waste_management_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `waste_management_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `waste_management_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `waste_management_ecm`.`customer`.`contact`(`contact_id`);

-- ========= contract --> landfill (5 constraint(s)) =========
-- Requires: contract schema, landfill schema
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_disposal_permit_id` FOREIGN KEY (`disposal_permit_id`) REFERENCES `waste_management_ecm`.`landfill`.`disposal_permit`(`disposal_permit_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);

-- ========= contract --> service (27 constraint(s)) =========
-- Requires: contract schema, service schema
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `waste_management_ecm`.`service`.`bundle`(`bundle_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`contract` ADD CONSTRAINT `fk_contract_contract_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ADD CONSTRAINT `fk_contract_agreement_type_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`agreement_type` ADD CONSTRAINT `fk_contract_agreement_type_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `waste_management_ecm`.`service`.`bundle`(`bundle_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_service_rate_schedule_id` FOREIGN KEY (`service_rate_schedule_id`) REFERENCES `waste_management_ecm`.`service`.`service_rate_schedule`(`service_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`service_commitment` ADD CONSTRAINT `fk_contract_service_commitment_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ADD CONSTRAINT `fk_contract_pricing_service_rate_schedule_id` FOREIGN KEY (`service_rate_schedule_id`) REFERENCES `waste_management_ecm`.`service`.`service_rate_schedule`(`service_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`pricing` ADD CONSTRAINT `fk_contract_pricing_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ADD CONSTRAINT `fk_contract_rate_line_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`rate_line` ADD CONSTRAINT `fk_contract_rate_line_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`sla_term` ADD CONSTRAINT `fk_contract_sla_term_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `waste_management_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`amendment` ADD CONSTRAINT `fk_contract_amendment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`renewal` ADD CONSTRAINT `fk_contract_renewal_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`termination` ADD CONSTRAINT `fk_contract_termination_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`franchise_agreement` ADD CONSTRAINT `fk_contract_franchise_agreement_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_service_rate_schedule_id` FOREIGN KEY (`service_rate_schedule_id`) REFERENCES `waste_management_ecm`.`service`.`service_rate_schedule`(`service_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`disposal_agreement` ADD CONSTRAINT `fk_contract_disposal_agreement_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_service_rate_schedule_id` FOREIGN KEY (`service_rate_schedule_id`) REFERENCES `waste_management_ecm`.`service`.`service_rate_schedule`(`service_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`hauling_agreement` ADD CONSTRAINT `fk_contract_hauling_agreement_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`performance_obligation` ADD CONSTRAINT `fk_contract_performance_obligation_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`contract`.`municipality` ADD CONSTRAINT `fk_contract_municipality_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `waste_management_ecm`.`service`.`territory`(`territory_id`);

-- ========= customer --> asset (10 constraint(s)) =========
-- Requires: customer schema, asset schema
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);

-- ========= customer --> billing (8 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `waste_management_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `waste_management_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= customer --> collection (15 constraint(s)) =========
-- Requires: customer schema, collection schema
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_stop_id` FOREIGN KEY (`stop_id`) REFERENCES `waste_management_ecm`.`collection`.`stop`(`stop_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_pickup_event_id` FOREIGN KEY (`pickup_event_id`) REFERENCES `waste_management_ecm`.`collection`.`pickup_event`(`pickup_event_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_stop_id` FOREIGN KEY (`stop_id`) REFERENCES `waste_management_ecm`.`collection`.`stop`(`stop_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_on_demand_request_id` FOREIGN KEY (`on_demand_request_id`) REFERENCES `waste_management_ecm`.`collection`.`on_demand_request`(`on_demand_request_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_pickup_event_id` FOREIGN KEY (`pickup_event_id`) REFERENCES `waste_management_ecm`.`collection`.`pickup_event`(`pickup_event_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_rolloff_order_id` FOREIGN KEY (`rolloff_order_id`) REFERENCES `waste_management_ecm`.`collection`.`rolloff_order`(`rolloff_order_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_stop_id` FOREIGN KEY (`stop_id`) REFERENCES `waste_management_ecm`.`collection`.`stop`(`stop_id`);

-- ========= customer --> compliance (26 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `waste_management_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_training_requirement_id` FOREIGN KEY (`training_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_ehs_incident_id` FOREIGN KEY (`ehs_incident_id`) REFERENCES `waste_management_ecm`.`compliance`.`ehs_incident`(`ehs_incident_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_monitoring_program_id` FOREIGN KEY (`monitoring_program_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_program`(`monitoring_program_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_regulatory_corrective_action_id` FOREIGN KEY (`regulatory_corrective_action_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_corrective_action`(`regulatory_corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_training_requirement_id` FOREIGN KEY (`training_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_ehs_incident_id` FOREIGN KEY (`ehs_incident_id`) REFERENCES `waste_management_ecm`.`compliance`.`ehs_incident`(`ehs_incident_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_regulatory_corrective_action_id` FOREIGN KEY (`regulatory_corrective_action_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_corrective_action`(`regulatory_corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);

-- ========= customer --> contract (15 constraint(s)) =========
-- Requires: customer schema, contract schema
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_billing_term_id` FOREIGN KEY (`billing_term_id`) REFERENCES `waste_management_ecm`.`contract`.`billing_term`(`billing_term_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `waste_management_ecm`.`contract`.`pricing`(`pricing_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);

-- ========= customer --> fleet (5 constraint(s)) =========
-- Requires: customer schema, fleet schema
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_vehicle_class_id` FOREIGN KEY (`vehicle_class_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_class`(`vehicle_class_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= customer --> hazmat (17 constraint(s)) =========
-- Requires: customer schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `waste_management_ecm`.`hazmat`.`service_order`(`service_order_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_service_order_id` FOREIGN KEY (`service_order_id`) REFERENCES `waste_management_ecm`.`hazmat`.`service_order`(`service_order_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_waste_shipment_id` FOREIGN KEY (`waste_shipment_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_shipment`(`waste_shipment_id`);

-- ========= customer --> landfill (4 constraint(s)) =========
-- Requires: customer schema, landfill schema
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);

-- ========= customer --> maintenance (4 constraint(s)) =========
-- Requires: customer schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `waste_management_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= customer --> recycling (9 constraint(s)) =========
-- Requires: customer schema, recycling schema
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_mrf_facility_id` FOREIGN KEY (`mrf_facility_id`) REFERENCES `waste_management_ecm`.`recycling`.`mrf_facility`(`mrf_facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_program_id` FOREIGN KEY (`program_id`) REFERENCES `waste_management_ecm`.`recycling`.`program`(`program_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_mrf_facility_id` FOREIGN KEY (`mrf_facility_id`) REFERENCES `waste_management_ecm`.`recycling`.`mrf_facility`(`mrf_facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_program_id` FOREIGN KEY (`program_id`) REFERENCES `waste_management_ecm`.`recycling`.`program`(`program_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_inbound_load_id` FOREIGN KEY (`inbound_load_id`) REFERENCES `waste_management_ecm`.`recycling`.`inbound_load`(`inbound_load_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_mrf_facility_id` FOREIGN KEY (`mrf_facility_id`) REFERENCES `waste_management_ecm`.`recycling`.`mrf_facility`(`mrf_facility_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_program_id` FOREIGN KEY (`program_id`) REFERENCES `waste_management_ecm`.`recycling`.`program`(`program_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_program_id` FOREIGN KEY (`program_id`) REFERENCES `waste_management_ecm`.`recycling`.`program`(`program_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_contamination_event_id` FOREIGN KEY (`contamination_event_id`) REFERENCES `waste_management_ecm`.`recycling`.`contamination_event`(`contamination_event_id`);

-- ========= customer --> service (14 constraint(s)) =========
-- Requires: customer schema, service schema
ALTER TABLE `waste_management_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `waste_management_ecm`.`service`.`bundle`(`bundle_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_enrollment` ADD CONSTRAINT `fk_customer_service_enrollment_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `waste_management_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`service_request` ADD CONSTRAINT `fk_customer_service_request_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`container_assignment` ADD CONSTRAINT `fk_customer_container_assignment_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`waste_generator_profile` ADD CONSTRAINT `fk_customer_waste_generator_profile_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);

-- ========= fleet --> asset (10 constraint(s)) =========
-- Requires: fleet schema, asset schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ADD CONSTRAINT `fk_fleet_driver_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ADD CONSTRAINT `fk_fleet_dot_inspection_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);

-- ========= fleet --> collection (14 constraint(s)) =========
-- Requires: fleet schema, collection schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ADD CONSTRAINT `fk_fleet_driver_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`fuel_transaction` ADD CONSTRAINT `fk_fleet_fuel_transaction_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ADD CONSTRAINT `fk_fleet_dot_inspection_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`hos_log` ADD CONSTRAINT `fk_fleet_hos_log_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);

-- ========= fleet --> compliance (10 constraint(s)) =========
-- Requires: fleet schema, compliance schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_registration` ADD CONSTRAINT `fk_fleet_vehicle_registration_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ADD CONSTRAINT `fk_fleet_driver_training_certification_id` FOREIGN KEY (`training_certification_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_certification`(`training_certification_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ADD CONSTRAINT `fk_fleet_dot_inspection_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ADD CONSTRAINT `fk_fleet_dot_inspection_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_ehs_incident_id` FOREIGN KEY (`ehs_incident_id`) REFERENCES `waste_management_ecm`.`compliance`.`ehs_incident`(`ehs_incident_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ADD CONSTRAINT `fk_fleet_vehicle_class_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ADD CONSTRAINT `fk_fleet_vehicle_class_training_requirement_id` FOREIGN KEY (`training_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= fleet --> contract (12 constraint(s)) =========
-- Requires: fleet schema, contract schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_service_commitment_id` FOREIGN KEY (`service_commitment_id`) REFERENCES `waste_management_ecm`.`contract`.`service_commitment`(`service_commitment_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ADD CONSTRAINT `fk_fleet_dot_inspection_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ADD CONSTRAINT `fk_fleet_dot_inspection_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);

-- ========= fleet --> hazmat (7 constraint(s)) =========
-- Requires: fleet schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_transporter_registration_id` FOREIGN KEY (`transporter_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`transporter_registration`(`transporter_registration_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ADD CONSTRAINT `fk_fleet_dot_inspection_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ADD CONSTRAINT `fk_fleet_dot_inspection_waste_shipment_id` FOREIGN KEY (`waste_shipment_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_shipment`(`waste_shipment_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_waste_shipment_id` FOREIGN KEY (`waste_shipment_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_shipment`(`waste_shipment_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_waste_shipment_id` FOREIGN KEY (`waste_shipment_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_shipment`(`waste_shipment_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ADD CONSTRAINT `fk_fleet_vehicle_class_dot_hazmat_classification_id` FOREIGN KEY (`dot_hazmat_classification_id`) REFERENCES `waste_management_ecm`.`hazmat`.`dot_hazmat_classification`(`dot_hazmat_classification_id`);

-- ========= fleet --> landfill (3 constraint(s)) =========
-- Requires: fleet schema, landfill schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);

-- ========= fleet --> maintenance (9 constraint(s)) =========
-- Requires: fleet schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_failure_mode_id` FOREIGN KEY (`failure_mode_id`) REFERENCES `waste_management_ecm`.`maintenance`.`failure_mode`(`failure_mode_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ADD CONSTRAINT `fk_fleet_dot_inspection_failure_mode_id` FOREIGN KEY (`failure_mode_id`) REFERENCES `waste_management_ecm`.`maintenance`.`failure_mode`(`failure_mode_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`dot_inspection` ADD CONSTRAINT `fk_fleet_dot_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_failure_mode_id` FOREIGN KEY (`failure_mode_id`) REFERENCES `waste_management_ecm`.`maintenance`.`failure_mode`(`failure_mode_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`pre_post_trip_inspection` ADD CONSTRAINT `fk_fleet_pre_post_trip_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `waste_management_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_type_id` FOREIGN KEY (`type_id`) REFERENCES `waste_management_ecm`.`maintenance`.`type`(`type_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`maintenance_schedule` ADD CONSTRAINT `fk_fleet_maintenance_schedule_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= fleet --> recycling (4 constraint(s)) =========
-- Requires: fleet schema, recycling schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_mrf_facility_id` FOREIGN KEY (`mrf_facility_id`) REFERENCES `waste_management_ecm`.`recycling`.`mrf_facility`(`mrf_facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_program_id` FOREIGN KEY (`program_id`) REFERENCES `waste_management_ecm`.`recycling`.`program`(`program_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`telematics_event` ADD CONSTRAINT `fk_fleet_telematics_event_mrf_facility_id` FOREIGN KEY (`mrf_facility_id`) REFERENCES `waste_management_ecm`.`recycling`.`mrf_facility`(`mrf_facility_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_mrf_facility_id` FOREIGN KEY (`mrf_facility_id`) REFERENCES `waste_management_ecm`.`recycling`.`mrf_facility`(`mrf_facility_id`);

-- ========= fleet --> service (9 constraint(s)) =========
-- Requires: fleet schema, service schema
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle` ADD CONSTRAINT `fk_fleet_vehicle_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`driver` ADD CONSTRAINT `fk_fleet_driver_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_assignment` ADD CONSTRAINT `fk_fleet_vehicle_assignment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`accident_report` ADD CONSTRAINT `fk_fleet_accident_report_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ADD CONSTRAINT `fk_fleet_vehicle_class_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ADD CONSTRAINT `fk_fleet_vehicle_class_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`fleet`.`vehicle_class` ADD CONSTRAINT `fk_fleet_vehicle_class_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);

-- ========= hazmat --> asset (12 constraint(s)) =========
-- Requires: hazmat schema, asset schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ADD CONSTRAINT `fk_hazmat_hazardous_waste_generator_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_rfid_tag_id` FOREIGN KEY (`rfid_tag_id`) REFERENCES `waste_management_ecm`.`asset`.`rfid_tag`(`rfid_tag_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ADD CONSTRAINT `fk_hazmat_rcra_biennial_report_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ADD CONSTRAINT `fk_hazmat_storage_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ADD CONSTRAINT `fk_hazmat_storage_unit_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ADD CONSTRAINT `fk_hazmat_storage_unit_inspection_checklist_id` FOREIGN KEY (`inspection_checklist_id`) REFERENCES `waste_management_ecm`.`asset`.`inspection_checklist`(`inspection_checklist_id`);

-- ========= hazmat --> billing (11 constraint(s)) =========
-- Requires: hazmat schema, billing schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ADD CONSTRAINT `fk_hazmat_hazardous_waste_generator_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_billing_tipping_fee_schedule_id` FOREIGN KEY (`billing_tipping_fee_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule`(`billing_tipping_fee_schedule_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`dot_hazmat_classification` ADD CONSTRAINT `fk_hazmat_dot_hazmat_classification_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `waste_management_ecm`.`billing`.`surcharge`(`surcharge_id`);

-- ========= hazmat --> compliance (21 constraint(s)) =========
-- Requires: hazmat schema, compliance schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ADD CONSTRAINT `fk_hazmat_hazardous_waste_generator_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ADD CONSTRAINT `fk_hazmat_hazardous_waste_generator_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_monitoring_program_id` FOREIGN KEY (`monitoring_program_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_program`(`monitoring_program_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`tsdf_facility` ADD CONSTRAINT `fk_hazmat_tsdf_facility_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`treatment_record` ADD CONSTRAINT `fk_hazmat_treatment_record_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`epa_id_registration` ADD CONSTRAINT `fk_hazmat_epa_id_registration_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ADD CONSTRAINT `fk_hazmat_rcra_biennial_report_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ADD CONSTRAINT `fk_hazmat_rcra_biennial_report_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_code` ADD CONSTRAINT `fk_hazmat_waste_code_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ADD CONSTRAINT `fk_hazmat_storage_unit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= hazmat --> contract (9 constraint(s)) =========
-- Requires: hazmat schema, contract schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ADD CONSTRAINT `fk_hazmat_rcra_biennial_report_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`transporter_registration` ADD CONSTRAINT `fk_hazmat_transporter_registration_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);

-- ========= hazmat --> customer (3 constraint(s)) =========
-- Requires: hazmat schema, customer schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);

-- ========= hazmat --> fleet (7 constraint(s)) =========
-- Requires: hazmat schema, fleet schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ADD CONSTRAINT `fk_hazmat_chain_of_custody_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ADD CONSTRAINT `fk_hazmat_chain_of_custody_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= hazmat --> landfill (1 constraint(s)) =========
-- Requires: hazmat schema, landfill schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`disposal_record` ADD CONSTRAINT `fk_hazmat_disposal_record_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);

-- ========= hazmat --> service (12 constraint(s)) =========
-- Requires: hazmat schema, service schema
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazardous_waste_generator` ADD CONSTRAINT `fk_hazmat_hazardous_waste_generator_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_profile` ADD CONSTRAINT `fk_hazmat_waste_profile_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`manifest` ADD CONSTRAINT `fk_hazmat_manifest_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`hazmat_container` ADD CONSTRAINT `fk_hazmat_hazmat_container_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`waste_shipment` ADD CONSTRAINT `fk_hazmat_waste_shipment_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`chain_of_custody` ADD CONSTRAINT `fk_hazmat_chain_of_custody_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`service_order` ADD CONSTRAINT `fk_hazmat_service_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`rcra_biennial_report` ADD CONSTRAINT `fk_hazmat_rcra_biennial_report_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`hazmat`.`storage_unit` ADD CONSTRAINT `fk_hazmat_storage_unit_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);

-- ========= landfill --> asset (13 constraint(s)) =========
-- Requires: landfill schema, asset schema
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ADD CONSTRAINT `fk_landfill_site_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ADD CONSTRAINT `fk_landfill_site_site_epa_facility_id` FOREIGN KEY (`site_epa_facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ADD CONSTRAINT `fk_landfill_cell_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `waste_management_ecm`.`asset`.`capital_project`(`capital_project_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`cell` ADD CONSTRAINT `fk_landfill_cell_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ADD CONSTRAINT `fk_landfill_leachate_collection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ADD CONSTRAINT `fk_landfill_lfg_extraction_well_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ADD CONSTRAINT `fk_landfill_lfg_extraction_well_inspection_checklist_id` FOREIGN KEY (`inspection_checklist_id`) REFERENCES `waste_management_ecm`.`asset`.`inspection_checklist`(`inspection_checklist_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ADD CONSTRAINT `fk_landfill_groundwater_monitoring_well_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ADD CONSTRAINT `fk_landfill_groundwater_monitoring_well_inspection_checklist_id` FOREIGN KEY (`inspection_checklist_id`) REFERENCES `waste_management_ecm`.`asset`.`inspection_checklist`(`inspection_checklist_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ADD CONSTRAINT `fk_landfill_capacity_plan_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `waste_management_ecm`.`asset`.`capital_project`(`capital_project_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ADD CONSTRAINT `fk_landfill_closure_plan_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `waste_management_ecm`.`asset`.`capital_project`(`capital_project_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ADD CONSTRAINT `fk_landfill_collection_point_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` ADD CONSTRAINT `fk_landfill_monitoring_point_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);

-- ========= landfill --> billing (3 constraint(s)) =========
-- Requires: landfill schema, billing schema
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ADD CONSTRAINT `fk_landfill_site_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= landfill --> collection (2 constraint(s)) =========
-- Requires: landfill schema, collection schema
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `waste_management_ecm`.`collection`.`weight_ticket`(`weight_ticket_id`);

-- ========= landfill --> compliance (26 constraint(s)) =========
-- Requires: landfill schema, compliance schema
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ADD CONSTRAINT `fk_landfill_site_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`airspace_consumption` ADD CONSTRAINT `fk_landfill_airspace_consumption_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ADD CONSTRAINT `fk_landfill_leachate_collection_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ADD CONSTRAINT `fk_landfill_leachate_collection_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ADD CONSTRAINT `fk_landfill_lfg_extraction_well_monitoring_program_id` FOREIGN KEY (`monitoring_program_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_program`(`monitoring_program_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_extraction_well` ADD CONSTRAINT `fk_landfill_lfg_extraction_well_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ADD CONSTRAINT `fk_landfill_groundwater_monitoring_well_monitoring_program_id` FOREIGN KEY (`monitoring_program_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_program`(`monitoring_program_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_monitoring_well` ADD CONSTRAINT `fk_landfill_groundwater_monitoring_well_monitoring_station_id` FOREIGN KEY (`monitoring_station_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_station`(`monitoring_station_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`groundwater_sample` ADD CONSTRAINT `fk_landfill_groundwater_sample_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `waste_management_ecm`.`compliance`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ADD CONSTRAINT `fk_landfill_capacity_plan_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ADD CONSTRAINT `fk_landfill_capacity_plan_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`disposal_permit` ADD CONSTRAINT `fk_landfill_disposal_permit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ADD CONSTRAINT `fk_landfill_regulatory_inspection_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`regulatory_inspection` ADD CONSTRAINT `fk_landfill_regulatory_inspection_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ADD CONSTRAINT `fk_landfill_closure_plan_monitoring_program_id` FOREIGN KEY (`monitoring_program_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_program`(`monitoring_program_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`closure_plan` ADD CONSTRAINT `fk_landfill_closure_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ADD CONSTRAINT `fk_landfill_stormwater_event_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `waste_management_ecm`.`compliance`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ADD CONSTRAINT `fk_landfill_stormwater_event_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`stormwater_event` ADD CONSTRAINT `fk_landfill_stormwater_event_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`collection_point` ADD CONSTRAINT `fk_landfill_collection_point_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`monitoring_point` ADD CONSTRAINT `fk_landfill_monitoring_point_monitoring_program_id` FOREIGN KEY (`monitoring_program_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_program`(`monitoring_program_id`);

-- ========= landfill --> contract (8 constraint(s)) =========
-- Requires: landfill schema, contract schema
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ADD CONSTRAINT `fk_landfill_site_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ADD CONSTRAINT `fk_landfill_leachate_collection_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`capacity_plan` ADD CONSTRAINT `fk_landfill_capacity_plan_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ADD CONSTRAINT `fk_landfill_landfill_tipping_fee_schedule_pricing_id` FOREIGN KEY (`pricing_id`) REFERENCES `waste_management_ecm`.`contract`.`pricing`(`pricing_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);

-- ========= landfill --> customer (9 constraint(s)) =========
-- Requires: landfill schema, customer schema
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_waste_generator_profile_id` FOREIGN KEY (`waste_generator_profile_id`) REFERENCES `waste_management_ecm`.`customer`.`waste_generator_profile`(`waste_generator_profile_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ADD CONSTRAINT `fk_landfill_landfill_tipping_fee_schedule_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `waste_management_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_waste_generator_profile_id` FOREIGN KEY (`waste_generator_profile_id`) REFERENCES `waste_management_ecm`.`customer`.`waste_generator_profile`(`waste_generator_profile_id`);

-- ========= landfill --> fleet (4 constraint(s)) =========
-- Requires: landfill schema, fleet schema
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`daily_cover` ADD CONSTRAINT `fk_landfill_daily_cover_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);

-- ========= landfill --> hazmat (9 constraint(s)) =========
-- Requires: landfill schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`landfill`.`site` ADD CONSTRAINT `fk_landfill_site_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ADD CONSTRAINT `fk_landfill_leachate_collection_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`leachate_collection` ADD CONSTRAINT `fk_landfill_leachate_collection_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);

-- ========= landfill --> maintenance (1 constraint(s)) =========
-- Requires: landfill schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`landfill`.`lfg_monitoring` ADD CONSTRAINT `fk_landfill_lfg_monitoring_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= landfill --> service (5 constraint(s)) =========
-- Requires: landfill schema, service schema
ALTER TABLE `waste_management_ecm`.`landfill`.`tonnage_receipt` ADD CONSTRAINT `fk_landfill_tonnage_receipt_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ADD CONSTRAINT `fk_landfill_landfill_tipping_fee_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`landfill_tipping_fee_schedule` ADD CONSTRAINT `fk_landfill_landfill_tipping_fee_schedule_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`landfill`.`special_waste_approval` ADD CONSTRAINT `fk_landfill_special_waste_approval_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);

-- ========= maintenance --> asset (20 constraint(s)) =========
-- Requires: maintenance schema, asset schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_warranty_id` FOREIGN KEY (`warranty_id`) REFERENCES `waste_management_ecm`.`asset`.`warranty`(`warranty_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_inspection_checklist_id` FOREIGN KEY (`inspection_checklist_id`) REFERENCES `waste_management_ecm`.`asset`.`inspection_checklist`(`inspection_checklist_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`wo_task` ADD CONSTRAINT `fk_maintenance_wo_task_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`wo_task` ADD CONSTRAINT `fk_maintenance_wo_task_inspection_checklist_id` FOREIGN KEY (`inspection_checklist_id`) REFERENCES `waste_management_ecm`.`asset`.`inspection_checklist`(`inspection_checklist_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `waste_management_ecm`.`asset`.`bom`(`bom_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_warranty_id` FOREIGN KEY (`warranty_id`) REFERENCES `waste_management_ecm`.`asset`.`warranty`(`warranty_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`storeroom` ADD CONSTRAINT `fk_maintenance_storeroom_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`failure_mode` ADD CONSTRAINT `fk_maintenance_failure_mode_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`type` ADD CONSTRAINT `fk_maintenance_type_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);

-- ========= maintenance --> billing (2 constraint(s)) =========
-- Requires: maintenance schema, billing schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`wo_task` ADD CONSTRAINT `fk_maintenance_wo_task_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice_line`(`invoice_line_id`);

-- ========= maintenance --> collection (2 constraint(s)) =========
-- Requires: maintenance schema, collection schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);

-- ========= maintenance --> compliance (20 constraint(s)) =========
-- Requires: maintenance schema, compliance schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_regulatory_corrective_action_id` FOREIGN KEY (`regulatory_corrective_action_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_corrective_action`(`regulatory_corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_monitoring_program_id` FOREIGN KEY (`monitoring_program_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_program`(`monitoring_program_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`wo_task` ADD CONSTRAINT `fk_maintenance_wo_task_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `waste_management_ecm`.`compliance`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`wo_task` ADD CONSTRAINT `fk_maintenance_wo_task_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_regulatory_corrective_action_id` FOREIGN KEY (`regulatory_corrective_action_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_corrective_action`(`regulatory_corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_ehs_incident_id` FOREIGN KEY (`ehs_incident_id`) REFERENCES `waste_management_ecm`.`compliance`.`ehs_incident`(`ehs_incident_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_training_certification_id` FOREIGN KEY (`training_certification_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_certification`(`training_certification_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_catalog` ADD CONSTRAINT `fk_maintenance_parts_catalog_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_catalog` ADD CONSTRAINT `fk_maintenance_parts_catalog_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`storeroom` ADD CONSTRAINT `fk_maintenance_storeroom_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`failure_mode` ADD CONSTRAINT `fk_maintenance_failure_mode_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`type` ADD CONSTRAINT `fk_maintenance_type_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= maintenance --> contract (7 constraint(s)) =========
-- Requires: maintenance schema, contract schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_sla_term_id` FOREIGN KEY (`sla_term_id`) REFERENCES `waste_management_ecm`.`contract`.`sla_term`(`sla_term_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`storeroom` ADD CONSTRAINT `fk_maintenance_storeroom_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);

-- ========= maintenance --> customer (6 constraint(s)) =========
-- Requires: maintenance schema, customer schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `waste_management_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `waste_management_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_service_enrollment_id` FOREIGN KEY (`service_enrollment_id`) REFERENCES `waste_management_ecm`.`customer`.`service_enrollment`(`service_enrollment_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_waste_generator_profile_id` FOREIGN KEY (`waste_generator_profile_id`) REFERENCES `waste_management_ecm`.`customer`.`waste_generator_profile`(`waste_generator_profile_id`);

-- ========= maintenance --> fleet (10 constraint(s)) =========
-- Requires: maintenance schema, fleet schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_vehicle_class_id` FOREIGN KEY (`vehicle_class_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_class`(`vehicle_class_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`technician_assignment` ADD CONSTRAINT `fk_maintenance_technician_assignment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_catalog` ADD CONSTRAINT `fk_maintenance_parts_catalog_vehicle_class_id` FOREIGN KEY (`vehicle_class_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_class`(`vehicle_class_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`failure_mode` ADD CONSTRAINT `fk_maintenance_failure_mode_vehicle_class_id` FOREIGN KEY (`vehicle_class_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_class`(`vehicle_class_id`);

-- ========= maintenance --> hazmat (12 constraint(s)) =========
-- Requires: maintenance schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_hazardous_waste_generator_id` FOREIGN KEY (`hazardous_waste_generator_id`) REFERENCES `waste_management_ecm`.`hazmat`.`hazardous_waste_generator`(`hazardous_waste_generator_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`wo_task` ADD CONSTRAINT `fk_maintenance_wo_task_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_catalog` ADD CONSTRAINT `fk_maintenance_parts_catalog_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_catalog` ADD CONSTRAINT `fk_maintenance_parts_catalog_dot_hazmat_classification_id` FOREIGN KEY (`dot_hazmat_classification_id`) REFERENCES `waste_management_ecm`.`hazmat`.`dot_hazmat_classification`(`dot_hazmat_classification_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`storeroom` ADD CONSTRAINT `fk_maintenance_storeroom_storage_unit_id` FOREIGN KEY (`storage_unit_id`) REFERENCES `waste_management_ecm`.`hazmat`.`storage_unit`(`storage_unit_id`);

-- ========= maintenance --> landfill (17 constraint(s)) =========
-- Requires: maintenance schema, landfill schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_collection_point_id` FOREIGN KEY (`collection_point_id`) REFERENCES `waste_management_ecm`.`landfill`.`collection_point`(`collection_point_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_groundwater_monitoring_well_id` FOREIGN KEY (`groundwater_monitoring_well_id`) REFERENCES `waste_management_ecm`.`landfill`.`groundwater_monitoring_well`(`groundwater_monitoring_well_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_lfg_extraction_well_id` FOREIGN KEY (`lfg_extraction_well_id`) REFERENCES `waste_management_ecm`.`landfill`.`lfg_extraction_well`(`lfg_extraction_well_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_monitoring_point_id` FOREIGN KEY (`monitoring_point_id`) REFERENCES `waste_management_ecm`.`landfill`.`monitoring_point`(`monitoring_point_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`parts_usage` ADD CONSTRAINT `fk_maintenance_parts_usage_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_groundwater_monitoring_well_id` FOREIGN KEY (`groundwater_monitoring_well_id`) REFERENCES `waste_management_ecm`.`landfill`.`groundwater_monitoring_well`(`groundwater_monitoring_well_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_lfg_extraction_well_id` FOREIGN KEY (`lfg_extraction_well_id`) REFERENCES `waste_management_ecm`.`landfill`.`lfg_extraction_well`(`lfg_extraction_well_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_lfg_extraction_well_id` FOREIGN KEY (`lfg_extraction_well_id`) REFERENCES `waste_management_ecm`.`landfill`.`lfg_extraction_well`(`lfg_extraction_well_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_monitoring_point_id` FOREIGN KEY (`monitoring_point_id`) REFERENCES `waste_management_ecm`.`landfill`.`monitoring_point`(`monitoring_point_id`);

-- ========= maintenance --> recycling (2 constraint(s)) =========
-- Requires: maintenance schema, recycling schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_sort_line_id` FOREIGN KEY (`sort_line_id`) REFERENCES `waste_management_ecm`.`recycling`.`sort_line`(`sort_line_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_sort_session_id` FOREIGN KEY (`sort_session_id`) REFERENCES `waste_management_ecm`.`recycling`.`sort_session`(`sort_session_id`);

-- ========= maintenance --> service (8 constraint(s)) =========
-- Requires: maintenance schema, service schema
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `waste_management_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`repair_history` ADD CONSTRAINT `fk_maintenance_repair_history_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `waste_management_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `waste_management_ecm`.`maintenance`.`downtime_event` ADD CONSTRAINT `fk_maintenance_downtime_event_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `waste_management_ecm`.`service`.`sla_definition`(`sla_definition_id`);

-- ========= recycling --> asset (16 constraint(s)) =========
-- Requires: recycling schema, asset schema
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_facility` ADD CONSTRAINT `fk_recycling_mrf_facility_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_inspection_checklist_id` FOREIGN KEY (`inspection_checklist_id`) REFERENCES `waste_management_ecm`.`asset`.`inspection_checklist`(`inspection_checklist_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`bale` ADD CONSTRAINT `fk_recycling_bale_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`bale` ADD CONSTRAINT `fk_recycling_bale_location_id` FOREIGN KEY (`location_id`) REFERENCES `waste_management_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity_inventory` ADD CONSTRAINT `fk_recycling_commodity_inventory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_asset_container_id` FOREIGN KEY (`asset_container_id`) REFERENCES `waste_management_ecm`.`asset`.`asset_container`(`asset_container_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `waste_management_ecm`.`asset`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_inspection_checklist_id` FOREIGN KEY (`inspection_checklist_id`) REFERENCES `waste_management_ecm`.`asset`.`inspection_checklist`(`inspection_checklist_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`buyer_contract` ADD CONSTRAINT `fk_recycling_buyer_contract_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= recycling --> billing (2 constraint(s)) =========
-- Requires: recycling schema, billing schema
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_billing_tipping_fee_schedule_id` FOREIGN KEY (`billing_tipping_fee_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule`(`billing_tipping_fee_schedule_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);

-- ========= recycling --> collection (7 constraint(s)) =========
-- Requires: recycling schema, collection schema
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_transfer_station_id` FOREIGN KEY (`transfer_station_id`) REFERENCES `waste_management_ecm`.`collection`.`transfer_station`(`transfer_station_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_route_execution_id` FOREIGN KEY (`route_execution_id`) REFERENCES `waste_management_ecm`.`collection`.`route_execution`(`route_execution_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_stop_id` FOREIGN KEY (`stop_id`) REFERENCES `waste_management_ecm`.`collection`.`stop`(`stop_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_route_id` FOREIGN KEY (`route_id`) REFERENCES `waste_management_ecm`.`collection`.`route`(`route_id`);

-- ========= recycling --> compliance (21 constraint(s)) =========
-- Requires: recycling schema, compliance schema
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_facility` ADD CONSTRAINT `fk_recycling_mrf_facility_monitoring_program_id` FOREIGN KEY (`monitoring_program_id`) REFERENCES `waste_management_ecm`.`compliance`.`monitoring_program`(`monitoring_program_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_facility` ADD CONSTRAINT `fk_recycling_mrf_facility_regulated_facility_id` FOREIGN KEY (`regulated_facility_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulated_facility`(`regulated_facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity` ADD CONSTRAINT `fk_recycling_commodity_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_compliance_inspection_id` FOREIGN KEY (`compliance_inspection_id`) REFERENCES `waste_management_ecm`.`compliance`.`compliance_inspection`(`compliance_inspection_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_ehs_incident_id` FOREIGN KEY (`ehs_incident_id`) REFERENCES `waste_management_ecm`.`compliance`.`ehs_incident`(`ehs_incident_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_ehs_incident_id` FOREIGN KEY (`ehs_incident_id`) REFERENCES `waste_management_ecm`.`compliance`.`ehs_incident`(`ehs_incident_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_regulatory_corrective_action_id` FOREIGN KEY (`regulatory_corrective_action_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_corrective_action`(`regulatory_corrective_action_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `waste_management_ecm`.`compliance`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity_sale` ADD CONSTRAINT `fk_recycling_commodity_sale_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`buyer_contract` ADD CONSTRAINT `fk_recycling_buyer_contract_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`buyer_contract` ADD CONSTRAINT `fk_recycling_buyer_contract_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= recycling --> contract (8 constraint(s)) =========
-- Requires: recycling schema, contract schema
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_hauling_agreement_id` FOREIGN KEY (`hauling_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`hauling_agreement`(`hauling_agreement_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_disposal_agreement_id` FOREIGN KEY (`disposal_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`disposal_agreement`(`disposal_agreement_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`buyer_contract` ADD CONSTRAINT `fk_recycling_buyer_contract_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`buyer_contract` ADD CONSTRAINT `fk_recycling_buyer_contract_primary_buyer_salesforce_contract_id` FOREIGN KEY (`primary_buyer_salesforce_contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `waste_management_ecm`.`contract`.`contract`(`contract_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_franchise_agreement_id` FOREIGN KEY (`franchise_agreement_id`) REFERENCES `waste_management_ecm`.`contract`.`franchise_agreement`(`franchise_agreement_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_municipality_id` FOREIGN KEY (`municipality_id`) REFERENCES `waste_management_ecm`.`contract`.`municipality`(`municipality_id`);

-- ========= recycling --> customer (3 constraint(s)) =========
-- Requires: recycling schema, customer schema
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_waste_generator_profile_id` FOREIGN KEY (`waste_generator_profile_id`) REFERENCES `waste_management_ecm`.`customer`.`waste_generator_profile`(`waste_generator_profile_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `waste_management_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= recycling --> fleet (9 constraint(s)) =========
-- Requires: recycling schema, fleet schema
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_driver_id` FOREIGN KEY (`driver_id`) REFERENCES `waste_management_ecm`.`fleet`.`driver`(`driver_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle`(`vehicle_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_vehicle_assignment_id` FOREIGN KEY (`vehicle_assignment_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_assignment`(`vehicle_assignment_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_vehicle_class_id` FOREIGN KEY (`vehicle_class_id`) REFERENCES `waste_management_ecm`.`fleet`.`vehicle_class`(`vehicle_class_id`);

-- ========= recycling --> hazmat (16 constraint(s)) =========
-- Requires: recycling schema, hazmat schema
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity` ADD CONSTRAINT `fk_recycling_commodity_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_dot_hazmat_classification_id` FOREIGN KEY (`dot_hazmat_classification_id`) REFERENCES `waste_management_ecm`.`hazmat`.`dot_hazmat_classification`(`dot_hazmat_classification_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_epa_id_registration_id` FOREIGN KEY (`epa_id_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`epa_id_registration`(`epa_id_registration_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`bale` ADD CONSTRAINT `fk_recycling_bale_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_transporter_registration_id` FOREIGN KEY (`transporter_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`transporter_registration`(`transporter_registration_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`outbound_shipment` ADD CONSTRAINT `fk_recycling_outbound_shipment_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_manifest_id` FOREIGN KEY (`manifest_id`) REFERENCES `waste_management_ecm`.`hazmat`.`manifest`(`manifest_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_transporter_registration_id` FOREIGN KEY (`transporter_registration_id`) REFERENCES `waste_management_ecm`.`hazmat`.`transporter_registration`(`transporter_registration_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_tsdf_facility_id` FOREIGN KEY (`tsdf_facility_id`) REFERENCES `waste_management_ecm`.`hazmat`.`tsdf_facility`(`tsdf_facility_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_waste_code_id` FOREIGN KEY (`waste_code_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_code`(`waste_code_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_waste_profile_id` FOREIGN KEY (`waste_profile_id`) REFERENCES `waste_management_ecm`.`hazmat`.`waste_profile`(`waste_profile_id`);

-- ========= recycling --> landfill (5 constraint(s)) =========
-- Requires: recycling schema, landfill schema
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_special_waste_approval_id` FOREIGN KEY (`special_waste_approval_id`) REFERENCES `waste_management_ecm`.`landfill`.`special_waste_approval`(`special_waste_approval_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_cell_id` FOREIGN KEY (`cell_id`) REFERENCES `waste_management_ecm`.`landfill`.`cell`(`cell_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_site_id` FOREIGN KEY (`site_id`) REFERENCES `waste_management_ecm`.`landfill`.`site`(`site_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_special_waste_approval_id` FOREIGN KEY (`special_waste_approval_id`) REFERENCES `waste_management_ecm`.`landfill`.`special_waste_approval`(`special_waste_approval_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`residue_disposal` ADD CONSTRAINT `fk_recycling_residue_disposal_tonnage_receipt_id` FOREIGN KEY (`tonnage_receipt_id`) REFERENCES `waste_management_ecm`.`landfill`.`tonnage_receipt`(`tonnage_receipt_id`);

-- ========= recycling --> maintenance (4 constraint(s)) =========
-- Requires: recycling schema, maintenance schema
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `waste_management_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `waste_management_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`mrf_equipment` ADD CONSTRAINT `fk_recycling_mrf_equipment_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `waste_management_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);

-- ========= recycling --> service (12 constraint(s)) =========
-- Requires: recycling schema, service schema
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`inbound_load` ADD CONSTRAINT `fk_recycling_inbound_load_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_line` ADD CONSTRAINT `fk_recycling_sort_line_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`commodity` ADD CONSTRAINT `fk_recycling_commodity_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`sort_session` ADD CONSTRAINT `fk_recycling_sort_session_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`contamination_event` ADD CONSTRAINT `fk_recycling_contamination_event_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_area_id` FOREIGN KEY (`area_id`) REFERENCES `waste_management_ecm`.`service`.`area`(`area_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_container_type_id` FOREIGN KEY (`container_type_id`) REFERENCES `waste_management_ecm`.`service`.`container_type`(`container_type_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_frequency_plan_id` FOREIGN KEY (`frequency_plan_id`) REFERENCES `waste_management_ecm`.`service`.`frequency_plan`(`frequency_plan_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_line_id` FOREIGN KEY (`line_id`) REFERENCES `waste_management_ecm`.`service`.`line`(`line_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `waste_management_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `waste_management_ecm`.`recycling`.`program` ADD CONSTRAINT `fk_recycling_program_waste_stream_id` FOREIGN KEY (`waste_stream_id`) REFERENCES `waste_management_ecm`.`service`.`waste_stream`(`waste_stream_id`);

-- ========= service --> asset (10 constraint(s)) =========
-- Requires: service schema, asset schema
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_inspection_checklist_id` FOREIGN KEY (`inspection_checklist_id`) REFERENCES `waste_management_ecm`.`asset`.`inspection_checklist`(`inspection_checklist_id`);
ALTER TABLE `waste_management_ecm`.`service`.`code` ADD CONSTRAINT `fk_service_code_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ADD CONSTRAINT `fk_service_container_type_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ADD CONSTRAINT `fk_service_container_type_inspection_checklist_id` FOREIGN KEY (`inspection_checklist_id`) REFERENCES `waste_management_ecm`.`asset`.`inspection_checklist`(`inspection_checklist_id`);
ALTER TABLE `waste_management_ecm`.`service`.`bundle` ADD CONSTRAINT `fk_service_bundle_class_id` FOREIGN KEY (`class_id`) REFERENCES `waste_management_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ADD CONSTRAINT `fk_service_waste_stream_inspection_checklist_id` FOREIGN KEY (`inspection_checklist_id`) REFERENCES `waste_management_ecm`.`asset`.`inspection_checklist`(`inspection_checklist_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_primary_mrf_facility_id` FOREIGN KEY (`primary_mrf_facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `waste_management_ecm`.`asset`.`facility`(`facility_id`);

-- ========= service --> collection (2 constraint(s)) =========
-- Requires: service schema, collection schema
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_district_id` FOREIGN KEY (`district_id`) REFERENCES `waste_management_ecm`.`collection`.`district`(`district_id`);

-- ========= service --> compliance (13 constraint(s)) =========
-- Requires: service schema, compliance schema
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_training_requirement_id` FOREIGN KEY (`training_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);
ALTER TABLE `waste_management_ecm`.`service`.`code` ADD CONSTRAINT `fk_service_code_training_requirement_id` FOREIGN KEY (`training_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);
ALTER TABLE `waste_management_ecm`.`service`.`container_type` ADD CONSTRAINT `fk_service_container_type_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`service`.`frequency_plan` ADD CONSTRAINT `fk_service_frequency_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ADD CONSTRAINT `fk_service_waste_stream_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`service`.`waste_stream` ADD CONSTRAINT `fk_service_waste_stream_training_requirement_id` FOREIGN KEY (`training_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`training_requirement`(`training_requirement_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`service`.`area` ADD CONSTRAINT `fk_service_area_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `waste_management_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `waste_management_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `waste_management_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= service --> recycling (1 constraint(s)) =========
-- Requires: service schema, recycling schema
ALTER TABLE `waste_management_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `waste_management_ecm`.`recycling`.`commodity`(`commodity_id`);

