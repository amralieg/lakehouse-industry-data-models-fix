-- Cross-Domain Foreign Keys for Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:09
-- Total cross-domain FK constraints: 2412
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, commercial, compliance, customer, drilling, exploration, finance, hse, land, logistics, petrochemical, procurement, product, production, refining, reservoir, revenue, venture, workforce

-- ========= asset --> compliance (17 constraint(s)) =========
-- Requires: asset schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `oil_gas_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_ferc_tariff_id` FOREIGN KEY (`ferc_tariff_id`) REFERENCES `oil_gas_ecm`.`compliance`.`ferc_tariff`(`ferc_tariff_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_pipeline_safety_report_id` FOREIGN KEY (`pipeline_safety_report_id`) REFERENCES `oil_gas_ecm`.`compliance`.`pipeline_safety_report`(`pipeline_safety_report_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ADD CONSTRAINT `fk_asset_moc_request_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ADD CONSTRAINT `fk_asset_abandonment_plan_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ADD CONSTRAINT `fk_asset_abandonment_plan_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= asset --> customer (6 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ADD CONSTRAINT `fk_asset_moc_request_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ADD CONSTRAINT `fk_asset_transfer_event_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ADD CONSTRAINT `fk_asset_abandonment_plan_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);

-- ========= asset --> drilling (1 constraint(s)) =========
-- Requires: asset schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ADD CONSTRAINT `fk_asset_asset_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`drilling`.`operator`(`operator_id`);

-- ========= asset --> finance (23 constraint(s)) =========
-- Requires: asset schema, finance schema
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ADD CONSTRAINT `fk_asset_moc_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ADD CONSTRAINT `fk_asset_moc_request_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ADD CONSTRAINT `fk_asset_transfer_event_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ADD CONSTRAINT `fk_asset_abandonment_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ADD CONSTRAINT `fk_asset_abandonment_plan_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);

-- ========= asset --> land (2 constraint(s)) =========
-- Requires: asset schema, land schema
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);

-- ========= asset --> logistics (1 constraint(s)) =========
-- Requires: asset schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_carrier_approval` ADD CONSTRAINT `fk_asset_facility_carrier_approval_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= asset --> procurement (15 constraint(s)) =========
-- Requires: asset schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ADD CONSTRAINT `fk_asset_moc_request_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ADD CONSTRAINT `fk_asset_transfer_event_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ADD CONSTRAINT `fk_asset_abandonment_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_contract_coverage` ADD CONSTRAINT `fk_asset_equipment_contract_coverage_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`facility_vendor_qualification` ADD CONSTRAINT `fk_asset_facility_vendor_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`program_vendor_qualification` ADD CONSTRAINT `fk_asset_program_vendor_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= asset --> product (8 constraint(s)) =========
-- Requires: asset schema, product schema
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_facility` ADD CONSTRAINT `fk_asset_asset_facility_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment` ADD CONSTRAINT `fk_asset_equipment_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ADD CONSTRAINT `fk_asset_corrosion_monitoring_point_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ADD CONSTRAINT `fk_asset_equipment_specification_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= asset --> production (16 constraint(s)) =========
-- Requires: asset schema, production schema
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`integrity_program` ADD CONSTRAINT `fk_asset_integrity_program_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`corrosion_monitoring_point` ADD CONSTRAINT `fk_asset_corrosion_monitoring_point_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ADD CONSTRAINT `fk_asset_moc_request_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ADD CONSTRAINT `fk_asset_moc_request_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ADD CONSTRAINT `fk_asset_asset_risk_assessment_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`maintenance_strategy` ADD CONSTRAINT `fk_asset_maintenance_strategy_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ADD CONSTRAINT `fk_asset_abandonment_plan_injection_well_id` FOREIGN KEY (`injection_well_id`) REFERENCES `oil_gas_ecm`.`production`.`injection_well`(`injection_well_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ADD CONSTRAINT `fk_asset_abandonment_plan_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);

-- ========= asset --> reservoir (1 constraint(s)) =========
-- Requires: asset schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`asset`.`well_asset` ADD CONSTRAINT `fk_asset_well_asset_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);

-- ========= asset --> venture (6 constraint(s)) =========
-- Requires: asset schema, venture schema
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ADD CONSTRAINT `fk_asset_transfer_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ADD CONSTRAINT `fk_asset_transfer_event_to_jv_partner_id` FOREIGN KEY (`to_jv_partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ADD CONSTRAINT `fk_asset_abandonment_plan_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ADD CONSTRAINT `fk_asset_asset_working_interest_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_working_interest` ADD CONSTRAINT `fk_asset_asset_working_interest_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);

-- ========= asset --> workforce (14 constraint(s)) =========
-- Requires: asset schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`asset`.`pipeline_segment` ADD CONSTRAINT `fk_asset_pipeline_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`preventive_maintenance_plan` ADD CONSTRAINT `fk_asset_preventive_maintenance_plan_tertiary_preventive_approved_by_employee_id` FOREIGN KEY (`tertiary_preventive_approved_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`failure_report` ADD CONSTRAINT `fk_asset_failure_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`moc_request` ADD CONSTRAINT `fk_asset_moc_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset_risk_assessment` ADD CONSTRAINT `fk_asset_asset_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`transfer_event` ADD CONSTRAINT `fk_asset_transfer_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`equipment_specification` ADD CONSTRAINT `fk_asset_equipment_specification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ADD CONSTRAINT `fk_asset_abandonment_plan_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`abandonment_plan` ADD CONSTRAINT `fk_asset_abandonment_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ADD CONSTRAINT `fk_asset_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`asset` ADD CONSTRAINT `fk_asset_asset_updated_by_user_employee_id` FOREIGN KEY (`updated_by_user_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`asset`.`work_center` ADD CONSTRAINT `fk_asset_work_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= commercial --> asset (3 constraint(s)) =========
-- Requires: commercial schema, asset schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ADD CONSTRAINT `fk_commercial_quota_allocation_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `oil_gas_ecm`.`asset`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);

-- ========= commercial --> compliance (14 constraint(s)) =========
-- Requires: commercial schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `oil_gas_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ADD CONSTRAINT `fk_commercial_hedging_instrument_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ADD CONSTRAINT `fk_commercial_commercial_volume_commitment_opec_quota_position_id` FOREIGN KEY (`opec_quota_position_id`) REFERENCES `oil_gas_ecm`.`compliance`.`opec_quota_position`(`opec_quota_position_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ADD CONSTRAINT `fk_commercial_quota_allocation_opec_quota_position_id` FOREIGN KEY (`opec_quota_position_id`) REFERENCES `oil_gas_ecm`.`compliance`.`opec_quota_position`(`opec_quota_position_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_opec_quota_position_id` FOREIGN KEY (`opec_quota_position_id`) REFERENCES `oil_gas_ecm`.`compliance`.`opec_quota_position`(`opec_quota_position_id`);

-- ========= commercial --> customer (21 constraint(s)) =========
-- Requires: commercial schema, customer schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `oil_gas_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_tertiary_sales_bill_to_party_account_id` FOREIGN KEY (`tertiary_sales_bill_to_party_account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_delivery_preference_id` FOREIGN KEY (`delivery_preference_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_preference`(`delivery_preference_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ADD CONSTRAINT `fk_commercial_commercial_volume_commitment_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ADD CONSTRAINT `fk_commercial_delivery_schedule_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ADD CONSTRAINT `fk_commercial_quota_allocation_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ADD CONSTRAINT `fk_commercial_performance_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_price_index_preference` ADD CONSTRAINT `fk_commercial_commercial_price_index_preference_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ADD CONSTRAINT `fk_commercial_opportunity_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);

-- ========= commercial --> exploration (1 constraint(s)) =========
-- Requires: commercial schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ADD CONSTRAINT `fk_commercial_opportunity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `oil_gas_ecm`.`exploration`.`campaign`(`campaign_id`);

-- ========= commercial --> finance (8 constraint(s)) =========
-- Requires: commercial schema, finance schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ADD CONSTRAINT `fk_commercial_hedging_instrument_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ADD CONSTRAINT `fk_commercial_commercial_volume_commitment_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);

-- ========= commercial --> hse (11 constraint(s)) =========
-- Requires: commercial schema, hse schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_hazardous_substance_id` FOREIGN KEY (`hazardous_substance_id`) REFERENCES `oil_gas_ecm`.`hse`.`hazardous_substance`(`hazardous_substance_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_management_of_change_id` FOREIGN KEY (`management_of_change_id`) REFERENCES `oil_gas_ecm`.`hse`.`management_of_change`(`management_of_change_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `oil_gas_ecm`.`hse`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_hse_risk_assessment_id` FOREIGN KEY (`hse_risk_assessment_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_risk_assessment`(`hse_risk_assessment_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_management_of_change_id` FOREIGN KEY (`management_of_change_id`) REFERENCES `oil_gas_ecm`.`hse`.`management_of_change`(`management_of_change_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `oil_gas_ecm`.`hse`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_hazardous_substance_id` FOREIGN KEY (`hazardous_substance_id`) REFERENCES `oil_gas_ecm`.`hse`.`hazardous_substance`(`hazardous_substance_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_h2s_monitoring_id` FOREIGN KEY (`h2s_monitoring_id`) REFERENCES `oil_gas_ecm`.`hse`.`h2s_monitoring`(`h2s_monitoring_id`);

-- ========= commercial --> land (5 constraint(s)) =========
-- Requires: commercial schema, land schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ADD CONSTRAINT `fk_commercial_quota_allocation_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= commercial --> logistics (4 constraint(s)) =========
-- Requires: commercial schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ADD CONSTRAINT `fk_commercial_delivery_schedule_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);

-- ========= commercial --> petrochemical (1 constraint(s)) =========
-- Requires: commercial schema, petrochemical schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ADD CONSTRAINT `fk_commercial_opportunity_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`product_catalog`(`product_catalog_id`);

-- ========= commercial --> procurement (10 constraint(s)) =========
-- Requires: commercial schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ADD CONSTRAINT `fk_commercial_hedging_instrument_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ADD CONSTRAINT `fk_commercial_commercial_counterparty_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= commercial --> product (27 constraint(s)) =========
-- Requires: commercial schema, product schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_certificate_of_quality_id` FOREIGN KEY (`certificate_of_quality_id`) REFERENCES `oil_gas_ecm`.`product`.`certificate_of_quality`(`certificate_of_quality_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_refined_product_id` FOREIGN KEY (`refined_product_id`) REFERENCES `oil_gas_ecm`.`product`.`refined_product`(`refined_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order_line` ADD CONSTRAINT `fk_commercial_sales_order_line_quality_test_result_id` FOREIGN KEY (`quality_test_result_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_test_result`(`quality_test_result_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ADD CONSTRAINT `fk_commercial_price_differential_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`price_differential` ADD CONSTRAINT `fk_commercial_price_differential_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ADD CONSTRAINT `fk_commercial_hedging_instrument_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_ngl_stream_id` FOREIGN KEY (`ngl_stream_id`) REFERENCES `oil_gas_ecm`.`product`.`ngl_stream`(`ngl_stream_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_refined_product_id` FOREIGN KEY (`refined_product_id`) REFERENCES `oil_gas_ecm`.`product`.`refined_product`(`refined_product_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ADD CONSTRAINT `fk_commercial_performance_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= commercial --> refining (1 constraint(s)) =========
-- Requires: commercial schema, refining schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);

-- ========= commercial --> venture (30 constraint(s)) =========
-- Requires: commercial schema, venture schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`offtake_agreement` ADD CONSTRAINT `fk_commercial_offtake_agreement_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ADD CONSTRAINT `fk_commercial_hedging_instrument_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ADD CONSTRAINT `fk_commercial_hedging_instrument_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ADD CONSTRAINT `fk_commercial_hedging_transaction_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_transaction` ADD CONSTRAINT `fk_commercial_hedging_transaction_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ADD CONSTRAINT `fk_commercial_quota_allocation_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ADD CONSTRAINT `fk_commercial_quota_allocation_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ADD CONSTRAINT `fk_commercial_performance_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ADD CONSTRAINT `fk_commercial_performance_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ADD CONSTRAINT `fk_commercial_commodity_exposure_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ADD CONSTRAINT `fk_commercial_commodity_exposure_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`credit_limit` ADD CONSTRAINT `fk_commercial_credit_limit_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);

-- ========= commercial --> workforce (20 constraint(s)) =========
-- Requires: commercial schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_term_contract` ADD CONSTRAINT `fk_commercial_commercial_term_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`spot_trade` ADD CONSTRAINT `fk_commercial_spot_trade_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_tertiary_sales_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_sales_last_modified_by_user_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`pricing_agreement` ADD CONSTRAINT `fk_commercial_pricing_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trading_position` ADD CONSTRAINT `fk_commercial_trading_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`hedging_instrument` ADD CONSTRAINT `fk_commercial_hedging_instrument_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`cargo_nomination` ADD CONSTRAINT `fk_commercial_cargo_nomination_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_volume_commitment` ADD CONSTRAINT `fk_commercial_commercial_volume_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`delivery_schedule` ADD CONSTRAINT `fk_commercial_delivery_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`trade_confirmation` ADD CONSTRAINT `fk_commercial_trade_confirmation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`quota_allocation` ADD CONSTRAINT `fk_commercial_quota_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`lifting_program` ADD CONSTRAINT `fk_commercial_lifting_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`marketing_deal` ADD CONSTRAINT `fk_commercial_marketing_deal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`performance` ADD CONSTRAINT `fk_commercial_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commodity_exposure` ADD CONSTRAINT `fk_commercial_commodity_exposure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`commercial_counterparty` ADD CONSTRAINT `fk_commercial_commercial_counterparty_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` ADD CONSTRAINT `fk_commercial_portfolio_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`portfolio` ADD CONSTRAINT `fk_commercial_portfolio_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`commercial`.`opportunity` ADD CONSTRAINT `fk_commercial_opportunity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> asset (16 constraint(s)) =========
-- Requires: compliance schema, asset schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `oil_gas_ecm`.`asset`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`sox_control_test` ADD CONSTRAINT `fk_compliance_sox_control_test_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_certification` ADD CONSTRAINT `fk_compliance_compliance_certification_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`release_report` ADD CONSTRAINT `fk_compliance_release_report_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`pipeline_safety_report` ADD CONSTRAINT `fk_compliance_pipeline_safety_report_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`waiver` ADD CONSTRAINT `fk_compliance_waiver_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`waiver` ADD CONSTRAINT `fk_compliance_waiver_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`offshore_safety_case` ADD CONSTRAINT `fk_compliance_offshore_safety_case_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);

-- ========= compliance --> customer (12 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing` ADD CONSTRAINT `fk_compliance_compliance_regulatory_filing_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing` ADD CONSTRAINT `fk_compliance_compliance_regulatory_filing_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`operating_license` ADD CONSTRAINT `fk_compliance_operating_license_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`esg_report` ADD CONSTRAINT `fk_compliance_esg_report_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`esg_report` ADD CONSTRAINT `fk_compliance_esg_report_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`sox_control` ADD CONSTRAINT `fk_compliance_sox_control_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_certification` ADD CONSTRAINT `fk_compliance_compliance_certification_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_certification` ADD CONSTRAINT `fk_compliance_compliance_certification_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);

-- ========= compliance --> drilling (6 constraint(s)) =========
-- Requires: compliance schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`release_report` ADD CONSTRAINT `fk_compliance_release_report_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`pipeline_safety_report` ADD CONSTRAINT `fk_compliance_pipeline_safety_report_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`pipeline_safety_report` ADD CONSTRAINT `fk_compliance_pipeline_safety_report_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`drilling`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`offshore_safety_case` ADD CONSTRAINT `fk_compliance_offshore_safety_case_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);

-- ========= compliance --> finance (19 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing` ADD CONSTRAINT `fk_compliance_compliance_regulatory_filing_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing` ADD CONSTRAINT `fk_compliance_compliance_regulatory_filing_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`operating_license` ADD CONSTRAINT `fk_compliance_operating_license_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_sec_reserves_disclosure` ADD CONSTRAINT `fk_compliance_compliance_sec_reserves_disclosure_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`esg_report` ADD CONSTRAINT `fk_compliance_esg_report_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_certification` ADD CONSTRAINT `fk_compliance_compliance_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`release_report` ADD CONSTRAINT `fk_compliance_release_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`pipeline_safety_report` ADD CONSTRAINT `fk_compliance_pipeline_safety_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`waiver` ADD CONSTRAINT `fk_compliance_waiver_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`ferc_tariff` ADD CONSTRAINT `fk_compliance_ferc_tariff_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`offshore_safety_case` ADD CONSTRAINT `fk_compliance_offshore_safety_case_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= compliance --> hse (1 constraint(s)) =========
-- Requires: compliance schema, hse schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `oil_gas_ecm`.`hse`.`audit`(`audit_id`);

-- ========= compliance --> procurement (18 constraint(s)) =========
-- Requires: compliance schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing` ADD CONSTRAINT `fk_compliance_compliance_regulatory_filing_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing` ADD CONSTRAINT `fk_compliance_compliance_regulatory_filing_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_sec_reserves_disclosure` ADD CONSTRAINT `fk_compliance_compliance_sec_reserves_disclosure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`esg_report` ADD CONSTRAINT `fk_compliance_esg_report_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`esg_report` ADD CONSTRAINT `fk_compliance_esg_report_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_certification` ADD CONSTRAINT `fk_compliance_compliance_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_certification` ADD CONSTRAINT `fk_compliance_compliance_certification_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`release_report` ADD CONSTRAINT `fk_compliance_release_report_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`offshore_safety_case` ADD CONSTRAINT `fk_compliance_offshore_safety_case_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`offshore_safety_case` ADD CONSTRAINT `fk_compliance_offshore_safety_case_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= compliance --> product (10 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing` ADD CONSTRAINT `fk_compliance_compliance_regulatory_filing_lng_specification_id` FOREIGN KEY (`lng_specification_id`) REFERENCES `oil_gas_ecm`.`product`.`lng_specification`(`lng_specification_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing` ADD CONSTRAINT `fk_compliance_compliance_regulatory_filing_tariff_code_id` FOREIGN KEY (`tariff_code_id`) REFERENCES `oil_gas_ecm`.`product`.`tariff_code`(`tariff_code_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_quality_test_result_id` FOREIGN KEY (`quality_test_result_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_test_result`(`quality_test_result_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_sec_reserves_disclosure` ADD CONSTRAINT `fk_compliance_compliance_sec_reserves_disclosure_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_sec_reserves_disclosure` ADD CONSTRAINT `fk_compliance_compliance_sec_reserves_disclosure_price_history_id` FOREIGN KEY (`price_history_id`) REFERENCES `oil_gas_ecm`.`product`.`price_history`(`price_history_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`esg_report` ADD CONSTRAINT `fk_compliance_esg_report_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `oil_gas_ecm`.`product`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`esg_report` ADD CONSTRAINT `fk_compliance_esg_report_refined_product_id` FOREIGN KEY (`refined_product_id`) REFERENCES `oil_gas_ecm`.`product`.`refined_product`(`refined_product_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`release_report` ADD CONSTRAINT `fk_compliance_release_report_ngl_stream_id` FOREIGN KEY (`ngl_stream_id`) REFERENCES `oil_gas_ecm`.`product`.`ngl_stream`(`ngl_stream_id`);

-- ========= compliance --> production (2 constraint(s)) =========
-- Requires: compliance schema, production schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`release_report` ADD CONSTRAINT `fk_compliance_release_report_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);

-- ========= compliance --> workforce (20 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing` ADD CONSTRAINT `fk_compliance_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`operating_license` ADD CONSTRAINT `fk_compliance_operating_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`calendar` ADD CONSTRAINT `fk_compliance_calendar_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_audit` ADD CONSTRAINT `fk_compliance_regulatory_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_audit_finding` ADD CONSTRAINT `fk_compliance_compliance_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`sox_control_test` ADD CONSTRAINT `fk_compliance_sox_control_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`sox_control_test` ADD CONSTRAINT `fk_compliance_sox_control_test_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`consent_order` ADD CONSTRAINT `fk_compliance_consent_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`regulatory_penalty` ADD CONSTRAINT `fk_compliance_regulatory_penalty_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`compliance_certification` ADD CONSTRAINT `fk_compliance_compliance_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`release_report` ADD CONSTRAINT `fk_compliance_release_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`pipeline_safety_report` ADD CONSTRAINT `fk_compliance_pipeline_safety_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`waiver` ADD CONSTRAINT `fk_compliance_waiver_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`waiver` ADD CONSTRAINT `fk_compliance_waiver_waiver_responsible_party_employee_id` FOREIGN KEY (`waiver_responsible_party_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`ferc_tariff` ADD CONSTRAINT `fk_compliance_ferc_tariff_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`compliance`.`offshore_safety_case` ADD CONSTRAINT `fk_compliance_offshore_safety_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> commercial (9 constraint(s)) =========
-- Requires: customer schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_counterparty` ADD CONSTRAINT `fk_customer_customer_counterparty_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_credit_limit_id` FOREIGN KEY (`credit_limit_id`) REFERENCES `oil_gas_ecm`.`commercial`.`credit_limit`(`credit_limit_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`kyc_record` ADD CONSTRAINT `fk_customer_kyc_record_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_price_index_preference` ADD CONSTRAINT `fk_customer_customer_price_index_preference_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `oil_gas_ecm`.`commercial`.`opportunity`(`opportunity_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_volume_commitment` ADD CONSTRAINT `fk_customer_customer_volume_commitment_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);

-- ========= customer --> compliance (1 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`customer`.`license_interest` ADD CONSTRAINT `fk_customer_license_interest_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);

-- ========= customer --> exploration (1 constraint(s)) =========
-- Requires: customer schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`exploration`.`field`(`field_id`);

-- ========= customer --> finance (15 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_counterparty` ADD CONSTRAINT `fk_customer_customer_counterparty_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`credit_event` ADD CONSTRAINT `fk_customer_credit_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`sanctions_screening` ADD CONSTRAINT `fk_customer_sanctions_screening_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_volume_commitment` ADD CONSTRAINT `fk_customer_customer_volume_commitment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_volume_commitment` ADD CONSTRAINT `fk_customer_customer_volume_commitment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= customer --> land (5 constraint(s)) =========
-- Requires: customer schema, land schema
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_counterparty` ADD CONSTRAINT `fk_customer_customer_counterparty_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`delivery_point` ADD CONSTRAINT `fk_customer_delivery_point_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= customer --> logistics (3 constraint(s)) =========
-- Requires: customer schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`delivery_preference` ADD CONSTRAINT `fk_customer_delivery_preference_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);

-- ========= customer --> procurement (5 constraint(s)) =========
-- Requires: customer schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_counterparty` ADD CONSTRAINT `fk_customer_customer_counterparty_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`delivery_point` ADD CONSTRAINT `fk_customer_delivery_point_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_product_approval` ADD CONSTRAINT `fk_customer_customer_product_approval_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);

-- ========= customer --> product (12 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_price_index_preference` ADD CONSTRAINT `fk_customer_customer_price_index_preference_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_primary_customer_crude_grade_id` FOREIGN KEY (`primary_customer_crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`delivery_preference` ADD CONSTRAINT `fk_customer_delivery_preference_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_volume_commitment` ADD CONSTRAINT `fk_customer_customer_volume_commitment_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_product_approval` ADD CONSTRAINT `fk_customer_customer_product_approval_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_term_contract` ADD CONSTRAINT `fk_customer_customer_term_contract_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`delivery_point_product_capability` ADD CONSTRAINT `fk_customer_delivery_point_product_capability_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= customer --> reservoir (2 constraint(s)) =========
-- Requires: customer schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);

-- ========= customer --> venture (18 constraint(s)) =========
-- Requires: customer schema, venture schema
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_counterparty` ADD CONSTRAINT `fk_customer_customer_counterparty_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`credit_event` ADD CONSTRAINT `fk_customer_credit_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`kyc_record` ADD CONSTRAINT `fk_customer_kyc_record_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_price_index_preference` ADD CONSTRAINT `fk_customer_customer_price_index_preference_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`sanctions_screening` ADD CONSTRAINT `fk_customer_sanctions_screening_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_volume_commitment` ADD CONSTRAINT `fk_customer_customer_volume_commitment_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`counterparty_joa_participation` ADD CONSTRAINT `fk_customer_counterparty_joa_participation_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);

-- ========= customer --> workforce (21 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_counterparty` ADD CONSTRAINT `fk_customer_customer_counterparty_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`delivery_point` ADD CONSTRAINT `fk_customer_delivery_point_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`credit_event` ADD CONSTRAINT `fk_customer_credit_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`kyc_record` ADD CONSTRAINT `fk_customer_kyc_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`kyc_document` ADD CONSTRAINT `fk_customer_kyc_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`kyc_document` ADD CONSTRAINT `fk_customer_kyc_document_primary_kyc_employee_id` FOREIGN KEY (`primary_kyc_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_price_index_preference` ADD CONSTRAINT `fk_customer_customer_price_index_preference_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`nomination` ADD CONSTRAINT `fk_customer_nomination_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_lifting_schedule` ADD CONSTRAINT `fk_customer_customer_lifting_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`offtake_entitlement` ADD CONSTRAINT `fk_customer_offtake_entitlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`delivery_preference` ADD CONSTRAINT `fk_customer_delivery_preference_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_complaint_escalation_owner_employee_id` FOREIGN KEY (`complaint_escalation_owner_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`sanctions_screening` ADD CONSTRAINT `fk_customer_sanctions_screening_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_volume_commitment` ADD CONSTRAINT `fk_customer_customer_volume_commitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`customer_product_approval` ADD CONSTRAINT `fk_customer_customer_product_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`end_use_declaration` ADD CONSTRAINT `fk_customer_end_use_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`bank_detail` ADD CONSTRAINT `fk_customer_bank_detail_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`customer`.`tax_registration` ADD CONSTRAINT `fk_customer_tax_registration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= drilling --> asset (14 constraint(s)) =========
-- Requires: drilling schema, asset schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ADD CONSTRAINT `fk_drilling_bit_run_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ADD CONSTRAINT `fk_drilling_directional_survey_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ADD CONSTRAINT `fk_drilling_mwd_lwd_log_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ADD CONSTRAINT `fk_drilling_casing_design_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ADD CONSTRAINT `fk_drilling_dst_result_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_abandonment_plan_id` FOREIGN KEY (`abandonment_plan_id`) REFERENCES `oil_gas_ecm`.`asset`.`abandonment_plan`(`abandonment_plan_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= drilling --> commercial (3 constraint(s)) =========
-- Requires: drilling schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);

-- ========= drilling --> compliance (14 constraint(s)) =========
-- Requires: drilling schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ADD CONSTRAINT `fk_drilling_bop_certification_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bop_certification` ADD CONSTRAINT `fk_drilling_bop_certification_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ADD CONSTRAINT `fk_drilling_well_control_event_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ADD CONSTRAINT `fk_drilling_well_control_event_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ADD CONSTRAINT `fk_drilling_dst_result_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ADD CONSTRAINT `fk_drilling_dc_program_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`wellbore` ADD CONSTRAINT `fk_drilling_wellbore_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= drilling --> customer (4 constraint(s)) =========
-- Requires: drilling schema, customer schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ADD CONSTRAINT `fk_drilling_cost_detail_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ADD CONSTRAINT `fk_drilling_dc_program_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);

-- ========= drilling --> exploration (3 constraint(s)) =========
-- Requires: drilling schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);

-- ========= drilling --> finance (11 constraint(s)) =========
-- Requires: drilling schema, finance schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ADD CONSTRAINT `fk_drilling_cost_detail_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ADD CONSTRAINT `fk_drilling_cost_detail_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ADD CONSTRAINT `fk_drilling_cost_detail_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ADD CONSTRAINT `fk_drilling_dc_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ADD CONSTRAINT `fk_drilling_dc_program_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= drilling --> hse (5 constraint(s)) =========
-- Requires: drilling schema, hse schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_hse_risk_assessment_id` FOREIGN KEY (`hse_risk_assessment_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_risk_assessment`(`hse_risk_assessment_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_norm_record_id` FOREIGN KEY (`norm_record_id`) REFERENCES `oil_gas_ecm`.`hse`.`norm_record`(`norm_record_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_hse_risk_assessment_id` FOREIGN KEY (`hse_risk_assessment_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_risk_assessment`(`hse_risk_assessment_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);

-- ========= drilling --> land (9 constraint(s)) =========
-- Requires: drilling schema, land schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ADD CONSTRAINT `fk_drilling_dst_result_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ADD CONSTRAINT `fk_drilling_dc_program_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_election` ADD CONSTRAINT `fk_drilling_afe_election_land_working_interest_id` FOREIGN KEY (`land_working_interest_id`) REFERENCES `oil_gas_ecm`.`land`.`land_working_interest`(`land_working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_unit_participation` ADD CONSTRAINT `fk_drilling_well_unit_participation_pooling_unit_id` FOREIGN KEY (`pooling_unit_id`) REFERENCES `oil_gas_ecm`.`land`.`pooling_unit`(`pooling_unit_id`);

-- ========= drilling --> logistics (3 constraint(s)) =========
-- Requires: drilling schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ADD CONSTRAINT `fk_drilling_cost_detail_freight_invoice_id` FOREIGN KEY (`freight_invoice_id`) REFERENCES `oil_gas_ecm`.`logistics`.`freight_invoice`(`freight_invoice_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ADD CONSTRAINT `fk_drilling_cost_detail_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);

-- ========= drilling --> procurement (21 constraint(s)) =========
-- Requires: drilling schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ADD CONSTRAINT `fk_drilling_rig_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ADD CONSTRAINT `fk_drilling_daily_drilling_report_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ADD CONSTRAINT `fk_drilling_bha_configuration_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ADD CONSTRAINT `fk_drilling_casing_design_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ADD CONSTRAINT `fk_drilling_dst_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cost_detail` ADD CONSTRAINT `fk_drilling_cost_detail_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ADD CONSTRAINT `fk_drilling_mud_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_contract` ADD CONSTRAINT `fk_drilling_rig_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`afe_vendor_spend` ADD CONSTRAINT `fk_drilling_afe_vendor_spend_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_service_engagement` ADD CONSTRAINT `fk_drilling_well_service_engagement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= drilling --> product (5 constraint(s)) =========
-- Requires: drilling schema, product schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ADD CONSTRAINT `fk_drilling_dst_result_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ADD CONSTRAINT `fk_drilling_mud_program_additive_id` FOREIGN KEY (`additive_id`) REFERENCES `oil_gas_ecm`.`product`.`additive`(`additive_id`);

-- ========= drilling --> reservoir (12 constraint(s)) =========
-- Requires: drilling schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_well` ADD CONSTRAINT `fk_drilling_drilling_well_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ADD CONSTRAINT `fk_drilling_bit_run_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ADD CONSTRAINT `fk_drilling_directional_survey_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`mwd_lwd_log` ADD CONSTRAINT `fk_drilling_mwd_lwd_log_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dst_result` ADD CONSTRAINT `fk_drilling_dst_result_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ADD CONSTRAINT `fk_drilling_mud_program_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_zone_completion` ADD CONSTRAINT `fk_drilling_well_zone_completion_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`zone`(`zone_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`program_reservoir_allocation` ADD CONSTRAINT `fk_drilling_program_reservoir_allocation_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);

-- ========= drilling --> venture (2 constraint(s)) =========
-- Requires: drilling schema, venture schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`drilling_afe` ADD CONSTRAINT `fk_drilling_drilling_afe_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ADD CONSTRAINT `fk_drilling_dc_program_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);

-- ========= drilling --> workforce (23 constraint(s)) =========
-- Requires: drilling schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_program` ADD CONSTRAINT `fk_drilling_well_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig` ADD CONSTRAINT `fk_drilling_rig_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`rig_schedule` ADD CONSTRAINT `fk_drilling_rig_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`daily_drilling_report` ADD CONSTRAINT `fk_drilling_daily_drilling_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`npt_event` ADD CONSTRAINT `fk_drilling_npt_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bha_configuration` ADD CONSTRAINT `fk_drilling_bha_configuration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`bit_run` ADD CONSTRAINT `fk_drilling_bit_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`directional_survey` ADD CONSTRAINT `fk_drilling_directional_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`casing_design` ADD CONSTRAINT `fk_drilling_casing_design_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`cementing_job` ADD CONSTRAINT `fk_drilling_cementing_job_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_control_event` ADD CONSTRAINT `fk_drilling_well_control_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`completion_design` ADD CONSTRAINT `fk_drilling_completion_design_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`perforation_job` ADD CONSTRAINT `fk_drilling_perforation_job_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`stimulation_job` ADD CONSTRAINT `fk_drilling_stimulation_job_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_status_history` ADD CONSTRAINT `fk_drilling_well_status_history_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`plug_and_abandonment` ADD CONSTRAINT `fk_drilling_plug_and_abandonment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`mud_program` ADD CONSTRAINT `fk_drilling_mud_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`well_permit` ADD CONSTRAINT `fk_drilling_well_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ADD CONSTRAINT `fk_drilling_dc_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`drilling`.`dc_program` ADD CONSTRAINT `fk_drilling_dc_program_primary_dc_employee_id` FOREIGN KEY (`primary_dc_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= exploration --> asset (6 constraint(s)) =========
-- Requires: exploration schema, asset schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ADD CONSTRAINT `fk_exploration_wildcat_well_plan_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= exploration --> commercial (3 constraint(s)) =========
-- Requires: exploration schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ADD CONSTRAINT `fk_exploration_block_interest_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);

-- ========= exploration --> compliance (7 constraint(s)) =========
-- Requires: exploration schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ADD CONSTRAINT `fk_exploration_license_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ADD CONSTRAINT `fk_exploration_wildcat_well_plan_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ADD CONSTRAINT `fk_exploration_campaign_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_permit` ADD CONSTRAINT `fk_exploration_block_permit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= exploration --> drilling (3 constraint(s)) =========
-- Requires: exploration schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`wellbore` ADD CONSTRAINT `fk_exploration_wellbore_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);

-- ========= exploration --> finance (13 constraint(s)) =========
-- Requires: exploration schema, finance schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ADD CONSTRAINT `fk_exploration_license_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ADD CONSTRAINT `fk_exploration_study_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ADD CONSTRAINT `fk_exploration_wildcat_well_plan_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ADD CONSTRAINT `fk_exploration_campaign_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ADD CONSTRAINT `fk_exploration_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ADD CONSTRAINT `fk_exploration_campaign_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= exploration --> land (9 constraint(s)) =========
-- Requires: exploration schema, land schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ADD CONSTRAINT `fk_exploration_wildcat_well_plan_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ADD CONSTRAINT `fk_exploration_core_sample_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ADD CONSTRAINT `fk_exploration_fluid_sample_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ADD CONSTRAINT `fk_exploration_geochemical_sample_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`field` ADD CONSTRAINT `fk_exploration_field_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`land`.`operator`(`operator_id`);

-- ========= exploration --> procurement (9 constraint(s)) =========
-- Requires: exploration schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_survey` ADD CONSTRAINT `fk_exploration_seismic_survey_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_line` ADD CONSTRAINT `fk_exploration_seismic_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ADD CONSTRAINT `fk_exploration_well_log_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`core_sample` ADD CONSTRAINT `fk_exploration_core_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ADD CONSTRAINT `fk_exploration_fluid_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ADD CONSTRAINT `fk_exploration_geochemical_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign_vendor_engagement` ADD CONSTRAINT `fk_exploration_campaign_vendor_engagement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_contract_line_item` ADD CONSTRAINT `fk_exploration_seismic_contract_line_item_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);

-- ========= exploration --> product (10 constraint(s)) =========
-- Requires: exploration schema, product schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ADD CONSTRAINT `fk_exploration_wildcat_well_plan_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ADD CONSTRAINT `fk_exploration_fluid_sample_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ADD CONSTRAINT `fk_exploration_campaign_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`geochemical_sample` ADD CONSTRAINT `fk_exploration_geochemical_sample_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ADD CONSTRAINT `fk_exploration_well_result_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= exploration --> reservoir (3 constraint(s)) =========
-- Requires: exploration schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_log` ADD CONSTRAINT `fk_exploration_well_log_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`fluid_sample` ADD CONSTRAINT `fk_exploration_fluid_sample_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);

-- ========= exploration --> venture (13 constraint(s)) =========
-- Requires: exploration schema, venture schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block` ADD CONSTRAINT `fk_exploration_block_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ADD CONSTRAINT `fk_exploration_license_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`license` ADD CONSTRAINT `fk_exploration_license_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ADD CONSTRAINT `fk_exploration_wildcat_well_plan_venture_afe_id` FOREIGN KEY (`venture_afe_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_afe`(`venture_afe_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_venture_afe_id` FOREIGN KEY (`venture_afe_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_afe`(`venture_afe_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ADD CONSTRAINT `fk_exploration_campaign_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ADD CONSTRAINT `fk_exploration_campaign_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ADD CONSTRAINT `fk_exploration_campaign_jv_budget_id` FOREIGN KEY (`jv_budget_id`) REFERENCES `oil_gas_ecm`.`venture`.`jv_budget`(`jv_budget_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ADD CONSTRAINT `fk_exploration_block_interest_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ADD CONSTRAINT `fk_exploration_block_interest_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`block_interest` ADD CONSTRAINT `fk_exploration_block_interest_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);

-- ========= exploration --> workforce (11 constraint(s)) =========
-- Requires: exploration schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`exploration`.`basin` ADD CONSTRAINT `fk_exploration_basin_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`lead` ADD CONSTRAINT `fk_exploration_lead_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ADD CONSTRAINT `fk_exploration_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`study` ADD CONSTRAINT `fk_exploration_study_study_lead_geoscientist_employee_id` FOREIGN KEY (`study_lead_geoscientist_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`seismic_interpretation` ADD CONSTRAINT `fk_exploration_seismic_interpretation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`wildcat_well_plan` ADD CONSTRAINT `fk_exploration_wildcat_well_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`exploration_well` ADD CONSTRAINT `fk_exploration_exploration_well_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`campaign` ADD CONSTRAINT `fk_exploration_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`discovery` ADD CONSTRAINT `fk_exploration_discovery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`exploration`.`well_result` ADD CONSTRAINT `fk_exploration_well_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> asset (8 constraint(s)) =========
-- Requires: finance schema, asset schema
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `oil_gas_ecm`.`asset`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_object` ADD CONSTRAINT `fk_finance_cost_object_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);

-- ========= finance --> commercial (7 constraint(s)) =========
-- Requires: finance schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ADD CONSTRAINT `fk_finance_hedge_position_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);

-- ========= finance --> customer (1 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ADD CONSTRAINT `fk_finance_cash_management_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);

-- ========= finance --> drilling (3 constraint(s)) =========
-- Requires: finance schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ADD CONSTRAINT `fk_finance_afe_cost_line_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);

-- ========= finance --> land (3 constraint(s)) =========
-- Requires: finance schema, land schema
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_party_id` FOREIGN KEY (`party_id`) REFERENCES `oil_gas_ecm`.`land`.`party`(`party_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`settlement_receiver` ADD CONSTRAINT `fk_finance_settlement_receiver_tax_entity_id` FOREIGN KEY (`tax_entity_id`) REFERENCES `oil_gas_ecm`.`land`.`tax_entity`(`tax_entity_id`);

-- ========= finance --> procurement (12 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ADD CONSTRAINT `fk_finance_afe_cost_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ADD CONSTRAINT `fk_finance_afe_cost_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ADD CONSTRAINT `fk_finance_afe_cost_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `oil_gas_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_service_entry_sheet_id` FOREIGN KEY (`service_entry_sheet_id`) REFERENCES `oil_gas_ecm`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_service_entry_sheet_id` FOREIGN KEY (`service_entry_sheet_id`) REFERENCES `oil_gas_ecm`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= finance --> venture (4 constraint(s)) =========
-- Requires: finance schema, venture schema
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);

-- ========= finance --> workforce (25 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ADD CONSTRAINT `fk_finance_finance_afe_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`finance_afe` ADD CONSTRAINT `fk_finance_finance_afe_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`afe_cost_line` ADD CONSTRAINT `fk_finance_afe_cost_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_tertiary_wbs_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_wbs_last_modified_by_user_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`actual_cost` ADD CONSTRAINT `fk_finance_actual_cost_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`project_economics` ADD CONSTRAINT `fk_finance_project_economics_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`financial_statement` ADD CONSTRAINT `fk_finance_financial_statement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`hedge_position` ADD CONSTRAINT `fk_finance_hedge_position_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`impairment_assessment` ADD CONSTRAINT `fk_finance_impairment_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`cash_management` ADD CONSTRAINT `fk_finance_cash_management_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`cost_object` ADD CONSTRAINT `fk_finance_cost_object_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`project` ADD CONSTRAINT `fk_finance_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`finance`.`project_definition` ADD CONSTRAINT `fk_finance_project_definition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= hse --> asset (68 constraint(s)) =========
-- Requires: hse schema, asset schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
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
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ADD CONSTRAINT `fk_hse_simops_plan_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ADD CONSTRAINT `fk_hse_simops_plan_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ADD CONSTRAINT `fk_hse_simops_plan_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ADD CONSTRAINT `fk_hse_simops_plan_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ADD CONSTRAINT `fk_hse_ldar_component_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ADD CONSTRAINT `fk_hse_ldar_component_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ADD CONSTRAINT `fk_hse_ldar_component_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ADD CONSTRAINT `fk_hse_h2s_monitoring_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ADD CONSTRAINT `fk_hse_h2s_monitoring_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ADD CONSTRAINT `fk_hse_h2s_monitoring_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ADD CONSTRAINT `fk_hse_h2s_monitoring_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ADD CONSTRAINT `fk_hse_norm_record_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ADD CONSTRAINT `fk_hse_norm_record_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ADD CONSTRAINT `fk_hse_norm_record_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `oil_gas_ecm`.`asset`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ADD CONSTRAINT `fk_hse_norm_record_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ADD CONSTRAINT `fk_hse_norm_record_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ADD CONSTRAINT `fk_hse_hazardous_substance_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ADD CONSTRAINT `fk_hse_chemical_inventory_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ADD CONSTRAINT `fk_hse_emergency_drill_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ADD CONSTRAINT `fk_hse_waste_manifest_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ADD CONSTRAINT `fk_hse_waste_manifest_generator_facility_id` FOREIGN KEY (`generator_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ADD CONSTRAINT `fk_hse_objective_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ADD CONSTRAINT `fk_hse_hse_risk_assessment_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ADD CONSTRAINT `fk_hse_hse_risk_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset`(`asset_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `oil_gas_ecm`.`asset`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= hse --> compliance (8 constraint(s)) =========
-- Requires: hse schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_compliance_audit_finding_id` FOREIGN KEY (`compliance_audit_finding_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_audit_finding`(`compliance_audit_finding_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_regulatory_audit_id` FOREIGN KEY (`regulatory_audit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_audit`(`regulatory_audit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_compliance_audit_finding_id` FOREIGN KEY (`compliance_audit_finding_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_audit_finding`(`compliance_audit_finding_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_compliance_corrective_action_id` FOREIGN KEY (`compliance_corrective_action_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= hse --> exploration (7 constraint(s)) =========
-- Requires: hse schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ADD CONSTRAINT `fk_hse_h2s_monitoring_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ADD CONSTRAINT `fk_hse_hse_risk_assessment_wildcat_well_plan_id` FOREIGN KEY (`wildcat_well_plan_id`) REFERENCES `oil_gas_ecm`.`exploration`.`wildcat_well_plan`(`wildcat_well_plan_id`);

-- ========= hse --> finance (12 constraint(s)) =========
-- Requires: hse schema, finance schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ADD CONSTRAINT `fk_hse_emergency_drill_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ADD CONSTRAINT `fk_hse_waste_manifest_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= hse --> land (19 constraint(s)) =========
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
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ADD CONSTRAINT `fk_hse_h2s_monitoring_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ADD CONSTRAINT `fk_hse_norm_record_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`norm_record` ADD CONSTRAINT `fk_hse_norm_record_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_tract_id` FOREIGN KEY (`tract_id`) REFERENCES `oil_gas_ecm`.`land`.`tract`(`tract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_surface_use_agreement_id` FOREIGN KEY (`surface_use_agreement_id`) REFERENCES `oil_gas_ecm`.`land`.`surface_use_agreement`(`surface_use_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ADD CONSTRAINT `fk_hse_waste_manifest_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= hse --> logistics (32 constraint(s)) =========
-- Requires: hse schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_charter_party_id` FOREIGN KEY (`charter_party_id`) REFERENCES `oil_gas_ecm`.`logistics`.`charter_party`(`charter_party_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `oil_gas_ecm`.`logistics`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_pipeline_throughput_id` FOREIGN KEY (`pipeline_throughput_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_throughput`(`pipeline_throughput_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_storage_inventory_id` FOREIGN KEY (`storage_inventory_id`) REFERENCES `oil_gas_ecm`.`logistics`.`storage_inventory`(`storage_inventory_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_truck_ticket_id` FOREIGN KEY (`truck_ticket_id`) REFERENCES `oil_gas_ecm`.`logistics`.`truck_ticket`(`truck_ticket_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_charter_party_id` FOREIGN KEY (`charter_party_id`) REFERENCES `oil_gas_ecm`.`logistics`.`charter_party`(`charter_party_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_custody_transfer_id` FOREIGN KEY (`custody_transfer_id`) REFERENCES `oil_gas_ecm`.`logistics`.`custody_transfer`(`custody_transfer_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `oil_gas_ecm`.`logistics`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_freight_invoice_id` FOREIGN KEY (`freight_invoice_id`) REFERENCES `oil_gas_ecm`.`logistics`.`freight_invoice`(`freight_invoice_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_pipeline_throughput_id` FOREIGN KEY (`pipeline_throughput_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_throughput`(`pipeline_throughput_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_port_call_id` FOREIGN KEY (`port_call_id`) REFERENCES `oil_gas_ecm`.`logistics`.`port_call`(`port_call_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_truck_ticket_id` FOREIGN KEY (`truck_ticket_id`) REFERENCES `oil_gas_ecm`.`logistics`.`truck_ticket`(`truck_ticket_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `oil_gas_ecm`.`logistics`.`voyage`(`voyage_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_charter_party_id` FOREIGN KEY (`charter_party_id`) REFERENCES `oil_gas_ecm`.`logistics`.`charter_party`(`charter_party_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_custody_transfer_id` FOREIGN KEY (`custody_transfer_id`) REFERENCES `oil_gas_ecm`.`logistics`.`custody_transfer`(`custody_transfer_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `oil_gas_ecm`.`logistics`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_pipeline_throughput_id` FOREIGN KEY (`pipeline_throughput_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_throughput`(`pipeline_throughput_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_port_call_id` FOREIGN KEY (`port_call_id`) REFERENCES `oil_gas_ecm`.`logistics`.`port_call`(`port_call_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_truck_ticket_id` FOREIGN KEY (`truck_ticket_id`) REFERENCES `oil_gas_ecm`.`logistics`.`truck_ticket`(`truck_ticket_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);

-- ========= hse --> petrochemical (27 constraint(s)) =========
-- Requires: hse schema, petrochemical schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_turnaround_event_id` FOREIGN KEY (`turnaround_event_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`turnaround_event`(`turnaround_event_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_turnaround_event_id` FOREIGN KEY (`turnaround_event_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`turnaround_event`(`turnaround_event_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ADD CONSTRAINT `fk_hse_simops_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ADD CONSTRAINT `fk_hse_ldar_component_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ADD CONSTRAINT `fk_hse_ldar_component_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`h2s_monitoring` ADD CONSTRAINT `fk_hse_h2s_monitoring_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_turnaround_event_id` FOREIGN KEY (`turnaround_event_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`turnaround_event`(`turnaround_event_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ADD CONSTRAINT `fk_hse_hazardous_substance_feedstock_id` FOREIGN KEY (`feedstock_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`feedstock`(`feedstock_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ADD CONSTRAINT `fk_hse_hazardous_substance_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`product_catalog`(`product_catalog_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ADD CONSTRAINT `fk_hse_chemical_inventory_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_turnaround_event_id` FOREIGN KEY (`turnaround_event_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`turnaround_event`(`turnaround_event_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_conversion_unit_id` FOREIGN KEY (`conversion_unit_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`conversion_unit`(`conversion_unit_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ADD CONSTRAINT `fk_hse_emergency_drill_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ADD CONSTRAINT `fk_hse_waste_manifest_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);

-- ========= hse --> procurement (14 constraint(s)) =========
-- Requires: hse schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ADD CONSTRAINT `fk_hse_hazardous_substance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ADD CONSTRAINT `fk_hse_chemical_inventory_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ADD CONSTRAINT `fk_hse_emergency_drill_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ADD CONSTRAINT `fk_hse_waste_manifest_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= hse --> product (11 constraint(s)) =========
-- Requires: hse schema, product schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hazardous_substance` ADD CONSTRAINT `fk_hse_hazardous_substance_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`process_safety_event` ADD CONSTRAINT `fk_hse_process_safety_event_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ADD CONSTRAINT `fk_hse_waste_manifest_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= hse --> refining (1 constraint(s)) =========
-- Requires: hse schema, refining schema
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ADD CONSTRAINT `fk_hse_ldar_component_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);

-- ========= hse --> revenue (3 constraint(s)) =========
-- Requires: hse schema, revenue schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_revenue_allocation_id` FOREIGN KEY (`revenue_allocation_id`) REFERENCES `oil_gas_ecm`.`revenue`.`revenue_allocation`(`revenue_allocation_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);

-- ========= hse --> venture (12 constraint(s)) =========
-- Requires: hse schema, venture schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_corrective_action` ADD CONSTRAINT `fk_hse_hse_corrective_action_jib_statement_id` FOREIGN KEY (`jib_statement_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_statement`(`jib_statement_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);

-- ========= hse --> workforce (66 constraint(s)) =========
-- Requires: hse schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_incident_investigation_lead_employee_id` FOREIGN KEY (`incident_investigation_lead_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_incident_observer_employee_id` FOREIGN KEY (`incident_observer_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_incident_reporter_employee_id` FOREIGN KEY (`incident_reporter_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_investigation` ADD CONSTRAINT `fk_hse_incident_investigation_tertiary_incident_lead_investigator_employee_id` FOREIGN KEY (`tertiary_incident_lead_investigator_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`permit_to_work` ADD CONSTRAINT `fk_hse_permit_to_work_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ADD CONSTRAINT `fk_hse_simops_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ADD CONSTRAINT `fk_hse_simops_plan_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ADD CONSTRAINT `fk_hse_simops_plan_primary_simops_employee_id` FOREIGN KEY (`primary_simops_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`simops_plan` ADD CONSTRAINT `fk_hse_simops_plan_tertiary_simops_hse_reviewer_employee_id` FOREIGN KEY (`tertiary_simops_hse_reviewer_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_audit_employee_id` FOREIGN KEY (`audit_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_audit_last_modified_by_employee_id` FOREIGN KEY (`audit_last_modified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_quaternary_hse_created_by_employee_id` FOREIGN KEY (`quaternary_hse_created_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_quinary_hse_last_modified_by_employee_id` FOREIGN KEY (`quinary_hse_last_modified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_audit_finding` ADD CONSTRAINT `fk_hse_hse_audit_finding_tertiary_hse_verified_by_employee_id` FOREIGN KEY (`tertiary_hse_verified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_survey` ADD CONSTRAINT `fk_hse_ldar_survey_primary_ldar_employee_id` FOREIGN KEY (`primary_ldar_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ADD CONSTRAINT `fk_hse_ldar_component_created_by_employee_id` FOREIGN KEY (`created_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ADD CONSTRAINT `fk_hse_ldar_component_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_component` ADD CONSTRAINT `fk_hse_ldar_component_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emission_source` ADD CONSTRAINT `fk_hse_emission_source_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ghg_emission` ADD CONSTRAINT `fk_hse_ghg_emission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`spill_event` ADD CONSTRAINT `fk_hse_spill_event_tertiary_spill_last_modified_by_employee_id` FOREIGN KEY (`tertiary_spill_last_modified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_tertiary_regulatory_submitted_by_employee_id` FOREIGN KEY (`tertiary_regulatory_submitted_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_training_record` ADD CONSTRAINT `fk_hse_hse_training_record_tertiary_hse_last_modified_by_employee_id` FOREIGN KEY (`tertiary_hse_last_modified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`chemical_inventory` ADD CONSTRAINT `fk_hse_chemical_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_primary_safety_employee_id` FOREIGN KEY (`primary_safety_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_tertiary_safety_verified_by_employee_id` FOREIGN KEY (`tertiary_safety_verified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_quaternary_emergency_last_modified_by_employee_id` FOREIGN KEY (`quaternary_emergency_last_modified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_quinary_emergency_plan_owner_employee_id` FOREIGN KEY (`quinary_emergency_plan_owner_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_tertiary_emergency_created_by_employee_id` FOREIGN KEY (`tertiary_emergency_created_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ADD CONSTRAINT `fk_hse_emergency_drill_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ADD CONSTRAINT `fk_hse_emergency_drill_quaternary_emergency_last_modified_by_employee_id` FOREIGN KEY (`quaternary_emergency_last_modified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`emergency_drill` ADD CONSTRAINT `fk_hse_emergency_drill_tertiary_emergency_created_by_employee_id` FOREIGN KEY (`tertiary_emergency_created_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`waste_manifest` ADD CONSTRAINT `fk_hse_waste_manifest_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ADD CONSTRAINT `fk_hse_objective_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ADD CONSTRAINT `fk_hse_objective_objective_created_by_employee_id` FOREIGN KEY (`objective_created_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ADD CONSTRAINT `fk_hse_objective_objective_employee_id` FOREIGN KEY (`objective_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ADD CONSTRAINT `fk_hse_objective_objective_last_modified_by_employee_id` FOREIGN KEY (`objective_last_modified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ADD CONSTRAINT `fk_hse_objective_objective_responsible_owner_employee_id` FOREIGN KEY (`objective_responsible_owner_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`objective` ADD CONSTRAINT `fk_hse_objective_primary_objective_employee_id` FOREIGN KEY (`primary_objective_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ADD CONSTRAINT `fk_hse_hse_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ADD CONSTRAINT `fk_hse_hse_risk_assessment_last_modified_by_employee_id` FOREIGN KEY (`last_modified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ADD CONSTRAINT `fk_hse_hse_risk_assessment_primary_hse_employee_id` FOREIGN KEY (`primary_hse_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`hse_risk_assessment` ADD CONSTRAINT `fk_hse_hse_risk_assessment_tertiary_hse_approved_by_employee_id` FOREIGN KEY (`tertiary_hse_approved_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_quaternary_management_last_modified_by_employee_id` FOREIGN KEY (`quaternary_management_last_modified_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`management_of_change` ADD CONSTRAINT `fk_hse_management_of_change_tertiary_management_created_by_employee_id` FOREIGN KEY (`tertiary_management_created_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`ldar_inspection` ADD CONSTRAINT `fk_hse_ldar_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`incident_substance_involvement` ADD CONSTRAINT `fk_hse_incident_substance_involvement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`hse`.`monitoring_station` ADD CONSTRAINT `fk_hse_monitoring_station_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= land --> asset (8 constraint(s)) =========
-- Requires: land schema, asset schema
ALTER TABLE `oil_gas_ecm`.`land`.`lease_expiry` ADD CONSTRAINT `fk_land_lease_expiry_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ADD CONSTRAINT `fk_land_suspense_account_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `oil_gas_ecm`.`asset`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ADD CONSTRAINT `fk_land_interest_assignment_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ADD CONSTRAINT `fk_land_orri_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ADD CONSTRAINT `fk_land_curative_action_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ADD CONSTRAINT `fk_land_lease_obligation_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ADD CONSTRAINT `fk_land_shut_in_royalty_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= land --> commercial (5 constraint(s)) =========
-- Requires: land schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ADD CONSTRAINT `fk_land_interest_assignment_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ADD CONSTRAINT `fk_land_interest_assignment_primary_interest_commercial_counterparty_id` FOREIGN KEY (`primary_interest_commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ADD CONSTRAINT `fk_land_shut_in_royalty_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ADD CONSTRAINT `fk_land_land_regulatory_filing_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);

-- ========= land --> compliance (11 constraint(s)) =========
-- Requires: land schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ADD CONSTRAINT `fk_land_tract_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ADD CONSTRAINT `fk_land_title_opinion_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ADD CONSTRAINT `fk_land_pooling_unit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ADD CONSTRAINT `fk_land_interest_assignment_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ADD CONSTRAINT `fk_land_curative_action_compliance_corrective_action_id` FOREIGN KEY (`compliance_corrective_action_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ADD CONSTRAINT `fk_land_lease_obligation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ADD CONSTRAINT `fk_land_leasing_prospect_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ADD CONSTRAINT `fk_land_land_regulatory_filing_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);

-- ========= land --> customer (1 constraint(s)) =========
-- Requires: land schema, customer schema
ALTER TABLE `oil_gas_ecm`.`land`.`lease_interest` ADD CONSTRAINT `fk_land_lease_interest_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);

-- ========= land --> drilling (5 constraint(s)) =========
-- Requires: land schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ADD CONSTRAINT `fk_land_pooling_unit_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`drilling`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`drilling`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ADD CONSTRAINT `fk_land_interest_assignment_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ADD CONSTRAINT `fk_land_leasing_prospect_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`drilling`.`operator`(`operator_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ADD CONSTRAINT `fk_land_land_regulatory_filing_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);

-- ========= land --> exploration (5 constraint(s)) =========
-- Requires: land schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ADD CONSTRAINT `fk_land_tract_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`pooling_unit` ADD CONSTRAINT `fk_land_pooling_unit_basin_id` FOREIGN KEY (`basin_id`) REFERENCES `oil_gas_ecm`.`exploration`.`basin`(`basin_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ADD CONSTRAINT `fk_land_leasing_prospect_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `oil_gas_ecm`.`exploration`.`prospect`(`prospect_id`);

-- ========= land --> finance (10 constraint(s)) =========
-- Requires: land schema, finance schema
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ADD CONSTRAINT `fk_land_delay_rental_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ADD CONSTRAINT `fk_land_delay_rental_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`suspense_account` ADD CONSTRAINT `fk_land_suspense_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ADD CONSTRAINT `fk_land_curative_action_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ADD CONSTRAINT `fk_land_lease_obligation_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ADD CONSTRAINT `fk_land_shut_in_royalty_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ADD CONSTRAINT `fk_land_leasing_prospect_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);

-- ========= land --> procurement (14 constraint(s)) =========
-- Requires: land schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ADD CONSTRAINT `fk_land_mineral_right_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`tract` ADD CONSTRAINT `fk_land_tract_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ADD CONSTRAINT `fk_land_title_opinion_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ADD CONSTRAINT `fk_land_surface_use_agreement_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`surface_use_agreement` ADD CONSTRAINT `fk_land_surface_use_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`right_of_way` ADD CONSTRAINT `fk_land_right_of_way_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ADD CONSTRAINT `fk_land_curative_action_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ADD CONSTRAINT `fk_land_lease_obligation_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ADD CONSTRAINT `fk_land_land_regulatory_filing_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= land --> product (6 constraint(s)) =========
-- Requires: land schema, product schema
ALTER TABLE `oil_gas_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`mineral_right` ADD CONSTRAINT `fk_land_mineral_right_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ADD CONSTRAINT `fk_land_division_order_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ADD CONSTRAINT `fk_land_royalty_disbursement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ADD CONSTRAINT `fk_land_leasing_prospect_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= land --> production (1 constraint(s)) =========
-- Requires: land schema, production schema
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ADD CONSTRAINT `fk_land_royalty_disbursement_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);

-- ========= land --> venture (10 constraint(s)) =========
-- Requires: land schema, venture schema
ALTER TABLE `oil_gas_ecm`.`land`.`division_order` ADD CONSTRAINT `fk_land_division_order_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_working_interest` ADD CONSTRAINT `fk_land_land_working_interest_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`royalty_disbursement` ADD CONSTRAINT `fk_land_royalty_disbursement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`interest_assignment` ADD CONSTRAINT `fk_land_interest_assignment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`orri` ADD CONSTRAINT `fk_land_orri_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ADD CONSTRAINT `fk_land_curative_action_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ADD CONSTRAINT `fk_land_lease_obligation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ADD CONSTRAINT `fk_land_shut_in_royalty_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ADD CONSTRAINT `fk_land_land_regulatory_filing_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);

-- ========= land --> workforce (13 constraint(s)) =========
-- Requires: land schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ADD CONSTRAINT `fk_land_title_opinion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`title_opinion` ADD CONSTRAINT `fk_land_title_opinion_tertiary_title_approved_by_employee_id` FOREIGN KEY (`tertiary_title_approved_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_acquisition` ADD CONSTRAINT `fk_land_lease_acquisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`delay_rental` ADD CONSTRAINT `fk_land_delay_rental_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ADD CONSTRAINT `fk_land_curative_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ADD CONSTRAINT `fk_land_curative_action_quaternary_curative_assigned_landman_employee_id` FOREIGN KEY (`quaternary_curative_assigned_landman_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`curative_action` ADD CONSTRAINT `fk_land_curative_action_tertiary_curative_approved_by_user_employee_id` FOREIGN KEY (`tertiary_curative_approved_by_user_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`lease_obligation` ADD CONSTRAINT `fk_land_lease_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`shut_in_royalty` ADD CONSTRAINT `fk_land_shut_in_royalty_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ADD CONSTRAINT `fk_land_leasing_prospect_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`leasing_prospect` ADD CONSTRAINT `fk_land_leasing_prospect_land_manager_employee_id` FOREIGN KEY (`land_manager_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`land`.`land_regulatory_filing` ADD CONSTRAINT `fk_land_land_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= logistics --> asset (8 constraint(s)) =========
-- Requires: logistics schema, asset schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_shipment_asset_facility_id` FOREIGN KEY (`shipment_asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ADD CONSTRAINT `fk_logistics_tariff_rate_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);

-- ========= logistics --> commercial (23 constraint(s)) =========
-- Requires: logistics schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_voyage_shipowner_commercial_counterparty_id` FOREIGN KEY (`voyage_shipowner_commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ADD CONSTRAINT `fk_logistics_tariff_rate_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_tertiary_delivery_consignee_party_commercial_counterparty_id` FOREIGN KEY (`tertiary_delivery_consignee_party_commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ADD CONSTRAINT `fk_logistics_demurrage_claim_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ADD CONSTRAINT `fk_logistics_demurrage_claim_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ADD CONSTRAINT `fk_logistics_shipping_schedule_lifting_program_id` FOREIGN KEY (`lifting_program_id`) REFERENCES `oil_gas_ecm`.`commercial`.`lifting_program`(`lifting_program_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ADD CONSTRAINT `fk_logistics_charter_party_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ADD CONSTRAINT `fk_logistics_rail_waybill_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ADD CONSTRAINT `fk_logistics_rail_waybill_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ADD CONSTRAINT `fk_logistics_cargo_inspection_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_contract_engagement` ADD CONSTRAINT `fk_logistics_carrier_contract_engagement_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);

-- ========= logistics --> compliance (22 constraint(s)) =========
-- Requires: logistics schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ADD CONSTRAINT `fk_logistics_vessel_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ADD CONSTRAINT `fk_logistics_tariff_rate_ferc_tariff_id` FOREIGN KEY (`ferc_tariff_id`) REFERENCES `oil_gas_ecm`.`compliance`.`ferc_tariff`(`ferc_tariff_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ADD CONSTRAINT `fk_logistics_demurrage_claim_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ADD CONSTRAINT `fk_logistics_truck_ticket_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ADD CONSTRAINT `fk_logistics_charter_party_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ADD CONSTRAINT `fk_logistics_port_call_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ADD CONSTRAINT `fk_logistics_rail_waybill_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= logistics --> customer (8 constraint(s)) =========
-- Requires: logistics schema, customer schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_customer_lifting_schedule_id` FOREIGN KEY (`customer_lifting_schedule_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_lifting_schedule`(`customer_lifting_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ADD CONSTRAINT `fk_logistics_cargo_inspection_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal_access_agreement` ADD CONSTRAINT `fk_logistics_terminal_access_agreement_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);

-- ========= logistics --> drilling (3 constraint(s)) =========
-- Requires: logistics schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);

-- ========= logistics --> exploration (1 constraint(s)) =========
-- Requires: logistics schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);

-- ========= logistics --> finance (50 constraint(s)) =========
-- Requires: logistics schema, finance schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ADD CONSTRAINT `fk_logistics_tariff_rate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ADD CONSTRAINT `fk_logistics_tariff_rate_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ADD CONSTRAINT `fk_logistics_demurrage_claim_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ADD CONSTRAINT `fk_logistics_demurrage_claim_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ADD CONSTRAINT `fk_logistics_demurrage_claim_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ADD CONSTRAINT `fk_logistics_shipping_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipping_schedule` ADD CONSTRAINT `fk_logistics_shipping_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ADD CONSTRAINT `fk_logistics_truck_ticket_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ADD CONSTRAINT `fk_logistics_truck_ticket_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ADD CONSTRAINT `fk_logistics_charter_party_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ADD CONSTRAINT `fk_logistics_charter_party_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ADD CONSTRAINT `fk_logistics_charter_party_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ADD CONSTRAINT `fk_logistics_port_call_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ADD CONSTRAINT `fk_logistics_port_call_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ADD CONSTRAINT `fk_logistics_port_call_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ADD CONSTRAINT `fk_logistics_rail_waybill_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ADD CONSTRAINT `fk_logistics_rail_waybill_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ADD CONSTRAINT `fk_logistics_rail_waybill_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ADD CONSTRAINT `fk_logistics_cargo_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ADD CONSTRAINT `fk_logistics_cargo_inspection_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ADD CONSTRAINT `fk_logistics_cargo_inspection_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= logistics --> hse (13 constraint(s)) =========
-- Requires: logistics schema, hse schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_hse_training_record_id` FOREIGN KEY (`hse_training_record_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_training_record`(`hse_training_record_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel` ADD CONSTRAINT `fk_logistics_vessel_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `oil_gas_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `oil_gas_ecm`.`hse`.`emission_source`(`emission_source_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_objective_id` FOREIGN KEY (`objective_id`) REFERENCES `oil_gas_ecm`.`hse`.`objective`(`objective_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_spill_event_id` FOREIGN KEY (`spill_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`spill_event`(`spill_event_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `oil_gas_ecm`.`hse`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `oil_gas_ecm`.`hse`.`ghg_emission`(`ghg_emission_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_spill_event_id` FOREIGN KEY (`spill_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`spill_event`(`spill_event_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ADD CONSTRAINT `fk_logistics_rail_waybill_waste_manifest_id` FOREIGN KEY (`waste_manifest_id`) REFERENCES `oil_gas_ecm`.`hse`.`waste_manifest`(`waste_manifest_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ADD CONSTRAINT `fk_logistics_cargo_inspection_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `oil_gas_ecm`.`hse`.`environmental_monitoring`(`environmental_monitoring_id`);

-- ========= logistics --> land (11 constraint(s)) =========
-- Requires: logistics schema, land schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ADD CONSTRAINT `fk_logistics_truck_ticket_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ADD CONSTRAINT `fk_logistics_rail_waybill_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipper` ADD CONSTRAINT `fk_logistics_shipper_tax_entity_id` FOREIGN KEY (`tax_entity_id`) REFERENCES `oil_gas_ecm`.`land`.`tax_entity`(`tax_entity_id`);

-- ========= logistics --> petrochemical (1 constraint(s)) =========
-- Requires: logistics schema, petrochemical schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ADD CONSTRAINT `fk_logistics_carrier_product_approval_product_catalog_id` FOREIGN KEY (`product_catalog_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`product_catalog`(`product_catalog_id`);

-- ========= logistics --> procurement (6 constraint(s)) =========
-- Requires: logistics schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ADD CONSTRAINT `fk_logistics_port_call_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ADD CONSTRAINT `fk_logistics_cargo_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= logistics --> product (16 constraint(s)) =========
-- Requires: logistics schema, product schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ADD CONSTRAINT `fk_logistics_truck_ticket_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`rail_waybill` ADD CONSTRAINT `fk_logistics_rail_waybill_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ADD CONSTRAINT `fk_logistics_cargo_inspection_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ADD CONSTRAINT `fk_logistics_carrier_product_authorization_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`vessel_cargo_compatibility` ADD CONSTRAINT `fk_logistics_vessel_cargo_compatibility_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= logistics --> reservoir (7 constraint(s)) =========
-- Requires: logistics schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ADD CONSTRAINT `fk_logistics_truck_ticket_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);

-- ========= logistics --> revenue (3 constraint(s)) =========
-- Requires: logistics schema, revenue schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `oil_gas_ecm`.`revenue`.`settlement`(`settlement_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ADD CONSTRAINT `fk_logistics_demurrage_claim_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);

-- ========= logistics --> venture (19 constraint(s)) =========
-- Requires: logistics schema, venture schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_nomination` ADD CONSTRAINT `fk_logistics_pipeline_nomination_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`logistics_lifting_schedule` ADD CONSTRAINT `fk_logistics_logistics_lifting_schedule_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`custody_transfer` ADD CONSTRAINT `fk_logistics_custody_transfer_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`tariff_rate` ADD CONSTRAINT `fk_logistics_tariff_rate_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ADD CONSTRAINT `fk_logistics_demurrage_claim_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ADD CONSTRAINT `fk_logistics_port_call_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_throughput` ADD CONSTRAINT `fk_logistics_pipeline_throughput_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ADD CONSTRAINT `fk_logistics_cargo_inspection_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);

-- ========= logistics --> workforce (17 constraint(s)) =========
-- Requires: logistics schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`logistics`.`shipment` ADD CONSTRAINT `fk_logistics_shipment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`voyage` ADD CONSTRAINT `fk_logistics_voyage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`terminal` ADD CONSTRAINT `fk_logistics_terminal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`delivery_order` ADD CONSTRAINT `fk_logistics_delivery_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier` ADD CONSTRAINT `fk_logistics_carrier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`freight_invoice` ADD CONSTRAINT `fk_logistics_freight_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`demurrage_claim` ADD CONSTRAINT `fk_logistics_demurrage_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`truck_ticket` ADD CONSTRAINT `fk_logistics_truck_ticket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`pipeline_batch` ADD CONSTRAINT `fk_logistics_pipeline_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`storage_inventory` ADD CONSTRAINT `fk_logistics_storage_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`charter_party` ADD CONSTRAINT `fk_logistics_charter_party_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`port_call` ADD CONSTRAINT `fk_logistics_port_call_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`lng_cargo` ADD CONSTRAINT `fk_logistics_lng_cargo_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`measurement_point` ADD CONSTRAINT `fk_logistics_measurement_point_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`cargo_inspection` ADD CONSTRAINT `fk_logistics_cargo_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_authorization` ADD CONSTRAINT `fk_logistics_carrier_product_authorization_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`logistics`.`carrier_product_approval` ADD CONSTRAINT `fk_logistics_carrier_product_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= petrochemical --> asset (10 constraint(s)) =========
-- Requires: petrochemical schema, asset schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ADD CONSTRAINT `fk_petrochemical_conversion_unit_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_lab_instrument_equipment_id` FOREIGN KEY (`lab_instrument_equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_storage_tank_equipment_id` FOREIGN KEY (`storage_tank_equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ADD CONSTRAINT `fk_petrochemical_ngl_fractionation_run_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ADD CONSTRAINT `fk_petrochemical_catalyst_record_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_work_order` ADD CONSTRAINT `fk_petrochemical_turnaround_work_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_integrity_enrollment` ADD CONSTRAINT `fk_petrochemical_unit_integrity_enrollment_integrity_program_id` FOREIGN KEY (`integrity_program_id`) REFERENCES `oil_gas_ecm`.`asset`.`integrity_program`(`integrity_program_id`);

-- ========= petrochemical --> commercial (8 constraint(s)) =========
-- Requires: petrochemical schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);

-- ========= petrochemical --> compliance (23 constraint(s)) =========
-- Requires: petrochemical schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ADD CONSTRAINT `fk_petrochemical_plant_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ADD CONSTRAINT `fk_petrochemical_conversion_unit_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ADD CONSTRAINT `fk_petrochemical_conversion_unit_consent_order_id` FOREIGN KEY (`consent_order_id`) REFERENCES `oil_gas_ecm`.`compliance`.`consent_order`(`consent_order_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ADD CONSTRAINT `fk_petrochemical_conversion_unit_regulatory_audit_id` FOREIGN KEY (`regulatory_audit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_audit`(`regulatory_audit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `oil_gas_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_compliance_corrective_action_id` FOREIGN KEY (`compliance_corrective_action_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_waiver_id` FOREIGN KEY (`waiver_id`) REFERENCES `oil_gas_ecm`.`compliance`.`waiver`(`waiver_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `oil_gas_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ADD CONSTRAINT `fk_petrochemical_plant_opex_record_compliance_audit_finding_id` FOREIGN KEY (`compliance_audit_finding_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_audit_finding`(`compliance_audit_finding_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ADD CONSTRAINT `fk_petrochemical_plant_opex_record_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `oil_gas_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ADD CONSTRAINT `fk_petrochemical_turnaround_event_compliance_corrective_action_id` FOREIGN KEY (`compliance_corrective_action_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ADD CONSTRAINT `fk_petrochemical_turnaround_event_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ADD CONSTRAINT `fk_petrochemical_turnaround_event_regulatory_audit_id` FOREIGN KEY (`regulatory_audit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_audit`(`regulatory_audit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ADD CONSTRAINT `fk_petrochemical_ngl_fractionation_run_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ADD CONSTRAINT `fk_petrochemical_product_inventory_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_ferc_tariff_id` FOREIGN KEY (`ferc_tariff_id`) REFERENCES `oil_gas_ecm`.`compliance`.`ferc_tariff`(`ferc_tariff_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);

-- ========= petrochemical --> customer (7 constraint(s)) =========
-- Requires: petrochemical schema, customer schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `oil_gas_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ADD CONSTRAINT `fk_petrochemical_petrochemical_product_approval_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);

-- ========= petrochemical --> drilling (1 constraint(s)) =========
-- Requires: petrochemical schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);

-- ========= petrochemical --> finance (39 constraint(s)) =========
-- Requires: petrochemical schema, finance schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ADD CONSTRAINT `fk_petrochemical_plant_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ADD CONSTRAINT `fk_petrochemical_plant_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ADD CONSTRAINT `fk_petrochemical_conversion_unit_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ADD CONSTRAINT `fk_petrochemical_unit_run_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ADD CONSTRAINT `fk_petrochemical_unit_run_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ADD CONSTRAINT `fk_petrochemical_petrochemical_yield_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ADD CONSTRAINT `fk_petrochemical_petrochemical_yield_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ADD CONSTRAINT `fk_petrochemical_plant_opex_record_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ADD CONSTRAINT `fk_petrochemical_plant_opex_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ADD CONSTRAINT `fk_petrochemical_plant_opex_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ADD CONSTRAINT `fk_petrochemical_turnaround_event_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ADD CONSTRAINT `fk_petrochemical_process_simulation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ADD CONSTRAINT `fk_petrochemical_process_simulation_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ADD CONSTRAINT `fk_petrochemical_ngl_fractionation_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ADD CONSTRAINT `fk_petrochemical_ngl_fractionation_run_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ADD CONSTRAINT `fk_petrochemical_product_inventory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ADD CONSTRAINT `fk_petrochemical_product_inventory_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ADD CONSTRAINT `fk_petrochemical_plant_capacity_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ADD CONSTRAINT `fk_petrochemical_mass_balance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ADD CONSTRAINT `fk_petrochemical_catalyst_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ADD CONSTRAINT `fk_petrochemical_catalyst_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= petrochemical --> hse (1 constraint(s)) =========
-- Requires: petrochemical schema, hse schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_waste_manifest_id` FOREIGN KEY (`waste_manifest_id`) REFERENCES `oil_gas_ecm`.`hse`.`waste_manifest`(`waste_manifest_id`);

-- ========= petrochemical --> land (3 constraint(s)) =========
-- Requires: petrochemical schema, land schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ADD CONSTRAINT `fk_petrochemical_ngl_fractionation_run_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= petrochemical --> logistics (10 constraint(s)) =========
-- Requires: petrochemical schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ADD CONSTRAINT `fk_petrochemical_plant_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_pipeline_batch_id` FOREIGN KEY (`pipeline_batch_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_batch`(`pipeline_batch_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_custody_transfer_id` FOREIGN KEY (`custody_transfer_id`) REFERENCES `oil_gas_ecm`.`logistics`.`custody_transfer`(`custody_transfer_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ADD CONSTRAINT `fk_petrochemical_product_inventory_storage_inventory_id` FOREIGN KEY (`storage_inventory_id`) REFERENCES `oil_gas_ecm`.`logistics`.`storage_inventory`(`storage_inventory_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `oil_gas_ecm`.`logistics`.`voyage`(`voyage_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_carrier_contract` ADD CONSTRAINT `fk_petrochemical_plant_carrier_contract_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);

-- ========= petrochemical --> procurement (5 constraint(s)) =========
-- Requires: petrochemical schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ADD CONSTRAINT `fk_petrochemical_catalyst_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= petrochemical --> product (12 constraint(s)) =========
-- Requires: petrochemical schema, product schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ADD CONSTRAINT `fk_petrochemical_feedstock_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ADD CONSTRAINT `fk_petrochemical_petrochemical_yield_record_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_catalog` ADD CONSTRAINT `fk_petrochemical_product_catalog_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ADD CONSTRAINT `fk_petrochemical_process_simulation_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ADD CONSTRAINT `fk_petrochemical_ngl_fractionation_run_ngl_stream_id` FOREIGN KEY (`ngl_stream_id`) REFERENCES `oil_gas_ecm`.`product`.`ngl_stream`(`ngl_stream_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ADD CONSTRAINT `fk_petrochemical_product_inventory_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= petrochemical --> production (6 constraint(s)) =========
-- Requires: petrochemical schema, production schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ADD CONSTRAINT `fk_petrochemical_ngl_fractionation_run_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_inventory` ADD CONSTRAINT `fk_petrochemical_product_inventory_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `oil_gas_ecm`.`production`.`storage_tank`(`storage_tank_id`);

-- ========= petrochemical --> refining (4 constraint(s)) =========
-- Requires: petrochemical schema, refining schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock` ADD CONSTRAINT `fk_petrochemical_feedstock_product_specification_id` FOREIGN KEY (`product_specification_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_specification`(`product_specification_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_crude_assay_id` FOREIGN KEY (`crude_assay_id`) REFERENCES `oil_gas_ecm`.`refining`.`crude_assay`(`crude_assay_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_product_quality_test_id` FOREIGN KEY (`product_quality_test_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_quality_test`(`product_quality_test_id`);

-- ========= petrochemical --> reservoir (5 constraint(s)) =========
-- Requires: petrochemical schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_receipt` ADD CONSTRAINT `fk_petrochemical_feedstock_receipt_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ADD CONSTRAINT `fk_petrochemical_petrochemical_yield_record_simulation_run_id` FOREIGN KEY (`simulation_run_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_run`(`simulation_run_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ADD CONSTRAINT `fk_petrochemical_plant_capacity_plan_simulation_run_id` FOREIGN KEY (`simulation_run_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_run`(`simulation_run_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ADD CONSTRAINT `fk_petrochemical_mass_balance_simulation_run_id` FOREIGN KEY (`simulation_run_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`simulation_run`(`simulation_run_id`);

-- ========= petrochemical --> revenue (4 constraint(s)) =========
-- Requires: petrochemical schema, revenue schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ADD CONSTRAINT `fk_petrochemical_plant_opex_record_intercompany_billing_id` FOREIGN KEY (`intercompany_billing_id`) REFERENCES `oil_gas_ecm`.`revenue`.`intercompany_billing`(`intercompany_billing_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `oil_gas_ecm`.`revenue`.`settlement`(`settlement_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `oil_gas_ecm`.`revenue`.`invoice`(`invoice_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `oil_gas_ecm`.`revenue`.`settlement`(`settlement_id`);

-- ========= petrochemical --> venture (14 constraint(s)) =========
-- Requires: petrochemical schema, venture schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant` ADD CONSTRAINT `fk_petrochemical_plant_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`conversion_unit` ADD CONSTRAINT `fk_petrochemical_conversion_unit_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`feedstock_allocation` ADD CONSTRAINT `fk_petrochemical_feedstock_allocation_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ADD CONSTRAINT `fk_petrochemical_plant_opex_record_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ADD CONSTRAINT `fk_petrochemical_turnaround_event_venture_afe_id` FOREIGN KEY (`venture_afe_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_afe`(`venture_afe_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_lifting` ADD CONSTRAINT `fk_petrochemical_product_lifting_lifting_entitlement_id` FOREIGN KEY (`lifting_entitlement_id`) REFERENCES `oil_gas_ecm`.`venture`.`lifting_entitlement`(`lifting_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ADD CONSTRAINT `fk_petrochemical_plant_capacity_plan_jv_budget_id` FOREIGN KEY (`jv_budget_id`) REFERENCES `oil_gas_ecm`.`venture`.`jv_budget`(`jv_budget_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ADD CONSTRAINT `fk_petrochemical_mass_balance_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ADD CONSTRAINT `fk_petrochemical_catalyst_record_venture_afe_id` FOREIGN KEY (`venture_afe_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_afe`(`venture_afe_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_ownership_interest` ADD CONSTRAINT `fk_petrochemical_plant_ownership_interest_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`product_entitlement` ADD CONSTRAINT `fk_petrochemical_product_entitlement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);

-- ========= petrochemical --> workforce (21 constraint(s)) =========
-- Requires: petrochemical schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`unit_run_record` ADD CONSTRAINT `fk_petrochemical_unit_run_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_yield_record` ADD CONSTRAINT `fk_petrochemical_petrochemical_yield_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`quality_assay` ADD CONSTRAINT `fk_petrochemical_quality_assay_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`production_order` ADD CONSTRAINT `fk_petrochemical_production_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ADD CONSTRAINT `fk_petrochemical_plant_opex_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ADD CONSTRAINT `fk_petrochemical_plant_opex_record_primary_plant_employee_id` FOREIGN KEY (`primary_plant_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_opex_record` ADD CONSTRAINT `fk_petrochemical_plant_opex_record_tertiary_plant_updated_by_user_employee_id` FOREIGN KEY (`tertiary_plant_updated_by_user_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ADD CONSTRAINT `fk_petrochemical_turnaround_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_event` ADD CONSTRAINT `fk_petrochemical_turnaround_event_tertiary_turnaround_updated_by_employee_id` FOREIGN KEY (`tertiary_turnaround_updated_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ADD CONSTRAINT `fk_petrochemical_process_simulation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`process_simulation` ADD CONSTRAINT `fk_petrochemical_process_simulation_tertiary_process_model_owner_employee_id` FOREIGN KEY (`tertiary_process_model_owner_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`ngl_fractionation_run` ADD CONSTRAINT `fk_petrochemical_ngl_fractionation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`offtake_nomination` ADD CONSTRAINT `fk_petrochemical_offtake_nomination_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`waste_disposal_record` ADD CONSTRAINT `fk_petrochemical_waste_disposal_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`plant_capacity_plan` ADD CONSTRAINT `fk_petrochemical_plant_capacity_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`mass_balance` ADD CONSTRAINT `fk_petrochemical_mass_balance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ADD CONSTRAINT `fk_petrochemical_catalyst_record_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`catalyst_record` ADD CONSTRAINT `fk_petrochemical_catalyst_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`petrochemical_product_approval` ADD CONSTRAINT `fk_petrochemical_petrochemical_product_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`petrochemical`.`turnaround_contractor_engagement` ADD CONSTRAINT `fk_petrochemical_turnaround_contractor_engagement_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);

-- ========= procurement --> asset (5 constraint(s)) =========
-- Requires: procurement schema, asset schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `oil_gas_ecm`.`asset`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ADD CONSTRAINT `fk_procurement_material_reservation_hierarchy_id` FOREIGN KEY (`hierarchy_id`) REFERENCES `oil_gas_ecm`.`asset`.`hierarchy`(`hierarchy_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ADD CONSTRAINT `fk_procurement_material_reservation_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ADD CONSTRAINT `fk_procurement_material_reservation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= procurement --> drilling (3 constraint(s)) =========
-- Requires: procurement schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ADD CONSTRAINT `fk_procurement_material_reservation_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);

-- ========= procurement --> finance (16 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ADD CONSTRAINT `fk_procurement_vendor_bid_project_id` FOREIGN KEY (`project_id`) REFERENCES `oil_gas_ecm`.`finance`.`project`(`project_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ADD CONSTRAINT `fk_procurement_afe_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ADD CONSTRAINT `fk_procurement_afe_budget_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ADD CONSTRAINT `fk_procurement_afe_budget_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ADD CONSTRAINT `fk_procurement_material_requisition_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ADD CONSTRAINT `fk_procurement_material_reservation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= procurement --> logistics (7 constraint(s)) =========
-- Requires: procurement schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_port_call_id` FOREIGN KEY (`port_call_id`) REFERENCES `oil_gas_ecm`.`logistics`.`port_call`(`port_call_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `oil_gas_ecm`.`logistics`.`voyage`(`voyage_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_demurrage_claim_id` FOREIGN KEY (`demurrage_claim_id`) REFERENCES `oil_gas_ecm`.`logistics`.`demurrage_claim`(`demurrage_claim_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_voyage_id` FOREIGN KEY (`voyage_id`) REFERENCES `oil_gas_ecm`.`logistics`.`voyage`(`voyage_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ADD CONSTRAINT `fk_procurement_inspection_lot_cargo_inspection_id` FOREIGN KEY (`cargo_inspection_id`) REFERENCES `oil_gas_ecm`.`logistics`.`cargo_inspection`(`cargo_inspection_id`);

-- ========= procurement --> product (13 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_master` ADD CONSTRAINT `fk_procurement_material_master_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ADD CONSTRAINT `fk_procurement_vendor_bid_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`po_line_item` ADD CONSTRAINT `fk_procurement_po_line_item_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`warehouse_inventory` ADD CONSTRAINT `fk_procurement_warehouse_inventory_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ADD CONSTRAINT `fk_procurement_inspection_lot_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ADD CONSTRAINT `fk_procurement_material_reservation_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= procurement --> venture (1 constraint(s)) =========
-- Requires: procurement schema, venture schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);

-- ========= procurement --> workforce (14 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_bid` ADD CONSTRAINT `fk_procurement_vendor_bid_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`contract_amendment` ADD CONSTRAINT `fk_procurement_contract_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`afe_budget` ADD CONSTRAINT `fk_procurement_afe_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_requisition` ADD CONSTRAINT `fk_procurement_material_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`inspection_lot` ADD CONSTRAINT `fk_procurement_inspection_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`material_reservation` ADD CONSTRAINT `fk_procurement_material_reservation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`procurement`.`project` ADD CONSTRAINT `fk_procurement_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= product --> asset (5 constraint(s)) =========
-- Requires: product schema, asset schema
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ADD CONSTRAINT `fk_product_blend_recipe_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ADD CONSTRAINT `fk_product_loss_gain_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);

-- ========= product --> finance (17 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ADD CONSTRAINT `fk_product_crude_grade_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ADD CONSTRAINT `fk_product_assay_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ADD CONSTRAINT `fk_product_refined_product_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ADD CONSTRAINT `fk_product_lng_specification_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ADD CONSTRAINT `fk_product_petrochemical_product_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ADD CONSTRAINT `fk_product_blend_recipe_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ADD CONSTRAINT `fk_product_blend_recipe_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ADD CONSTRAINT `fk_product_loss_gain_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ADD CONSTRAINT `fk_product_loss_gain_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ADD CONSTRAINT `fk_product_regulatory_approval_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`regulatory_approval` ADD CONSTRAINT `fk_product_regulatory_approval_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`price_history` ADD CONSTRAINT `fk_product_price_history_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`budget_allocation` ADD CONSTRAINT `fk_product_budget_allocation_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `oil_gas_ecm`.`finance`.`budget`(`budget_id`);

-- ========= product --> land (3 constraint(s)) =========
-- Requires: product schema, land schema
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ADD CONSTRAINT `fk_product_assay_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= product --> logistics (2 constraint(s)) =========
-- Requires: product schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_cargo_id` FOREIGN KEY (`cargo_id`) REFERENCES `oil_gas_ecm`.`logistics`.`cargo`(`cargo_id`);

-- ========= product --> procurement (10 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ADD CONSTRAINT `fk_product_crude_grade_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ADD CONSTRAINT `fk_product_assay_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ADD CONSTRAINT `fk_product_lng_specification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ADD CONSTRAINT `fk_product_petrochemical_product_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ADD CONSTRAINT `fk_product_blend_recipe_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ADD CONSTRAINT `fk_product_additive_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`safety_data_sheet` ADD CONSTRAINT `fk_product_safety_data_sheet_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= product --> refining (1 constraint(s)) =========
-- Requires: product schema, refining schema
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_sample_id` FOREIGN KEY (`sample_id`) REFERENCES `oil_gas_ecm`.`refining`.`sample`(`sample_id`);

-- ========= product --> venture (9 constraint(s)) =========
-- Requires: product schema, venture schema
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ADD CONSTRAINT `fk_product_petrochemical_product_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ADD CONSTRAINT `fk_product_blend_recipe_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ADD CONSTRAINT `fk_product_loss_gain_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`loss_gain` ADD CONSTRAINT `fk_product_loss_gain_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`crude_lifting_nomination` ADD CONSTRAINT `fk_product_crude_lifting_nomination_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`entitlement` ADD CONSTRAINT `fk_product_entitlement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);

-- ========= product --> workforce (16 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`product`.`petroleum_product` ADD CONSTRAINT `fk_product_petroleum_product_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`crude_grade` ADD CONSTRAINT `fk_product_crude_grade_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_spec` ADD CONSTRAINT `fk_product_quality_spec_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`assay` ADD CONSTRAINT `fk_product_assay_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`refined_product` ADD CONSTRAINT `fk_product_refined_product_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`ngl_stream` ADD CONSTRAINT `fk_product_ngl_stream_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`lng_specification` ADD CONSTRAINT `fk_product_lng_specification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`petrochemical_product` ADD CONSTRAINT `fk_product_petrochemical_product_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`quality_test_result` ADD CONSTRAINT `fk_product_quality_test_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`certificate_of_quality` ADD CONSTRAINT `fk_product_certificate_of_quality_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`blend_recipe` ADD CONSTRAINT `fk_product_blend_recipe_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`additive` ADD CONSTRAINT `fk_product_additive_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`lifecycle_status` ADD CONSTRAINT `fk_product_lifecycle_status_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`substitution` ADD CONSTRAINT `fk_product_substitution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`handling_requirement` ADD CONSTRAINT `fk_product_handling_requirement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`product`.`emission_factor` ADD CONSTRAINT `fk_product_emission_factor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= production --> asset (21 constraint(s)) =========
-- Requires: production schema, asset schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ADD CONSTRAINT `fk_production_sharing_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`event` ADD CONSTRAINT `fk_production_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`event` ADD CONSTRAINT `fk_production_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ADD CONSTRAINT `fk_production_reservoir_pressure_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ADD CONSTRAINT `fk_production_chemical_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ADD CONSTRAINT `fk_production_sand_management_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ADD CONSTRAINT `fk_production_water_management_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ADD CONSTRAINT `fk_production_water_management_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`scada_tag` ADD CONSTRAINT `fk_production_scada_tag_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);

-- ========= production --> commercial (9 constraint(s)) =========
-- Requires: production schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`facility_offtake_allocation` ADD CONSTRAINT `fk_production_facility_offtake_allocation_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`well_contract_allocation` ADD CONSTRAINT `fk_production_well_contract_allocation_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);

-- ========= production --> compliance (13 constraint(s)) =========
-- Requires: production schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_compliance_certification_id` FOREIGN KEY (`compliance_certification_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_certification`(`compliance_certification_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_compliance_sec_reserves_disclosure_id` FOREIGN KEY (`compliance_sec_reserves_disclosure_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_sec_reserves_disclosure`(`compliance_sec_reserves_disclosure_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ADD CONSTRAINT `fk_production_water_management_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= production --> drilling (19 constraint(s)) =========
-- Requires: production schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ADD CONSTRAINT `fk_production_sharing_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`event` ADD CONSTRAINT `fk_production_event_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ADD CONSTRAINT `fk_production_reservoir_pressure_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ADD CONSTRAINT `fk_production_choke_setting_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ADD CONSTRAINT `fk_production_chemical_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ADD CONSTRAINT `fk_production_sand_management_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ADD CONSTRAINT `fk_production_water_management_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ADD CONSTRAINT `fk_production_esp_performance_drilling_well_id` FOREIGN KEY (`drilling_well_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_well`(`drilling_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`field` ADD CONSTRAINT `fk_production_field_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `oil_gas_ecm`.`drilling`.`operator`(`operator_id`);

-- ========= production --> exploration (4 constraint(s)) =========
-- Requires: production schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_block_id` FOREIGN KEY (`block_id`) REFERENCES `oil_gas_ecm`.`exploration`.`block`(`block_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_discovery_id` FOREIGN KEY (`discovery_id`) REFERENCES `oil_gas_ecm`.`exploration`.`discovery`(`discovery_id`);

-- ========= production --> finance (25 constraint(s)) =========
-- Requires: production schema, finance schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`event` ADD CONSTRAINT `fk_production_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`event` ADD CONSTRAINT `fk_production_event_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ADD CONSTRAINT `fk_production_chemical_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ADD CONSTRAINT `fk_production_chemical_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`well_afe_assignment` ADD CONSTRAINT `fk_production_well_afe_assignment_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);

-- ========= production --> hse (7 constraint(s)) =========
-- Requires: production schema, hse schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `oil_gas_ecm`.`hse`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_norm_record_id` FOREIGN KEY (`norm_record_id`) REFERENCES `oil_gas_ecm`.`hse`.`norm_record`(`norm_record_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `oil_gas_ecm`.`hse`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `oil_gas_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `oil_gas_ecm`.`hse`.`emission_source`(`emission_source_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_ghg_emission_id` FOREIGN KEY (`ghg_emission_id`) REFERENCES `oil_gas_ecm`.`hse`.`ghg_emission`(`ghg_emission_id`);

-- ========= production --> land (4 constraint(s)) =========
-- Requires: production schema, land schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`working_interest` ADD CONSTRAINT `fk_production_working_interest_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`working_interest` ADD CONSTRAINT `fk_production_working_interest_party_id` FOREIGN KEY (`party_id`) REFERENCES `oil_gas_ecm`.`land`.`party`(`party_id`);

-- ========= production --> logistics (6 constraint(s)) =========
-- Requires: production schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `oil_gas_ecm`.`logistics`.`carrier`(`carrier_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);

-- ========= production --> petrochemical (1 constraint(s)) =========
-- Requires: production schema, petrochemical schema
ALTER TABLE `oil_gas_ecm`.`production`.`facility_plant_supply` ADD CONSTRAINT `fk_production_facility_plant_supply_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);

-- ========= production --> procurement (15 constraint(s)) =========
-- Requires: production schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`event` ADD CONSTRAINT `fk_production_event_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ADD CONSTRAINT `fk_production_chemical_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ADD CONSTRAINT `fk_production_chemical_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`pipeline_connection` ADD CONSTRAINT `fk_production_pipeline_connection_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);

-- ========= production --> product (10 constraint(s)) =========
-- Requires: production schema, product schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= production --> reservoir (15 constraint(s)) =========
-- Requires: production schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_well_test_id` FOREIGN KEY (`well_test_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`well_test`(`well_test_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_well_test_id` FOREIGN KEY (`well_test_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`well_test`(`well_test_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_eor_scheme_id` FOREIGN KEY (`eor_scheme_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`eor_scheme`(`eor_scheme_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`event` ADD CONSTRAINT `fk_production_event_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ADD CONSTRAINT `fk_production_reservoir_pressure_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ADD CONSTRAINT `fk_production_choke_setting_well_test_id` FOREIGN KEY (`well_test_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`well_test`(`well_test_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ADD CONSTRAINT `fk_production_chemical_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ADD CONSTRAINT `fk_production_sand_management_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ADD CONSTRAINT `fk_production_esp_performance_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);

-- ========= production --> venture (33 constraint(s)) =========
-- Requires: production schema, venture schema
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_well` ADD CONSTRAINT `fk_production_production_well_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_facility` ADD CONSTRAINT `fk_production_production_facility_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_jib_batch_id` FOREIGN KEY (`jib_batch_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_batch`(`jib_batch_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`monthly_production` ADD CONSTRAINT `fk_production_monthly_production_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`downtime_event` ADD CONSTRAINT `fk_production_downtime_event_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_well` ADD CONSTRAINT `fk_production_injection_well_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`run_ticket` ADD CONSTRAINT `fk_production_run_ticket_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ADD CONSTRAINT `fk_production_sharing_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ADD CONSTRAINT `fk_production_sharing_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`sharing` ADD CONSTRAINT `fk_production_sharing_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`event` ADD CONSTRAINT `fk_production_event_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ADD CONSTRAINT `fk_production_reservoir_pressure_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`chemical` ADD CONSTRAINT `fk_production_chemical_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ADD CONSTRAINT `fk_production_sand_management_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ADD CONSTRAINT `fk_production_water_management_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ADD CONSTRAINT `fk_production_esp_performance_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ADD CONSTRAINT `fk_production_production_working_interest_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_working_interest` ADD CONSTRAINT `fk_production_production_working_interest_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ADD CONSTRAINT `fk_production_facility_working_interest_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`facility_working_interest` ADD CONSTRAINT `fk_production_facility_working_interest_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);

-- ========= production --> workforce (15 constraint(s)) =========
-- Requires: production schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`production`.`daily_production` ADD CONSTRAINT `fk_production_daily_production_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`production_allocation` ADD CONSTRAINT `fk_production_production_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`artificial_lift` ADD CONSTRAINT `fk_production_artificial_lift_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`forecast` ADD CONSTRAINT `fk_production_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`injection_record` ADD CONSTRAINT `fk_production_injection_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`gas_measurement` ADD CONSTRAINT `fk_production_gas_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`reservoir_pressure` ADD CONSTRAINT `fk_production_reservoir_pressure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`choke_setting` ADD CONSTRAINT `fk_production_choke_setting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`sand_management` ADD CONSTRAINT `fk_production_sand_management_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`flare_record` ADD CONSTRAINT `fk_production_flare_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`water_management` ADD CONSTRAINT `fk_production_water_management_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`separator` ADD CONSTRAINT `fk_production_separator_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`meter_station` ADD CONSTRAINT `fk_production_meter_station_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`production`.`esp_performance` ADD CONSTRAINT `fk_production_esp_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= refining --> asset (20 constraint(s)) =========
-- Requires: refining schema, asset schema
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ADD CONSTRAINT `fk_refining_process_unit_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ADD CONSTRAINT `fk_refining_refining_yield_record_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ADD CONSTRAINT `fk_refining_schedule_deviation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ADD CONSTRAINT `fk_refining_tank_inventory_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ADD CONSTRAINT `fk_refining_tank_inventory_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_integrity_program_id` FOREIGN KEY (`integrity_program_id`) REFERENCES `oil_gas_ecm`.`asset`.`integrity_program`(`integrity_program_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ADD CONSTRAINT `fk_refining_hydrogen_balance_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ADD CONSTRAINT `fk_refining_process_alarm_equipment_id` FOREIGN KEY (`equipment_id`) REFERENCES `oil_gas_ecm`.`asset`.`equipment`(`equipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ADD CONSTRAINT `fk_refining_process_alarm_moc_request_id` FOREIGN KEY (`moc_request_id`) REFERENCES `oil_gas_ecm`.`asset`.`moc_request`(`moc_request_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ADD CONSTRAINT `fk_refining_process_alarm_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `oil_gas_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);

-- ========= refining --> commercial (7 constraint(s)) =========
-- Requires: refining schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ADD CONSTRAINT `fk_refining_crude_assay_price_differential_id` FOREIGN KEY (`price_differential_id`) REFERENCES `oil_gas_ecm`.`commercial`.`price_differential`(`price_differential_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ADD CONSTRAINT `fk_refining_tank_inventory_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);

-- ========= refining --> compliance (13 constraint(s)) =========
-- Requires: refining schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_operating_license_id` FOREIGN KEY (`operating_license_id`) REFERENCES `oil_gas_ecm`.`compliance`.`operating_license`(`operating_license_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ADD CONSTRAINT `fk_refining_process_unit_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ADD CONSTRAINT `fk_refining_refining_yield_record_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `oil_gas_ecm`.`compliance`.`esg_report`(`esg_report_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_consent_order_id` FOREIGN KEY (`consent_order_id`) REFERENCES `oil_gas_ecm`.`compliance`.`consent_order`(`consent_order_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ADD CONSTRAINT `fk_refining_schedule_deviation_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ADD CONSTRAINT `fk_refining_tank_inventory_release_report_id` FOREIGN KEY (`release_report_id`) REFERENCES `oil_gas_ecm`.`compliance`.`release_report`(`release_report_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_compliance_corrective_action_id` FOREIGN KEY (`compliance_corrective_action_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_alarm` ADD CONSTRAINT `fk_refining_process_alarm_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);

-- ========= refining --> customer (5 constraint(s)) =========
-- Requires: refining schema, customer schema
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `oil_gas_ecm`.`customer`.`complaint`(`complaint_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);

-- ========= refining --> finance (14 constraint(s)) =========
-- Requires: refining schema, finance schema
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ADD CONSTRAINT `fk_refining_process_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ADD CONSTRAINT `fk_refining_refining_yield_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ADD CONSTRAINT `fk_refining_schedule_deviation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);

-- ========= refining --> hse (13 constraint(s)) =========
-- Requires: refining schema, hse schema
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_objective_id` FOREIGN KEY (`objective_id`) REFERENCES `oil_gas_ecm`.`hse`.`objective`(`objective_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ADD CONSTRAINT `fk_refining_process_unit_hse_risk_assessment_id` FOREIGN KEY (`hse_risk_assessment_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_risk_assessment`(`hse_risk_assessment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ADD CONSTRAINT `fk_refining_process_unit_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ADD CONSTRAINT `fk_refining_crude_assay_hazardous_substance_id` FOREIGN KEY (`hazardous_substance_id`) REFERENCES `oil_gas_ecm`.`hse`.`hazardous_substance`(`hazardous_substance_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_process_safety_event_id` FOREIGN KEY (`process_safety_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`process_safety_event`(`process_safety_event_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_emergency_drill_id` FOREIGN KEY (`emergency_drill_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_drill`(`emergency_drill_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `oil_gas_ecm`.`hse`.`audit`(`audit_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ADD CONSTRAINT `fk_refining_hydrogen_balance_emission_source_id` FOREIGN KEY (`emission_source_id`) REFERENCES `oil_gas_ecm`.`hse`.`emission_source`(`emission_source_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_spill_event_id` FOREIGN KEY (`spill_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`spill_event`(`spill_event_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_spill_event_id` FOREIGN KEY (`spill_event_id`) REFERENCES `oil_gas_ecm`.`hse`.`spill_event`(`spill_event_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_waste_manifest_id` FOREIGN KEY (`waste_manifest_id`) REFERENCES `oil_gas_ecm`.`hse`.`waste_manifest`(`waste_manifest_id`);

-- ========= refining --> land (1 constraint(s)) =========
-- Requires: refining schema, land schema
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= refining --> logistics (12 constraint(s)) =========
-- Requires: refining schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_pipeline_nomination_id` FOREIGN KEY (`pipeline_nomination_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_nomination`(`pipeline_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_shipping_schedule_id` FOREIGN KEY (`shipping_schedule_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipping_schedule`(`shipping_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ADD CONSTRAINT `fk_refining_tank_inventory_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_custody_transfer_id` FOREIGN KEY (`custody_transfer_id`) REFERENCES `oil_gas_ecm`.`logistics`.`custody_transfer`(`custody_transfer_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_rail_waybill_id` FOREIGN KEY (`rail_waybill_id`) REFERENCES `oil_gas_ecm`.`logistics`.`rail_waybill`(`rail_waybill_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_truck_ticket_id` FOREIGN KEY (`truck_ticket_id`) REFERENCES `oil_gas_ecm`.`logistics`.`truck_ticket`(`truck_ticket_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `oil_gas_ecm`.`logistics`.`vessel`(`vessel_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_terminal_id` FOREIGN KEY (`terminal_id`) REFERENCES `oil_gas_ecm`.`logistics`.`terminal`(`terminal_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_pipeline_batch_id` FOREIGN KEY (`pipeline_batch_id`) REFERENCES `oil_gas_ecm`.`logistics`.`pipeline_batch`(`pipeline_batch_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipment`(`shipment_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_truck_ticket_id` FOREIGN KEY (`truck_ticket_id`) REFERENCES `oil_gas_ecm`.`logistics`.`truck_ticket`(`truck_ticket_id`);

-- ========= refining --> petrochemical (1 constraint(s)) =========
-- Requires: refining schema, petrochemical schema
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ADD CONSTRAINT `fk_refining_supply_agreement_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `oil_gas_ecm`.`petrochemical`.`plant`(`plant_id`);

-- ========= refining --> procurement (11 constraint(s)) =========
-- Requires: refining schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ADD CONSTRAINT `fk_refining_blending_recipe_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `oil_gas_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`catalyst_lifecycle` ADD CONSTRAINT `fk_refining_catalyst_lifecycle_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= refining --> product (18 constraint(s)) =========
-- Requires: refining schema, product schema
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ADD CONSTRAINT `fk_refining_process_unit_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_assay` ADD CONSTRAINT `fk_refining_crude_assay_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refining_yield_record` ADD CONSTRAINT `fk_refining_refining_yield_record_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_blend_recipe_id` FOREIGN KEY (`blend_recipe_id`) REFERENCES `oil_gas_ecm`.`product`.`blend_recipe`(`blend_recipe_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ADD CONSTRAINT `fk_refining_tank_inventory_blend_recipe_id` FOREIGN KEY (`blend_recipe_id`) REFERENCES `oil_gas_ecm`.`product`.`blend_recipe`(`blend_recipe_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ADD CONSTRAINT `fk_refining_tank_inventory_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`hydrogen_balance` ADD CONSTRAINT `fk_refining_hydrogen_balance_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_blend_recipe_id` FOREIGN KEY (`blend_recipe_id`) REFERENCES `oil_gas_ecm`.`product`.`blend_recipe`(`blend_recipe_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`supply_agreement` ADD CONSTRAINT `fk_refining_supply_agreement_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);

-- ========= refining --> production (4 constraint(s)) =========
-- Requires: refining schema, production schema
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);

-- ========= refining --> reservoir (2 constraint(s)) =========
-- Requires: refining schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);

-- ========= refining --> venture (8 constraint(s)) =========
-- Requires: refining schema, venture schema
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ADD CONSTRAINT `fk_refining_process_unit_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_venture_afe_id` FOREIGN KEY (`venture_afe_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_afe`(`venture_afe_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`energy_consumption` ADD CONSTRAINT `fk_refining_energy_consumption_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_interest` ADD CONSTRAINT `fk_refining_refinery_interest_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);

-- ========= refining --> workforce (15 constraint(s)) =========
-- Requires: refining schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery` ADD CONSTRAINT `fk_refining_refinery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`process_unit` ADD CONSTRAINT `fk_refining_process_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`feedstock_blend` ADD CONSTRAINT `fk_refining_feedstock_blend_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`unit_run` ADD CONSTRAINT `fk_refining_unit_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_quality_test` ADD CONSTRAINT `fk_refining_product_quality_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`refinery_schedule` ADD CONSTRAINT `fk_refining_refinery_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`schedule_deviation` ADD CONSTRAINT `fk_refining_schedule_deviation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blending_recipe` ADD CONSTRAINT `fk_refining_blending_recipe_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`blend_event` ADD CONSTRAINT `fk_refining_blend_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`tank_inventory` ADD CONSTRAINT `fk_refining_tank_inventory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround` ADD CONSTRAINT `fk_refining_turnaround_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`turnaround_work_item` ADD CONSTRAINT `fk_refining_turnaround_work_item_contractor_id` FOREIGN KEY (`contractor_id`) REFERENCES `oil_gas_ecm`.`workforce`.`contractor`(`contractor_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`crude_receipt` ADD CONSTRAINT `fk_refining_crude_receipt_tertiary_crude_updated_by_user_employee_id` FOREIGN KEY (`tertiary_crude_updated_by_user_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`refining`.`product_movement` ADD CONSTRAINT `fk_refining_product_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= reservoir --> asset (25 constraint(s)) =========
-- Requires: reservoir schema, asset schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ADD CONSTRAINT `fk_reservoir_reservoir_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ADD CONSTRAINT `fk_reservoir_reservoir_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ADD CONSTRAINT `fk_reservoir_simulation_model_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ADD CONSTRAINT `fk_reservoir_petrophysical_interp_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ADD CONSTRAINT `fk_reservoir_decline_curve_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ADD CONSTRAINT `fk_reservoir_surveillance_plan_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ADD CONSTRAINT `fk_reservoir_tracer_test_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ADD CONSTRAINT `fk_reservoir_injection_performance_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_performance` ADD CONSTRAINT `fk_reservoir_injection_performance_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ADD CONSTRAINT `fk_reservoir_connectivity_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ADD CONSTRAINT `fk_reservoir_connectivity_connectivity_well_pair_target_well_asset_id` FOREIGN KEY (`connectivity_well_pair_target_well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ADD CONSTRAINT `fk_reservoir_connectivity_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ADD CONSTRAINT `fk_reservoir_reservoir_sec_reserves_disclosure_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ADD CONSTRAINT `fk_reservoir_core_analysis_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ADD CONSTRAINT `fk_reservoir_core_analysis_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`interference_test` ADD CONSTRAINT `fk_reservoir_interference_test_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= reservoir --> commercial (7 constraint(s)) =========
-- Requires: reservoir schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ADD CONSTRAINT `fk_reservoir_simulation_run_pricing_agreement_id` FOREIGN KEY (`pricing_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`pricing_agreement`(`pricing_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);

-- ========= reservoir --> compliance (9 constraint(s)) =========
-- Requires: reservoir schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ADD CONSTRAINT `fk_reservoir_reservoir_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_compliance_sec_reserves_disclosure_id` FOREIGN KEY (`compliance_sec_reserves_disclosure_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_sec_reserves_disclosure`(`compliance_sec_reserves_disclosure_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `oil_gas_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ADD CONSTRAINT `fk_reservoir_simulation_model_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `oil_gas_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ADD CONSTRAINT `fk_reservoir_tracer_test_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ADD CONSTRAINT `fk_reservoir_reservoir_sec_reserves_disclosure_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);

-- ========= reservoir --> customer (1 constraint(s)) =========
-- Requires: reservoir schema, customer schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`equity_participation` ADD CONSTRAINT `fk_reservoir_equity_participation_customer_counterparty_id` FOREIGN KEY (`customer_counterparty_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_counterparty`(`customer_counterparty_id`);

-- ========= reservoir --> drilling (1 constraint(s)) =========
-- Requires: reservoir schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`sample` ADD CONSTRAINT `fk_reservoir_sample_wellbore_id` FOREIGN KEY (`wellbore_id`) REFERENCES `oil_gas_ecm`.`drilling`.`wellbore`(`wellbore_id`);

-- ========= reservoir --> exploration (8 constraint(s)) =========
-- Requires: reservoir schema, exploration schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ADD CONSTRAINT `fk_reservoir_reservoir_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`zone` ADD CONSTRAINT `fk_reservoir_zone_formation_id` FOREIGN KEY (`formation_id`) REFERENCES `oil_gas_ecm`.`exploration`.`formation`(`formation_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_discovery_id` FOREIGN KEY (`discovery_id`) REFERENCES `oil_gas_ecm`.`exploration`.`discovery`(`discovery_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ADD CONSTRAINT `fk_reservoir_petrophysical_interp_exploration_well_id` FOREIGN KEY (`exploration_well_id`) REFERENCES `oil_gas_ecm`.`exploration`.`exploration_well`(`exploration_well_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ADD CONSTRAINT `fk_reservoir_core_analysis_core_sample_id` FOREIGN KEY (`core_sample_id`) REFERENCES `oil_gas_ecm`.`exploration`.`core_sample`(`core_sample_id`);

-- ========= reservoir --> finance (16 constraint(s)) =========
-- Requires: reservoir schema, finance schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ADD CONSTRAINT `fk_reservoir_reservoir_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ADD CONSTRAINT `fk_reservoir_reservoir_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_actual_cost_id` FOREIGN KEY (`actual_cost_id`) REFERENCES `oil_gas_ecm`.`finance`.`actual_cost`(`actual_cost_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ADD CONSTRAINT `fk_reservoir_volumetric_estimate_actual_cost_id` FOREIGN KEY (`actual_cost_id`) REFERENCES `oil_gas_ecm`.`finance`.`actual_cost`(`actual_cost_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `oil_gas_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ADD CONSTRAINT `fk_reservoir_simulation_model_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ADD CONSTRAINT `fk_reservoir_material_balance_actual_cost_id` FOREIGN KEY (`actual_cost_id`) REFERENCES `oil_gas_ecm`.`finance`.`actual_cost`(`actual_cost_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_actual_cost_id` FOREIGN KEY (`actual_cost_id`) REFERENCES `oil_gas_ecm`.`finance`.`actual_cost`(`actual_cost_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`production_forecast` ADD CONSTRAINT `fk_reservoir_production_forecast_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `oil_gas_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `oil_gas_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ADD CONSTRAINT `fk_reservoir_decline_curve_actual_cost_id` FOREIGN KEY (`actual_cost_id`) REFERENCES `oil_gas_ecm`.`finance`.`actual_cost`(`actual_cost_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ADD CONSTRAINT `fk_reservoir_surveillance_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `oil_gas_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ADD CONSTRAINT `fk_reservoir_tracer_test_actual_cost_id` FOREIGN KEY (`actual_cost_id`) REFERENCES `oil_gas_ecm`.`finance`.`actual_cost`(`actual_cost_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ADD CONSTRAINT `fk_reservoir_core_analysis_actual_cost_id` FOREIGN KEY (`actual_cost_id`) REFERENCES `oil_gas_ecm`.`finance`.`actual_cost`(`actual_cost_id`);

-- ========= reservoir --> hse (13 constraint(s)) =========
-- Requires: reservoir schema, hse schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_hazardous_substance_id` FOREIGN KEY (`hazardous_substance_id`) REFERENCES `oil_gas_ecm`.`hse`.`hazardous_substance`(`hazardous_substance_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ADD CONSTRAINT `fk_reservoir_simulation_run_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ADD CONSTRAINT `fk_reservoir_material_balance_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `oil_gas_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `oil_gas_ecm`.`hse`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_hse_risk_assessment_id` FOREIGN KEY (`hse_risk_assessment_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_risk_assessment`(`hse_risk_assessment_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `oil_gas_ecm`.`hse`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ADD CONSTRAINT `fk_reservoir_surveillance_plan_hse_risk_assessment_id` FOREIGN KEY (`hse_risk_assessment_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_risk_assessment`(`hse_risk_assessment_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ADD CONSTRAINT `fk_reservoir_tracer_test_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `oil_gas_ecm`.`hse`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `oil_gas_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_hse_risk_assessment_id` FOREIGN KEY (`hse_risk_assessment_id`) REFERENCES `oil_gas_ecm`.`hse`.`hse_risk_assessment`(`hse_risk_assessment_id`);

-- ========= reservoir --> land (5 constraint(s)) =========
-- Requires: reservoir schema, land schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ADD CONSTRAINT `fk_reservoir_reservoir_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ADD CONSTRAINT `fk_reservoir_reservoir_sec_reserves_disclosure_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= reservoir --> procurement (15 constraint(s)) =========
-- Requires: reservoir schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pvt_analysis` ADD CONSTRAINT `fk_reservoir_pvt_analysis_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ADD CONSTRAINT `fk_reservoir_simulation_model_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ADD CONSTRAINT `fk_reservoir_simulation_run_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_service_entry_sheet_id` FOREIGN KEY (`service_entry_sheet_id`) REFERENCES `oil_gas_ecm`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_service_entry_sheet_id` FOREIGN KEY (`service_entry_sheet_id`) REFERENCES `oil_gas_ecm`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `oil_gas_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ADD CONSTRAINT `fk_reservoir_surveillance_plan_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ADD CONSTRAINT `fk_reservoir_tracer_test_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ADD CONSTRAINT `fk_reservoir_tracer_test_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`core_analysis` ADD CONSTRAINT `fk_reservoir_core_analysis_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ADD CONSTRAINT `fk_reservoir_eor_vendor_supply_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= reservoir --> production (3 constraint(s)) =========
-- Requires: reservoir schema, production schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_injection_well_id` FOREIGN KEY (`injection_well_id`) REFERENCES `oil_gas_ecm`.`production`.`injection_well`(`injection_well_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ADD CONSTRAINT `fk_reservoir_tracer_test_injection_well_id` FOREIGN KEY (`injection_well_id`) REFERENCES `oil_gas_ecm`.`production`.`injection_well`(`injection_well_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`scheme_well_assignment` ADD CONSTRAINT `fk_reservoir_scheme_well_assignment_injection_well_id` FOREIGN KEY (`injection_well_id`) REFERENCES `oil_gas_ecm`.`production`.`injection_well`(`injection_well_id`);

-- ========= reservoir --> venture (8 constraint(s)) =========
-- Requires: reservoir schema, venture schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir` ADD CONSTRAINT `fk_reservoir_reservoir_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ADD CONSTRAINT `fk_reservoir_simulation_model_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ADD CONSTRAINT `fk_reservoir_reservoir_sec_reserves_disclosure_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_participation` ADD CONSTRAINT `fk_reservoir_eor_participation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_working_interest` ADD CONSTRAINT `fk_reservoir_reservoir_working_interest_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);

-- ========= reservoir --> workforce (22 constraint(s)) =========
-- Requires: reservoir schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`reservoir`.`volumetric_estimate` ADD CONSTRAINT `fk_reservoir_volumetric_estimate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reserves_estimate` ADD CONSTRAINT `fk_reservoir_reserves_estimate_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_model` ADD CONSTRAINT `fk_reservoir_simulation_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`simulation_run` ADD CONSTRAINT `fk_reservoir_simulation_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`material_balance` ADD CONSTRAINT `fk_reservoir_material_balance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_survey` ADD CONSTRAINT `fk_reservoir_pressure_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`well_test` ADD CONSTRAINT `fk_reservoir_well_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_scheme` ADD CONSTRAINT `fk_reservoir_eor_scheme_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`injection_event` ADD CONSTRAINT `fk_reservoir_injection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`aquifer_model` ADD CONSTRAINT `fk_reservoir_aquifer_model_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`petrophysical_interp` ADD CONSTRAINT `fk_reservoir_petrophysical_interp_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`pressure_history` ADD CONSTRAINT `fk_reservoir_pressure_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`decline_curve` ADD CONSTRAINT `fk_reservoir_decline_curve_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`surveillance_plan` ADD CONSTRAINT `fk_reservoir_surveillance_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`tracer_test` ADD CONSTRAINT `fk_reservoir_tracer_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`model_update` ADD CONSTRAINT `fk_reservoir_model_update_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`connectivity` ADD CONSTRAINT `fk_reservoir_connectivity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure` ADD CONSTRAINT `fk_reservoir_reservoir_sec_reserves_disclosure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`development_plan` ADD CONSTRAINT `fk_reservoir_development_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ADD CONSTRAINT `fk_reservoir_eor_vendor_supply_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`eor_vendor_supply_agreement` ADD CONSTRAINT `fk_reservoir_eor_vendor_supply_agreement_technical_contact_employee_id` FOREIGN KEY (`technical_contact_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`reservoir`.`sample` ADD CONSTRAINT `fk_reservoir_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= revenue --> asset (19 constraint(s)) =========
-- Requires: revenue schema, asset schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ADD CONSTRAINT `fk_revenue_dispute_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ADD CONSTRAINT `fk_revenue_take_or_pay_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_pipeline_segment_id` FOREIGN KEY (`pipeline_segment_id`) REFERENCES `oil_gas_ecm`.`asset`.`pipeline_segment`(`pipeline_segment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= revenue --> commercial (28 constraint(s)) =========
-- Requires: revenue schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_tariff_agreement_id` FOREIGN KEY (`tariff_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`tariff_agreement`(`tariff_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_cargo_nomination_id` FOREIGN KEY (`cargo_nomination_id`) REFERENCES `oil_gas_ecm`.`commercial`.`cargo_nomination`(`cargo_nomination_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_tariff_agreement_id` FOREIGN KEY (`tariff_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`tariff_agreement`(`tariff_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ADD CONSTRAINT `fk_revenue_dispute_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ADD CONSTRAINT `fk_revenue_customer_credit_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ADD CONSTRAINT `fk_revenue_take_or_pay_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ADD CONSTRAINT `fk_revenue_take_or_pay_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ADD CONSTRAINT `fk_revenue_take_or_pay_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_commercial_term_contract_id` FOREIGN KEY (`commercial_term_contract_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_term_contract`(`commercial_term_contract_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `oil_gas_ecm`.`commercial`.`offtake_agreement`(`offtake_agreement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_sales_order_id` FOREIGN KEY (`sales_order_id`) REFERENCES `oil_gas_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_spot_trade_id` FOREIGN KEY (`spot_trade_id`) REFERENCES `oil_gas_ecm`.`commercial`.`spot_trade`(`spot_trade_id`);

-- ========= revenue --> compliance (16 constraint(s)) =========
-- Requires: revenue schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_ferc_tariff_id` FOREIGN KEY (`ferc_tariff_id`) REFERENCES `oil_gas_ecm`.`compliance`.`ferc_tariff`(`ferc_tariff_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ADD CONSTRAINT `fk_revenue_dispute_regulatory_penalty_id` FOREIGN KEY (`regulatory_penalty_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_penalty`(`regulatory_penalty_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ADD CONSTRAINT `fk_revenue_dispute_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ADD CONSTRAINT `fk_revenue_intercompany_billing_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `oil_gas_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ADD CONSTRAINT `fk_revenue_take_or_pay_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);

-- ========= revenue --> customer (20 constraint(s)) =========
-- Requires: revenue schema, customer schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_customer_lifting_schedule_id` FOREIGN KEY (`customer_lifting_schedule_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_lifting_schedule`(`customer_lifting_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_end_use_declaration_id` FOREIGN KEY (`end_use_declaration_id`) REFERENCES `oil_gas_ecm`.`customer`.`end_use_declaration`(`end_use_declaration_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_nomination_id` FOREIGN KEY (`nomination_id`) REFERENCES `oil_gas_ecm`.`customer`.`nomination`(`nomination_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_bank_detail_id` FOREIGN KEY (`bank_detail_id`) REFERENCES `oil_gas_ecm`.`customer`.`bank_detail`(`bank_detail_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `oil_gas_ecm`.`customer`.`complaint`(`complaint_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_offtake_entitlement_id` FOREIGN KEY (`offtake_entitlement_id`) REFERENCES `oil_gas_ecm`.`customer`.`offtake_entitlement`(`offtake_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`customer_credit` ADD CONSTRAINT `fk_revenue_customer_credit_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ADD CONSTRAINT `fk_revenue_take_or_pay_customer_volume_commitment_id` FOREIGN KEY (`customer_volume_commitment_id`) REFERENCES `oil_gas_ecm`.`customer`.`customer_volume_commitment`(`customer_volume_commitment_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ADD CONSTRAINT `fk_revenue_take_or_pay_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `oil_gas_ecm`.`customer`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_account_id` FOREIGN KEY (`account_id`) REFERENCES `oil_gas_ecm`.`customer`.`account`(`account_id`);

-- ========= revenue --> finance (23 constraint(s)) =========
-- Requires: revenue schema, finance schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ADD CONSTRAINT `fk_revenue_dispute_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ADD CONSTRAINT `fk_revenue_intercompany_billing_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ADD CONSTRAINT `fk_revenue_intercompany_billing_receiving_entity_company_code_id` FOREIGN KEY (`receiving_entity_company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= revenue --> land (16 constraint(s)) =========
-- Requires: revenue schema, land schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_division_order_id` FOREIGN KEY (`division_order_id`) REFERENCES `oil_gas_ecm`.`land`.`division_order`(`division_order_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_property_id` FOREIGN KEY (`property_id`) REFERENCES `oil_gas_ecm`.`land`.`property`(`property_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= revenue --> logistics (2 constraint(s)) =========
-- Requires: revenue schema, logistics schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_measurement_point_id` FOREIGN KEY (`measurement_point_id`) REFERENCES `oil_gas_ecm`.`logistics`.`measurement_point`(`measurement_point_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_shipper_id` FOREIGN KEY (`shipper_id`) REFERENCES `oil_gas_ecm`.`logistics`.`shipper`(`shipper_id`);

-- ========= revenue --> procurement (3 constraint(s)) =========
-- Requires: revenue schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);

-- ========= revenue --> product (20 constraint(s)) =========
-- Requires: revenue schema, product schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_quality_test_result_id` FOREIGN KEY (`quality_test_result_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_test_result`(`quality_test_result_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ADD CONSTRAINT `fk_revenue_dispute_quality_test_result_id` FOREIGN KEY (`quality_test_result_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_test_result`(`quality_test_result_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ADD CONSTRAINT `fk_revenue_intercompany_billing_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`take_or_pay` ADD CONSTRAINT `fk_revenue_take_or_pay_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_crude_grade_id` FOREIGN KEY (`crude_grade_id`) REFERENCES `oil_gas_ecm`.`product`.`crude_grade`(`crude_grade_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_pricing_benchmark_id` FOREIGN KEY (`pricing_benchmark_id`) REFERENCES `oil_gas_ecm`.`product`.`pricing_benchmark`(`pricing_benchmark_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_quality_spec_id` FOREIGN KEY (`quality_spec_id`) REFERENCES `oil_gas_ecm`.`product`.`quality_spec`(`quality_spec_id`);

-- ========= revenue --> production (4 constraint(s)) =========
-- Requires: revenue schema, production schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_production_well_id` FOREIGN KEY (`production_well_id`) REFERENCES `oil_gas_ecm`.`production`.`production_well`(`production_well_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `oil_gas_ecm`.`production`.`production_facility`(`production_facility_id`);

-- ========= revenue --> refining (7 constraint(s)) =========
-- Requires: revenue schema, refining schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_refinery_id` FOREIGN KEY (`refinery_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery`(`refinery_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_blend_event_id` FOREIGN KEY (`blend_event_id`) REFERENCES `oil_gas_ecm`.`refining`.`blend_event`(`blend_event_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `oil_gas_ecm`.`refining`.`process_unit`(`process_unit_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_tank_inventory_id` FOREIGN KEY (`tank_inventory_id`) REFERENCES `oil_gas_ecm`.`refining`.`tank_inventory`(`tank_inventory_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ADD CONSTRAINT `fk_revenue_dispute_product_quality_test_id` FOREIGN KEY (`product_quality_test_id`) REFERENCES `oil_gas_ecm`.`refining`.`product_quality_test`(`product_quality_test_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_refinery_schedule_id` FOREIGN KEY (`refinery_schedule_id`) REFERENCES `oil_gas_ecm`.`refining`.`refinery_schedule`(`refinery_schedule_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_turnaround_id` FOREIGN KEY (`turnaround_id`) REFERENCES `oil_gas_ecm`.`refining`.`turnaround`(`turnaround_id`);

-- ========= revenue --> reservoir (3 constraint(s)) =========
-- Requires: revenue schema, reservoir schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_allocation` ADD CONSTRAINT `fk_revenue_revenue_allocation_reservoir_id` FOREIGN KEY (`reservoir_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir`(`reservoir_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_reserves_estimate_id` FOREIGN KEY (`reserves_estimate_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reserves_estimate`(`reserves_estimate_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_reservoir_sec_reserves_disclosure_id` FOREIGN KEY (`reservoir_sec_reserves_disclosure_id`) REFERENCES `oil_gas_ecm`.`reservoir`.`reservoir_sec_reserves_disclosure`(`reservoir_sec_reserves_disclosure_id`);

-- ========= revenue --> venture (29 constraint(s)) =========
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
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ADD CONSTRAINT `fk_revenue_dispute_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`dispute` ADD CONSTRAINT `fk_revenue_dispute_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`deferred_revenue` ADD CONSTRAINT `fk_revenue_deferred_revenue_jib_statement_id` FOREIGN KEY (`jib_statement_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_statement`(`jib_statement_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ADD CONSTRAINT `fk_revenue_intercompany_billing_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);

-- ========= revenue --> workforce (16 constraint(s)) =========
-- Requires: revenue schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice` ADD CONSTRAINT `fk_revenue_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`invoice_line` ADD CONSTRAINT `fk_revenue_invoice_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`payment` ADD CONSTRAINT `fk_revenue_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`receivable` ADD CONSTRAINT `fk_revenue_receivable_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `oil_gas_ecm`.`workforce`.`plan`(`plan_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`cash_application` ADD CONSTRAINT `fk_revenue_cash_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_note` ADD CONSTRAINT `fk_revenue_credit_note_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`tariff_charge` ADD CONSTRAINT `fk_revenue_tariff_charge_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_event` ADD CONSTRAINT `fk_revenue_recognition_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`intercompany_billing` ADD CONSTRAINT `fk_revenue_intercompany_billing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`accrual` ADD CONSTRAINT `fk_revenue_accrual_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`revenue_forecast` ADD CONSTRAINT `fk_revenue_revenue_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`settlement` ADD CONSTRAINT `fk_revenue_settlement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`credit_review` ADD CONSTRAINT `fk_revenue_credit_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_schedule` ADD CONSTRAINT `fk_revenue_recognition_schedule_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`revenue`.`recognition_schedule` ADD CONSTRAINT `fk_revenue_recognition_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= venture --> asset (15 constraint(s)) =========
-- Requires: venture schema, asset schema
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_field_id` FOREIGN KEY (`field_id`) REFERENCES `oil_gas_ecm`.`asset`.`field`(`field_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ADD CONSTRAINT `fk_venture_royalty_obligation_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ADD CONSTRAINT `fk_venture_royalty_payment_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ADD CONSTRAINT `fk_venture_non_consent_election_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ADD CONSTRAINT `fk_venture_non_consent_election_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= venture --> commercial (1 constraint(s)) =========
-- Requires: venture schema, commercial schema
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ADD CONSTRAINT `fk_venture_partner_commercial_counterparty_id` FOREIGN KEY (`commercial_counterparty_id`) REFERENCES `oil_gas_ecm`.`commercial`.`commercial_counterparty`(`commercial_counterparty_id`);

-- ========= venture --> compliance (16 constraint(s)) =========
-- Requires: venture schema, compliance schema
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ADD CONSTRAINT `fk_venture_psa_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ADD CONSTRAINT `fk_venture_psa_compliance_sec_reserves_disclosure_id` FOREIGN KEY (`compliance_sec_reserves_disclosure_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_sec_reserves_disclosure`(`compliance_sec_reserves_disclosure_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_regulatory_audit_id` FOREIGN KEY (`regulatory_audit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_audit`(`regulatory_audit_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `oil_gas_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_compliance_audit_finding_id` FOREIGN KEY (`compliance_audit_finding_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_audit_finding`(`compliance_audit_finding_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_sox_control_id` FOREIGN KEY (`sox_control_id`) REFERENCES `oil_gas_ecm`.`compliance`.`sox_control`(`sox_control_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_regulatory_audit_id` FOREIGN KEY (`regulatory_audit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_audit`(`regulatory_audit_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ADD CONSTRAINT `fk_venture_jv_audit_regulatory_audit_id` FOREIGN KEY (`regulatory_audit_id`) REFERENCES `oil_gas_ecm`.`compliance`.`regulatory_audit`(`regulatory_audit_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ADD CONSTRAINT `fk_venture_default_notice_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `oil_gas_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ADD CONSTRAINT `fk_venture_non_consent_election_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ADD CONSTRAINT `fk_venture_filing_participation_compliance_regulatory_filing_id` FOREIGN KEY (`compliance_regulatory_filing_id`) REFERENCES `oil_gas_ecm`.`compliance`.`compliance_regulatory_filing`(`compliance_regulatory_filing_id`);

-- ========= venture --> drilling (6 constraint(s)) =========
-- Requires: venture schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_dc_program_id` FOREIGN KEY (`dc_program_id`) REFERENCES `oil_gas_ecm`.`drilling`.`dc_program`(`dc_program_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ADD CONSTRAINT `fk_venture_afe_approval_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ADD CONSTRAINT `fk_venture_default_notice_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ADD CONSTRAINT `fk_venture_non_consent_election_drilling_afe_id` FOREIGN KEY (`drilling_afe_id`) REFERENCES `oil_gas_ecm`.`drilling`.`drilling_afe`(`drilling_afe_id`);

-- ========= venture --> finance (17 constraint(s)) =========
-- Requires: venture schema, finance schema
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ADD CONSTRAINT `fk_venture_psa_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ADD CONSTRAINT `fk_venture_partner_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `oil_gas_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_finance_afe_id` FOREIGN KEY (`finance_afe_id`) REFERENCES `oil_gas_ecm`.`finance`.`finance_afe`(`finance_afe_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_journal_entry_line_id` FOREIGN KEY (`journal_entry_line_id`) REFERENCES `oil_gas_ecm`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `oil_gas_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_actual_cost_id` FOREIGN KEY (`actual_cost_id`) REFERENCES `oil_gas_ecm`.`finance`.`actual_cost`(`actual_cost_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ADD CONSTRAINT `fk_venture_partner_netting_intercompany_transaction_id` FOREIGN KEY (`intercompany_transaction_id`) REFERENCES `oil_gas_ecm`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `oil_gas_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ADD CONSTRAINT `fk_venture_royalty_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `oil_gas_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ADD CONSTRAINT `fk_venture_jv_audit_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `oil_gas_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ADD CONSTRAINT `fk_venture_joa_wbs_allocation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `oil_gas_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ADD CONSTRAINT `fk_venture_partner_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ADD CONSTRAINT `fk_venture_partner_account_assignment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `oil_gas_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= venture --> land (17 constraint(s)) =========
-- Requires: venture schema, land schema
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_property_id` FOREIGN KEY (`property_id`) REFERENCES `oil_gas_ecm`.`land`.`property`(`property_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_property_id` FOREIGN KEY (`property_id`) REFERENCES `oil_gas_ecm`.`land`.`property`(`property_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ADD CONSTRAINT `fk_venture_royalty_obligation_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ADD CONSTRAINT `fk_venture_royalty_obligation_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ADD CONSTRAINT `fk_venture_royalty_payment_property_id` FOREIGN KEY (`property_id`) REFERENCES `oil_gas_ecm`.`land`.`property`(`property_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ADD CONSTRAINT `fk_venture_royalty_payment_royalty_owner_id` FOREIGN KEY (`royalty_owner_id`) REFERENCES `oil_gas_ecm`.`land`.`royalty_owner`(`royalty_owner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ADD CONSTRAINT `fk_venture_default_notice_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ADD CONSTRAINT `fk_venture_non_consent_election_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `oil_gas_ecm`.`land`.`lease`(`lease_id`);

-- ========= venture --> procurement (10 constraint(s)) =========
-- Requires: venture schema, procurement schema
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ADD CONSTRAINT `fk_venture_jv_audit_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ADD CONSTRAINT `fk_venture_default_notice_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ADD CONSTRAINT `fk_venture_non_consent_election_afe_budget_id` FOREIGN KEY (`afe_budget_id`) REFERENCES `oil_gas_ecm`.`procurement`.`afe_budget`(`afe_budget_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ADD CONSTRAINT `fk_venture_joa_contract_allocation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `oil_gas_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ADD CONSTRAINT `fk_venture_partner_vendor_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `oil_gas_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= venture --> product (6 constraint(s)) =========
-- Requires: venture schema, product schema
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ADD CONSTRAINT `fk_venture_royalty_payment_petroleum_product_id` FOREIGN KEY (`petroleum_product_id`) REFERENCES `oil_gas_ecm`.`product`.`petroleum_product`(`petroleum_product_id`);

-- ========= venture --> workforce (13 constraint(s)) =========
-- Requires: venture schema, workforce schema
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ADD CONSTRAINT `fk_venture_psa_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ADD CONSTRAINT `fk_venture_afe_approval_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ADD CONSTRAINT `fk_venture_partner_netting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ADD CONSTRAINT `fk_venture_opcom_meeting_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ADD CONSTRAINT `fk_venture_jv_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ADD CONSTRAINT `fk_venture_default_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ADD CONSTRAINT `fk_venture_non_consent_election_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `oil_gas_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> asset (14 constraint(s)) =========
-- Requires: workforce schema, asset schema
ALTER TABLE `oil_gas_ecm`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`workforce_training_record` ADD CONSTRAINT `fk_workforce_workforce_training_record_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ADD CONSTRAINT `fk_workforce_crew_schedule_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`pob_record` ADD CONSTRAINT `fk_workforce_pob_record_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`mobilization_event` ADD CONSTRAINT `fk_workforce_mobilization_event_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`hse_induction` ADD CONSTRAINT `fk_workforce_hse_induction_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`work_permit_visa` ADD CONSTRAINT `fk_workforce_work_permit_visa_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_asset_facility_id` FOREIGN KEY (`asset_facility_id`) REFERENCES `oil_gas_ecm`.`asset`.`asset_facility`(`asset_facility_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_well_asset_id` FOREIGN KEY (`well_asset_id`) REFERENCES `oil_gas_ecm`.`asset`.`well_asset`(`well_asset_id`);

-- ========= workforce --> drilling (1 constraint(s)) =========
-- Requires: workforce schema, drilling schema
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ADD CONSTRAINT `fk_workforce_crew_schedule_rig_id` FOREIGN KEY (`rig_id`) REFERENCES `oil_gas_ecm`.`drilling`.`rig`(`rig_id`);

-- ========= workforce --> finance (1 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `oil_gas_ecm`.`workforce`.`succession_plan` ADD CONSTRAINT `fk_workforce_succession_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `oil_gas_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> venture (2 constraint(s)) =========
-- Requires: workforce schema, venture schema
ALTER TABLE `oil_gas_ecm`.`workforce`.`crew_schedule` ADD CONSTRAINT `fk_workforce_crew_schedule_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`workforce`.`labor_cost_allocation` ADD CONSTRAINT `fk_workforce_labor_cost_allocation_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);

