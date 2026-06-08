-- Cross-Domain Foreign Keys for Business: Water Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 23:22:58
-- Total cross-domain FK constraints: 1345
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, compliance, customer, distribution, finance, laboratory, metering, project, quality, service, supply, treatment, wastewater, workforce

-- ========= asset --> billing (3 constraint(s)) =========
-- Requires: asset schema, billing schema
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `water_utilities_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= asset --> compliance (4 constraint(s)) =========
-- Requires: asset schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`compliance_requirement` ADD CONSTRAINT `fk_asset_compliance_requirement_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= asset --> customer (4 constraint(s)) =========
-- Requires: asset schema, customer schema
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);

-- ========= asset --> finance (9 constraint(s)) =========
-- Requires: asset schema, finance schema
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`disposal` ADD CONSTRAINT `fk_asset_disposal_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`grant_funding` ADD CONSTRAINT `fk_asset_grant_funding_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);

-- ========= asset --> laboratory (6 constraint(s)) =========
-- Requires: asset schema, laboratory schema
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`test_result`(`test_result_id`);

-- ========= asset --> metering (1 constraint(s)) =========
-- Requires: asset schema, metering schema
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_meter` ADD CONSTRAINT `fk_asset_asset_meter_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);

-- ========= asset --> project (7 constraint(s)) =========
-- Requires: asset schema, project schema
ALTER TABLE `water_utilities_ecm`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`disposal` ADD CONSTRAINT `fk_asset_disposal_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_project_permit_id` FOREIGN KEY (`project_permit_id`) REFERENCES `water_utilities_ecm`.`project`.`project_permit`(`project_permit_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_design_contract_id` FOREIGN KEY (`design_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`design_contract`(`design_contract_id`);

-- ========= asset --> quality (5 constraint(s)) =========
-- Requires: asset schema, quality schema
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `water_utilities_ecm`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_sampling_point` ADD CONSTRAINT `fk_asset_asset_sampling_point_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);

-- ========= asset --> supply (7 constraint(s)) =========
-- Requires: asset schema, supply schema
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `water_utilities_ecm`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`disposal` ADD CONSTRAINT `fk_asset_disposal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`procurement_mapping` ADD CONSTRAINT `fk_asset_procurement_mapping_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `water_utilities_ecm`.`supply`.`procurement_category`(`procurement_category_id`);

-- ========= asset --> treatment (6 constraint(s)) =========
-- Requires: asset schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`acquisition` ADD CONSTRAINT `fk_asset_acquisition_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= asset --> workforce (19 constraint(s)) =========
-- Requires: asset schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`asset_class` ADD CONSTRAINT `fk_asset_asset_class_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_primary_condition_employee_id` FOREIGN KEY (`primary_condition_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_reviewed_by_employee_id` FOREIGN KEY (`reviewed_by_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_tertiary_condition_approved_by_employee_id` FOREIGN KEY (`tertiary_condition_approved_by_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `water_utilities_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_work_center_org_unit_id` FOREIGN KEY (`work_center_org_unit_id`) REFERENCES `water_utilities_ecm`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`failure_record` ADD CONSTRAINT `fk_asset_failure_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`inspection_event` ADD CONSTRAINT `fk_asset_inspection_event_primary_inspection_approved_by_employee_id` FOREIGN KEY (`primary_inspection_approved_by_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`document` ADD CONSTRAINT `fk_asset_document_document_author_employee_id` FOREIGN KEY (`document_author_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`asset`.`procurement_mapping` ADD CONSTRAINT `fk_asset_procurement_mapping_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= billing --> asset (4 constraint(s)) =========
-- Requires: billing schema, asset schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= billing --> customer (11 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_assistance_program_id` FOREIGN KEY (`assistance_program_id`) REFERENCES `water_utilities_ecm`.`customer`.`assistance_program`(`assistance_program_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_assistance_enrollment` ADD CONSTRAINT `fk_billing_billing_assistance_enrollment_assistance_program_id` FOREIGN KEY (`assistance_program_id`) REFERENCES `water_utilities_ecm`.`customer`.`assistance_program`(`assistance_program_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_person_id` FOREIGN KEY (`person_id`) REFERENCES `water_utilities_ecm`.`customer`.`person`(`person_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_lien_premise_id` FOREIGN KEY (`lien_premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `water_utilities_ecm`.`customer`.`parcel`(`parcel_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`delinquency_notice` ADD CONSTRAINT `fk_billing_delinquency_notice_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= billing --> distribution (7 constraint(s)) =========
-- Requires: billing schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `water_utilities_ecm`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_network_isolation_event_id` FOREIGN KEY (`network_isolation_event_id`) REFERENCES `water_utilities_ecm`.`distribution`.`network_isolation_event`(`network_isolation_event_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `water_utilities_ecm`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);

-- ========= billing --> finance (13 constraint(s)) =========
-- Requires: billing schema, finance schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `water_utilities_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `water_utilities_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `water_utilities_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_finance_rate_case_id` FOREIGN KEY (`finance_rate_case_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `water_utilities_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_assistance_enrollment` ADD CONSTRAINT `fk_billing_billing_assistance_enrollment_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `water_utilities_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `water_utilities_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `water_utilities_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `water_utilities_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= billing --> laboratory (4 constraint(s)) =========
-- Requires: billing schema, laboratory schema
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`test_result`(`test_result_id`);

-- ========= billing --> metering (1 constraint(s)) =========
-- Requires: billing schema, metering schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_interval_consumption_id` FOREIGN KEY (`interval_consumption_id`) REFERENCES `water_utilities_ecm`.`metering`.`interval_consumption`(`interval_consumption_id`);

-- ========= billing --> project (7 constraint(s)) =========
-- Requires: billing schema, project schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= billing --> quality (5 constraint(s)) =========
-- Requires: billing schema, quality schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `water_utilities_ecm`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);

-- ========= billing --> service (9 constraint(s)) =========
-- Requires: billing schema, service schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_order_id` FOREIGN KEY (`order_id`) REFERENCES `water_utilities_ecm`.`service`.`order`(`order_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_order_id` FOREIGN KEY (`order_id`) REFERENCES `water_utilities_ecm`.`service`.`order`(`order_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);

-- ========= billing --> treatment (4 constraint(s)) =========
-- Requires: billing schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_treatment_violation_id` FOREIGN KEY (`treatment_violation_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_violation`(`treatment_violation_id`);

-- ========= billing --> wastewater (1 constraint(s)) =========
-- Requires: billing schema, wastewater schema
ALTER TABLE `water_utilities_ecm`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_sewer_service_connection_id` FOREIGN KEY (`sewer_service_connection_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`sewer_service_connection`(`sewer_service_connection_id`);

-- ========= billing --> workforce (27 constraint(s)) =========
-- Requires: billing schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_received_by_user_employee_id` FOREIGN KEY (`received_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_applied_by_user_employee_id` FOREIGN KEY (`applied_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_adjustment_employee_id` FOREIGN KEY (`adjustment_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_adjustment_initiated_by_user_employee_id` FOREIGN KEY (`adjustment_initiated_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_initiated_by_user_employee_id` FOREIGN KEY (`initiated_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`collection_notice` ADD CONSTRAINT `fk_billing_collection_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_assistance_enrollment` ADD CONSTRAINT `fk_billing_billing_assistance_enrollment_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`billing_assistance_enrollment` ADD CONSTRAINT `fk_billing_billing_assistance_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_assigned_to_user_employee_id` FOREIGN KEY (`assigned_to_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_primary_write_employee_id` FOREIGN KEY (`primary_write_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_lien_employee_id` FOREIGN KEY (`lien_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_lien_released_by_user_employee_id` FOREIGN KEY (`lien_released_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`lien` ADD CONSTRAINT `fk_billing_lien_released_by_user_employee_id` FOREIGN KEY (`released_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`revenue_recognition_event` ADD CONSTRAINT `fk_billing_revenue_recognition_event_primary_revenue_employee_id` FOREIGN KEY (`primary_revenue_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`billing`.`delinquency_notice` ADD CONSTRAINT `fk_billing_delinquency_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= compliance --> asset (7 constraint(s)) =========
-- Requires: compliance schema, asset schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_document_id` FOREIGN KEY (`document_id`) REFERENCES `water_utilities_ecm`.`asset`.`document`(`document_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_affected_asset_registry_id` FOREIGN KEY (`affected_asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_inspection_event_id` FOREIGN KEY (`inspection_event_id`) REFERENCES `water_utilities_ecm`.`asset`.`inspection_event`(`inspection_event_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= compliance --> billing (2 constraint(s)) =========
-- Requires: compliance schema, billing schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`industrial_user` ADD CONSTRAINT `fk_compliance_industrial_user_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= compliance --> finance (13 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `water_utilities_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`ccr` ADD CONSTRAINT `fk_compliance_ccr_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_encumbrance_id` FOREIGN KEY (`encumbrance_id`) REFERENCES `water_utilities_ecm`.`finance`.`encumbrance`(`encumbrance_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `water_utilities_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`permit_grant_allocation` ADD CONSTRAINT `fk_compliance_permit_grant_allocation_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);

-- ========= compliance --> laboratory (20 constraint(s)) =========
-- Requires: compliance schema, laboratory schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`ccr` ADD CONSTRAINT `fk_compliance_ccr_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_lab_accreditation_id` FOREIGN KEY (`lab_accreditation_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_accreditation`(`lab_accreditation_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_test_method_id` FOREIGN KEY (`test_method_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`test_method`(`test_method_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_lab_work_order_id` FOREIGN KEY (`lab_work_order_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_work_order`(`lab_work_order_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`industrial_user` ADD CONSTRAINT `fk_compliance_industrial_user_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_plan`(`sampling_plan_id`);

-- ========= compliance --> project (8 constraint(s)) =========
-- Requires: compliance schema, project schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= compliance --> supply (13 constraint(s)) =========
-- Requires: compliance schema, supply schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`industrial_user` ADD CONSTRAINT `fk_compliance_industrial_user_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `water_utilities_ecm`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`permit_vendor_service` ADD CONSTRAINT `fk_compliance_permit_vendor_service_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`material_compliance_certification` ADD CONSTRAINT `fk_compliance_material_compliance_certification_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= compliance --> treatment (13 constraint(s)) =========
-- Requires: compliance schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_finished_water_production_id` FOREIGN KEY (`finished_water_production_id`) REFERENCES `water_utilities_ecm`.`treatment`.`finished_water_production`(`finished_water_production_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_treatment_violation_id` FOREIGN KEY (`treatment_violation_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_violation`(`treatment_violation_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= compliance --> wastewater (3 constraint(s)) =========
-- Requires: compliance schema, wastewater schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr` ADD CONSTRAINT `fk_compliance_dmr_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_dmr_submission_id` FOREIGN KEY (`dmr_submission_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`dmr_submission`(`dmr_submission_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`outfall`(`outfall_id`);

-- ========= compliance --> workforce (24 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_permit` ADD CONSTRAINT `fk_compliance_compliance_permit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_position_id` FOREIGN KEY (`position_id`) REFERENCES `water_utilities_ecm`.`workforce`.`position`(`position_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`dmr_result` ADD CONSTRAINT `fk_compliance_dmr_result_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`mor` ADD CONSTRAINT `fk_compliance_mor_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_violation` ADD CONSTRAINT `fk_compliance_compliance_violation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_public_notification` ADD CONSTRAINT `fk_compliance_compliance_public_notification_primary_compliance_employee_id` FOREIGN KEY (`primary_compliance_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`ccr` ADD CONSTRAINT `fk_compliance_ccr_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_inspection` ADD CONSTRAINT `fk_compliance_regulatory_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`inspection_finding` ADD CONSTRAINT `fk_compliance_inspection_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_corrective_action` ADD CONSTRAINT `fk_compliance_compliance_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_correspondence` ADD CONSTRAINT `fk_compliance_regulatory_correspondence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`pretreatment_iup` ADD CONSTRAINT `fk_compliance_pretreatment_iup_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`industrial_user` ADD CONSTRAINT `fk_compliance_industrial_user_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`overflow_event` ADD CONSTRAINT `fk_compliance_overflow_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`compliance_schedule` ADD CONSTRAINT `fk_compliance_compliance_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_agency` ADD CONSTRAINT `fk_compliance_regulatory_agency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`regulatory_agency` ADD CONSTRAINT `fk_compliance_regulatory_agency_primary_liaison_employee_id` FOREIGN KEY (`primary_liaison_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`compliance`.`crew_assignment` ADD CONSTRAINT `fk_compliance_crew_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);

-- ========= customer --> asset (6 constraint(s)) =========
-- Requires: customer schema, asset schema
ALTER TABLE `water_utilities_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_document_id` FOREIGN KEY (`document_id`) REFERENCES `water_utilities_ecm`.`asset`.`document`(`document_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_asset_responsibility` ADD CONSTRAINT `fk_customer_account_asset_responsibility_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= customer --> billing (4 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `water_utilities_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_payment_arrangement_payment_plan_id` FOREIGN KEY (`payment_arrangement_payment_plan_id`) REFERENCES `water_utilities_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `water_utilities_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `water_utilities_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= customer --> compliance (10 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_overflow_event_id` FOREIGN KEY (`overflow_event_id`) REFERENCES `water_utilities_ecm`.`compliance`.`overflow_event`(`overflow_event_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_overflow_event_id` FOREIGN KEY (`overflow_event_id`) REFERENCES `water_utilities_ecm`.`compliance`.`overflow_event`(`overflow_event_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_enforcement_impact` ADD CONSTRAINT `fk_customer_account_enforcement_impact_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`premise_overflow_impact` ADD CONSTRAINT `fk_customer_premise_overflow_impact_overflow_event_id` FOREIGN KEY (`overflow_event_id`) REFERENCES `water_utilities_ecm`.`compliance`.`overflow_event`(`overflow_event_id`);

-- ========= customer --> distribution (8 constraint(s)) =========
-- Requires: customer schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `water_utilities_ecm`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_network_valve_id` FOREIGN KEY (`network_valve_id`) REFERENCES `water_utilities_ecm`.`distribution`.`network_valve`(`network_valve_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);

-- ========= customer --> finance (9 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `water_utilities_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`deposit` ADD CONSTRAINT `fk_customer_deposit_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `water_utilities_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`deposit` ADD CONSTRAINT `fk_customer_deposit_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`grant_enrollment` ADD CONSTRAINT `fk_customer_grant_enrollment_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);

-- ========= customer --> laboratory (1 constraint(s)) =========
-- Requires: customer schema, laboratory schema
ALTER TABLE `water_utilities_ecm`.`customer`.`sampling_participation` ADD CONSTRAINT `fk_customer_sampling_participation_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_plan`(`sampling_plan_id`);

-- ========= customer --> metering (1 constraint(s)) =========
-- Requires: customer schema, metering schema
ALTER TABLE `water_utilities_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_read_id` FOREIGN KEY (`read_id`) REFERENCES `water_utilities_ecm`.`metering`.`read`(`read_id`);

-- ========= customer --> project (8 constraint(s)) =========
-- Requires: customer schema, project schema
ALTER TABLE `water_utilities_ecm`.`customer`.`service_address` ADD CONSTRAINT `fk_customer_service_address_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`project_stakeholder` ADD CONSTRAINT `fk_customer_project_stakeholder_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= customer --> quality (1 constraint(s)) =========
-- Requires: customer schema, quality schema
ALTER TABLE `water_utilities_ecm`.`customer`.`sampling_site` ADD CONSTRAINT `fk_customer_sampling_site_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);

-- ========= customer --> service (11 constraint(s)) =========
-- Requires: customer schema, service schema
ALTER TABLE `water_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_assistance_enrollment` ADD CONSTRAINT `fk_customer_customer_assistance_enrollment_affordability_plan_id` FOREIGN KEY (`affordability_plan_id`) REFERENCES `water_utilities_ecm`.`service`.`affordability_plan`(`affordability_plan_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_order_id` FOREIGN KEY (`order_id`) REFERENCES `water_utilities_ecm`.`service`.`order`(`order_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `water_utilities_ecm`.`service`.`order`(`order_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_order_id` FOREIGN KEY (`order_id`) REFERENCES `water_utilities_ecm`.`service`.`order`(`order_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_order_id` FOREIGN KEY (`order_id`) REFERENCES `water_utilities_ecm`.`service`.`order`(`order_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_program_enrollment` ADD CONSTRAINT `fk_customer_customer_program_enrollment_conservation_program_id` FOREIGN KEY (`conservation_program_id`) REFERENCES `water_utilities_ecm`.`service`.`conservation_program`(`conservation_program_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_program_enrollment` ADD CONSTRAINT `fk_customer_customer_program_enrollment_service_program_enrollment_id` FOREIGN KEY (`service_program_enrollment_id`) REFERENCES `water_utilities_ecm`.`service`.`service_program_enrollment`(`service_program_enrollment_id`);

-- ========= customer --> supply (1 constraint(s)) =========
-- Requires: customer schema, supply schema
ALTER TABLE `water_utilities_ecm`.`customer`.`organization` ADD CONSTRAINT `fk_customer_organization_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= customer --> treatment (2 constraint(s)) =========
-- Requires: customer schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= customer --> workforce (23 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_assigned_to_user_employee_id` FOREIGN KEY (`assigned_to_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`service_application` ADD CONSTRAINT `fk_customer_service_application_primary_service_employee_id` FOREIGN KEY (`primary_service_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_status_history` ADD CONSTRAINT `fk_customer_account_status_history_primary_account_employee_id` FOREIGN KEY (`primary_account_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`contact` ADD CONSTRAINT `fk_customer_contact_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_primary_account_employee_id` FOREIGN KEY (`primary_account_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_note` ADD CONSTRAINT `fk_customer_account_note_reviewed_by_user_employee_id` FOREIGN KEY (`reviewed_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_agent_employee_id` FOREIGN KEY (`agent_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_assigned_to_user_employee_id` FOREIGN KEY (`assigned_to_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`customer_complaint` ADD CONSTRAINT `fk_customer_customer_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`third_party_notification` ADD CONSTRAINT `fk_customer_third_party_notification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_primary_account_employee_id` FOREIGN KEY (`primary_account_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_quaternary_account_last_modified_by_user_employee_id` FOREIGN KEY (`quaternary_account_last_modified_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`account_document` ADD CONSTRAINT `fk_customer_account_document_tertiary_account_created_by_user_employee_id` FOREIGN KEY (`tertiary_account_created_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= distribution --> asset (18 constraint(s)) =========
-- Requires: distribution schema, asset schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
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
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= distribution --> compliance (12 constraint(s)) =========
-- Requires: distribution schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pressure_zone` ADD CONSTRAINT `fk_distribution_pressure_zone_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`dma` ADD CONSTRAINT `fk_distribution_dma_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_regulatory_inspection_id` FOREIGN KEY (`regulatory_inspection_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_inspection`(`regulatory_inspection_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`distribution_nrw_water_balance` ADD CONSTRAINT `fk_distribution_distribution_nrw_water_balance_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_compliance_corrective_action_id` FOREIGN KEY (`compliance_corrective_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_compliance_public_notification_id` FOREIGN KEY (`compliance_public_notification_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_public_notification`(`compliance_public_notification_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_compliance_public_notification_id` FOREIGN KEY (`compliance_public_notification_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_public_notification`(`compliance_public_notification_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydraulic_model_run` ADD CONSTRAINT `fk_distribution_hydraulic_model_run_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_compliance_public_notification_id` FOREIGN KEY (`compliance_public_notification_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_public_notification`(`compliance_public_notification_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_compliance_corrective_action_id` FOREIGN KEY (`compliance_corrective_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);

-- ========= distribution --> customer (3 constraint(s)) =========
-- Requires: distribution schema, customer schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_customer_complaint_id` FOREIGN KEY (`customer_complaint_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_complaint`(`customer_complaint_id`);

-- ========= distribution --> finance (20 constraint(s)) =========
-- Requires: distribution schema, finance schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_main` ADD CONSTRAINT `fk_distribution_pipe_main_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_valve` ADD CONSTRAINT `fk_distribution_network_valve_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`prv_station` ADD CONSTRAINT `fk_distribution_prv_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant` ADD CONSTRAINT `fk_distribution_hydrant_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pump_station` ADD CONSTRAINT `fk_distribution_pump_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`storage_tank` ADD CONSTRAINT `fk_distribution_storage_tank_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`distribution_nrw_water_balance` ADD CONSTRAINT `fk_distribution_distribution_nrw_water_balance_revenue_requirement_id` FOREIGN KEY (`revenue_requirement_id`) REFERENCES `water_utilities_ecm`.`finance`.`revenue_requirement`(`revenue_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_grant_expenditure_id` FOREIGN KEY (`grant_expenditure_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant_expenditure`(`grant_expenditure_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_encumbrance_id` FOREIGN KEY (`encumbrance_id`) REFERENCES `water_utilities_ecm`.`finance`.`encumbrance`(`encumbrance_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydraulic_model_run` ADD CONSTRAINT `fk_distribution_hydraulic_model_run_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_encumbrance_id` FOREIGN KEY (`encumbrance_id`) REFERENCES `water_utilities_ecm`.`finance`.`encumbrance`(`encumbrance_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_cost_allocation_id` FOREIGN KEY (`cost_allocation_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_encumbrance_id` FOREIGN KEY (`encumbrance_id`) REFERENCES `water_utilities_ecm`.`finance`.`encumbrance`(`encumbrance_id`);

-- ========= distribution --> laboratory (2 constraint(s)) =========
-- Requires: distribution schema, laboratory schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);

-- ========= distribution --> metering (5 constraint(s)) =========
-- Requires: distribution schema, metering schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_reading` ADD CONSTRAINT `fk_distribution_network_reading_read_id` FOREIGN KEY (`read_id`) REFERENCES `water_utilities_ecm`.`metering`.`read`(`read_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_leak_detection_event_id` FOREIGN KEY (`leak_detection_event_id`) REFERENCES `water_utilities_ecm`.`metering`.`leak_detection_event`(`leak_detection_event_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydraulic_model_run` ADD CONSTRAINT `fk_distribution_hydraulic_model_run_consumption_profile_id` FOREIGN KEY (`consumption_profile_id`) REFERENCES `water_utilities_ecm`.`metering`.`consumption_profile`(`consumption_profile_id`);

-- ========= distribution --> project (7 constraint(s)) =========
-- Requires: distribution schema, project schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydraulic_model_run` ADD CONSTRAINT `fk_distribution_hydraulic_model_run_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= distribution --> quality (6 constraint(s)) =========
-- Requires: distribution schema, quality schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`service_line` ADD CONSTRAINT `fk_distribution_service_line_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_turbidity_reading_id` FOREIGN KEY (`turbidity_reading_id`) REFERENCES `water_utilities_ecm`.`quality`.`turbidity_reading`(`turbidity_reading_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);

-- ========= distribution --> service (1 constraint(s)) =========
-- Requires: distribution schema, service schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`flow_reading` ADD CONSTRAINT `fk_distribution_flow_reading_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);

-- ========= distribution --> supply (25 constraint(s)) =========
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
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_contractor_vendor_id` FOREIGN KEY (`contractor_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_contractor_vendor_id` FOREIGN KEY (`contractor_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_contractor_vendor_id` FOREIGN KEY (`contractor_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_procurement` ADD CONSTRAINT `fk_distribution_pipe_procurement_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `water_utilities_ecm`.`supply`.`procurement_contract`(`procurement_contract_id`);

-- ========= distribution --> treatment (1 constraint(s)) =========
-- Requires: distribution schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`pressure_zone` ADD CONSTRAINT `fk_distribution_pressure_zone_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= distribution --> workforce (18 constraint(s)) =========
-- Requires: distribution schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`distribution`.`dma` ADD CONSTRAINT `fk_distribution_dma_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`dma` ADD CONSTRAINT `fk_distribution_dma_responsible_operator_employee_id` FOREIGN KEY (`responsible_operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`leak_detection_survey` ADD CONSTRAINT `fk_distribution_leak_detection_survey_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`main_break` ADD CONSTRAINT `fk_distribution_main_break_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`valve_exercise` ADD CONSTRAINT `fk_distribution_valve_exercise_technician_employee_id` FOREIGN KEY (`technician_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`hydrant_flow_test` ADD CONSTRAINT `fk_distribution_hydrant_flow_test_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`flushing_event` ADD CONSTRAINT `fk_distribution_flushing_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_crew_supervisor_employee_id` FOREIGN KEY (`crew_supervisor_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`network_isolation_event` ADD CONSTRAINT `fk_distribution_network_isolation_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`pipe_condition_assessment` ADD CONSTRAINT `fk_distribution_pipe_condition_assessment_technician_employee_id` FOREIGN KEY (`technician_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`dma_crew_coverage` ADD CONSTRAINT `fk_distribution_dma_crew_coverage_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`distribution`.`zone_operator_assignment` ADD CONSTRAINT `fk_distribution_zone_operator_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> asset (7 constraint(s)) =========
-- Requires: finance schema, asset schema
ALTER TABLE `water_utilities_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= finance --> billing (5 constraint(s)) =========
-- Requires: finance schema, billing schema
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `water_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `water_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `water_utilities_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`revenue_requirement` ADD CONSTRAINT `fk_finance_revenue_requirement_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);

-- ========= finance --> customer (2 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `water_utilities_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= finance --> project (13 constraint(s)) =========
-- Requires: finance schema, project schema
ALTER TABLE `water_utilities_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ar_transaction` ADD CONSTRAINT `fk_finance_ar_transaction_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`debt_service_payment` ADD CONSTRAINT `fk_finance_debt_service_payment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`revenue_requirement` ADD CONSTRAINT `fk_finance_revenue_requirement_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`interfund_transfer` ADD CONSTRAINT `fk_finance_interfund_transfer_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`project_funding_allocation` ADD CONSTRAINT `fk_finance_project_funding_allocation_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= finance --> supply (8 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `water_utilities_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_business_partner_vendor_id` FOREIGN KEY (`business_partner_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`encumbrance` ADD CONSTRAINT `fk_finance_encumbrance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= finance --> wastewater (2 constraint(s)) =========
-- Requires: finance schema, wastewater schema
ALTER TABLE `water_utilities_ecm`.`finance`.`grant_allocation` ADD CONSTRAINT `fk_finance_grant_allocation_lift_station_id` FOREIGN KEY (`lift_station_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`lift_station`(`lift_station_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`grant_funded_segment` ADD CONSTRAINT `fk_finance_grant_funded_segment_sewer_network_id` FOREIGN KEY (`sewer_network_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`sewer_network`(`sewer_network_id`);

-- ========= finance --> workforce (17 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_manager_employee_id` FOREIGN KEY (`budget_manager_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`grant_expenditure` ADD CONSTRAINT `fk_finance_grant_expenditure_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_primary_bank_employee_id` FOREIGN KEY (`primary_bank_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_reviewed_by_user_employee_id` FOREIGN KEY (`reviewed_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`bank_reconciliation` ADD CONSTRAINT `fk_finance_bank_reconciliation_tertiary_bank_approved_by_user_employee_id` FOREIGN KEY (`tertiary_bank_approved_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_primary_cost_employee_id` FOREIGN KEY (`primary_cost_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_tertiary_cost_responsible_manager_employee_id` FOREIGN KEY (`tertiary_cost_responsible_manager_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`drawdown_request` ADD CONSTRAINT `fk_finance_drawdown_request_approval_user_employee_id` FOREIGN KEY (`approval_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`finance`.`drawdown_request` ADD CONSTRAINT `fk_finance_drawdown_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= laboratory --> asset (4 constraint(s)) =========
-- Requires: laboratory schema, asset schema
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_instrument` ADD CONSTRAINT `fk_laboratory_lab_instrument_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_instrument` ADD CONSTRAINT `fk_laboratory_lab_instrument_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= laboratory --> compliance (3 constraint(s)) =========
-- Requires: laboratory schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_compliance_corrective_action_id` FOREIGN KEY (`compliance_corrective_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_corrective_action`(`compliance_corrective_action_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_accreditation_grant` ADD CONSTRAINT `fk_laboratory_lab_accreditation_grant_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);

-- ========= laboratory --> customer (6 constraint(s)) =========
-- Requires: laboratory schema, customer schema
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`chain_of_custody` ADD CONSTRAINT `fk_laboratory_chain_of_custody_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_work_order` ADD CONSTRAINT `fk_laboratory_lab_work_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`certificate_of_analysis` ADD CONSTRAINT `fk_laboratory_certificate_of_analysis_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= laboratory --> distribution (10 constraint(s)) =========
-- Requires: laboratory schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `water_utilities_ecm`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `water_utilities_ecm`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `water_utilities_ecm`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `water_utilities_ecm`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `water_utilities_ecm`.`distribution`.`storage_tank`(`storage_tank_id`);

-- ========= laboratory --> finance (8 constraint(s)) =========
-- Requires: laboratory schema, finance schema
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`analytical_test` ADD CONSTRAINT `fk_laboratory_analytical_test_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`qc_batch` ADD CONSTRAINT `fk_laboratory_qc_batch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`reagent_standard` ADD CONSTRAINT `fk_laboratory_reagent_standard_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_work_order` ADD CONSTRAINT `fk_laboratory_lab_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`analyst_grant_allocation` ADD CONSTRAINT `fk_laboratory_analyst_grant_allocation_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);

-- ========= laboratory --> metering (5 constraint(s)) =========
-- Requires: laboratory schema, metering schema
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_metering_dma_zone_id` FOREIGN KEY (`metering_dma_zone_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_dma_zone`(`metering_dma_zone_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_metering_dma_zone_id` FOREIGN KEY (`metering_dma_zone_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_dma_zone`(`metering_dma_zone_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);

-- ========= laboratory --> project (6 constraint(s)) =========
-- Requires: laboratory schema, project schema
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`chain_of_custody` ADD CONSTRAINT `fk_laboratory_chain_of_custody_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`analytical_test` ADD CONSTRAINT `fk_laboratory_analytical_test_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_work_order` ADD CONSTRAINT `fk_laboratory_lab_work_order_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= laboratory --> quality (2 constraint(s)) =========
-- Requires: laboratory schema, quality schema
ALTER TABLE `water_utilities_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `water_utilities_ecm`.`quality`.`analytical_result`(`analytical_result_id`);

-- ========= laboratory --> service (5 constraint(s)) =========
-- Requires: laboratory schema, service schema
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`test_result` ADD CONSTRAINT `fk_laboratory_test_result_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_plan` ADD CONSTRAINT `fk_laboratory_sampling_plan_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);

-- ========= laboratory --> supply (10 constraint(s)) =========
-- Requires: laboratory schema, supply schema
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`test_method` ADD CONSTRAINT `fk_laboratory_test_method_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_instrument` ADD CONSTRAINT `fk_laboratory_lab_instrument_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `water_utilities_ecm`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_instrument` ADD CONSTRAINT `fk_laboratory_lab_instrument_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`reagent_standard` ADD CONSTRAINT `fk_laboratory_reagent_standard_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_work_order` ADD CONSTRAINT `fk_laboratory_lab_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`method_material_usage` ADD CONSTRAINT `fk_laboratory_method_material_usage_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= laboratory --> treatment (4 constraint(s)) =========
-- Requires: laboratory schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_plan` ADD CONSTRAINT `fk_laboratory_sampling_plan_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_scada_tag_id` FOREIGN KEY (`scada_tag_id`) REFERENCES `water_utilities_ecm`.`treatment`.`scada_tag`(`scada_tag_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_work_order` ADD CONSTRAINT `fk_laboratory_lab_work_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= laboratory --> workforce (24 constraint(s)) =========
-- Requires: laboratory schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`lab_sample` ADD CONSTRAINT `fk_laboratory_lab_sample_sampler_employee_id` FOREIGN KEY (`sampler_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_collector_employee_id` FOREIGN KEY (`collector_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sample_collection_event` ADD CONSTRAINT `fk_laboratory_sample_collection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`chain_of_custody` ADD CONSTRAINT `fk_laboratory_chain_of_custody_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`test_method` ADD CONSTRAINT `fk_laboratory_test_method_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_plan` ADD CONSTRAINT `fk_laboratory_sampling_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`sampling_location` ADD CONSTRAINT `fk_laboratory_sampling_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`qc_batch` ADD CONSTRAINT `fk_laboratory_qc_batch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`qc_batch` ADD CONSTRAINT `fk_laboratory_qc_batch_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`certified_analyst` ADD CONSTRAINT `fk_laboratory_certified_analyst_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`certified_analyst` ADD CONSTRAINT `fk_laboratory_certified_analyst_primary_certified_employee_id` FOREIGN KEY (`primary_certified_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`proficiency_test` ADD CONSTRAINT `fk_laboratory_proficiency_test_reviewed_by_employee_id` FOREIGN KEY (`reviewed_by_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_primary_result_employee_id` FOREIGN KEY (`primary_result_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_reviewer_id` FOREIGN KEY (`reviewer_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`reagent_standard` ADD CONSTRAINT `fk_laboratory_reagent_standard_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`analyte` ADD CONSTRAINT `fk_laboratory_analyte_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`method_detection_limit` ADD CONSTRAINT `fk_laboratory_method_detection_limit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`method_detection_limit` ADD CONSTRAINT `fk_laboratory_method_detection_limit_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`analyst_method_qualification` ADD CONSTRAINT `fk_laboratory_analyst_method_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`laboratory`.`analyst_training_completion` ADD CONSTRAINT `fk_laboratory_analyst_training_completion_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `water_utilities_ecm`.`workforce`.`training_course`(`training_course_id`);

-- ========= metering --> asset (12 constraint(s)) =========
-- Requires: metering schema, asset schema
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_program` ADD CONSTRAINT `fk_metering_replacement_program_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_complaint` ADD CONSTRAINT `fk_metering_metering_complaint_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= metering --> billing (5 constraint(s)) =========
-- Requires: metering schema, billing schema
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `water_utilities_ecm`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`tamper_event` ADD CONSTRAINT `fk_metering_tamper_event_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `water_utilities_ecm`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `water_utilities_ecm`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_cycle`(`billing_cycle_id`);

-- ========= metering --> compliance (5 constraint(s)) =========
-- Requires: metering schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_regulatory_correspondence_id` FOREIGN KEY (`regulatory_correspondence_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_correspondence`(`regulatory_correspondence_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);

-- ========= metering --> customer (13 constraint(s)) =========
-- Requires: metering schema, customer schema
ALTER TABLE `water_utilities_ecm`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);

-- ========= metering --> distribution (7 constraint(s)) =========
-- Requires: metering schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_main_break_id` FOREIGN KEY (`main_break_id`) REFERENCES `water_utilities_ecm`.`distribution`.`main_break`(`main_break_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);

-- ========= metering --> finance (6 constraint(s)) =========
-- Requires: metering schema, finance schema
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`interval_consumption` ADD CONSTRAINT `fk_metering_interval_consumption_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= metering --> project (4 constraint(s)) =========
-- Requires: metering schema, project schema
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= metering --> service (4 constraint(s)) =========
-- Requires: metering schema, service schema
ALTER TABLE `water_utilities_ecm`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_order_id` FOREIGN KEY (`order_id`) REFERENCES `water_utilities_ecm`.`service`.`order`(`order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_dma_zone` ADD CONSTRAINT `fk_metering_metering_dma_zone_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_nrw_water_balance` ADD CONSTRAINT `fk_metering_metering_nrw_water_balance_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);

-- ========= metering --> supply (8 constraint(s)) =========
-- Requires: metering schema, supply schema
ALTER TABLE `water_utilities_ecm`.`metering`.`metering_meter` ADD CONSTRAINT `fk_metering_metering_meter_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_endpoint` ADD CONSTRAINT `fk_metering_ami_endpoint_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_material_requisition_id` FOREIGN KEY (`material_requisition_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_requisition`(`material_requisition_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`replacement_order` ADD CONSTRAINT `fk_metering_replacement_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `water_utilities_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_material_requisition_id` FOREIGN KEY (`material_requisition_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_requisition`(`material_requisition_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`ami_network_collector` ADD CONSTRAINT `fk_metering_ami_network_collector_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`endpoint_procurement` ADD CONSTRAINT `fk_metering_endpoint_procurement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_procurement` ADD CONSTRAINT `fk_metering_meter_procurement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= metering --> workforce (9 constraint(s)) =========
-- Requires: metering schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`metering`.`installation` ADD CONSTRAINT `fk_metering_installation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`consumption_profile` ADD CONSTRAINT `fk_metering_consumption_profile_validated_by_user_employee_id` FOREIGN KEY (`validated_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`leak_detection_event` ADD CONSTRAINT `fk_metering_leak_detection_event_primary_leak_employee_id` FOREIGN KEY (`primary_leak_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`high_usage_alert` ADD CONSTRAINT `fk_metering_high_usage_alert_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`read_exception` ADD CONSTRAINT `fk_metering_read_exception_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`metering`.`meter_field_inspection` ADD CONSTRAINT `fk_metering_meter_field_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= project --> asset (7 constraint(s)) =========
-- Requires: project schema, asset schema
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_class`(`asset_class_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= project --> compliance (7 constraint(s)) =========
-- Requires: project schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= project --> distribution (16 constraint(s)) =========
-- Requires: project schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `water_utilities_ecm`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `water_utilities_ecm`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`land_acquisition` ADD CONSTRAINT `fk_project_land_acquisition_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_hydrant_id` FOREIGN KEY (`hydrant_id`) REFERENCES `water_utilities_ecm`.`distribution`.`hydrant`(`hydrant_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`punch_list` ADD CONSTRAINT `fk_project_punch_list_pipe_main_id` FOREIGN KEY (`pipe_main_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pipe_main`(`pipe_main_id`);

-- ========= project --> finance (25 constraint(s)) =========
-- Requires: project schema, finance schema
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
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`funding_allocation` ADD CONSTRAINT `fk_project_funding_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`land_acquisition` ADD CONSTRAINT `fk_project_land_acquisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`land_acquisition` ADD CONSTRAINT `fk_project_land_acquisition_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`closeout_record` ADD CONSTRAINT `fk_project_closeout_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`closeout_record` ADD CONSTRAINT `fk_project_closeout_record_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);

-- ========= project --> laboratory (7 constraint(s)) =========
-- Requires: project schema, laboratory schema
ALTER TABLE `water_utilities_ecm`.`project`.`design_submittal` ADD CONSTRAINT `fk_project_design_submittal_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_location`(`sampling_location_id`);

-- ========= project --> metering (4 constraint(s)) =========
-- Requires: project schema, metering schema
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `water_utilities_ecm`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `water_utilities_ecm`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);

-- ========= project --> quality (4 constraint(s)) =========
-- Requires: project schema, quality schema
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);

-- ========= project --> service (9 constraint(s)) =========
-- Requires: project schema, service schema
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_offering_id` FOREIGN KEY (`offering_id`) REFERENCES `water_utilities_ecm`.`service`.`offering`(`offering_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`commissioning_activity` ADD CONSTRAINT `fk_project_commissioning_activity_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`funding_allocation` ADD CONSTRAINT `fk_project_funding_allocation_tariff_id` FOREIGN KEY (`tariff_id`) REFERENCES `water_utilities_ecm`.`service`.`tariff`(`tariff_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`land_acquisition` ADD CONSTRAINT `fk_project_land_acquisition_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);

-- ========= project --> supply (19 constraint(s)) =========
-- Requires: project schema, supply schema
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_primary_design_vendor_id` FOREIGN KEY (`primary_design_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_contractor_vendor_id` FOREIGN KEY (`contractor_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_contractor_vendor_id` FOREIGN KEY (`contractor_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_contractor_vendor_id` FOREIGN KEY (`contractor_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_contractor_vendor_id` FOREIGN KEY (`contractor_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_contractor_vendor_id` FOREIGN KEY (`contractor_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_contractor_vendor_id` FOREIGN KEY (`contractor_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_contractor_vendor_id` FOREIGN KEY (`contractor_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`asset_handover` ADD CONSTRAINT `fk_project_asset_handover_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_contractor_vendor_id` FOREIGN KEY (`contractor_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= project --> workforce (23 constraint(s)) =========
-- Requires: project schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ADD CONSTRAINT `fk_project_cip_project_project_manager_employee_id` FOREIGN KEY (`project_manager_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_contract_administrator_employee_id` FOREIGN KEY (`contract_administrator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_design_administrator_employee_id` FOREIGN KEY (`design_administrator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_primary_design_employee_id` FOREIGN KEY (`primary_design_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_project_manager_employee_id` FOREIGN KEY (`project_manager_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_design_engineer_employee_id` FOREIGN KEY (`design_engineer_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_engineer_employee_id` FOREIGN KEY (`engineer_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_approver_employee_id` FOREIGN KEY (`approver_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_primary_cost_employee_id` FOREIGN KEY (`primary_cost_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_submittal` ADD CONSTRAINT `fk_project_design_submittal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_submittal` ADD CONSTRAINT `fk_project_construction_submittal_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`nonconformance_report` ADD CONSTRAINT `fk_project_nonconformance_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`land_acquisition` ADD CONSTRAINT `fk_project_land_acquisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`risk` ADD CONSTRAINT `fk_project_risk_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`issue` ADD CONSTRAINT `fk_project_issue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> asset (5 constraint(s)) =========
-- Requires: quality schema, asset schema
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_sampling_point` ADD CONSTRAINT `fk_quality_quality_sampling_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= quality --> compliance (14 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_sampling_point` ADD CONSTRAINT `fk_quality_quality_sampling_point_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_dmr_result_id` FOREIGN KEY (`dmr_result_id`) REFERENCES `water_utilities_ecm`.`compliance`.`dmr_result`(`dmr_result_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ADD CONSTRAINT `fk_quality_contaminant_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_dmr_id` FOREIGN KEY (`dmr_id`) REFERENCES `water_utilities_ecm`.`compliance`.`dmr`(`dmr_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `water_utilities_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`monitoring_waiver` ADD CONSTRAINT `fk_quality_monitoring_waiver_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_industrial_user_id` FOREIGN KEY (`industrial_user_id`) REFERENCES `water_utilities_ecm`.`compliance`.`industrial_user`(`industrial_user_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_pretreatment_iup_id` FOREIGN KEY (`pretreatment_iup_id`) REFERENCES `water_utilities_ecm`.`compliance`.`pretreatment_iup`(`pretreatment_iup_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_round` ADD CONSTRAINT `fk_quality_sampling_round_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);

-- ========= quality --> customer (9 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_sampling_point` ADD CONSTRAINT `fk_quality_quality_sampling_point_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_sampling_site_id` FOREIGN KEY (`sampling_site_id`) REFERENCES `water_utilities_ecm`.`customer`.`sampling_site`(`sampling_site_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `water_utilities_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_service_address_id` FOREIGN KEY (`service_address_id`) REFERENCES `water_utilities_ecm`.`customer`.`service_address`(`service_address_id`);

-- ========= quality --> finance (15 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_sampling_point` ADD CONSTRAINT `fk_quality_quality_sampling_point_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ADD CONSTRAINT `fk_quality_ccr_period_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> laboratory (19 constraint(s)) =========
-- Requires: quality schema, laboratory schema
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_chain_of_custody_id` FOREIGN KEY (`chain_of_custody_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`chain_of_custody`(`chain_of_custody_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_lab_instrument_id` FOREIGN KEY (`lab_instrument_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_instrument`(`lab_instrument_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`test_result`(`test_result_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ADD CONSTRAINT `fk_quality_contaminant_analyte_id` FOREIGN KEY (`analyte_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`analyte`(`analyte_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_analytical_test_id` FOREIGN KEY (`analytical_test_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`analytical_test`(`analytical_test_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_chain_of_custody_id` FOREIGN KEY (`chain_of_custody_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`chain_of_custody`(`chain_of_custody_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_analytical_test_id` FOREIGN KEY (`analytical_test_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`analytical_test`(`analytical_test_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_qc_batch_id` FOREIGN KEY (`qc_batch_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`qc_batch`(`qc_batch_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_analytical_test_id` FOREIGN KEY (`analytical_test_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`analytical_test`(`analytical_test_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`qaqc_batch` ADD CONSTRAINT `fk_quality_qaqc_batch_qc_batch_id` FOREIGN KEY (`qc_batch_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`qc_batch`(`qc_batch_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_round` ADD CONSTRAINT `fk_quality_sampling_round_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_round` ADD CONSTRAINT `fk_quality_sampling_round_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_plan`(`sampling_plan_id`);

-- ========= quality --> metering (5 constraint(s)) =========
-- Requires: quality schema, metering schema
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `water_utilities_ecm`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_ami_endpoint_id` FOREIGN KEY (`ami_endpoint_id`) REFERENCES `water_utilities_ecm`.`metering`.`ami_endpoint`(`ami_endpoint_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);

-- ========= quality --> project (6 constraint(s)) =========
-- Requires: quality schema, project schema
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_sampling_point` ADD CONSTRAINT `fk_quality_quality_sampling_point_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= quality --> service (11 constraint(s)) =========
-- Requires: quality schema, service schema
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_sampling_point` ADD CONSTRAINT `fk_quality_quality_sampling_point_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_bulk_water_agreement_id` FOREIGN KEY (`bulk_water_agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`bulk_water_agreement`(`bulk_water_agreement_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_special_contract_id` FOREIGN KEY (`special_contract_id`) REFERENCES `water_utilities_ecm`.`service`.`special_contract`(`special_contract_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_special_contract_id` FOREIGN KEY (`special_contract_id`) REFERENCES `water_utilities_ecm`.`service`.`special_contract`(`special_contract_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`territory_contaminant_monitoring_requirement` ADD CONSTRAINT `fk_quality_territory_contaminant_monitoring_requirement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);

-- ========= quality --> supply (8 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`dbp_monitoring_event` ADD CONSTRAINT `fk_quality_dbp_monitoring_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= quality --> treatment (12 constraint(s)) =========
-- Requires: quality schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_sampling_point` ADD CONSTRAINT `fk_quality_quality_sampling_point_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_wtp_facility_id` FOREIGN KEY (`wtp_facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_wtp_facility_id` FOREIGN KEY (`wtp_facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_process_control_setpoint_id` FOREIGN KEY (`process_control_setpoint_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_control_setpoint`(`process_control_setpoint_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_source_location_source_water_intake_id` FOREIGN KEY (`source_location_source_water_intake_id`) REFERENCES `water_utilities_ecm`.`treatment`.`source_water_intake`(`source_water_intake_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_source_water_intake_id` FOREIGN KEY (`source_water_intake_id`) REFERENCES `water_utilities_ecm`.`treatment`.`source_water_intake`(`source_water_intake_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_round` ADD CONSTRAINT `fk_quality_sampling_round_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= quality --> wastewater (6 constraint(s)) =========
-- Requires: quality schema, wastewater schema
ALTER TABLE `water_utilities_ecm`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_outfall_id` FOREIGN KEY (`outfall_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`outfall`(`outfall_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_industrial_user_permit_id` FOREIGN KEY (`industrial_user_permit_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`industrial_user_permit`(`industrial_user_permit_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_establishment_fog_source_id` FOREIGN KEY (`establishment_fog_source_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`fog_source`(`fog_source_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_fog_source_id` FOREIGN KEY (`fog_source_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`fog_source`(`fog_source_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_grease_interceptor_id` FOREIGN KEY (`grease_interceptor_id`) REFERENCES `water_utilities_ecm`.`wastewater`.`grease_interceptor`(`grease_interceptor_id`);

-- ========= quality --> workforce (26 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_primary_water_employee_id` FOREIGN KEY (`primary_water_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ct_calculation` ADD CONSTRAINT `fk_quality_ct_calculation_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`residual_chlorine_reading` ADD CONSTRAINT `fk_quality_residual_chlorine_reading_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`bacteriological_result` ADD CONSTRAINT `fk_quality_bacteriological_result_primary_bacteriological_employee_id` FOREIGN KEY (`primary_bacteriological_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`source_water_quality` ADD CONSTRAINT `fk_quality_source_water_quality_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`effluent_quality` ADD CONSTRAINT `fk_quality_effluent_quality_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_primary_ccr_employee_id` FOREIGN KEY (`primary_ccr_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_detected_contaminant` ADD CONSTRAINT `fk_quality_ccr_detected_contaminant_tertiary_ccr_modified_by_user_employee_id` FOREIGN KEY (`tertiary_ccr_modified_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`monitoring_waiver` ADD CONSTRAINT `fk_quality_monitoring_waiver_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`iup_monitoring_result` ADD CONSTRAINT `fk_quality_iup_monitoring_result_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`fog_monitoring_event` ADD CONSTRAINT `fk_quality_fog_monitoring_event_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= service --> asset (6 constraint(s)) =========
-- Requires: service schema, asset schema
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_asset_meter_id` FOREIGN KEY (`asset_meter_id`) REFERENCES `water_utilities_ecm`.`asset`.`asset_meter`(`asset_meter_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= service --> billing (8 constraint(s)) =========
-- Requires: service schema, billing schema
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `water_utilities_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `water_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`sla_definition` ADD CONSTRAINT `fk_service_sla_definition_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`special_contract` ADD CONSTRAINT `fk_service_special_contract_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`service_program_enrollment` ADD CONSTRAINT `fk_service_service_program_enrollment_account_billing_account_id` FOREIGN KEY (`account_billing_account_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`service_program_enrollment` ADD CONSTRAINT `fk_service_service_program_enrollment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= service --> compliance (7 constraint(s)) =========
-- Requires: service schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`special_contract` ADD CONSTRAINT `fk_service_special_contract_pretreatment_iup_id` FOREIGN KEY (`pretreatment_iup_id`) REFERENCES `water_utilities_ecm`.`compliance`.`pretreatment_iup`(`pretreatment_iup_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);

-- ========= service --> customer (8 constraint(s)) =========
-- Requires: service schema, customer schema
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`special_contract` ADD CONSTRAINT `fk_service_special_contract_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= service --> distribution (10 constraint(s)) =========
-- Requires: service schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);

-- ========= service --> finance (13 constraint(s)) =========
-- Requires: service schema, finance schema
ALTER TABLE `water_utilities_ecm`.`service`.`service_rate_schedule` ADD CONSTRAINT `fk_service_service_rate_schedule_finance_rate_case_id` FOREIGN KEY (`finance_rate_case_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`tariff` ADD CONSTRAINT `fk_service_tariff_finance_rate_case_id` FOREIGN KEY (`finance_rate_case_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`special_contract` ADD CONSTRAINT `fk_service_special_contract_finance_rate_case_id` FOREIGN KEY (`finance_rate_case_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`special_contract` ADD CONSTRAINT `fk_service_special_contract_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`affordability_plan` ADD CONSTRAINT `fk_service_affordability_plan_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_finance_rate_case_id` FOREIGN KEY (`finance_rate_case_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_rate_case`(`finance_rate_case_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);

-- ========= service --> metering (6 constraint(s)) =========
-- Requires: service schema, metering schema
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_meter_size_type_id` FOREIGN KEY (`meter_size_type_id`) REFERENCES `water_utilities_ecm`.`metering`.`meter_size_type`(`meter_size_type_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_order_new_meter_metering_meter_id` FOREIGN KEY (`order_new_meter_metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);

-- ========= service --> project (4 constraint(s)) =========
-- Requires: service schema, project schema
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`special_contract` ADD CONSTRAINT `fk_service_special_contract_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= service --> supply (4 constraint(s)) =========
-- Requires: service schema, supply schema
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_material_requisition_id` FOREIGN KEY (`material_requisition_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_requisition`(`material_requisition_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `water_utilities_ecm`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`program_material_eligibility` ADD CONSTRAINT `fk_service_program_material_eligibility_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);

-- ========= service --> treatment (5 constraint(s)) =========
-- Requires: service schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`service`.`offering` ADD CONSTRAINT `fk_service_offering_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`agreement` ADD CONSTRAINT `fk_service_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`point` ADD CONSTRAINT `fk_service_point_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`bulk_water_agreement` ADD CONSTRAINT `fk_service_bulk_water_agreement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= service --> workforce (9 constraint(s)) =========
-- Requires: service schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`service`.`connection_application` ADD CONSTRAINT `fk_service_connection_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_order_created_by_user_employee_id` FOREIGN KEY (`order_created_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_order_employee_id` FOREIGN KEY (`order_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`order` ADD CONSTRAINT `fk_service_order_order_modified_by_user_employee_id` FOREIGN KEY (`order_modified_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`service`.`conservation_program` ADD CONSTRAINT `fk_service_conservation_program_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> asset (3 constraint(s)) =========
-- Requires: supply schema, asset schema
ALTER TABLE `water_utilities_ecm`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= supply --> finance (25 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `water_utilities_ecm`.`finance`.`fund`(`fund_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);

-- ========= supply --> project (5 constraint(s)) =========
-- Requires: supply schema, project schema
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`material_requisition` ADD CONSTRAINT `fk_supply_material_requisition_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`project_vendor_engagement` ADD CONSTRAINT `fk_supply_project_vendor_engagement_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= supply --> treatment (5 constraint(s)) =========
-- Requires: supply schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_wtp_facility_id` FOREIGN KEY (`wtp_facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_wtp_facility_id` FOREIGN KEY (`wtp_facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

-- ========= supply --> workforce (7 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_primary_purchase_requisitioner_employee_id` FOREIGN KEY (`primary_purchase_requisitioner_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_receiving_personnel_employee_id` FOREIGN KEY (`receiving_personnel_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`approved_vendor_list` ADD CONSTRAINT `fk_supply_approved_vendor_list_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`supply`.`procurement_category` ADD CONSTRAINT `fk_supply_procurement_category_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= treatment --> asset (16 constraint(s)) =========
-- Requires: treatment schema, asset schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `water_utilities_ecm`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`membrane_performance` ADD CONSTRAINT `fk_treatment_membrane_performance_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`membrane_performance` ADD CONSTRAINT `fk_treatment_membrane_performance_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`membrane_performance` ADD CONSTRAINT `fk_treatment_membrane_performance_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`uv_disinfection_event` ADD CONSTRAINT `fk_treatment_uv_disinfection_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `water_utilities_ecm`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`scada_tag` ADD CONSTRAINT `fk_treatment_scada_tag_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_maintenance_plan` ADD CONSTRAINT `fk_treatment_process_maintenance_plan_job_plan_id` FOREIGN KEY (`job_plan_id`) REFERENCES `water_utilities_ecm`.`asset`.`job_plan`(`job_plan_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`filter_unit` ADD CONSTRAINT `fk_treatment_filter_unit_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);

-- ========= treatment --> compliance (6 constraint(s)) =========
-- Requires: treatment schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`mor_submission` ADD CONSTRAINT `fk_treatment_mor_submission_mor_id` FOREIGN KEY (`mor_id`) REFERENCES `water_utilities_ecm`.`compliance`.`mor`(`mor_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`mor_submission` ADD CONSTRAINT `fk_treatment_mor_submission_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_compliance_monitoring` ADD CONSTRAINT `fk_treatment_process_compliance_monitoring_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `water_utilities_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`permit_compliance_obligation` ADD CONSTRAINT `fk_treatment_permit_compliance_obligation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= treatment --> distribution (11 constraint(s)) =========
-- Requires: treatment schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pump_station`(`pump_station_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_storage_tank_id` FOREIGN KEY (`storage_tank_id`) REFERENCES `water_utilities_ecm`.`distribution`.`storage_tank`(`storage_tank_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`membrane_performance` ADD CONSTRAINT `fk_treatment_membrane_performance_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`uv_disinfection_event` ADD CONSTRAINT `fk_treatment_uv_disinfection_event_pressure_zone_id` FOREIGN KEY (`pressure_zone_id`) REFERENCES `water_utilities_ecm`.`distribution`.`pressure_zone`(`pressure_zone_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`sludge_production` ADD CONSTRAINT `fk_treatment_sludge_production_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);

-- ========= treatment --> finance (9 constraint(s)) =========
-- Requires: treatment schema, finance schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`facility` ADD CONSTRAINT `fk_treatment_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `water_utilities_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`membrane_performance` ADD CONSTRAINT `fk_treatment_membrane_performance_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`sludge_production` ADD CONSTRAINT `fk_treatment_sludge_production_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`mor_submission` ADD CONSTRAINT `fk_treatment_mor_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= treatment --> laboratory (3 constraint(s)) =========
-- Requires: treatment schema, laboratory schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`sludge_production` ADD CONSTRAINT `fk_treatment_sludge_production_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);

-- ========= treatment --> metering (3 constraint(s)) =========
-- Requires: treatment schema, metering schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_installation_id` FOREIGN KEY (`installation_id`) REFERENCES `water_utilities_ecm`.`metering`.`installation`(`installation_id`);

-- ========= treatment --> project (15 constraint(s)) =========
-- Requires: treatment schema, project schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_commissioning_activity_id` FOREIGN KEY (`commissioning_activity_id`) REFERENCES `water_utilities_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_commissioning_activity_id` FOREIGN KEY (`commissioning_activity_id`) REFERENCES `water_utilities_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_commissioning_activity_id` FOREIGN KEY (`commissioning_activity_id`) REFERENCES `water_utilities_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_commissioning_activity_id` FOREIGN KEY (`commissioning_activity_id`) REFERENCES `water_utilities_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`membrane_performance` ADD CONSTRAINT `fk_treatment_membrane_performance_commissioning_activity_id` FOREIGN KEY (`commissioning_activity_id`) REFERENCES `water_utilities_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`uv_disinfection_event` ADD CONSTRAINT `fk_treatment_uv_disinfection_event_commissioning_activity_id` FOREIGN KEY (`commissioning_activity_id`) REFERENCES `water_utilities_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`sludge_production` ADD CONSTRAINT `fk_treatment_sludge_production_commissioning_activity_id` FOREIGN KEY (`commissioning_activity_id`) REFERENCES `water_utilities_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_commissioning_activity_id` FOREIGN KEY (`commissioning_activity_id`) REFERENCES `water_utilities_ecm`.`project`.`commissioning_activity`(`commissioning_activity_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `water_utilities_ecm`.`project`.`change_order`(`change_order_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`mor_submission` ADD CONSTRAINT `fk_treatment_mor_submission_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`facility_project` ADD CONSTRAINT `fk_treatment_facility_project_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= treatment --> quality (6 constraint(s)) =========
-- Requires: treatment schema, quality schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_online_instrument_id` FOREIGN KEY (`online_instrument_id`) REFERENCES `water_utilities_ecm`.`quality`.`online_instrument`(`online_instrument_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_exceedance_id` FOREIGN KEY (`exceedance_id`) REFERENCES `water_utilities_ecm`.`quality`.`exceedance`(`exceedance_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_ct_calculation_id` FOREIGN KEY (`ct_calculation_id`) REFERENCES `water_utilities_ecm`.`quality`.`ct_calculation`(`ct_calculation_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`scada_tag` ADD CONSTRAINT `fk_treatment_scada_tag_online_instrument_id` FOREIGN KEY (`online_instrument_id`) REFERENCES `water_utilities_ecm`.`quality`.`online_instrument`(`online_instrument_id`);

-- ========= treatment --> service (5 constraint(s)) =========
-- Requires: treatment schema, service schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`scada_tag` ADD CONSTRAINT `fk_treatment_scada_tag_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`facility_service_allocation` ADD CONSTRAINT `fk_treatment_facility_service_allocation_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`facility_service_allocation` ADD CONSTRAINT `fk_treatment_facility_service_allocation_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`facility_service_allocation` ADD CONSTRAINT `fk_treatment_facility_service_allocation_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);

-- ========= treatment --> supply (13 constraint(s)) =========
-- Requires: treatment schema, supply schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_chemical_supplier_vendor_id` FOREIGN KEY (`chemical_supplier_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`membrane_performance` ADD CONSTRAINT `fk_treatment_membrane_performance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`uv_disinfection_event` ADD CONSTRAINT `fk_treatment_uv_disinfection_event_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`sludge_production` ADD CONSTRAINT `fk_treatment_sludge_production_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical` ADD CONSTRAINT `fk_treatment_chemical_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_supply_agreement` ADD CONSTRAINT `fk_treatment_chemical_supply_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`filter_unit` ADD CONSTRAINT `fk_treatment_filter_unit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= treatment --> workforce (32 constraint(s)) =========
-- Requires: treatment schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_shift_assignment_id` FOREIGN KEY (`shift_assignment_id`) REFERENCES `water_utilities_ecm`.`workforce`.`shift_assignment`(`shift_assignment_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_primary_finished_employee_id` FOREIGN KEY (`primary_finished_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`uv_disinfection_event` ADD CONSTRAINT `fk_treatment_uv_disinfection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`uv_disinfection_event` ADD CONSTRAINT `fk_treatment_uv_disinfection_event_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`sludge_production` ADD CONSTRAINT `fk_treatment_sludge_production_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`sludge_production` ADD CONSTRAINT `fk_treatment_sludge_production_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`mor_submission` ADD CONSTRAINT `fk_treatment_mor_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`mor_submission` ADD CONSTRAINT `fk_treatment_mor_submission_operator_employee_id` FOREIGN KEY (`operator_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`mor_submission` ADD CONSTRAINT `fk_treatment_mor_submission_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`facility_project` ADD CONSTRAINT `fk_treatment_facility_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`operator_qualification` ADD CONSTRAINT `fk_treatment_operator_qualification_certifying_supervisor_employee_id` FOREIGN KEY (`certifying_supervisor_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`operator_qualification` ADD CONSTRAINT `fk_treatment_operator_qualification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`process_compliance_monitoring` ADD CONSTRAINT `fk_treatment_process_compliance_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`treatment`.`permit_compliance_obligation` ADD CONSTRAINT `fk_treatment_permit_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= wastewater --> asset (18 constraint(s)) =========
-- Requires: wastewater schema, asset schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_primary_ii_registry_id` FOREIGN KEY (`primary_ii_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ADD CONSTRAINT `fk_wastewater_ii_flow_measurement_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_repair` ADD CONSTRAINT `fk_wastewater_sewer_repair_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`grease_interceptor` ADD CONSTRAINT `fk_wastewater_grease_interceptor_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);

-- ========= wastewater --> billing (2 constraint(s)) =========
-- Requires: wastewater schema, billing schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `water_utilities_ecm`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `water_utilities_ecm`.`billing`.`billing_account`(`billing_account_id`);

-- ========= wastewater --> compliance (15 constraint(s)) =========
-- Requires: wastewater schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_industrial_user_id` FOREIGN KEY (`industrial_user_id`) REFERENCES `water_utilities_ecm`.`compliance`.`industrial_user`(`industrial_user_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_compliance_violation_id` FOREIGN KEY (`compliance_violation_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_violation`(`compliance_violation_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `water_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_land_application` ADD CONSTRAINT `fk_wastewater_biosolids_land_application_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_land_application` ADD CONSTRAINT `fk_wastewater_biosolids_land_application_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`dmr_submission` ADD CONSTRAINT `fk_wastewater_dmr_submission_compliance_permit_id` FOREIGN KEY (`compliance_permit_id`) REFERENCES `water_utilities_ecm`.`compliance`.`compliance_permit`(`compliance_permit_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`dmr_submission` ADD CONSTRAINT `fk_wastewater_dmr_submission_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `water_utilities_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);

-- ========= wastewater --> customer (7 constraint(s)) =========
-- Requires: wastewater schema, customer schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `water_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `water_utilities_ecm`.`customer`.`segment`(`segment_id`);

-- ========= wastewater --> distribution (4 constraint(s)) =========
-- Requires: wastewater schema, distribution schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ADD CONSTRAINT `fk_wastewater_ii_flow_measurement_dma_id` FOREIGN KEY (`dma_id`) REFERENCES `water_utilities_ecm`.`distribution`.`dma`(`dma_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `water_utilities_ecm`.`distribution`.`service_line`(`service_line_id`);

-- ========= wastewater --> finance (18 constraint(s)) =========
-- Requires: wastewater schema, finance schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `water_utilities_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_discharge_event` ADD CONSTRAINT `fk_wastewater_effluent_discharge_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_ar_transaction_id` FOREIGN KEY (`ar_transaction_id`) REFERENCES `water_utilities_ecm`.`finance`.`ar_transaction`(`ar_transaction_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_land_application` ADD CONSTRAINT `fk_wastewater_biosolids_land_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`dmr_submission` ADD CONSTRAINT `fk_wastewater_dmr_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`facility_grant_allocation` ADD CONSTRAINT `fk_wastewater_facility_grant_allocation_grant_id` FOREIGN KEY (`grant_id`) REFERENCES `water_utilities_ecm`.`finance`.`grant`(`grant_id`);

-- ========= wastewater --> laboratory (10 constraint(s)) =========
-- Requires: wastewater schema, laboratory schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_certified_analyst_id` FOREIGN KEY (`certified_analyst_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`certified_analyst`(`certified_analyst_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_lab_accreditation_id` FOREIGN KEY (`lab_accreditation_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_accreditation`(`lab_accreditation_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_sampling_location_id` FOREIGN KEY (`sampling_location_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_location`(`sampling_location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_sampling_plan_id` FOREIGN KEY (`sampling_plan_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`sampling_plan`(`sampling_plan_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_lab_accreditation_id` FOREIGN KEY (`lab_accreditation_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_accreditation`(`lab_accreditation_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `water_utilities_ecm`.`laboratory`.`lab_sample`(`lab_sample_id`);

-- ========= wastewater --> metering (2 constraint(s)) =========
-- Requires: wastewater schema, metering schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_metering_meter_id` FOREIGN KEY (`metering_meter_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_meter`(`metering_meter_id`);

-- ========= wastewater --> project (12 constraint(s)) =========
-- Requires: wastewater schema, project schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_monitoring_point` ADD CONSTRAINT `fk_wastewater_ii_monitoring_point_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= wastewater --> quality (6 constraint(s)) =========
-- Requires: wastewater schema, quality schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sso_event` ADD CONSTRAINT `fk_wastewater_sso_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`cso_event` ADD CONSTRAINT `fk_wastewater_cso_event_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_quality_sampling_point_id` FOREIGN KEY (`quality_sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`quality_sampling_point`(`quality_sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);

-- ========= wastewater --> service (4 constraint(s)) =========
-- Requires: wastewater schema, service schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `water_utilities_ecm`.`service`.`agreement`(`agreement_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_service_connection` ADD CONSTRAINT `fk_wastewater_sewer_service_connection_point_id` FOREIGN KEY (`point_id`) REFERENCES `water_utilities_ecm`.`service`.`point`(`point_id`);

-- ========= wastewater --> supply (8 constraint(s)) =========
-- Requires: wastewater schema, supply schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `water_utilities_ecm`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`wwtp` ADD CONSTRAINT `fk_wastewater_wwtp_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`industrial_user_permit` ADD CONSTRAINT `fk_wastewater_industrial_user_permit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_source` ADD CONSTRAINT `fk_wastewater_fog_source_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`facility_vendor_contract` ADD CONSTRAINT `fk_wastewater_facility_vendor_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= wastewater --> treatment (3 constraint(s)) =========
-- Requires: wastewater schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`lift_station` ADD CONSTRAINT `fk_wastewater_lift_station_scada_tag_id` FOREIGN KEY (`scada_tag_id`) REFERENCES `water_utilities_ecm`.`treatment`.`scada_tag`(`scada_tag_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_batch` ADD CONSTRAINT `fk_wastewater_biosolids_batch_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_unit`(`process_unit_id`);

-- ========= wastewater --> workforce (14 constraint(s)) =========
-- Requires: wastewater schema, workforce schema
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`effluent_parameter_result` ADD CONSTRAINT `fk_wastewater_effluent_parameter_result_primary_effluent_employee_id` FOREIGN KEY (`primary_effluent_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ADD CONSTRAINT `fk_wastewater_ii_flow_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`ii_flow_measurement` ADD CONSTRAINT `fk_wastewater_ii_flow_measurement_validated_by_user_employee_id` FOREIGN KEY (`validated_by_user_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`iup_compliance_sample` ADD CONSTRAINT `fk_wastewater_iup_compliance_sample_sampler_employee_id` FOREIGN KEY (`sampler_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`fog_inspection` ADD CONSTRAINT `fk_wastewater_fog_inspection_inspector_employee_id` FOREIGN KEY (`inspector_employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`biosolids_land_application` ADD CONSTRAINT `fk_wastewater_biosolids_land_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`sewer_inspection` ADD CONSTRAINT `fk_wastewater_sewer_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `water_utilities_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`collection_system_blockage` ADD CONSTRAINT `fk_wastewater_collection_system_blockage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `water_utilities_ecm`.`wastewater`.`dmr_submission` ADD CONSTRAINT `fk_wastewater_dmr_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `water_utilities_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> asset (12 constraint(s)) =========
-- Requires: workforce schema, asset schema
ALTER TABLE `water_utilities_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`labor_timesheet` ADD CONSTRAINT `fk_workforce_labor_timesheet_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `water_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `water_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`swap_request` ADD CONSTRAINT `fk_workforce_swap_request_location_id` FOREIGN KEY (`location_id`) REFERENCES `water_utilities_ecm`.`asset`.`location`(`location_id`);

-- ========= workforce --> compliance (1 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `water_utilities_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `water_utilities_ecm`.`compliance`.`crew_assignment`(`crew_assignment_id`);

-- ========= workforce --> customer (1 constraint(s)) =========
-- Requires: workforce schema, customer schema
ALTER TABLE `water_utilities_ecm`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `water_utilities_ecm`.`customer`.`customer_account`(`customer_account_id`);

-- ========= workforce --> finance (8 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `water_utilities_ecm`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`labor_timesheet` ADD CONSTRAINT `fk_workforce_labor_timesheet_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`labor_timesheet` ADD CONSTRAINT `fk_workforce_labor_timesheet_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `water_utilities_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `water_utilities_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> metering (1 constraint(s)) =========
-- Requires: workforce schema, metering schema
ALTER TABLE `water_utilities_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_metering_dma_zone_id` FOREIGN KEY (`metering_dma_zone_id`) REFERENCES `water_utilities_ecm`.`metering`.`metering_dma_zone`(`metering_dma_zone_id`);

-- ========= workforce --> project (1 constraint(s)) =========
-- Requires: workforce schema, project schema
ALTER TABLE `water_utilities_ecm`.`workforce`.`labor_timesheet` ADD CONSTRAINT `fk_workforce_labor_timesheet_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);

-- ========= workforce --> service (2 constraint(s)) =========
-- Requires: workforce schema, service schema
ALTER TABLE `water_utilities_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_service_area_territory_id` FOREIGN KEY (`service_area_territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `water_utilities_ecm`.`service`.`territory`(`territory_id`);

-- ========= workforce --> supply (5 constraint(s)) =========
-- Requires: workforce schema, supply schema
ALTER TABLE `water_utilities_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_approved_provider_vendor_id` FOREIGN KEY (`approved_provider_vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `water_utilities_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `water_utilities_ecm`.`supply`.`warehouse_location`(`warehouse_location_id`);

-- ========= workforce --> treatment (6 constraint(s)) =========
-- Requires: workforce schema, treatment schema
ALTER TABLE `water_utilities_ecm`.`workforce`.`operator_license` ADD CONSTRAINT `fk_workforce_operator_license_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `water_utilities_ecm`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `water_utilities_ecm`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `water_utilities_ecm`.`treatment`.`facility`(`facility_id`);

