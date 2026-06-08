-- Cross-Domain Foreign Keys for Business: Water Utilities | Version: v1_mvm
-- Generated on: 2026-05-06 01:37:22
-- Total cross-domain FK constraints: 1037
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, compliance, customer, distribution, finance, metering, project, quality, service, supply, treatment, wastewater

-- ========= asset --> billing (2 constraint(s)) =========
-- Requires: asset schema, billing schema
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `water_utilities_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= asset --> compliance (14 constraint(s)) =========
-- Requires: asset schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ADD CONSTRAINT `fk_asset_asset_class_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`criticality_rating` ADD CONSTRAINT `fk_asset_criticality_rating_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ADD CONSTRAINT `fk_asset_asset_meter_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= asset --> customer (6 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);

-- ========= asset --> finance (10 constraint(s)) =========
-- Requires: asset schema, finance schema
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ADD CONSTRAINT `fk_asset_asset_class_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= asset --> metering (1 constraint(s)) =========
-- Requires: asset schema, metering schema
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ADD CONSTRAINT `fk_asset_asset_meter_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);

-- ========= asset --> project (6 constraint(s)) =========
-- Requires: asset schema, project schema
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_project_permit_id` FOREIGN KEY (`project_permit_id`) REFERENCES `water_utilities_ecm`.`project`.`project_permit`(`project_permit_id`);

-- ========= asset --> quality (8 constraint(s)) =========
-- Requires: asset schema, quality schema
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `water_utilities_ecm`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `water_utilities_ecm`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ADD CONSTRAINT `fk_asset_asset_meter_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);

-- ========= asset --> service (7 constraint(s)) =========
-- Requires: asset schema, service schema
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `water_utilities_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `water_utilities_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);

-- ========= asset --> supply (7 constraint(s)) =========
-- Requires: asset schema, supply schema
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `water_utilities_ecm`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ADD CONSTRAINT `fk_asset_asset_meter_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= asset --> treatment (6 constraint(s)) =========
-- Requires: asset schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ADD CONSTRAINT `fk_asset_asset_meter_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= billing --> asset (5 constraint(s)) =========
-- Requires: billing schema, asset schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= billing --> compliance (6 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ccr_id` FOREIGN KEY (`ccr_id`) REFERENCES `water_utilities_ecm`.`compliance`.`ccr`(`ccr_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);

