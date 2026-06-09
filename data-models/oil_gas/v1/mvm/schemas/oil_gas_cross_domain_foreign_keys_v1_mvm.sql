-- Cross-Domain Foreign Keys for Business: Oil Gas | Version: v1_mvm
-- Generated on: 2026-05-04 09:29:11
-- Total cross-domain FK constraints: 2073
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, commercial, compliance, customer, drilling, exploration, finance, hse, land, logistics, procurement, product, production, refining, reservoir, revenue, venture

-- ========= asset --> compliance (22 constraint(s)) =========
-- Requires: asset schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `oil_gas_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_regulatory_audit_id` FOREIGN KEY (`regulatory_audit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_audit`(`regulatory_audit_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `oil_gas_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= asset --> customer (6 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= asset --> exploration (1 constraint(s)) =========
-- Requires: asset schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);

-- ========= asset --> finance (37 constraint(s)) =========
-- Requires: asset schema, finance schema
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `oil_gas_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= asset --> hse (9 constraint(s)) =========
-- Requires: asset schema, hse schema
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_process_safety_event_id` FOREIGN KEY (`process_safety_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`process_safety_event`(`process_safety_event_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_process_safety_event_id` FOREIGN KEY (`process_safety_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`process_safety_event`(`process_safety_event_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_spill_event_id` FOREIGN KEY (`spill_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`spill_event`(`spill_event_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_process_safety_event_id` FOREIGN KEY (`process_safety_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`process_safety_event`(`process_safety_event_id`);

-- ========= asset --> land (9 constraint(s)) =========
-- Requires: asset schema, land schema
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_right_of_way_id` FOREIGN KEY (`right_of_way_id`) REFERENCES `oil_gas_ecm`.`land`.`right_of_way`(`right_of_way_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_right_of_way_id` FOREIGN KEY (`right_of_way_id`) REFERENCES `oil_gas_ecm`.`land`.`right_of_way`(`right_of_way_id`);

-- ========= asset --> procurement (19 constraint(s)) =========
-- Requires: asset schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= asset --> product (6 constraint(s)) =========
-- Requires: asset schema, product schema
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= asset --> production (7 constraint(s)) =========
-- Requires: asset schema, production schema
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);

-- ========= asset --> reservoir (1 constraint(s)) =========
-- Requires: asset schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);

-- ========= asset --> venture (3 constraint(s)) =========
-- Requires: asset schema, venture schema
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);

-- ========= commercial --> asset (11 constraint(s)) =========
-- Requires: commercial schema, asset schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);

-- ========= commercial --> compliance (10 constraint(s)) =========
-- Requires: commercial schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ADD CONSTRAINT `fk_commercial_credit_limit_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= commercial --> customer (14 constraint(s)) =========
-- Requires: commercial schema, customer schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `oil_gas_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_tertiary_sales_bill_to_party_account_id` FOREIGN KEY (`tertiary_sales_bill_to_party_account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);

-- ========= commercial --> drilling (1 constraint(s)) =========
-- Requires: commercial schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);

-- ========= commercial --> exploration (7 constraint(s)) =========
-- Requires: commercial schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_license_id` FOREIGN KEY (`license_id`) REFERENCES `oil_gas_ecm`.`exploration`.`license`(`license_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_license_id` FOREIGN KEY (`license_id`) REFERENCES `oil_gas_ecm`.`exploration`.`license`(`license_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_discovery_id` FOREIGN KEY (`discovery_id`) REFERENCES `oil_gas_ecm`.`exploration`.`discovery`(`discovery_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);

-- ========= commercial --> finance (14 constraint(s)) =========
-- Requires: commercial schema, finance schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ADD CONSTRAINT `fk_commercial_hedging_instrument_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ADD CONSTRAINT `fk_commercial_hedging_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` ADD CONSTRAINT `fk_commercial_portfolio_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= commercial --> hse (2 constraint(s)) =========
-- Requires: commercial schema, hse schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);

-- ========= commercial --> land (17 constraint(s)) =========
-- Requires: commercial schema, land schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_division_order_id` FOREIGN KEY (`division_order_id`) REFERENCES `oil_gas_ecm`.`land`.`division_order`(`division_order_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_division_order_id` FOREIGN KEY (`division_order_id`) REFERENCES `oil_gas_ecm`.`land`.`division_order`(`division_order_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);

-- ========= commercial --> logistics (4 constraint(s)) =========
-- Requires: commercial schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);

-- ========= commercial --> procurement (12 constraint(s)) =========
-- Requires: commercial schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_vendor_qualification_id` FOREIGN KEY (`vendor_qualification_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor_qualification`(`vendor_qualification_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_vendor_qualification_id` FOREIGN KEY (`vendor_qualification_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor_qualification`(`vendor_qualification_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= commercial --> product (17 constraint(s)) =========
-- Requires: commercial schema, product schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_refined_product_id` FOREIGN KEY (`refined_product_id`) REFERENCES `oil_gas_ecm`.`product`.`refined_product`(`refined_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ADD CONSTRAINT `fk_commercial_hedging_instrument_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);

-- ========= commercial --> production (2 constraint(s)) =========
-- Requires: commercial schema, production schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `oil_gas_ecm`.`production`.`forecast`(`forecast_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);

-- ========= commercial --> refining (1 constraint(s)) =========
-- Requires: commercial schema, refining schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);

-- ========= commercial --> venture (24 constraint(s)) =========
-- Requires: commercial schema, venture schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ADD CONSTRAINT `fk_commercial_hedging_instrument_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ADD CONSTRAINT `fk_commercial_hedging_instrument_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ADD CONSTRAINT `fk_commercial_hedging_transaction_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ADD CONSTRAINT `fk_commercial_hedging_transaction_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ADD CONSTRAINT `fk_commercial_credit_limit_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);

-- ========= compliance --> asset (21 constraint(s)) =========
-- Requires: compliance schema, asset schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `oil_gas_ecm`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`certification` ADD CONSTRAINT `fk_compliance_certification_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`certification` ADD CONSTRAINT `fk_compliance_certification_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= compliance --> customer (9 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`operating_license` ADD CONSTRAINT `fk_compliance_operating_license_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`certification` ADD CONSTRAINT `fk_compliance_certification_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`certification` ADD CONSTRAINT `fk_compliance_certification_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= compliance --> drilling (2 constraint(s)) =========
-- Requires: compliance schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);

-- ========= compliance --> finance (25 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`operating_license` ADD CONSTRAINT `fk_compliance_operating_license_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`operating_license` ADD CONSTRAINT `fk_compliance_operating_license_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`certification` ADD CONSTRAINT `fk_compliance_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`certification` ADD CONSTRAINT `fk_compliance_certification_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= compliance --> procurement (15 constraint(s)) =========
-- Requires: compliance schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`certification` ADD CONSTRAINT `fk_compliance_certification_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`certification` ADD CONSTRAINT `fk_compliance_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= compliance --> product (10 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= compliance --> production (1 constraint(s)) =========
-- Requires: compliance schema, production schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);

-- ========= customer --> commercial (3 constraint(s)) =========
-- Requires: customer schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_credit_limit_id` FOREIGN KEY (`credit_limit_id`) REFERENCES `oil_gas_ecm`.`commercial`.`credit_limit`(`credit_limit_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`credit_event` ADD CONSTRAINT `fk_customer_credit_event_credit_limit_id` FOREIGN KEY (`credit_limit_id`) REFERENCES `oil_gas_ecm`.`commercial`.`credit_limit`(`credit_limit_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);

-- ========= customer --> compliance (1 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`customer`.`delivery_point` ADD CONSTRAINT `fk_customer_delivery_point_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);

-- ========= customer --> exploration (8 constraint(s)) =========
-- Requires: customer schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_discovery_id` FOREIGN KEY (`discovery_id`) REFERENCES `oil_gas_ecm`.`exploration`.`discovery`(`discovery_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_license_id` FOREIGN KEY (`license_id`) REFERENCES `oil_gas_ecm`.`exploration`.`license`(`license_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_term_contract` ADD CONSTRAINT `fk_customer_customer_term_contract_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_term_contract` ADD CONSTRAINT `fk_customer_customer_term_contract_discovery_id` FOREIGN KEY (`discovery_id`) REFERENCES `oil_gas_ecm`.`exploration`.`discovery`(`discovery_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_term_contract` ADD CONSTRAINT `fk_customer_customer_term_contract_license_id` FOREIGN KEY (`license_id`) REFERENCES `oil_gas_ecm`.`exploration`.`license`(`license_id`);

-- ========= customer --> finance (15 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `oil_gas_ecm`.`customer`.`counterparty` ADD CONSTRAINT `fk_customer_counterparty_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`delivery_point` ADD CONSTRAINT `fk_customer_delivery_point_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`delivery_point` ADD CONSTRAINT `fk_customer_delivery_point_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`credit_event` ADD CONSTRAINT `fk_customer_credit_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_term_contract` ADD CONSTRAINT `fk_customer_customer_term_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_term_contract` ADD CONSTRAINT `fk_customer_customer_term_contract_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= customer --> land (7 constraint(s)) =========
-- Requires: customer schema, land schema
ALTER TABLE `oil_gas_ecm`.`customer`.`counterparty` ADD CONSTRAINT `fk_customer_counterparty_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`delivery_point` ADD CONSTRAINT `fk_customer_delivery_point_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_term_contract` ADD CONSTRAINT `fk_customer_customer_term_contract_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);

-- ========= customer --> logistics (2 constraint(s)) =========
-- Requires: customer schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);

-- ========= customer --> procurement (6 constraint(s)) =========
-- Requires: customer schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`customer`.`counterparty` ADD CONSTRAINT `fk_customer_counterparty_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`delivery_point` ADD CONSTRAINT `fk_customer_delivery_point_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);

-- ========= customer --> product (8 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_certificate_of_quality_id` FOREIGN KEY (`certificate_of_quality_id`) REFERENCES `oil_gas_ecm`.`product`.`certificate_of_quality`(`certificate_of_quality_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_term_contract` ADD CONSTRAINT `fk_customer_customer_term_contract_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_term_contract` ADD CONSTRAINT `fk_customer_customer_term_contract_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_term_contract` ADD CONSTRAINT `fk_customer_customer_term_contract_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);

-- ========= customer --> reservoir (4 constraint(s)) =========
-- Requires: customer schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_production_forecast_id` FOREIGN KEY (`production_forecast_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`production_forecast`(`production_forecast_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_reserves_estimate_id` FOREIGN KEY (`reserves_estimate_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reserves_estimate`(`reserves_estimate_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_term_contract` ADD CONSTRAINT `fk_customer_customer_term_contract_development_plan_id` FOREIGN KEY (`development_plan_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`development_plan`(`development_plan_id`);

-- ========= customer --> venture (13 constraint(s)) =========
-- Requires: customer schema, venture schema
ALTER TABLE `oil_gas_ecm`.`customer`.`counterparty` ADD CONSTRAINT `fk_customer_counterparty_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`credit_event` ADD CONSTRAINT `fk_customer_credit_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`kyc_record` ADD CONSTRAINT `fk_customer_kyc_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);

-- ========= drilling --> asset (20 constraint(s)) =========
-- Requires: drilling schema, asset schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ADD CONSTRAINT `fk_drilling_rig_schedule_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ADD CONSTRAINT `fk_drilling_daily_drilling_report_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ADD CONSTRAINT `fk_drilling_bit_run_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ADD CONSTRAINT `fk_drilling_directional_survey_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ADD CONSTRAINT `fk_drilling_well_control_event_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= drilling --> commercial (1 constraint(s)) =========
-- Requires: drilling schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);

-- ========= drilling --> compliance (22 constraint(s)) =========
-- Requires: drilling schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `oil_gas_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ADD CONSTRAINT `fk_drilling_rig_schedule_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ADD CONSTRAINT `fk_drilling_directional_survey_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ADD CONSTRAINT `fk_drilling_well_control_event_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ADD CONSTRAINT `fk_drilling_well_control_event_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= drilling --> customer (5 constraint(s)) =========
-- Requires: drilling schema, customer schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= drilling --> exploration (10 constraint(s)) =========
-- Requires: drilling schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ADD CONSTRAINT `fk_drilling_daily_drilling_report_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ADD CONSTRAINT `fk_drilling_bit_run_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ADD CONSTRAINT `fk_drilling_casing_design_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);

-- ========= drilling --> finance (28 constraint(s)) =========
-- Requires: drilling schema, finance schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ADD CONSTRAINT `fk_drilling_rig_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ADD CONSTRAINT `fk_drilling_rig_schedule_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ADD CONSTRAINT `fk_drilling_daily_drilling_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ADD CONSTRAINT `fk_drilling_daily_drilling_report_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ADD CONSTRAINT `fk_drilling_well_control_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= drilling --> hse (8 constraint(s)) =========
-- Requires: drilling schema, hse schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ADD CONSTRAINT `fk_drilling_daily_drilling_report_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ADD CONSTRAINT `fk_drilling_daily_drilling_report_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ADD CONSTRAINT `fk_drilling_well_control_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ADD CONSTRAINT `fk_drilling_well_control_event_process_safety_event_id` FOREIGN KEY (`process_safety_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`process_safety_event`(`process_safety_event_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);

-- ========= drilling --> land (21 constraint(s)) =========
-- Requires: drilling schema, land schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_lease_acquisition_id` FOREIGN KEY (`lease_acquisition_id`) REFERENCES `oil_gas_ecm`.`land`.`lease_acquisition`(`lease_acquisition_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_lease_expiry_id` FOREIGN KEY (`lease_expiry_id`) REFERENCES `oil_gas_ecm`.`land`.`lease_expiry`(`lease_expiry_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_lease_expiry_id` FOREIGN KEY (`lease_expiry_id`) REFERENCES `oil_gas_ecm`.`land`.`lease_expiry`(`lease_expiry_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);

-- ========= drilling --> logistics (5 constraint(s)) =========
-- Requires: drilling schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ADD CONSTRAINT `fk_drilling_rig_schedule_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= drilling --> procurement (22 constraint(s)) =========
-- Requires: drilling schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ADD CONSTRAINT `fk_drilling_rig_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ADD CONSTRAINT `fk_drilling_daily_drilling_report_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ADD CONSTRAINT `fk_drilling_bit_run_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ADD CONSTRAINT `fk_drilling_bit_run_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ADD CONSTRAINT `fk_drilling_directional_survey_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= drilling --> product (8 constraint(s)) =========
-- Requires: drilling schema, product schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ADD CONSTRAINT `fk_drilling_casing_design_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= drilling --> refining (1 constraint(s)) =========
-- Requires: drilling schema, refining schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);

-- ========= drilling --> reservoir (16 constraint(s)) =========
-- Requires: drilling schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_development_plan_id` FOREIGN KEY (`development_plan_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`development_plan`(`development_plan_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_development_plan_id` FOREIGN KEY (`development_plan_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`development_plan`(`development_plan_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ADD CONSTRAINT `fk_drilling_daily_drilling_report_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ADD CONSTRAINT `fk_drilling_bit_run_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ADD CONSTRAINT `fk_drilling_directional_survey_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ADD CONSTRAINT `fk_drilling_well_control_event_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_well_test_id` FOREIGN KEY (`well_test_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`well_test`(`well_test_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_well_test_id` FOREIGN KEY (`well_test_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`well_test`(`well_test_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);

-- ========= drilling --> venture (6 constraint(s)) =========
-- Requires: drilling schema, venture schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);

-- ========= exploration --> asset (6 constraint(s)) =========
-- Requires: exploration schema, asset schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= exploration --> compliance (10 constraint(s)) =========
-- Requires: exploration schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ADD CONSTRAINT `fk_exploration_basin_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ADD CONSTRAINT `fk_exploration_license_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ADD CONSTRAINT `fk_exploration_license_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);

-- ========= exploration --> drilling (2 constraint(s)) =========
-- Requires: exploration schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect_resource_estimate` ADD CONSTRAINT `fk_exploration_prospect_resource_estimate_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);

-- ========= exploration --> finance (20 constraint(s)) =========
-- Requires: exploration schema, finance schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ADD CONSTRAINT `fk_exploration_basin_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ADD CONSTRAINT `fk_exploration_license_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ADD CONSTRAINT `fk_exploration_license_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= exploration --> land (11 constraint(s)) =========
-- Requires: exploration schema, land schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ADD CONSTRAINT `fk_exploration_license_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ADD CONSTRAINT `fk_exploration_core_sample_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= exploration --> procurement (4 constraint(s)) =========
-- Requires: exploration schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ADD CONSTRAINT `fk_exploration_core_sample_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ADD CONSTRAINT `fk_exploration_core_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= exploration --> product (8 constraint(s)) =========
-- Requires: exploration schema, product schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ADD CONSTRAINT `fk_exploration_core_sample_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= exploration --> venture (16 constraint(s)) =========
-- Requires: exploration schema, venture schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ADD CONSTRAINT `fk_exploration_license_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_carried_interest_id` FOREIGN KEY (`carried_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`carried_interest`(`carried_interest_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);

-- ========= finance --> asset (8 constraint(s)) =========
-- Requires: finance schema, asset schema
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ADD CONSTRAINT `fk_finance_finance_afe_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ADD CONSTRAINT `fk_finance_project_economics_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ADD CONSTRAINT `fk_finance_impairment_assessment_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ADD CONSTRAINT `fk_finance_impairment_assessment_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= finance --> commercial (8 constraint(s)) =========
-- Requires: finance schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_hedging_transaction_id` FOREIGN KEY (`hedging_transaction_id`) REFERENCES `oil_gas_ecm`.`commercial`.`hedging_transaction`(`hedging_transaction_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_marketing_deal_id` FOREIGN KEY (`marketing_deal_id`) REFERENCES `oil_gas_ecm`.`commercial`.`marketing_deal`(`marketing_deal_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_lifting_program_id` FOREIGN KEY (`lifting_program_id`) REFERENCES `oil_gas_ecm`.`commercial`.`lifting_program`(`lifting_program_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_marketing_deal_id` FOREIGN KEY (`marketing_deal_id`) REFERENCES `oil_gas_ecm`.`commercial`.`marketing_deal`(`marketing_deal_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);

-- ========= finance --> drilling (3 constraint(s)) =========
-- Requires: finance schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);

-- ========= finance --> procurement (6 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ADD CONSTRAINT `fk_finance_afe_cost_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ADD CONSTRAINT `fk_finance_afe_cost_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ADD CONSTRAINT `fk_finance_afe_cost_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= finance --> venture (2 constraint(s)) =========
-- Requires: finance schema, venture schema
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);

-- ========= hse --> asset (27 constraint(s)) =========
-- Requires: hse schema, asset schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);

-- ========= hse --> compliance (25 constraint(s)) =========
-- Requires: hse schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_consent_order_id` FOREIGN KEY (`consent_order_id`) REFERENCES `oil_gas_ecm`.`compliance`.`consent_order`(`consent_order_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_regulatory_audit_id` FOREIGN KEY (`regulatory_audit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_audit`(`regulatory_audit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= hse --> customer (7 constraint(s)) =========
-- Requires: hse schema, customer schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);

-- ========= hse --> drilling (10 constraint(s)) =========
-- Requires: hse schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);

-- ========= hse --> exploration (12 constraint(s)) =========
-- Requires: hse schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_seismic_survey_id` FOREIGN KEY (`seismic_survey_id`) REFERENCES `oil_gas_ecm`.`exploration`.`seismic_survey`(`seismic_survey_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_seismic_survey_id` FOREIGN KEY (`seismic_survey_id`) REFERENCES `oil_gas_ecm`.`exploration`.`seismic_survey`(`seismic_survey_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_seismic_survey_id` FOREIGN KEY (`seismic_survey_id`) REFERENCES `oil_gas_ecm`.`exploration`.`seismic_survey`(`seismic_survey_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_seismic_survey_id` FOREIGN KEY (`seismic_survey_id`) REFERENCES `oil_gas_ecm`.`exploration`.`seismic_survey`(`seismic_survey_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_seismic_survey_id` FOREIGN KEY (`seismic_survey_id`) REFERENCES `oil_gas_ecm`.`exploration`.`seismic_survey`(`seismic_survey_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_seismic_survey_id` FOREIGN KEY (`seismic_survey_id`) REFERENCES `oil_gas_ecm`.`exploration`.`seismic_survey`(`seismic_survey_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);

-- ========= hse --> finance (72 constraint(s)) =========
-- Requires: hse schema, finance schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= hse --> land (14 constraint(s)) =========
-- Requires: hse schema, land schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_right_of_way_id` FOREIGN KEY (`right_of_way_id`) REFERENCES `oil_gas_ecm`.`land`.`right_of_way`(`right_of_way_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_right_of_way_id` FOREIGN KEY (`right_of_way_id`) REFERENCES `oil_gas_ecm`.`land`.`right_of_way`(`right_of_way_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);

-- ========= hse --> logistics (9 constraint(s)) =========
-- Requires: hse schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `oil_gas_ecm`.`logistics`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `oil_gas_ecm`.`logistics`.`voyage`(`voyage_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);

-- ========= hse --> procurement (10 constraint(s)) =========
-- Requires: hse schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= hse --> product (13 constraint(s)) =========
-- Requires: hse schema, product schema
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_refined_product_id` FOREIGN KEY (`refined_product_id`) REFERENCES `oil_gas_ecm`.`product`.`refined_product`(`refined_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_refined_product_id` FOREIGN KEY (`refined_product_id`) REFERENCES `oil_gas_ecm`.`product`.`refined_product`(`refined_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_refined_product_id` FOREIGN KEY (`refined_product_id`) REFERENCES `oil_gas_ecm`.`product`.`refined_product`(`refined_product_id`);

-- ========= hse --> production (9 constraint(s)) =========
-- Requires: hse schema, production schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_injection_well_id` FOREIGN KEY (`injection_well_id`) REFERENCES `oil_gas_ecm`.`production`.`injection_well`(`injection_well_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_injection_well_id` FOREIGN KEY (`injection_well_id`) REFERENCES `oil_gas_ecm`.`production`.`injection_well`(`injection_well_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);

-- ========= hse --> revenue (1 constraint(s)) =========
-- Requires: hse schema, revenue schema
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);

-- ========= hse --> venture (12 constraint(s)) =========
-- Requires: hse schema, venture schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_operating_committee_id` FOREIGN KEY (`operating_committee_id`) REFERENCES `oil_gas_ecm`.`venture`.`operating_committee`(`operating_committee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_operating_committee_id` FOREIGN KEY (`operating_committee_id`) REFERENCES `oil_gas_ecm`.`venture`.`operating_committee`(`operating_committee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_operating_committee_id` FOREIGN KEY (`operating_committee_id`) REFERENCES `oil_gas_ecm`.`venture`.`operating_committee`(`operating_committee_id`);

-- ========= land --> asset (3 constraint(s)) =========
-- Requires: land schema, asset schema
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ADD CONSTRAINT `fk_land_division_order_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ADD CONSTRAINT `fk_land_lease_expiry_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ADD CONSTRAINT `fk_land_interest_assignment_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= land --> commercial (1 constraint(s)) =========
-- Requires: land schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ADD CONSTRAINT `fk_land_royalty_disbursement_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);

-- ========= land --> compliance (3 constraint(s)) =========
-- Requires: land schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ADD CONSTRAINT `fk_land_operator_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);

-- ========= land --> drilling (1 constraint(s)) =========
-- Requires: land schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ADD CONSTRAINT `fk_land_interest_assignment_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);

-- ========= land --> exploration (6 constraint(s)) =========
-- Requires: land schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ADD CONSTRAINT `fk_land_tract_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ADD CONSTRAINT `fk_land_pooling_unit_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ADD CONSTRAINT `fk_land_pooling_unit_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);

-- ========= land --> finance (12 constraint(s)) =========
-- Requires: land schema, finance schema
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ADD CONSTRAINT `fk_land_mineral_right_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ADD CONSTRAINT `fk_land_tract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_owner` ADD CONSTRAINT `fk_land_royalty_owner_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ADD CONSTRAINT `fk_land_division_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ADD CONSTRAINT `fk_land_delay_rental_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ADD CONSTRAINT `fk_land_delay_rental_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ADD CONSTRAINT `fk_land_pooling_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= land --> procurement (9 constraint(s)) =========
-- Requires: land schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ADD CONSTRAINT `fk_land_tract_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ADD CONSTRAINT `fk_land_surface_use_agreement_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ADD CONSTRAINT `fk_land_surface_use_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ADD CONSTRAINT `fk_land_pooling_unit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= land --> product (4 constraint(s)) =========
-- Requires: land schema, product schema
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ADD CONSTRAINT `fk_land_mineral_right_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ADD CONSTRAINT `fk_land_division_order_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ADD CONSTRAINT `fk_land_royalty_disbursement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= land --> production (2 constraint(s)) =========
-- Requires: land schema, production schema
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ADD CONSTRAINT `fk_land_lease_expiry_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ADD CONSTRAINT `fk_land_royalty_disbursement_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);

-- ========= land --> venture (12 constraint(s)) =========
-- Requires: land schema, venture schema
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ADD CONSTRAINT `fk_land_division_order_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ADD CONSTRAINT `fk_land_division_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ADD CONSTRAINT `fk_land_land_working_interest_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ADD CONSTRAINT `fk_land_pooling_unit_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ADD CONSTRAINT `fk_land_pooling_unit_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ADD CONSTRAINT `fk_land_royalty_disbursement_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ADD CONSTRAINT `fk_land_royalty_disbursement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ADD CONSTRAINT `fk_land_interest_assignment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ADD CONSTRAINT `fk_land_interest_assignment_farmout_id` FOREIGN KEY (`farmout_id`) REFERENCES `oil_gas_ecm`.`venture`.`farmout`(`farmout_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`party` ADD CONSTRAINT `fk_land_party_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`operator` ADD CONSTRAINT `fk_land_operator_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);

-- ========= logistics --> asset (8 constraint(s)) =========
-- Requires: logistics schema, asset schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);

-- ========= logistics --> commercial (13 constraint(s)) =========
-- Requires: logistics schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);

-- ========= logistics --> compliance (11 constraint(s)) =========
-- Requires: logistics schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= logistics --> customer (19 constraint(s)) =========
-- Requires: logistics schema, customer schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_customer_term_contract_id` FOREIGN KEY (`customer_term_contract_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_term_contract`(`customer_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ADD CONSTRAINT `fk_logistics_shipping_schedule_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);

-- ========= logistics --> drilling (4 constraint(s)) =========
-- Requires: logistics schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);

-- ========= logistics --> exploration (2 constraint(s)) =========
-- Requires: logistics schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);

-- ========= logistics --> finance (21 constraint(s)) =========
-- Requires: logistics schema, finance schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ADD CONSTRAINT `fk_logistics_vessel_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ADD CONSTRAINT `fk_logistics_shipping_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ADD CONSTRAINT `fk_logistics_shipping_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= logistics --> hse (3 constraint(s)) =========
-- Requires: logistics schema, hse schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ADD CONSTRAINT `fk_logistics_vessel_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `oil_gas_ecm`.`hse`.`emission_source`(`emission_source_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `oil_gas_ecm`.`hse`.`emission_source`(`emission_source_id`);

-- ========= logistics --> land (10 constraint(s)) =========
-- Requires: logistics schema, land schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= logistics --> procurement (2 constraint(s)) =========
-- Requires: logistics schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);

-- ========= logistics --> product (22 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `oil_gas_ecm`.`product`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ADD CONSTRAINT `fk_logistics_vessel_safety_data_sheet_id` FOREIGN KEY (`safety_data_sheet_id`) REFERENCES `oil_gas_ecm`.`product`.`safety_data_sheet`(`safety_data_sheet_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);

-- ========= logistics --> production (6 constraint(s)) =========
-- Requires: logistics schema, production schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);

-- ========= logistics --> reservoir (7 constraint(s)) =========
-- Requires: logistics schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_eor_scheme_id` FOREIGN KEY (`eor_scheme_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`eor_scheme`(`eor_scheme_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_well_test_id` FOREIGN KEY (`well_test_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`well_test`(`well_test_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_production_forecast_id` FOREIGN KEY (`production_forecast_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`production_forecast`(`production_forecast_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);

-- ========= logistics --> revenue (5 constraint(s)) =========
-- Requires: logistics schema, revenue schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_revenue_allocation_id` FOREIGN KEY (`revenue_allocation_id`) REFERENCES `oil_gas_ecm`.`revenue`.`revenue_allocation`(`revenue_allocation_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_accrual_id` FOREIGN KEY (`accrual_id`) REFERENCES `oil_gas_ecm`.`revenue`.`accrual`(`accrual_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);

-- ========= logistics --> venture (21 constraint(s)) =========
-- Requires: logistics schema, venture schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_lifting_entitlement_id` FOREIGN KEY (`lifting_entitlement_id`) REFERENCES `oil_gas_ecm`.`venture`.`lifting_entitlement`(`lifting_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_overlift_underlift_id` FOREIGN KEY (`overlift_underlift_id`) REFERENCES `oil_gas_ecm`.`venture`.`overlift_underlift`(`overlift_underlift_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_lifting_entitlement_id` FOREIGN KEY (`lifting_entitlement_id`) REFERENCES `oil_gas_ecm`.`venture`.`lifting_entitlement`(`lifting_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_lifting_entitlement_id` FOREIGN KEY (`lifting_entitlement_id`) REFERENCES `oil_gas_ecm`.`venture`.`lifting_entitlement`(`lifting_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_overlift_underlift_id` FOREIGN KEY (`overlift_underlift_id`) REFERENCES `oil_gas_ecm`.`venture`.`overlift_underlift`(`overlift_underlift_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_lifting_entitlement_id` FOREIGN KEY (`lifting_entitlement_id`) REFERENCES `oil_gas_ecm`.`venture`.`lifting_entitlement`(`lifting_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_lifting_entitlement_id` FOREIGN KEY (`lifting_entitlement_id`) REFERENCES `oil_gas_ecm`.`venture`.`lifting_entitlement`(`lifting_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_lifting_entitlement_id` FOREIGN KEY (`lifting_entitlement_id`) REFERENCES `oil_gas_ecm`.`venture`.`lifting_entitlement`(`lifting_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);

-- ========= procurement --> asset (8 constraint(s)) =========
-- Requires: procurement schema, asset schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `oil_gas_ecm`.`asset`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_integrity_program_id` FOREIGN KEY (`integrity_program_id`) REFERENCES `oil_gas_ecm`.`asset`.`integrity_program`(`integrity_program_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= procurement --> drilling (3 constraint(s)) =========
-- Requires: procurement schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);

-- ========= procurement --> finance (13 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ADD CONSTRAINT `fk_procurement_afe_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ADD CONSTRAINT `fk_procurement_afe_budget_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= procurement --> hse (3 constraint(s)) =========
-- Requires: procurement schema, hse schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `oil_gas_ecm`.`hse`.`audit`(`audit_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);

-- ========= procurement --> logistics (5 constraint(s)) =========
-- Requires: procurement schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `oil_gas_ecm`.`logistics`.`voyage`(`voyage_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `oil_gas_ecm`.`logistics`.`voyage`(`voyage_id`);

-- ========= procurement --> product (5 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ADD CONSTRAINT `fk_procurement_material_master_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= procurement --> refining (6 constraint(s)) =========
-- Requires: procurement schema, refining schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);

-- ========= procurement --> venture (1 constraint(s)) =========
-- Requires: procurement schema, venture schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);

-- ========= product --> asset (5 constraint(s)) =========
-- Requires: product schema, asset schema
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);

-- ========= product --> compliance (1 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ADD CONSTRAINT `fk_product_safety_data_sheet_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);

-- ========= product --> finance (23 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ADD CONSTRAINT `fk_product_petroleum_product_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ADD CONSTRAINT `fk_product_petroleum_product_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ADD CONSTRAINT `fk_product_crude_grade_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ADD CONSTRAINT `fk_product_crude_grade_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ADD CONSTRAINT `fk_product_quality_spec_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ADD CONSTRAINT `fk_product_assay_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ADD CONSTRAINT `fk_product_assay_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ADD CONSTRAINT `fk_product_refined_product_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ADD CONSTRAINT `fk_product_refined_product_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ADD CONSTRAINT `fk_product_refined_product_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ADD CONSTRAINT `fk_product_refined_product_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ADD CONSTRAINT `fk_product_safety_data_sheet_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ADD CONSTRAINT `fk_product_price_history_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ADD CONSTRAINT `fk_product_price_history_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ADD CONSTRAINT `fk_product_price_history_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= product --> land (6 constraint(s)) =========
-- Requires: product schema, land schema
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ADD CONSTRAINT `fk_product_petroleum_product_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ADD CONSTRAINT `fk_product_crude_grade_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ADD CONSTRAINT `fk_product_assay_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= product --> procurement (9 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ADD CONSTRAINT `fk_product_crude_grade_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ADD CONSTRAINT `fk_product_quality_spec_vendor_qualification_id` FOREIGN KEY (`vendor_qualification_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor_qualification`(`vendor_qualification_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ADD CONSTRAINT `fk_product_assay_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ADD CONSTRAINT `fk_product_safety_data_sheet_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ADD CONSTRAINT `fk_product_safety_data_sheet_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= product --> venture (6 constraint(s)) =========
-- Requires: product schema, venture schema
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ADD CONSTRAINT `fk_product_refined_product_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ADD CONSTRAINT `fk_product_safety_data_sheet_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ADD CONSTRAINT `fk_product_price_history_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);

-- ========= production --> asset (9 constraint(s)) =========
-- Requires: production schema, asset schema
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);

-- ========= production --> commercial (8 constraint(s)) =========
-- Requires: production schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_lifting_program_id` FOREIGN KEY (`lifting_program_id`) REFERENCES `oil_gas_ecm`.`commercial`.`lifting_program`(`lifting_program_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_lifting_program_id` FOREIGN KEY (`lifting_program_id`) REFERENCES `oil_gas_ecm`.`commercial`.`lifting_program`(`lifting_program_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);

-- ========= production --> compliance (12 constraint(s)) =========
-- Requires: production schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`field` ADD CONSTRAINT `fk_production_field_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);

-- ========= production --> customer (12 constraint(s)) =========
-- Requires: production schema, customer schema
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_offtake_entitlement_id` FOREIGN KEY (`offtake_entitlement_id`) REFERENCES `oil_gas_ecm`.`customer`.`offtake_entitlement`(`offtake_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_customer_term_contract_id` FOREIGN KEY (`customer_term_contract_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_term_contract`(`customer_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_offtake_entitlement_id` FOREIGN KEY (`offtake_entitlement_id`) REFERENCES `oil_gas_ecm`.`customer`.`offtake_entitlement`(`offtake_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_customer_term_contract_id` FOREIGN KEY (`customer_term_contract_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_term_contract`(`customer_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_customer_lifting_schedule_id` FOREIGN KEY (`customer_lifting_schedule_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_lifting_schedule`(`customer_lifting_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);

-- ========= production --> drilling (7 constraint(s)) =========
-- Requires: production schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_completion_design_id` FOREIGN KEY (`completion_design_id`) REFERENCES `oil_gas_ecm`.`drilling`.`completion_design`(`completion_design_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_well_control_event_id` FOREIGN KEY (`well_control_event_id`) REFERENCES `oil_gas_ecm`.`drilling`.`well_control_event`(`well_control_event_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_well_control_event_id` FOREIGN KEY (`well_control_event_id`) REFERENCES `oil_gas_ecm`.`drilling`.`well_control_event`(`well_control_event_id`);

-- ========= production --> exploration (9 constraint(s)) =========
-- Requires: production schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_play_id` FOREIGN KEY (`play_id`) REFERENCES `oil_gas_ecm`.`exploration`.`play`(`play_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_discovery_id` FOREIGN KEY (`discovery_id`) REFERENCES `oil_gas_ecm`.`exploration`.`discovery`(`discovery_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_play_id` FOREIGN KEY (`play_id`) REFERENCES `oil_gas_ecm`.`exploration`.`play`(`play_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`field` ADD CONSTRAINT `fk_production_field_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`field` ADD CONSTRAINT `fk_production_field_play_id` FOREIGN KEY (`play_id`) REFERENCES `oil_gas_ecm`.`exploration`.`play`(`play_id`);

-- ========= production --> finance (38 constraint(s)) =========
-- Requires: production schema, finance schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`field` ADD CONSTRAINT `fk_production_field_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`field` ADD CONSTRAINT `fk_production_field_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= production --> hse (11 constraint(s)) =========
-- Requires: production schema, hse schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_process_safety_event_id` FOREIGN KEY (`process_safety_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`process_safety_event`(`process_safety_event_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_spill_event_id` FOREIGN KEY (`spill_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`spill_event`(`spill_event_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `oil_gas_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `oil_gas_ecm`.`hse`.`emission_source`(`emission_source_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `oil_gas_ecm`.`hse`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `oil_gas_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `oil_gas_ecm`.`hse`.`emission_source`(`emission_source_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`field` ADD CONSTRAINT `fk_production_field_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);

-- ========= production --> land (15 constraint(s)) =========
-- Requires: production schema, land schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_mineral_right_id` FOREIGN KEY (`mineral_right_id`) REFERENCES `oil_gas_ecm`.`land`.`mineral_right`(`mineral_right_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= production --> logistics (11 constraint(s)) =========
-- Requires: production schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_custody_transfer_id` FOREIGN KEY (`custody_transfer_id`) REFERENCES `oil_gas_ecm`.`logistics`.`custody_transfer`(`custody_transfer_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_custody_transfer_id` FOREIGN KEY (`custody_transfer_id`) REFERENCES `oil_gas_ecm`.`logistics`.`custody_transfer`(`custody_transfer_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_shipping_schedule_id` FOREIGN KEY (`shipping_schedule_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipping_schedule`(`shipping_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `oil_gas_ecm`.`logistics`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `oil_gas_ecm`.`logistics`.`measurement_point`(`measurement_point_id`);

-- ========= production --> procurement (19 constraint(s)) =========
-- Requires: production schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= production --> product (29 constraint(s)) =========
-- Requires: production schema, product schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_ngl_stream_id` FOREIGN KEY (`ngl_stream_id`) REFERENCES `oil_gas_ecm`.`product`.`ngl_stream`(`ngl_stream_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_ngl_stream_id` FOREIGN KEY (`ngl_stream_id`) REFERENCES `oil_gas_ecm`.`product`.`ngl_stream`(`ngl_stream_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_quality_test_result_id` FOREIGN KEY (`quality_test_result_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_test_result`(`quality_test_result_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_ngl_stream_id` FOREIGN KEY (`ngl_stream_id`) REFERENCES `oil_gas_ecm`.`product`.`ngl_stream`(`ngl_stream_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_ngl_stream_id` FOREIGN KEY (`ngl_stream_id`) REFERENCES `oil_gas_ecm`.`product`.`ngl_stream`(`ngl_stream_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_ngl_stream_id` FOREIGN KEY (`ngl_stream_id`) REFERENCES `oil_gas_ecm`.`product`.`ngl_stream`(`ngl_stream_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`field` ADD CONSTRAINT `fk_production_field_assay_id` FOREIGN KEY (`assay_id`) REFERENCES `oil_gas_ecm`.`product`.`assay`(`assay_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`field` ADD CONSTRAINT `fk_production_field_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);

-- ========= production --> reservoir (20 constraint(s)) =========
-- Requires: production schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_well_test_id` FOREIGN KEY (`well_test_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`well_test`(`well_test_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_well_test_id` FOREIGN KEY (`well_test_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`well_test`(`well_test_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_eor_scheme_id` FOREIGN KEY (`eor_scheme_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`eor_scheme`(`eor_scheme_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_eor_scheme_id` FOREIGN KEY (`eor_scheme_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`eor_scheme`(`eor_scheme_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_eor_scheme_id` FOREIGN KEY (`eor_scheme_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`eor_scheme`(`eor_scheme_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);

-- ========= production --> venture (37 constraint(s)) =========
-- Requires: production schema, venture schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_farmout_id` FOREIGN KEY (`farmout_id`) REFERENCES `oil_gas_ecm`.`venture`.`farmout`(`farmout_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_lifting_entitlement_id` FOREIGN KEY (`lifting_entitlement_id`) REFERENCES `oil_gas_ecm`.`venture`.`lifting_entitlement`(`lifting_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_lifting_entitlement_id` FOREIGN KEY (`lifting_entitlement_id`) REFERENCES `oil_gas_ecm`.`venture`.`lifting_entitlement`(`lifting_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);

-- ========= refining --> asset (16 constraint(s)) =========
-- Requires: refining schema, asset schema
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ADD CONSTRAINT `fk_refining_yield_record_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ADD CONSTRAINT `fk_refining_blending_recipe_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_failure_report_id` FOREIGN KEY (`failure_report_id`) REFERENCES `oil_gas_ecm`.`asset`.`failure_report`(`failure_report_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `oil_gas_ecm`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);

-- ========= refining --> commercial (13 constraint(s)) =========
-- Requires: refining schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ADD CONSTRAINT `fk_refining_tank_inventory_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_lifting_program_id` FOREIGN KEY (`lifting_program_id`) REFERENCES `oil_gas_ecm`.`commercial`.`lifting_program`(`lifting_program_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_trade_confirmation_id` FOREIGN KEY (`trade_confirmation_id`) REFERENCES `oil_gas_ecm`.`commercial`.`trade_confirmation`(`trade_confirmation_id`);

-- ========= refining --> compliance (16 constraint(s)) =========
-- Requires: refining schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `oil_gas_ecm`.`compliance`.`certification`(`certification_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ADD CONSTRAINT `fk_refining_blending_recipe_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_compliance_corrective_action_id` FOREIGN KEY (`compliance_corrective_action_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ADD CONSTRAINT `fk_refining_product_specification_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ADD CONSTRAINT `fk_refining_product_specification_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= refining --> customer (10 constraint(s)) =========
-- Requires: refining schema, customer schema
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ADD CONSTRAINT `fk_refining_tank_inventory_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_customer_lifting_schedule_id` FOREIGN KEY (`customer_lifting_schedule_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_lifting_schedule`(`customer_lifting_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_offtake_entitlement_id` FOREIGN KEY (`offtake_entitlement_id`) REFERENCES `oil_gas_ecm`.`customer`.`offtake_entitlement`(`offtake_entitlement_id`);

-- ========= refining --> drilling (1 constraint(s)) =========
-- Requires: refining schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ADD CONSTRAINT `fk_refining_crude_assay_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);

-- ========= refining --> exploration (1 constraint(s)) =========
-- Requires: refining schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_discovery_id` FOREIGN KEY (`discovery_id`) REFERENCES `oil_gas_ecm`.`exploration`.`discovery`(`discovery_id`);

-- ========= refining --> finance (22 constraint(s)) =========
-- Requires: refining schema, finance schema
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ADD CONSTRAINT `fk_refining_yield_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `oil_gas_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `oil_gas_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `oil_gas_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `oil_gas_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);

-- ========= refining --> hse (3 constraint(s)) =========
-- Requires: refining schema, hse schema
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_process_safety_event_id` FOREIGN KEY (`process_safety_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`process_safety_event`(`process_safety_event_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `oil_gas_ecm`.`hse`.`audit`(`audit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);

-- ========= refining --> land (3 constraint(s)) =========
-- Requires: refining schema, land schema
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ADD CONSTRAINT `fk_refining_crude_assay_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= refining --> logistics (17 constraint(s)) =========
-- Requires: refining schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_custody_transfer_id` FOREIGN KEY (`custody_transfer_id`) REFERENCES `oil_gas_ecm`.`logistics`.`custody_transfer`(`custody_transfer_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_logistics_lifting_schedule_id` FOREIGN KEY (`logistics_lifting_schedule_id`) REFERENCES `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule`(`logistics_lifting_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_custody_transfer_id` FOREIGN KEY (`custody_transfer_id`) REFERENCES `oil_gas_ecm`.`logistics`.`custody_transfer`(`custody_transfer_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `oil_gas_ecm`.`logistics`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= refining --> procurement (13 constraint(s)) =========
-- Requires: refining schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ADD CONSTRAINT `fk_refining_crude_assay_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ADD CONSTRAINT `fk_refining_blending_recipe_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= refining --> product (17 constraint(s)) =========
-- Requires: refining schema, product schema
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ADD CONSTRAINT `fk_refining_crude_assay_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ADD CONSTRAINT `fk_refining_yield_record_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ADD CONSTRAINT `fk_refining_blending_recipe_refined_product_id` FOREIGN KEY (`refined_product_id`) REFERENCES `oil_gas_ecm`.`product`.`refined_product`(`refined_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_certificate_of_quality_id` FOREIGN KEY (`certificate_of_quality_id`) REFERENCES `oil_gas_ecm`.`product`.`certificate_of_quality`(`certificate_of_quality_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_certificate_of_quality_id` FOREIGN KEY (`certificate_of_quality_id`) REFERENCES `oil_gas_ecm`.`product`.`certificate_of_quality`(`certificate_of_quality_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_certificate_of_quality_id` FOREIGN KEY (`certificate_of_quality_id`) REFERENCES `oil_gas_ecm`.`product`.`certificate_of_quality`(`certificate_of_quality_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_specification` ADD CONSTRAINT `fk_refining_product_specification_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);

-- ========= refining --> production (11 constraint(s)) =========
-- Requires: refining schema, production schema
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ADD CONSTRAINT `fk_refining_crude_assay_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ADD CONSTRAINT `fk_refining_crude_assay_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_run_ticket_id` FOREIGN KEY (`run_ticket_id`) REFERENCES `oil_gas_ecm`.`production`.`run_ticket`(`run_ticket_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);

-- ========= refining --> reservoir (6 constraint(s)) =========
-- Requires: refining schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ADD CONSTRAINT `fk_refining_crude_assay_pvt_analysis_id` FOREIGN KEY (`pvt_analysis_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`pvt_analysis`(`pvt_analysis_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ADD CONSTRAINT `fk_refining_crude_assay_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ADD CONSTRAINT `fk_refining_crude_assay_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_pvt_analysis_id` FOREIGN KEY (`pvt_analysis_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`pvt_analysis`(`pvt_analysis_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_pvt_analysis_id` FOREIGN KEY (`pvt_analysis_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`pvt_analysis`(`pvt_analysis_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);

-- ========= refining --> venture (17 constraint(s)) =========
-- Requires: refining schema, venture schema
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ADD CONSTRAINT `fk_refining_process_unit_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ADD CONSTRAINT `fk_refining_process_unit_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`yield_record` ADD CONSTRAINT `fk_refining_yield_record_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_operating_committee_id` FOREIGN KEY (`operating_committee_id`) REFERENCES `oil_gas_ecm`.`venture`.`operating_committee`(`operating_committee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_operating_committee_id` FOREIGN KEY (`operating_committee_id`) REFERENCES `oil_gas_ecm`.`venture`.`operating_committee`(`operating_committee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_venture_afe_id` FOREIGN KEY (`venture_afe_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_afe`(`venture_afe_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_jib_statement_id` FOREIGN KEY (`jib_statement_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_statement`(`jib_statement_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_lifting_entitlement_id` FOREIGN KEY (`lifting_entitlement_id`) REFERENCES `oil_gas_ecm`.`venture`.`lifting_entitlement`(`lifting_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);

-- ========= reservoir --> asset (15 constraint(s)) =========
-- Requires: reservoir schema, asset schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ADD CONSTRAINT `fk_reservoir_petrophysical_interp_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ADD CONSTRAINT `fk_reservoir_decline_curve_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);

-- ========= reservoir --> commercial (4 constraint(s)) =========
-- Requires: reservoir schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ADD CONSTRAINT `fk_reservoir_simulation_run_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_lifting_program_id` FOREIGN KEY (`lifting_program_id`) REFERENCES `oil_gas_ecm`.`commercial`.`lifting_program`(`lifting_program_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_marketing_deal_id` FOREIGN KEY (`marketing_deal_id`) REFERENCES `oil_gas_ecm`.`commercial`.`marketing_deal`(`marketing_deal_id`);

-- ========= reservoir --> compliance (8 constraint(s)) =========
-- Requires: reservoir schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ADD CONSTRAINT `fk_reservoir_reservoir_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);

-- ========= reservoir --> exploration (11 constraint(s)) =========
-- Requires: reservoir schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ADD CONSTRAINT `fk_reservoir_reservoir_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ADD CONSTRAINT `fk_reservoir_reservoir_play_id` FOREIGN KEY (`play_id`) REFERENCES `oil_gas_ecm`.`exploration`.`play`(`play_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ADD CONSTRAINT `fk_reservoir_zone_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ADD CONSTRAINT `fk_reservoir_volumetric_estimate_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ADD CONSTRAINT `fk_reservoir_petrophysical_interp_core_sample_id` FOREIGN KEY (`core_sample_id`) REFERENCES `oil_gas_ecm`.`exploration`.`core_sample`(`core_sample_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ADD CONSTRAINT `fk_reservoir_petrophysical_interp_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);

-- ========= reservoir --> finance (11 constraint(s)) =========
-- Requires: reservoir schema, finance schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ADD CONSTRAINT `fk_reservoir_reservoir_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ADD CONSTRAINT `fk_reservoir_volumetric_estimate_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ADD CONSTRAINT `fk_reservoir_simulation_run_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `oil_gas_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_actual_cost_id` FOREIGN KEY (`actual_cost_id`) REFERENCES `oil_gas_ecm`.`finance`.`actual_cost`(`actual_cost_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ADD CONSTRAINT `fk_reservoir_petrophysical_interp_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);

-- ========= reservoir --> hse (8 constraint(s)) =========
-- Requires: reservoir schema, hse schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_process_safety_event_id` FOREIGN KEY (`process_safety_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`process_safety_event`(`process_safety_event_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `oil_gas_ecm`.`hse`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);

-- ========= reservoir --> land (7 constraint(s)) =========
-- Requires: reservoir schema, land schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ADD CONSTRAINT `fk_reservoir_reservoir_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);

-- ========= reservoir --> procurement (13 constraint(s)) =========
-- Requires: reservoir schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_service_entry_sheet_id` FOREIGN KEY (`service_entry_sheet_id`) REFERENCES `oil_gas_ecm`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ADD CONSTRAINT `fk_reservoir_simulation_run_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ADD CONSTRAINT `fk_reservoir_simulation_run_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_service_entry_sheet_id` FOREIGN KEY (`service_entry_sheet_id`) REFERENCES `oil_gas_ecm`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ADD CONSTRAINT `fk_reservoir_petrophysical_interp_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ADD CONSTRAINT `fk_reservoir_decline_curve_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);

-- ========= reservoir --> product (7 constraint(s)) =========
-- Requires: reservoir schema, product schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_assay_id` FOREIGN KEY (`assay_id`) REFERENCES `oil_gas_ecm`.`product`.`assay`(`assay_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);

-- ========= reservoir --> production (1 constraint(s)) =========
-- Requires: reservoir schema, production schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_injection_well_id` FOREIGN KEY (`injection_well_id`) REFERENCES `oil_gas_ecm`.`production`.`injection_well`(`injection_well_id`);

-- ========= reservoir --> venture (12 constraint(s)) =========
-- Requires: reservoir schema, venture schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ADD CONSTRAINT `fk_reservoir_volumetric_estimate_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ADD CONSTRAINT `fk_reservoir_volumetric_estimate_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ADD CONSTRAINT `fk_reservoir_simulation_run_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);

-- ========= revenue --> asset (24 constraint(s)) =========
-- Requires: revenue schema, asset schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= revenue --> commercial (50 constraint(s)) =========
-- Requires: revenue schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_sales_order_line_id` FOREIGN KEY (`sales_order_line_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order_line`(`sales_order_line_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_lifting_program_id` FOREIGN KEY (`lifting_program_id`) REFERENCES `oil_gas_ecm`.`commercial`.`lifting_program`(`lifting_program_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_marketing_deal_id` FOREIGN KEY (`marketing_deal_id`) REFERENCES `oil_gas_ecm`.`commercial`.`marketing_deal`(`marketing_deal_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_trade_confirmation_id` FOREIGN KEY (`trade_confirmation_id`) REFERENCES `oil_gas_ecm`.`commercial`.`trade_confirmation`(`trade_confirmation_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_trade_confirmation_id` FOREIGN KEY (`trade_confirmation_id`) REFERENCES `oil_gas_ecm`.`commercial`.`trade_confirmation`(`trade_confirmation_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_lifting_program_id` FOREIGN KEY (`lifting_program_id`) REFERENCES `oil_gas_ecm`.`commercial`.`lifting_program`(`lifting_program_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_marketing_deal_id` FOREIGN KEY (`marketing_deal_id`) REFERENCES `oil_gas_ecm`.`commercial`.`marketing_deal`(`marketing_deal_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_trade_confirmation_id` FOREIGN KEY (`trade_confirmation_id`) REFERENCES `oil_gas_ecm`.`commercial`.`trade_confirmation`(`trade_confirmation_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_lifting_program_id` FOREIGN KEY (`lifting_program_id`) REFERENCES `oil_gas_ecm`.`commercial`.`lifting_program`(`lifting_program_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_marketing_deal_id` FOREIGN KEY (`marketing_deal_id`) REFERENCES `oil_gas_ecm`.`commercial`.`marketing_deal`(`marketing_deal_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);

-- ========= revenue --> compliance (11 constraint(s)) =========
-- Requires: revenue schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);

-- ========= revenue --> customer (23 constraint(s)) =========
-- Requires: revenue schema, customer schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_customer_lifting_schedule_id` FOREIGN KEY (`customer_lifting_schedule_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_lifting_schedule`(`customer_lifting_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_customer_term_contract_id` FOREIGN KEY (`customer_term_contract_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_term_contract`(`customer_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_offtake_entitlement_id` FOREIGN KEY (`offtake_entitlement_id`) REFERENCES `oil_gas_ecm`.`customer`.`offtake_entitlement`(`offtake_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_customer_term_contract_id` FOREIGN KEY (`customer_term_contract_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_term_contract`(`customer_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_customer_term_contract_id` FOREIGN KEY (`customer_term_contract_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_term_contract`(`customer_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_customer_term_contract_id` FOREIGN KEY (`customer_term_contract_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_term_contract`(`customer_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_customer_term_contract_id` FOREIGN KEY (`customer_term_contract_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_term_contract`(`customer_term_contract_id`);

-- ========= revenue --> drilling (5 constraint(s)) =========
-- Requires: revenue schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_well_status_history_id` FOREIGN KEY (`well_status_history_id`) REFERENCES `oil_gas_ecm`.`drilling`.`well_status_history`(`well_status_history_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);

-- ========= revenue --> exploration (9 constraint(s)) =========
-- Requires: revenue schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_discovery_id` FOREIGN KEY (`discovery_id`) REFERENCES `oil_gas_ecm`.`exploration`.`discovery`(`discovery_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_license_id` FOREIGN KEY (`license_id`) REFERENCES `oil_gas_ecm`.`exploration`.`license`(`license_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_license_id` FOREIGN KEY (`license_id`) REFERENCES `oil_gas_ecm`.`exploration`.`license`(`license_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_discovery_id` FOREIGN KEY (`discovery_id`) REFERENCES `oil_gas_ecm`.`exploration`.`discovery`(`discovery_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_license_id` FOREIGN KEY (`license_id`) REFERENCES `oil_gas_ecm`.`exploration`.`license`(`license_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_discovery_id` FOREIGN KEY (`discovery_id`) REFERENCES `oil_gas_ecm`.`exploration`.`discovery`(`discovery_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_license_id` FOREIGN KEY (`license_id`) REFERENCES `oil_gas_ecm`.`exploration`.`license`(`license_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_license_id` FOREIGN KEY (`license_id`) REFERENCES `oil_gas_ecm`.`exploration`.`license`(`license_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_license_id` FOREIGN KEY (`license_id`) REFERENCES `oil_gas_ecm`.`exploration`.`license`(`license_id`);

-- ========= revenue --> finance (34 constraint(s)) =========
-- Requires: revenue schema, finance schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `oil_gas_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `oil_gas_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `oil_gas_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= revenue --> land (21 constraint(s)) =========
-- Requires: revenue schema, land schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_division_order_id` FOREIGN KEY (`division_order_id`) REFERENCES `oil_gas_ecm`.`land`.`division_order`(`division_order_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);

-- ========= revenue --> procurement (1 constraint(s)) =========
-- Requires: revenue schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);

-- ========= revenue --> product (26 constraint(s)) =========
-- Requires: revenue schema, product schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_ngl_stream_id` FOREIGN KEY (`ngl_stream_id`) REFERENCES `oil_gas_ecm`.`product`.`ngl_stream`(`ngl_stream_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_refined_product_id` FOREIGN KEY (`refined_product_id`) REFERENCES `oil_gas_ecm`.`product`.`refined_product`(`refined_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_ngl_stream_id` FOREIGN KEY (`ngl_stream_id`) REFERENCES `oil_gas_ecm`.`product`.`ngl_stream`(`ngl_stream_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_quality_test_result_id` FOREIGN KEY (`quality_test_result_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_test_result`(`quality_test_result_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_refined_product_id` FOREIGN KEY (`refined_product_id`) REFERENCES `oil_gas_ecm`.`product`.`refined_product`(`refined_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_ngl_stream_id` FOREIGN KEY (`ngl_stream_id`) REFERENCES `oil_gas_ecm`.`product`.`ngl_stream`(`ngl_stream_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_ngl_stream_id` FOREIGN KEY (`ngl_stream_id`) REFERENCES `oil_gas_ecm`.`product`.`ngl_stream`(`ngl_stream_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_refined_product_id` FOREIGN KEY (`refined_product_id`) REFERENCES `oil_gas_ecm`.`product`.`refined_product`(`refined_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_ngl_stream_id` FOREIGN KEY (`ngl_stream_id`) REFERENCES `oil_gas_ecm`.`product`.`ngl_stream`(`ngl_stream_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_refined_product_id` FOREIGN KEY (`refined_product_id`) REFERENCES `oil_gas_ecm`.`product`.`refined_product`(`refined_product_id`);

-- ========= revenue --> production (13 constraint(s)) =========
-- Requires: revenue schema, production schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_run_ticket_id` FOREIGN KEY (`run_ticket_id`) REFERENCES `oil_gas_ecm`.`production`.`run_ticket`(`run_ticket_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_run_ticket_id` FOREIGN KEY (`run_ticket_id`) REFERENCES `oil_gas_ecm`.`production`.`run_ticket`(`run_ticket_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_gas_measurement_id` FOREIGN KEY (`gas_measurement_id`) REFERENCES `oil_gas_ecm`.`production`.`gas_measurement`(`gas_measurement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_run_ticket_id` FOREIGN KEY (`run_ticket_id`) REFERENCES `oil_gas_ecm`.`production`.`run_ticket`(`run_ticket_id`);

-- ========= revenue --> refining (15 constraint(s)) =========
-- Requires: revenue schema, refining schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_blend_event_id` FOREIGN KEY (`blend_event_id`) REFERENCES `oil_gas_ecm`.`refining`.`blend_event`(`blend_event_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_crude_receipt_id` FOREIGN KEY (`crude_receipt_id`) REFERENCES `oil_gas_ecm`.`refining`.`crude_receipt`(`crude_receipt_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_product_movement_id` FOREIGN KEY (`product_movement_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_movement`(`product_movement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_product_quality_test_id` FOREIGN KEY (`product_quality_test_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_quality_test`(`product_quality_test_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_tank_inventory_id` FOREIGN KEY (`tank_inventory_id`) REFERENCES `oil_gas_ecm`.`refining`.`tank_inventory`(`tank_inventory_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_unit_run_id` FOREIGN KEY (`unit_run_id`) REFERENCES `oil_gas_ecm`.`refining`.`unit_run`(`unit_run_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_crude_receipt_id` FOREIGN KEY (`crude_receipt_id`) REFERENCES `oil_gas_ecm`.`refining`.`crude_receipt`(`crude_receipt_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_product_quality_test_id` FOREIGN KEY (`product_quality_test_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_quality_test`(`product_quality_test_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_unit_run_id` FOREIGN KEY (`unit_run_id`) REFERENCES `oil_gas_ecm`.`refining`.`unit_run`(`unit_run_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_refinery_schedule_id` FOREIGN KEY (`refinery_schedule_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery_schedule`(`refinery_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_feedstock_blend_id` FOREIGN KEY (`feedstock_blend_id`) REFERENCES `oil_gas_ecm`.`refining`.`feedstock_blend`(`feedstock_blend_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_product_quality_test_id` FOREIGN KEY (`product_quality_test_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_quality_test`(`product_quality_test_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_unit_run_id` FOREIGN KEY (`unit_run_id`) REFERENCES `oil_gas_ecm`.`refining`.`unit_run`(`unit_run_id`);

-- ========= revenue --> reservoir (6 constraint(s)) =========
-- Requires: revenue schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_eor_scheme_id` FOREIGN KEY (`eor_scheme_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`eor_scheme`(`eor_scheme_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_reserves_estimate_id` FOREIGN KEY (`reserves_estimate_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reserves_estimate`(`reserves_estimate_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_production_forecast_id` FOREIGN KEY (`production_forecast_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`production_forecast`(`production_forecast_id`);

-- ========= revenue --> venture (23 constraint(s)) =========
-- Requires: revenue schema, venture schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_jib_statement_id` FOREIGN KEY (`jib_statement_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_statement`(`jib_statement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_jib_statement_id` FOREIGN KEY (`jib_statement_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_statement`(`jib_statement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_jib_statement_id` FOREIGN KEY (`jib_statement_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_statement`(`jib_statement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_jib_statement_id` FOREIGN KEY (`jib_statement_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_statement`(`jib_statement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_jib_statement_id` FOREIGN KEY (`jib_statement_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_statement`(`jib_statement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);

-- ========= venture --> asset (18 constraint(s)) =========
-- Requires: venture schema, asset schema
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);

-- ========= venture --> compliance (12 constraint(s)) =========
-- Requires: venture schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ADD CONSTRAINT `fk_venture_psa_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ADD CONSTRAINT `fk_venture_partner_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= venture --> exploration (9 constraint(s)) =========
-- Requires: venture schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ADD CONSTRAINT `fk_venture_afe_approval_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);

-- ========= venture --> finance (22 constraint(s)) =========
-- Requires: venture schema, finance schema
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ADD CONSTRAINT `fk_venture_psa_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ADD CONSTRAINT `fk_venture_partner_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_journal_entry_line_id` FOREIGN KEY (`journal_entry_line_id`) REFERENCES `oil_gas_ecm`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `oil_gas_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ADD CONSTRAINT `fk_venture_cash_call_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `oil_gas_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_actual_cost_id` FOREIGN KEY (`actual_cost_id`) REFERENCES `oil_gas_ecm`.`finance`.`actual_cost`(`actual_cost_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `oil_gas_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ADD CONSTRAINT `fk_venture_joint_venture_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= venture --> land (16 constraint(s)) =========
-- Requires: venture schema, land schema
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= venture --> procurement (13 constraint(s)) =========
-- Requires: venture schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);

-- ========= venture --> product (5 constraint(s)) =========
-- Requires: venture schema, product schema
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= venture --> production (6 constraint(s)) =========
-- Requires: venture schema, production schema
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_monthly_production_id` FOREIGN KEY (`monthly_production_id`) REFERENCES `oil_gas_ecm`.`production`.`monthly_production`(`monthly_production_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_monthly_production_id` FOREIGN KEY (`monthly_production_id`) REFERENCES `oil_gas_ecm`.`production`.`monthly_production`(`monthly_production_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`production`.`field`(`field_id`);

-- ========= venture --> reservoir (6 constraint(s)) =========
-- Requires: venture schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);