-- ========= billing --> customer (20 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_assistance_enrollment_id` FOREIGN KEY (`assistance_enrollment_id`) REFERENCES `water_utilities_ecm`.`customer`.`assistance_enrollment`(`assistance_enrollment_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_person_id` FOREIGN KEY (`person_id`) REFERENCES `water_utilities_ecm`.`customer`.`person`(`person_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_person_id` FOREIGN KEY (`person_id`) REFERENCES `water_utilities_ecm`.`customer`.`person`(`person_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `water_utilities_ecm`.`customer`.`complaint`(`complaint_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);

-- ========= billing --> distribution (8 constraint(s)) =========
-- Requires: billing schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_leak_detection_survey_id` FOREIGN KEY (`leak_detection_survey_id`) REFERENCES `water_utilities_ecm`.`distribution`.`leak_detection_survey`(`leak_detection_survey_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `water_utilities_ecm`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_leak_detection_survey_id` FOREIGN KEY (`leak_detection_survey_id`) REFERENCES `water_utilities_ecm`.`distribution`.`leak_detection_survey`(`leak_detection_survey_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `water_utilities_ecm`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);

-- ========= billing --> finance (16 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `water_utilities_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `water_utilities_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `water_utilities_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `water_utilities_ecm`.`finance`.`rate_case`(`rate_case_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `water_utilities_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`rate_tier` ADD CONSTRAINT `fk_billing_rate_tier_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= billing --> metering (7 constraint(s)) =========
-- Requires: billing schema, metering schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_interval_consumption_id` FOREIGN KEY (`interval_consumption_id`) REFERENCES `water_utilities_ecm`.`metering`.`interval_consumption`(`interval_consumption_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `water_utilities_ecm`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `water_utilities_ecm`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_accuracy_test_id` FOREIGN KEY (`accuracy_test_id`) REFERENCES `water_utilities_ecm`.`metering`.`accuracy_test`(`accuracy_test_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_high_usage_alert_id` FOREIGN KEY (`high_usage_alert_id`) REFERENCES `water_utilities_ecm`.`metering`.`high_usage_alert`(`high_usage_alert_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_accuracy_test_id` FOREIGN KEY (`accuracy_test_id`) REFERENCES `water_utilities_ecm`.`metering`.`accuracy_test`(`accuracy_test_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_high_usage_alert_id` FOREIGN KEY (`high_usage_alert_id`) REFERENCES `water_utilities_ecm`.`metering`.`high_usage_alert`(`high_usage_alert_id`);

-- ========= billing --> project (5 constraint(s)) =========
-- Requires: billing schema, project schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= billing --> quality (6 constraint(s)) =========
-- Requires: billing schema, quality schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ccr_period_id` FOREIGN KEY (`ccr_period_id`) REFERENCES `water_utilities_ecm`.`quality`.`ccr_period`(`ccr_period_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `water_utilities_ecm`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `water_utilities_ecm`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);

-- ========= billing --> service (13 constraint(s)) =========
-- Requires: billing schema, service schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_conservation_program_id` FOREIGN KEY (`conservation_program_id`) REFERENCES `water_utilities_ecm`.`service`.`conservation_program`(`conservation_program_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_affordability_plan_id` FOREIGN KEY (`affordability_plan_id`) REFERENCES `water_utilities_ecm`.`service`.`affordability_plan`(`affordability_plan_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_conservation_program_id` FOREIGN KEY (`conservation_program_id`) REFERENCES `water_utilities_ecm`.`service`.`conservation_program`(`conservation_program_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_order_id` FOREIGN KEY (`order_id`) REFERENCES `water_utilities_ecm`.`service`.`order`(`order_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_order_id` FOREIGN KEY (`order_id`) REFERENCES `water_utilities_ecm`.`service`.`order`(`order_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_order_id` FOREIGN KEY (`order_id`) REFERENCES `water_utilities_ecm`.`service`.`order`(`order_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);

-- ========= billing --> treatment (2 constraint(s)) =========
-- Requires: billing schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= billing --> wastewater (9 constraint(s)) =========
-- Requires: billing schema, wastewater schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_industrial_user_permit_id` FOREIGN KEY (`industrial_user_permit_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`industrial_user_permit`(`industrial_user_permit_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_biosolids_batch_id` FOREIGN KEY (`biosolids_batch_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`biosolids_batch`(`biosolids_batch_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_industrial_user_permit_id` FOREIGN KEY (`industrial_user_permit_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`industrial_user_permit`(`industrial_user_permit_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_cso_event_id` FOREIGN KEY (`cso_event_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`cso_event`(`cso_event_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_cso_event_id` FOREIGN KEY (`cso_event_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`cso_event`(`cso_event_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_sso_event_id` FOREIGN KEY (`sso_event_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`sso_event`(`sso_event_id`);

-- ========= compliance --> asset (10 constraint(s)) =========
-- Requires: compliance schema, asset schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_asset_meter_id` FOREIGN KEY (`asset_meter_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_meter`(`asset_meter_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_asset_meter_id` FOREIGN KEY (`asset_meter_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_meter`(`asset_meter_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `water_utilities_ecm`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`schedule` ADD CONSTRAINT `fk_compliance_schedule_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`schedule` ADD CONSTRAINT `fk_compliance_schedule_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= compliance --> finance (19 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `water_utilities_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `water_utilities_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`ccr` ADD CONSTRAINT `fk_compliance_ccr_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `water_utilities_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`schedule` ADD CONSTRAINT `fk_compliance_schedule_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`schedule` ADD CONSTRAINT `fk_compliance_schedule_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);

-- ========= compliance --> project (17 constraint(s)) =========
-- Requires: compliance schema, project schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `water_utilities_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `water_utilities_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `water_utilities_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`schedule` ADD CONSTRAINT `fk_compliance_schedule_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`schedule` ADD CONSTRAINT `fk_compliance_schedule_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `water_utilities_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`schedule` ADD CONSTRAINT `fk_compliance_schedule_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= compliance --> service (2 constraint(s)) =========
-- Requires: compliance schema, service schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`ccr` ADD CONSTRAINT `fk_compliance_ccr_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`industrial_user` ADD CONSTRAINT `fk_compliance_industrial_user_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);

-- ========= compliance --> supply (15 constraint(s)) =========
-- Requires: compliance schema, supply schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `water_utilities_ecm`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`corrective_action` ADD CONSTRAINT `fk_compliance_corrective_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`industrial_user` ADD CONSTRAINT `fk_compliance_industrial_user_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`schedule` ADD CONSTRAINT `fk_compliance_schedule_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `water_utilities_ecm`.`supply`.`procurement_contract`(`procurement_contract_id`);

-- ========= compliance --> treatment (21 constraint(s)) =========
-- Requires: compliance schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_finished_water_production_id` FOREIGN KEY (`finished_water_production_id`) REFERENCES `water_utilities_ecm`.`treatment`.`finished_water_production`(`finished_water_production_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_process_reading_id` FOREIGN KEY (`process_reading_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_reading`(`process_reading_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_process_reading_id` FOREIGN KEY (`process_reading_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_reading`(`process_reading_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_treatment_violation_id` FOREIGN KEY (`treatment_violation_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_violation`(`treatment_violation_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_treatment_violation_id` FOREIGN KEY (`treatment_violation_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_violation`(`treatment_violation_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`ccr` ADD CONSTRAINT `fk_compliance_ccr_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`ccr` ADD CONSTRAINT `fk_compliance_ccr_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `water_utilities_ecm`.`treatment`.`water_source`(`water_source_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`schedule` ADD CONSTRAINT `fk_compliance_schedule_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_permit`(`treatment_permit_id`);

-- ========= compliance --> wastewater (5 constraint(s)) =========
-- Requires: compliance schema, wastewater schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`schedule` ADD CONSTRAINT `fk_compliance_schedule_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);

-- ========= customer --> asset (4 constraint(s)) =========
-- Requires: customer schema, asset schema
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= customer --> billing (6 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ADD CONSTRAINT `fk_customer_assistance_enrollment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `water_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `water_utilities_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `water_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `water_utilities_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= customer --> compliance (4 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_pretreatment_iup_id` FOREIGN KEY (`pretreatment_iup_id`) REFERENCES `water_utilities_ecm`.`compliance`.`pretreatment_iup`(`pretreatment_iup_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_overflow_event_id` FOREIGN KEY (`overflow_event_id`) REFERENCES `water_utilities_ecm`.`compliance`.`overflow_event`(`overflow_event_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_overflow_event_id` FOREIGN KEY (`overflow_event_id`) REFERENCES `water_utilities_ecm`.`compliance`.`overflow_event`(`overflow_event_id`);

-- ========= customer --> distribution (14 constraint(s)) =========
-- Requires: customer schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `water_utilities_ecm`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `water_utilities_ecm`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_network_valve_id` FOREIGN KEY (`network_valve_id`) REFERENCES `water_utilities_ecm`.`distribution`.`network_valve`(`network_valve_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `water_utilities_ecm`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `water_utilities_ecm`.`distribution`.`main_break`(`main_break_id`);

-- ========= customer --> finance (9 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ADD CONSTRAINT `fk_customer_assistance_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ADD CONSTRAINT `fk_customer_assistance_enrollment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ADD CONSTRAINT `fk_customer_assistance_enrollment_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);

-- ========= customer --> metering (1 constraint(s)) =========
-- Requires: customer schema, metering schema
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `water_utilities_ecm`.`metering`.`meter_size_type`(`meter_size_type_id`);

-- ========= customer --> project (8 constraint(s)) =========
-- Requires: customer schema, project schema
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`parcel` ADD CONSTRAINT `fk_customer_parcel_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= customer --> quality (4 constraint(s)) =========
-- Requires: customer schema, quality schema
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_system`(`water_system_id`);

-- ========= customer --> service (20 constraint(s)) =========
-- Requires: customer schema, service schema
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `water_utilities_ecm`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_sla_definition_id` FOREIGN KEY (`sla_definition_id`) REFERENCES `water_utilities_ecm`.`service`.`sla_definition`(`sla_definition_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `water_utilities_ecm`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ADD CONSTRAINT `fk_customer_assistance_enrollment_affordability_plan_id` FOREIGN KEY (`affordability_plan_id`) REFERENCES `water_utilities_ecm`.`service`.`affordability_plan`(`affordability_plan_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ADD CONSTRAINT `fk_customer_assistance_enrollment_primary_assistance_program_affordability_plan_id` FOREIGN KEY (`primary_assistance_program_affordability_plan_id`) REFERENCES `water_utilities_ecm`.`service`.`affordability_plan`(`affordability_plan_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `water_utilities_ecm`.`service`.`order`(`order_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_order_id` FOREIGN KEY (`order_id`) REFERENCES `water_utilities_ecm`.`service`.`order`(`order_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_order_id` FOREIGN KEY (`order_id`) REFERENCES `water_utilities_ecm`.`service`.`order`(`order_id`);

-- ========= customer --> supply (3 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ADD CONSTRAINT `fk_customer_organization_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`assistance_enrollment` ADD CONSTRAINT `fk_customer_assistance_enrollment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= customer --> treatment (5 constraint(s)) =========
-- Requires: customer schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_treatment_violation_id` FOREIGN KEY (`treatment_violation_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_violation`(`treatment_violation_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_treatment_violation_id` FOREIGN KEY (`treatment_violation_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_violation`(`treatment_violation_id`);

-- ========= customer --> wastewater (2 constraint(s)) =========
-- Requires: customer schema, wastewater schema
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`sewer_network`(`sewer_network_id`);

-- ========= distribution --> asset (22 constraint(s)) =========
-- Requires: distribution schema, asset schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_criticality_rating_id` FOREIGN KEY (`criticality_rating_id`) REFERENCES `water_utilities_ecm`.`asset`.`criticality_rating`(`criticality_rating_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_criticality_rating_id` FOREIGN KEY (`criticality_rating_id`) REFERENCES `water_utilities_ecm`.`asset`.`criticality_rating`(`criticality_rating_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_criticality_rating_id` FOREIGN KEY (`criticality_rating_id`) REFERENCES `water_utilities_ecm`.`asset`.`criticality_rating`(`criticality_rating_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_criticality_rating_id` FOREIGN KEY (`criticality_rating_id`) REFERENCES `water_utilities_ecm`.`asset`.`criticality_rating`(`criticality_rating_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_criticality_rating_id` FOREIGN KEY (`criticality_rating_id`) REFERENCES `water_utilities_ecm`.`asset`.`criticality_rating`(`criticality_rating_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_criticality_rating_id` FOREIGN KEY (`criticality_rating_id`) REFERENCES `water_utilities_ecm`.`asset`.`criticality_rating`(`criticality_rating_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_condition_assessment_id` FOREIGN KEY (`condition_assessment_id`) REFERENCES `water_utilities_ecm`.`asset`.`condition_assessment`(`condition_assessment_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_failure_record_id` FOREIGN KEY (`failure_record_id`) REFERENCES `water_utilities_ecm`.`asset`.`failure_record`(`failure_record_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `water_utilities_ecm`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `water_utilities_ecm`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= distribution --> compliance (14 constraint(s)) =========
-- Requires: distribution schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pressure_zone` ADD CONSTRAINT `fk_distribution_pressure_zone_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`dma` ADD CONSTRAINT `fk_distribution_dma_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`nrw_water_balance` ADD CONSTRAINT `fk_distribution_nrw_water_balance_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`nrw_water_balance` ADD CONSTRAINT `fk_distribution_nrw_water_balance_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`nrw_water_balance` ADD CONSTRAINT `fk_distribution_nrw_water_balance_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `water_utilities_ecm`.`compliance`.`schedule`(`schedule_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_compliance_public_notification_id` FOREIGN KEY (`compliance_public_notification_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_public_notification`(`compliance_public_notification_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_compliance_public_notification_id` FOREIGN KEY (`compliance_public_notification_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_public_notification`(`compliance_public_notification_id`);

-- ========= distribution --> customer (3 constraint(s)) =========
-- Requires: distribution schema, customer schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `water_utilities_ecm`.`customer`.`complaint`(`complaint_id`);

-- ========= distribution --> finance (14 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pressure_zone` ADD CONSTRAINT `fk_distribution_pressure_zone_revenue_requirement_id` FOREIGN KEY (`revenue_requirement_id`) REFERENCES `water_utilities_ecm`.`finance`.`revenue_requirement`(`revenue_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`nrw_water_balance` ADD CONSTRAINT `fk_distribution_nrw_water_balance_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`nrw_water_balance` ADD CONSTRAINT `fk_distribution_nrw_water_balance_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `water_utilities_ecm`.`finance`.`rate_case`(`rate_case_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`nrw_water_balance` ADD CONSTRAINT `fk_distribution_nrw_water_balance_revenue_requirement_id` FOREIGN KEY (`revenue_requirement_id`) REFERENCES `water_utilities_ecm`.`finance`.`revenue_requirement`(`revenue_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_grant_expenditure_id` FOREIGN KEY (`grant_expenditure_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant_expenditure`(`grant_expenditure_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `water_utilities_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);

-- ========= distribution --> metering (5 constraint(s)) =========
-- Requires: distribution schema, metering schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `water_utilities_ecm`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_leak_detection_event_id` FOREIGN KEY (`leak_detection_event_id`) REFERENCES `water_utilities_ecm`.`metering`.`leak_detection_event`(`leak_detection_event_id`);

-- ========= distribution --> project (8 constraint(s)) =========
-- Requires: distribution schema, project schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= distribution --> quality (8 constraint(s)) =========
-- Requires: distribution schema, quality schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_turbidity_reading_id` FOREIGN KEY (`turbidity_reading_id`) REFERENCES `water_utilities_ecm`.`quality`.`turbidity_reading`(`turbidity_reading_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);

-- ========= distribution --> service (1 constraint(s)) =========
-- Requires: distribution schema, service schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);

-- ========= distribution --> supply (21 constraint(s)) =========
-- Requires: distribution schema, supply schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`nrw_water_balance` ADD CONSTRAINT `fk_distribution_nrw_water_balance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= distribution --> treatment (1 constraint(s)) =========
-- Requires: distribution schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`pressure_zone` ADD CONSTRAINT `fk_distribution_pressure_zone_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= finance --> asset (7 constraint(s)) =========
-- Requires: finance schema, asset schema
ALTER TABLE `water_utilities_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= finance --> billing (7 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `water_utilities_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `water_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `water_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `water_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `water_utilities_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`revenue_requirement` ADD CONSTRAINT `fk_finance_revenue_requirement_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);

-- ========= finance --> customer (1 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `water_utilities_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= finance --> project (14 constraint(s)) =========
-- Requires: finance schema, project schema
ALTER TABLE `water_utilities_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_design_contract_id` FOREIGN KEY (`design_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`design_contract`(`design_contract_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= finance --> service (6 constraint(s)) =========
-- Requires: finance schema, service schema
ALTER TABLE `water_utilities_ecm`.`finance`.`grant` ADD CONSTRAINT `fk_finance_grant_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`debt_instrument` ADD CONSTRAINT `fk_finance_debt_instrument_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`rate_case` ADD CONSTRAINT `fk_finance_rate_case_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`revenue_requirement` ADD CONSTRAINT `fk_finance_revenue_requirement_service_class_id` FOREIGN KEY (`service_class_id`) REFERENCES `water_utilities_ecm`.`service`.`service_class`(`service_class_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`revenue_requirement` ADD CONSTRAINT `fk_finance_revenue_requirement_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `water_utilities_ecm`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`revenue_requirement` ADD CONSTRAINT `fk_finance_revenue_requirement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);

-- ========= finance --> supply (12 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `water_utilities_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `water_utilities_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `water_utilities_ecm`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= finance --> treatment (1 constraint(s)) =========
-- Requires: finance schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= metering --> asset (11 constraint(s)) =========
-- Requires: metering schema, asset schema
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `water_utilities_ecm`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= metering --> billing (2 constraint(s)) =========
-- Requires: metering schema, billing schema
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `water_utilities_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `water_utilities_ecm`.`billing`.`adjustment`(`adjustment_id`);

-- ========= metering --> compliance (5 constraint(s)) =========
-- Requires: metering schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= metering --> customer (10 constraint(s)) =========
-- Requires: metering schema, customer schema
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= metering --> distribution (7 constraint(s)) =========
-- Requires: metering schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);

-- ========= metering --> finance (9 constraint(s)) =========
-- Requires: metering schema, finance schema
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`accuracy_test` ADD CONSTRAINT `fk_metering_accuracy_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `water_utilities_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);

-- ========= metering --> project (8 constraint(s)) =========
-- Requires: metering schema, project schema
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= metering --> service (5 constraint(s)) =========
-- Requires: metering schema, service schema
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_connection_application_id` FOREIGN KEY (`connection_application_id`) REFERENCES `water_utilities_ecm`.`service`.`connection_application`(`connection_application_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);

-- ========= metering --> supply (5 constraint(s)) =========
-- Requires: metering schema, supply schema
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `water_utilities_ecm`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `water_utilities_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);

-- ========= metering --> wastewater (1 constraint(s)) =========
-- Requires: metering schema, wastewater schema
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);

-- ========= project --> asset (4 constraint(s)) =========
-- Requires: project schema, asset schema
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= project --> billing (1 constraint(s)) =========
-- Requires: project schema, billing schema
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `water_utilities_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= project --> compliance (12 constraint(s)) =========
-- Requires: project schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `water_utilities_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `water_utilities_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);

-- ========= project --> distribution (16 constraint(s)) =========
-- Requires: project schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `water_utilities_ecm`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `water_utilities_ecm`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_network_valve_id` FOREIGN KEY (`network_valve_id`) REFERENCES `water_utilities_ecm`.`distribution`.`network_valve`(`network_valve_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_prv_station_id` FOREIGN KEY (`prv_station_id`) REFERENCES `water_utilities_ecm`.`distribution`.`prv_station`(`prv_station_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `water_utilities_ecm`.`distribution`.`storage_tank`(`storage_tank_id`);

-- ========= project --> finance (23 constraint(s)) =========
-- Requires: project schema, finance schema
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `water_utilities_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `water_utilities_ecm`.`finance`.`rate_case`(`rate_case_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `water_utilities_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= project --> quality (2 constraint(s)) =========
-- Requires: project schema, quality schema
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_point`(`sampling_point_id`);

-- ========= project --> service (12 constraint(s)) =========
-- Requires: project schema, service schema
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_conservation_program_id` FOREIGN KEY (`conservation_program_id`) REFERENCES `water_utilities_ecm`.`service`.`conservation_program`(`conservation_program_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `water_utilities_ecm`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `water_utilities_ecm`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);

-- ========= project --> supply (14 constraint(s)) =========
-- Requires: project schema, supply schema
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_primary_design_vendor_id` FOREIGN KEY (`primary_design_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_construction_vendor_id` FOREIGN KEY (`construction_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_change_vendor_id` FOREIGN KEY (`change_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_pay_vendor_id` FOREIGN KEY (`pay_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_inspection_vendor_id` FOREIGN KEY (`inspection_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= project --> treatment (5 constraint(s)) =========
-- Requires: project schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_unit`(`process_unit_id`);

-- ========= quality --> asset (5 constraint(s)) =========
-- Requires: quality schema, asset schema
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= quality --> compliance (11 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ADD CONSTRAINT `fk_quality_contaminant_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `water_utilities_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_mor_id` FOREIGN KEY (`mor_id`) REFERENCES `water_utilities_ecm`.`compliance`.`mor`(`mor_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ADD CONSTRAINT `fk_quality_ccr_period_ccr_id` FOREIGN KEY (`ccr_id`) REFERENCES `water_utilities_ecm`.`compliance`.`ccr`(`ccr_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_compliance_public_notification_id` FOREIGN KEY (`compliance_public_notification_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_public_notification`(`compliance_public_notification_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ADD CONSTRAINT `fk_quality_water_system_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= quality --> customer (5 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);

-- ========= quality --> finance (12 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ADD CONSTRAINT `fk_quality_water_system_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ADD CONSTRAINT `fk_quality_water_system_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ADD CONSTRAINT `fk_quality_water_system_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `water_utilities_ecm`.`finance`.`rate_case`(`rate_case_id`);

-- ========= quality --> metering (5 constraint(s)) =========
-- Requires: quality schema, metering schema
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `water_utilities_ecm`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `water_utilities_ecm`.`metering`.`ami_endpoint`(`ami_endpoint_id`);

-- ========= quality --> project (5 constraint(s)) =========
-- Requires: quality schema, project schema
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_project_permit_id` FOREIGN KEY (`project_permit_id`) REFERENCES `water_utilities_ecm`.`project`.`project_permit`(`project_permit_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= quality --> service (9 constraint(s)) =========
-- Requires: quality schema, service schema
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ADD CONSTRAINT `fk_quality_ccr_period_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ADD CONSTRAINT `fk_quality_water_system_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);

-- ========= quality --> supply (6 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= quality --> treatment (4 constraint(s)) =========
-- Requires: quality schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= service --> asset (4 constraint(s)) =========
-- Requires: service schema, asset schema
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= service --> billing (3 constraint(s)) =========
-- Requires: service schema, billing schema
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `water_utilities_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);

-- ========= service --> compliance (9 constraint(s)) =========
-- Requires: service schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ADD CONSTRAINT `fk_service_affordability_plan_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= service --> customer (6 constraint(s)) =========
-- Requires: service schema, customer schema
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_order_customer_customer_account_id` FOREIGN KEY (`order_customer_customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);

-- ========= service --> distribution (15 constraint(s)) =========
-- Requires: service schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `water_utilities_ecm`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);

-- ========= service --> finance (19 constraint(s)) =========
-- Requires: service schema, finance schema
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `water_utilities_ecm`.`finance`.`rate_case`(`rate_case_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`service_class` ADD CONSTRAINT `fk_service_service_class_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `water_utilities_ecm`.`finance`.`rate_case`(`rate_case_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ADD CONSTRAINT `fk_service_affordability_plan_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ADD CONSTRAINT `fk_service_affordability_plan_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);

-- ========= service --> metering (5 constraint(s)) =========
-- Requires: service schema, metering schema
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `water_utilities_ecm`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_order_new_meter_metering_meter_id` FOREIGN KEY (`order_new_meter_metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);

-- ========= service --> project (2 constraint(s)) =========
-- Requires: service schema, project schema
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= service --> supply (3 constraint(s)) =========
-- Requires: service schema, supply schema
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= service --> treatment (6 constraint(s)) =========
-- Requires: service schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`territory` ADD CONSTRAINT `fk_service_territory_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `water_utilities_ecm`.`treatment`.`water_source`(`water_source_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `water_utilities_ecm`.`treatment`.`water_source`(`water_source_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= supply --> asset (1 constraint(s)) =========
-- Requires: supply schema, asset schema
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= supply --> finance (26 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `water_utilities_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= supply --> project (6 constraint(s)) =========
-- Requires: supply schema, project schema
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= supply --> quality (1 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant`(`contaminant_id`);

-- ========= supply --> service (2 constraint(s)) =========
-- Requires: supply schema, service schema
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`warehouse_location` ADD CONSTRAINT `fk_supply_warehouse_location_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);

-- ========= supply --> treatment (6 constraint(s)) =========
-- Requires: supply schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_backwash_event_id` FOREIGN KEY (`backwash_event_id`) REFERENCES `water_utilities_ecm`.`treatment`.`backwash_event`(`backwash_event_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_chemical_dose_event_id` FOREIGN KEY (`chemical_dose_event_id`) REFERENCES `water_utilities_ecm`.`treatment`.`chemical_dose_event`(`chemical_dose_event_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= treatment --> asset (20 constraint(s)) =========
-- Requires: treatment schema, asset schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `water_utilities_ecm`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `water_utilities_ecm`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= treatment --> compliance (9 constraint(s)) =========
-- Requires: treatment schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`water_source` ADD CONSTRAINT `fk_treatment_water_source_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= treatment --> distribution (9 constraint(s)) =========
-- Requires: treatment schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `water_utilities_ecm`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `water_utilities_ecm`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);

-- ========= treatment --> finance (11 constraint(s)) =========
-- Requires: treatment schema, finance schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `water_utilities_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `water_utilities_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= treatment --> metering (5 constraint(s)) =========
-- Requires: treatment schema, metering schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);

-- ========= treatment --> project (7 constraint(s)) =========
-- Requires: treatment schema, project schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= treatment --> quality (10 constraint(s)) =========
-- Requires: treatment schema, quality schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_online_instrument_id` FOREIGN KEY (`online_instrument_id`) REFERENCES `water_utilities_ecm`.`quality`.`online_instrument`(`online_instrument_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_turbidity_reading_id` FOREIGN KEY (`turbidity_reading_id`) REFERENCES `water_utilities_ecm`.`quality`.`turbidity_reading`(`turbidity_reading_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `water_utilities_ecm`.`quality`.`analytical_result`(`analytical_result_id`);

-- ========= treatment --> service (2 constraint(s)) =========
-- Requires: treatment schema, service schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);

-- ========= treatment --> supply (9 constraint(s)) =========
-- Requires: treatment schema, supply schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_primary_chemical_supplier_vendor_id` FOREIGN KEY (`primary_chemical_supplier_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_inventory_stock_id` FOREIGN KEY (`inventory_stock_id`) REFERENCES `water_utilities_ecm`.`supply`.`inventory_stock`(`inventory_stock_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);

-- ========= wastewater --> asset (31 constraint(s)) =========
-- Requires: wastewater schema, asset schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_failure_record_id` FOREIGN KEY (`failure_record_id`) REFERENCES `water_utilities_ecm`.`asset`.`failure_record`(`failure_record_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `water_utilities_ecm`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_failure_record_id` FOREIGN KEY (`failure_record_id`) REFERENCES `water_utilities_ecm`.`asset`.`failure_record`(`failure_record_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `water_utilities_ecm`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ADD CONSTRAINT `fk_wastewater_ii_flow_measurement_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `water_utilities_ecm`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_condition_assessment_id` FOREIGN KEY (`condition_assessment_id`) REFERENCES `water_utilities_ecm`.`asset`.`condition_assessment`(`condition_assessment_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `water_utilities_ecm`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= wastewater --> compliance (24 constraint(s)) =========
-- Requires: wastewater schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_dmr_id` FOREIGN KEY (`dmr_id`) REFERENCES `water_utilities_ecm`.`compliance`.`dmr`(`dmr_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `water_utilities_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_overflow_event_id` FOREIGN KEY (`overflow_event_id`) REFERENCES `water_utilities_ecm`.`compliance`.`overflow_event`(`overflow_event_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_overflow_event_id` FOREIGN KEY (`overflow_event_id`) REFERENCES `water_utilities_ecm`.`compliance`.`overflow_event`(`overflow_event_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_industrial_user_id` FOREIGN KEY (`industrial_user_id`) REFERENCES `water_utilities_ecm`.`compliance`.`industrial_user`(`industrial_user_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_pretreatment_iup_id` FOREIGN KEY (`pretreatment_iup_id`) REFERENCES `water_utilities_ecm`.`compliance`.`pretreatment_iup`(`pretreatment_iup_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= wastewater --> customer (10 constraint(s)) =========
-- Requires: wastewater schema, customer schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_organization_id` FOREIGN KEY (`organization_id`) REFERENCES `water_utilities_ecm`.`customer`.`organization`(`organization_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);

-- ========= wastewater --> distribution (5 constraint(s)) =========
-- Requires: wastewater schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ADD CONSTRAINT `fk_wastewater_ii_flow_measurement_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);

-- ========= wastewater --> finance (24 constraint(s)) =========
-- Requires: wastewater schema, finance schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_debt_instrument_id` FOREIGN KEY (`debt_instrument_id`) REFERENCES `water_utilities_ecm`.`finance`.`debt_instrument`(`debt_instrument_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `water_utilities_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `water_utilities_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `water_utilities_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `water_utilities_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= wastewater --> metering (3 constraint(s)) =========
-- Requires: wastewater schema, metering schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);

-- ========= wastewater --> project (15 constraint(s)) =========
-- Requires: wastewater schema, project schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_project_permit_id` FOREIGN KEY (`project_permit_id`) REFERENCES `water_utilities_ecm`.`project`.`project_permit`(`project_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_project_permit_id` FOREIGN KEY (`project_permit_id`) REFERENCES `water_utilities_ecm`.`project`.`project_permit`(`project_permit_id`);

-- ========= wastewater --> quality (8 constraint(s)) =========
-- Requires: wastewater schema, quality schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `water_utilities_ecm`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `water_utilities_ecm`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_point`(`sampling_point_id`);

-- ========= wastewater --> service (13 constraint(s)) =========
-- Requires: wastewater schema, service schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`outfall` ADD CONSTRAINT `fk_wastewater_outfall_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);

-- ========= wastewater --> supply (11 constraint(s)) =========
-- Requires: wastewater schema, supply schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= wastewater --> treatment (5 constraint(s)) =========
-- Requires: wastewater schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_source_water_intake_id` FOREIGN KEY (`source_water_intake_id`) REFERENCES `water_utilities_ecm`.`treatment`.`source_water_intake`(`source_water_intake_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_source_water_intake_id` FOREIGN KEY (`source_water_intake_id`) REFERENCES `water_utilities_ecm`.`treatment`.`source_water_intake`(`source_water_intake_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_unit`(`process_unit_id`);

