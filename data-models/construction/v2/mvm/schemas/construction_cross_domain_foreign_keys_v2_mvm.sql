-- Cross-Domain Foreign Keys for Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-22 17:24:54
-- Total cross-domain FK constraints: 672
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: client, contract, design, equipment, finance, material, procurement, project, quality, safety, schedule, site, workforce

-- ========= client --> contract (1 constraint(s)) =========
-- Requires: client schema, contract schema
ALTER TABLE `vibe_construction_v1`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= client --> project (3 constraint(s)) =========
-- Requires: client schema, project schema
ALTER TABLE `vibe_construction_v1`.`client`.`jv_structure` ADD CONSTRAINT `fk_client_jv_structure_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`client`.`project_engagement` ADD CONSTRAINT `fk_client_project_engagement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= client --> schedule (1 constraint(s)) =========
-- Requires: client schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`client`.`interaction` ADD CONSTRAINT `fk_client_interaction_schedule_milestone_id` FOREIGN KEY (`schedule_milestone_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_milestone`(`schedule_milestone_id`);

-- ========= contract --> client (6 constraint(s)) =========
-- Requires: contract schema, client schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `vibe_construction_v1`.`client`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_jv_structure_id` FOREIGN KEY (`jv_structure_id`) REFERENCES `vibe_construction_v1`.`client`.`jv_structure`(`jv_structure_id`);

-- ========= contract --> design (9 constraint(s)) =========
-- Requires: contract schema, design schema
ALTER TABLE `vibe_construction_v1`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`scope` ADD CONSTRAINT `fk_contract_scope_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_rfi_id` FOREIGN KEY (`rfi_id`) REFERENCES `vibe_construction_v1`.`design`.`rfi`(`rfi_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= contract --> finance (7 constraint(s)) =========
-- Requires: contract schema, finance schema
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_progress_billing_id` FOREIGN KEY (`progress_billing_id`) REFERENCES `vibe_construction_v1`.`finance`.`progress_billing`(`progress_billing_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_payment_record_id` FOREIGN KEY (`payment_record_id`) REFERENCES `vibe_construction_v1`.`finance`.`payment_record`(`payment_record_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_progress_billing_id` FOREIGN KEY (`progress_billing_id`) REFERENCES `vibe_construction_v1`.`finance`.`progress_billing`(`progress_billing_id`);

-- ========= contract --> material (1 constraint(s)) =========
-- Requires: contract schema, material schema
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= contract --> procurement (6 constraint(s)) =========
-- Requires: contract schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`party` ADD CONSTRAINT `fk_contract_party_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);

-- ========= contract --> project (6 constraint(s)) =========
-- Requires: contract schema, project schema
ALTER TABLE `vibe_construction_v1`.`contract`.`agreement` ADD CONSTRAINT `fk_contract_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_milestone` ADD CONSTRAINT `fk_contract_contract_milestone_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`bond_guarantee` ADD CONSTRAINT `fk_contract_bond_guarantee_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= contract --> quality (1 constraint(s)) =========
-- Requires: contract schema, quality schema
ALTER TABLE `vibe_construction_v1`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= contract --> safety (2 constraint(s)) =========
-- Requires: contract schema, safety schema
ALTER TABLE `vibe_construction_v1`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract` ADD CONSTRAINT `fk_contract_subcontract_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);

-- ========= contract --> schedule (3 constraint(s)) =========
-- Requires: contract schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`contract`.`payment_certificate` ADD CONSTRAINT `fk_contract_payment_certificate_progress_update_id` FOREIGN KEY (`progress_update_id`) REFERENCES `vibe_construction_v1`.`schedule`.`progress_update`(`progress_update_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_delay_event_id` FOREIGN KEY (`delay_event_id`) REFERENCES `vibe_construction_v1`.`schedule`.`delay_event`(`delay_event_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_progress_update_id` FOREIGN KEY (`progress_update_id`) REFERENCES `vibe_construction_v1`.`schedule`.`progress_update`(`progress_update_id`);

-- ========= contract --> site (2 constraint(s)) =========
-- Requires: contract schema, site schema
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`eot_claim` ADD CONSTRAINT `fk_contract_eot_claim_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);

-- ========= contract --> workforce (2 constraint(s)) =========
-- Requires: contract schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`contract`.`contract_change_order` ADD CONSTRAINT `fk_contract_contract_change_order_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `vibe_construction_v1`.`contract`.`subcontract_payment` ADD CONSTRAINT `fk_contract_subcontract_payment_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);

-- ========= design --> client (5 constraint(s)) =========
-- Requires: design schema, client schema
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= design --> contract (1 constraint(s)) =========
-- Requires: design schema, contract schema
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= design --> equipment (1 constraint(s)) =========
-- Requires: design schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);

-- ========= design --> finance (4 constraint(s)) =========
-- Requires: design schema, finance schema
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= design --> material (4 constraint(s)) =========
-- Requires: design schema, material schema
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= design --> project (9 constraint(s)) =========
-- Requires: design schema, project schema
ALTER TABLE `vibe_construction_v1`.`design`.`transmittal` ADD CONSTRAINT `fk_design_transmittal_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`rfi` ADD CONSTRAINT `fk_design_rfi_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`document_register` ADD CONSTRAINT `fk_design_document_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`workflow_approval` ADD CONSTRAINT `fk_design_workflow_approval_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`bim_model` ADD CONSTRAINT `fk_design_bim_model_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing` ADD CONSTRAINT `fk_design_drawing_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`drawing_revision` ADD CONSTRAINT `fk_design_drawing_revision_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`technical_specification` ADD CONSTRAINT `fk_design_technical_specification_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`design`.`submittal` ADD CONSTRAINT `fk_design_submittal_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= equipment --> client (2 constraint(s)) =========
-- Requires: equipment schema, client schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_jv_structure_id` FOREIGN KEY (`jv_structure_id`) REFERENCES `vibe_construction_v1`.`client`.`jv_structure`(`jv_structure_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_jv_structure_id` FOREIGN KEY (`jv_structure_id`) REFERENCES `vibe_construction_v1`.`client`.`jv_structure`(`jv_structure_id`);

-- ========= equipment --> contract (3 constraint(s)) =========
-- Requires: equipment schema, contract schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= equipment --> design (4 constraint(s)) =========
-- Requires: equipment schema, design schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);

-- ========= equipment --> finance (14 constraint(s)) =========
-- Requires: equipment schema, finance schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset_category` ADD CONSTRAINT `fk_equipment_asset_category_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);

-- ========= equipment --> material (4 constraint(s)) =========
-- Requires: equipment schema, material schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);

-- ========= equipment --> procurement (3 constraint(s)) =========
-- Requires: equipment schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= equipment --> project (15 constraint(s)) =========
-- Requires: equipment schema, project schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_asset_current_location_site_construction_project_id` FOREIGN KEY (`asset_current_location_site_construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`rental_agreement` ADD CONSTRAINT `fk_equipment_rental_agreement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);

-- ========= equipment --> safety (10 constraint(s)) =========
-- Requires: equipment schema, safety schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `vibe_construction_v1`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);

-- ========= equipment --> schedule (1 constraint(s)) =========
-- Requires: equipment schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= equipment --> site (3 constraint(s)) =========
-- Requires: equipment schema, site schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);

-- ========= equipment --> workforce (9 constraint(s)) =========
-- Requires: equipment schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`hours` ADD CONSTRAINT `fk_equipment_hours_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`maintenance_order` ADD CONSTRAINT `fk_equipment_maintenance_order_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`inspection_record` ADD CONSTRAINT `fk_equipment_inspection_record_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`equipment`.`fuel_transaction` ADD CONSTRAINT `fk_equipment_fuel_transaction_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= finance --> client (7 constraint(s)) =========
-- Requires: finance schema, client schema
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `vibe_construction_v1`.`client`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `vibe_construction_v1`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= finance --> contract (3 constraint(s)) =========
-- Requires: finance schema, contract schema
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);

-- ========= finance --> procurement (8 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= finance --> project (16 constraint(s)) =========
-- Requires: finance schema, project schema
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_code` ADD CONSTRAINT `fk_finance_cost_code_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`earned_value_record` ADD CONSTRAINT `fk_finance_earned_value_record_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`invoice` ADD CONSTRAINT `fk_finance_invoice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`payment_record` ADD CONSTRAINT `fk_finance_payment_record_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);

-- ========= finance --> safety (2 constraint(s)) =========
-- Requires: finance schema, safety schema
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`progress_billing` ADD CONSTRAINT `fk_finance_progress_billing_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);

-- ========= finance --> schedule (3 constraint(s)) =========
-- Requires: finance schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`finance`.`project_budget` ADD CONSTRAINT `fk_finance_project_budget_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`job_cost_transaction` ADD CONSTRAINT `fk_finance_job_cost_transaction_delay_event_id` FOREIGN KEY (`delay_event_id`) REFERENCES `vibe_construction_v1`.`schedule`.`delay_event`(`delay_event_id`);
ALTER TABLE `vibe_construction_v1`.`finance`.`cash_flow_forecast` ADD CONSTRAINT `fk_finance_cash_flow_forecast_schedule_milestone_id` FOREIGN KEY (`schedule_milestone_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_milestone`(`schedule_milestone_id`);

-- ========= material --> client (4 constraint(s)) =========
-- Requires: material schema, client schema
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `vibe_construction_v1`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= material --> contract (3 constraint(s)) =========
-- Requires: material schema, contract schema
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);

-- ========= material --> design (3 constraint(s)) =========
-- Requires: material schema, design schema
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ADD CONSTRAINT `fk_material_boq_line_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);

-- ========= material --> equipment (2 constraint(s)) =========
-- Requires: material schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `vibe_construction_v1`.`equipment`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `vibe_construction_v1`.`equipment`.`maintenance_order`(`maintenance_order_id`);

-- ========= material --> finance (20 constraint(s)) =========
-- Requires: material schema, finance schema
ALTER TABLE `vibe_construction_v1`.`material`.`master` ADD CONSTRAINT `fk_material_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_level` ADD CONSTRAINT `fk_material_stock_level_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ADD CONSTRAINT `fk_material_boq_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ADD CONSTRAINT `fk_material_boq_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ADD CONSTRAINT `fk_material_boq_line_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_cash_flow_forecast_id` FOREIGN KEY (`cash_flow_forecast_id`) REFERENCES `vibe_construction_v1`.`finance`.`cash_flow_forecast`(`cash_flow_forecast_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);

-- ========= material --> procurement (5 constraint(s)) =========
-- Requires: material schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`material`.`master` ADD CONSTRAINT `fk_material_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= material --> project (7 constraint(s)) =========
-- Requires: material schema, project schema
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`batch_lot` ADD CONSTRAINT `fk_material_batch_lot_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`boq_line` ADD CONSTRAINT `fk_material_boq_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_line` ADD CONSTRAINT `fk_material_mto_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`mto_header` ADD CONSTRAINT `fk_material_mto_header_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_construction_v1`.`project`.`project_site`(`project_site_id`);

-- ========= material --> safety (2 constraint(s)) =========
-- Requires: material schema, safety schema
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);

-- ========= material --> site (2 constraint(s)) =========
-- Requires: material schema, site schema
ALTER TABLE `vibe_construction_v1`.`material`.`warehouse` ADD CONSTRAINT `fk_material_warehouse_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);

-- ========= material --> workforce (4 constraint(s)) =========
-- Requires: material schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`stock_movement` ADD CONSTRAINT `fk_material_stock_movement_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`material`.`goods_issue` ADD CONSTRAINT `fk_material_goods_issue_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);

-- ========= procurement --> client (1 constraint(s)) =========
-- Requires: procurement schema, client schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= procurement --> contract (5 constraint(s)) =========
-- Requires: procurement schema, contract schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_scope_id` FOREIGN KEY (`scope_id`) REFERENCES `vibe_construction_v1`.`contract`.`scope`(`scope_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);

-- ========= procurement --> design (11 constraint(s)) =========
-- Requires: procurement schema, design schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= procurement --> equipment (3 constraint(s)) =========
-- Requires: procurement schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_rental_agreement_id` FOREIGN KEY (`rental_agreement_id`) REFERENCES `vibe_construction_v1`.`equipment`.`rental_agreement`(`rental_agreement_id`);

-- ========= procurement --> finance (12 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `vibe_construction_v1`.`finance`.`invoice`(`invoice_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `vibe_construction_v1`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= procurement --> material (4 constraint(s)) =========
-- Requires: procurement schema, material schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ADD CONSTRAINT `fk_procurement_material_catalog_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_mto_header_id` FOREIGN KEY (`mto_header_id`) REFERENCES `vibe_construction_v1`.`material`.`mto_header`(`mto_header_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_construction_v1`.`material`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= procurement --> project (8 constraint(s)) =========
-- Requires: procurement schema, project schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_construction_v1`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_account_id` FOREIGN KEY (`cost_account_id`) REFERENCES `vibe_construction_v1`.`project`.`cost_account`(`cost_account_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= procurement --> quality (1 constraint(s)) =========
-- Requires: procurement schema, quality schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp_line`(`itp_line_id`);

-- ========= procurement --> workforce (3 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);

-- ========= project --> client (7 constraint(s)) =========
-- Requires: project schema, client schema
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_baseline` ADD CONSTRAINT `fk_project_project_baseline_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= project --> contract (4 constraint(s)) =========
-- Requires: project schema, contract schema
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_payment_certificate_id` FOREIGN KEY (`payment_certificate_id`) REFERENCES `vibe_construction_v1`.`contract`.`payment_certificate`(`payment_certificate_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= project --> design (14 constraint(s)) =========
-- Requires: project schema, design schema
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_workflow_approval_id` FOREIGN KEY (`workflow_approval_id`) REFERENCES `vibe_construction_v1`.`design`.`workflow_approval`(`workflow_approval_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `vibe_construction_v1`.`design`.`transmittal`(`transmittal_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_document_register_id` FOREIGN KEY (`document_register_id`) REFERENCES `vibe_construction_v1`.`design`.`document_register`(`document_register_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_transmittal_id` FOREIGN KEY (`transmittal_id`) REFERENCES `vibe_construction_v1`.`design`.`transmittal`(`transmittal_id`);

-- ========= project --> finance (7 constraint(s)) =========
-- Requires: project schema, finance schema
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ADD CONSTRAINT `fk_project_evm_period_record_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`cost_account` ADD CONSTRAINT `fk_project_cost_account_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ADD CONSTRAINT `fk_project_project_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= project --> material (4 constraint(s)) =========
-- Requires: project schema, material schema
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ADD CONSTRAINT `fk_project_project_site_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);

-- ========= project --> procurement (1 constraint(s)) =========
-- Requires: project schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`project`.`construction_project` ADD CONSTRAINT `fk_project_construction_project_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= project --> quality (3 constraint(s)) =========
-- Requires: project schema, quality schema
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `vibe_construction_v1`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `vibe_construction_v1`.`quality`.`plan`(`plan_id`);

-- ========= project --> safety (5 constraint(s)) =========
-- Requires: project schema, safety schema
ALTER TABLE `vibe_construction_v1`.`project`.`project_milestone` ADD CONSTRAINT `fk_project_project_milestone_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`phase` ADD CONSTRAINT `fk_project_phase_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ADD CONSTRAINT `fk_project_project_site_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);

-- ========= project --> schedule (8 constraint(s)) =========
-- Requires: project schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ADD CONSTRAINT `fk_project_evm_period_record_progress_update_id` FOREIGN KEY (`progress_update_id`) REFERENCES `vibe_construction_v1`.`schedule`.`progress_update`(`progress_update_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`evm_period_record` ADD CONSTRAINT `fk_project_evm_period_record_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`progress_measurement` ADD CONSTRAINT `fk_project_progress_measurement_schedule_baseline_id` FOREIGN KEY (`schedule_baseline_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_baseline`(`schedule_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_delay_event_id` FOREIGN KEY (`delay_event_id`) REFERENCES `vibe_construction_v1`.`schedule`.`delay_event`(`delay_event_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= project --> site (4 constraint(s)) =========
-- Requires: project schema, site schema
ALTER TABLE `vibe_construction_v1`.`project`.`project_change_order` ADD CONSTRAINT `fk_project_project_change_order_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`deliverable` ADD CONSTRAINT `fk_project_deliverable_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`risk_register` ADD CONSTRAINT `fk_project_risk_register_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`project`.`project_site` ADD CONSTRAINT `fk_project_project_site_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);

-- ========= quality --> client (9 constraint(s)) =========
-- Requires: quality schema, client schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= quality --> contract (6 constraint(s)) =========
-- Requires: quality schema, contract schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= quality --> design (16 constraint(s)) =========
-- Requires: quality schema, design schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_drawing_revision_id` FOREIGN KEY (`drawing_revision_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing_revision`(`drawing_revision_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= quality --> equipment (5 constraint(s)) =========
-- Requires: quality schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `vibe_construction_v1`.`equipment`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `vibe_construction_v1`.`equipment`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= quality --> finance (6 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_progress_billing_id` FOREIGN KEY (`progress_billing_id`) REFERENCES `vibe_construction_v1`.`finance`.`progress_billing`(`progress_billing_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_job_cost_transaction_id` FOREIGN KEY (`job_cost_transaction_id`) REFERENCES `vibe_construction_v1`.`finance`.`job_cost_transaction`(`job_cost_transaction_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= quality --> material (9 constraint(s)) =========
-- Requires: quality schema, material schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_construction_v1`.`material`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `vibe_construction_v1`.`material`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_construction_v1`.`material`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `vibe_construction_v1`.`material`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_construction_v1`.`material`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_mto_line_id` FOREIGN KEY (`mto_line_id`) REFERENCES `vibe_construction_v1`.`material`.`mto_line`(`mto_line_id`);

-- ========= quality --> procurement (6 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);

-- ========= quality --> project (10 constraint(s)) =========
-- Requires: quality schema, project schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp` ADD CONSTRAINT `fk_quality_itp_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= quality --> safety (11 constraint(s)) =========
-- Requires: quality schema, safety schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_hazard_register_id` FOREIGN KEY (`hazard_register_id`) REFERENCES `vibe_construction_v1`.`safety`.`hazard_register`(`hazard_register_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`checklist` ADD CONSTRAINT `fk_quality_checklist_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);

-- ========= quality --> schedule (1 constraint(s)) =========
-- Requires: quality schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

-- ========= quality --> site (12 constraint(s)) =========
-- Requires: quality schema, site schema
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_concrete_pour_id` FOREIGN KEY (`concrete_pour_id`) REFERENCES `vibe_construction_v1`.`site`.`concrete_pour`(`concrete_pour_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_daily_log_id` FOREIGN KEY (`daily_log_id`) REFERENCES `vibe_construction_v1`.`site`.`daily_log`(`daily_log_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_material_delivery_id` FOREIGN KEY (`material_delivery_id`) REFERENCES `vibe_construction_v1`.`site`.`material_delivery`(`material_delivery_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_concrete_pour_id` FOREIGN KEY (`concrete_pour_id`) REFERENCES `vibe_construction_v1`.`site`.`concrete_pour`(`concrete_pour_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_material_delivery_id` FOREIGN KEY (`material_delivery_id`) REFERENCES `vibe_construction_v1`.`site`.`material_delivery`(`material_delivery_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_concrete_pour_id` FOREIGN KEY (`concrete_pour_id`) REFERENCES `vibe_construction_v1`.`site`.`concrete_pour`(`concrete_pour_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`test_certificate` ADD CONSTRAINT `fk_quality_test_certificate_material_delivery_id` FOREIGN KEY (`material_delivery_id`) REFERENCES `vibe_construction_v1`.`site`.`material_delivery`(`material_delivery_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_list` ADD CONSTRAINT `fk_quality_punch_list_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`plan` ADD CONSTRAINT `fk_quality_plan_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);

-- ========= quality --> workforce (10 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`itp_line` ADD CONSTRAINT `fk_quality_itp_line_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew_assignment`(`crew_assignment_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`ncr` ADD CONSTRAINT `fk_quality_ncr_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew_assignment`(`crew_assignment_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`quality`.`punch_item` ADD CONSTRAINT `fk_quality_punch_item_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);

-- ========= safety --> client (7 constraint(s)) =========
-- Requires: safety schema, client schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);

-- ========= safety --> contract (5 constraint(s)) =========
-- Requires: safety schema, contract schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_insurance_register_id` FOREIGN KEY (`insurance_register_id`) REFERENCES `vibe_construction_v1`.`contract`.`insurance_register`(`insurance_register_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);

-- ========= safety --> design (9 constraint(s)) =========
-- Requires: safety schema, design schema
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);

-- ========= safety --> equipment (1 constraint(s)) =========
-- Requires: safety schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= safety --> finance (8 constraint(s)) =========
-- Requires: safety schema, finance schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `vibe_construction_v1`.`finance`.`project_budget`(`project_budget_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= safety --> material (3 constraint(s)) =========
-- Requires: safety schema, material schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= safety --> procurement (7 constraint(s)) =========
-- Requires: safety schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= safety --> project (9 constraint(s)) =========
-- Requires: safety schema, project schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hse_plan` ADD CONSTRAINT `fk_safety_hse_plan_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`risk_assessment` ADD CONSTRAINT `fk_safety_risk_assessment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= safety --> site (8 constraint(s)) =========
-- Requires: safety schema, site schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident_investigation` ADD CONSTRAINT `fk_safety_incident_investigation_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`swms` ADD CONSTRAINT `fk_safety_swms_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_site_id` FOREIGN KEY (`site_id`) REFERENCES `vibe_construction_v1`.`site`.`site`(`site_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`hazard_register` ADD CONSTRAINT `fk_safety_hazard_register_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);

-- ========= safety --> workforce (5 constraint(s)) =========
-- Requires: safety schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`permit_to_work` ADD CONSTRAINT `fk_safety_permit_to_work_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`safety`.`toolbox_meeting` ADD CONSTRAINT `fk_safety_toolbox_meeting_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);

-- ========= schedule --> client (3 constraint(s)) =========
-- Requires: schedule schema, client schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `vibe_construction_v1`.`client`.`contact`(`contact_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_project_engagement_id` FOREIGN KEY (`project_engagement_id`) REFERENCES `vibe_construction_v1`.`client`.`project_engagement`(`project_engagement_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);

-- ========= schedule --> contract (2 constraint(s)) =========
-- Requires: schedule schema, contract schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);

-- ========= schedule --> design (3 constraint(s)) =========
-- Requires: schedule schema, design schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);

-- ========= schedule --> equipment (4 constraint(s)) =========
-- Requires: schedule schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `vibe_construction_v1`.`equipment`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_asset_category_id` FOREIGN KEY (`asset_category_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset_category`(`asset_category_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `vibe_construction_v1`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);

-- ========= schedule --> finance (4 constraint(s)) =========
-- Requires: schedule schema, finance schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);

-- ========= schedule --> material (1 constraint(s)) =========
-- Requires: schedule schema, material schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);

-- ========= schedule --> procurement (6 constraint(s)) =========
-- Requires: schedule schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= schedule --> project (6 constraint(s)) =========
-- Requires: schedule schema, project schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_project_baseline_id` FOREIGN KEY (`project_baseline_id`) REFERENCES `vibe_construction_v1`.`project`.`project_baseline`(`project_baseline_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_relationship` ADD CONSTRAINT `fk_schedule_activity_relationship_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_baseline` ADD CONSTRAINT `fk_schedule_schedule_baseline_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`progress_update` ADD CONSTRAINT `fk_schedule_progress_update_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= schedule --> quality (4 constraint(s)) =========
-- Requires: schedule schema, quality schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_punch_list_id` FOREIGN KEY (`punch_list_id`) REFERENCES `vibe_construction_v1`.`quality`.`punch_list`(`punch_list_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);

-- ========= schedule --> safety (4 constraint(s)) =========
-- Requires: schedule schema, safety schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`schedule_milestone` ADD CONSTRAINT `fk_schedule_schedule_milestone_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `vibe_construction_v1`.`safety`.`incident`(`incident_id`);

-- ========= schedule --> site (2 constraint(s)) =========
-- Requires: schedule schema, site schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`delay_event` ADD CONSTRAINT `fk_schedule_delay_event_work_front_id` FOREIGN KEY (`work_front_id`) REFERENCES `vibe_construction_v1`.`site`.`work_front`(`work_front_id`);

-- ========= schedule --> workforce (5 constraint(s)) =========
-- Requires: schedule schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity` ADD CONSTRAINT `fk_schedule_activity_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`resource` ADD CONSTRAINT `fk_schedule_resource_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`schedule`.`activity_resource_assignment` ADD CONSTRAINT `fk_schedule_activity_resource_assignment_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);

-- ========= site --> client (3 constraint(s)) =========
-- Requires: site schema, client schema
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site` ADD CONSTRAINT `fk_site_site_account_id` FOREIGN KEY (`account_id`) REFERENCES `vibe_construction_v1`.`client`.`account`(`account_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site` ADD CONSTRAINT `fk_site_site_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `vibe_construction_v1`.`client`.`opportunity`(`opportunity_id`);

-- ========= site --> contract (6 constraint(s)) =========
-- Requires: site schema, contract schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_contract_milestone_id` FOREIGN KEY (`contract_milestone_id`) REFERENCES `vibe_construction_v1`.`contract`.`contract_milestone`(`contract_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_subcontract_id` FOREIGN KEY (`subcontract_id`) REFERENCES `vibe_construction_v1`.`contract`.`subcontract`(`subcontract_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= site --> design (12 constraint(s)) =========
-- Requires: site schema, design schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_bim_model_id` FOREIGN KEY (`bim_model_id`) REFERENCES `vibe_construction_v1`.`design`.`bim_model`(`bim_model_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_submittal_id` FOREIGN KEY (`submittal_id`) REFERENCES `vibe_construction_v1`.`design`.`submittal`(`submittal_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_technical_specification_id` FOREIGN KEY (`technical_specification_id`) REFERENCES `vibe_construction_v1`.`design`.`technical_specification`(`technical_specification_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_drawing_id` FOREIGN KEY (`drawing_id`) REFERENCES `vibe_construction_v1`.`design`.`drawing`(`drawing_id`);

-- ========= site --> equipment (6 constraint(s)) =========
-- Requires: site schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_fleet_assignment_id` FOREIGN KEY (`fleet_assignment_id`) REFERENCES `vibe_construction_v1`.`equipment`.`fleet_assignment`(`fleet_assignment_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_hours_id` FOREIGN KEY (`hours_id`) REFERENCES `vibe_construction_v1`.`equipment`.`hours`(`hours_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_maintenance_order_id` FOREIGN KEY (`maintenance_order_id`) REFERENCES `vibe_construction_v1`.`equipment`.`maintenance_order`(`maintenance_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `vibe_construction_v1`.`equipment`.`inspection_record`(`inspection_record_id`);

-- ========= site --> finance (12 constraint(s)) =========
-- Requires: site schema, finance schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_earned_value_record_id` FOREIGN KEY (`earned_value_record_id`) REFERENCES `vibe_construction_v1`.`finance`.`earned_value_record`(`earned_value_record_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_progress_billing_id` FOREIGN KEY (`progress_billing_id`) REFERENCES `vibe_construction_v1`.`finance`.`progress_billing`(`progress_billing_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site` ADD CONSTRAINT `fk_site_site_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);

-- ========= site --> material (5 constraint(s)) =========
-- Requires: site schema, material schema
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_construction_v1`.`material`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_batch_lot_id` FOREIGN KEY (`batch_lot_id`) REFERENCES `vibe_construction_v1`.`material`.`batch_lot`(`batch_lot_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_master_id` FOREIGN KEY (`master_id`) REFERENCES `vibe_construction_v1`.`material`.`master`(`master_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `vibe_construction_v1`.`material`.`warehouse`(`warehouse_id`);

-- ========= site --> procurement (11 constraint(s)) =========
-- Requires: site schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= site --> project (17 constraint(s)) =========
-- Requires: site schema, project schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`material_delivery` ADD CONSTRAINT `fk_site_material_delivery_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`site` ADD CONSTRAINT `fk_site_site_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= site --> quality (2 constraint(s)) =========
-- Requires: site schema, quality schema
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_itp_id` FOREIGN KEY (`itp_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp`(`itp_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp_line`(`itp_line_id`);

-- ========= site --> safety (9 constraint(s)) =========
-- Requires: site schema, safety schema
ALTER TABLE `vibe_construction_v1`.`site`.`work_front` ADD CONSTRAINT `fk_site_work_front_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`daily_log` ADD CONSTRAINT `fk_site_daily_log_toolbox_meeting_id` FOREIGN KEY (`toolbox_meeting_id`) REFERENCES `vibe_construction_v1`.`safety`.`toolbox_meeting`(`toolbox_meeting_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_toolbox_meeting_id` FOREIGN KEY (`toolbox_meeting_id`) REFERENCES `vibe_construction_v1`.`safety`.`toolbox_meeting`(`toolbox_meeting_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `vibe_construction_v1`.`safety`.`risk_assessment`(`risk_assessment_id`);

-- ========= site --> schedule (6 constraint(s)) =========
-- Requires: site schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_progress_update_id` FOREIGN KEY (`progress_update_id`) REFERENCES `vibe_construction_v1`.`schedule`.`progress_update`(`progress_update_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`field_progress` ADD CONSTRAINT `fk_site_field_progress_progress_update_id` FOREIGN KEY (`progress_update_id`) REFERENCES `vibe_construction_v1`.`schedule`.`progress_update`(`progress_update_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`permit` ADD CONSTRAINT `fk_site_permit_schedule_milestone_id` FOREIGN KEY (`schedule_milestone_id`) REFERENCES `vibe_construction_v1`.`schedule`.`schedule_milestone`(`schedule_milestone_id`);

-- ========= site --> workforce (5 constraint(s)) =========
-- Requires: site schema, workforce schema
ALTER TABLE `vibe_construction_v1`.`site`.`production_entry` ADD CONSTRAINT `fk_site_production_entry_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`crew_deployment` ADD CONSTRAINT `fk_site_crew_deployment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`concrete_pour` ADD CONSTRAINT `fk_site_concrete_pour_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`site`.`equipment_deployment` ADD CONSTRAINT `fk_site_equipment_deployment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);

-- ========= workforce --> contract (2 constraint(s)) =========
-- Requires: workforce schema, contract schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_party_id` FOREIGN KEY (`party_id`) REFERENCES `vibe_construction_v1`.`contract`.`party`(`party_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `vibe_construction_v1`.`contract`.`agreement`(`agreement_id`);

-- ========= workforce --> equipment (1 constraint(s)) =========
-- Requires: workforce schema, equipment schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `vibe_construction_v1`.`equipment`.`asset`(`asset_id`);

-- ========= workforce --> finance (9 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ADD CONSTRAINT `fk_workforce_labor_cost_code_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ADD CONSTRAINT `fk_workforce_labor_cost_code_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `vibe_construction_v1`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_cost_code_id` FOREIGN KEY (`cost_code_id`) REFERENCES `vibe_construction_v1`.`finance`.`cost_code`(`cost_code_id`);

-- ========= workforce --> procurement (1 constraint(s)) =========
-- Requires: workforce schema, procurement schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= workforce --> project (12 constraint(s)) =========
-- Requires: workforce schema, project schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_construction_v1`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_project_milestone_id` FOREIGN KEY (`project_milestone_id`) REFERENCES `vibe_construction_v1`.`project`.`project_milestone`(`project_milestone_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `vibe_construction_v1`.`project`.`phase`(`phase_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_project_site_id` FOREIGN KEY (`project_site_id`) REFERENCES `vibe_construction_v1`.`project`.`project_site`(`project_site_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `vibe_construction_v1`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_construction_project_id` FOREIGN KEY (`construction_project_id`) REFERENCES `vibe_construction_v1`.`project`.`construction_project`(`construction_project_id`);

-- ========= workforce --> quality (3 constraint(s)) =========
-- Requires: workforce schema, quality schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_itp_line_id` FOREIGN KEY (`itp_line_id`) REFERENCES `vibe_construction_v1`.`quality`.`itp_line`(`itp_line_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_ncr_id` FOREIGN KEY (`ncr_id`) REFERENCES `vibe_construction_v1`.`quality`.`ncr`(`ncr_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_punch_item_id` FOREIGN KEY (`punch_item_id`) REFERENCES `vibe_construction_v1`.`quality`.`punch_item`(`punch_item_id`);

-- ========= workforce --> safety (3 constraint(s)) =========
-- Requires: workforce schema, safety schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_hse_plan_id` FOREIGN KEY (`hse_plan_id`) REFERENCES `vibe_construction_v1`.`safety`.`hse_plan`(`hse_plan_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_permit_to_work_id` FOREIGN KEY (`permit_to_work_id`) REFERENCES `vibe_construction_v1`.`safety`.`permit_to_work`(`permit_to_work_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_swms_id` FOREIGN KEY (`swms_id`) REFERENCES `vibe_construction_v1`.`safety`.`swms`(`swms_id`);

-- ========= workforce --> schedule (2 constraint(s)) =========
-- Requires: workforce schema, schedule schema
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `vibe_construction_v1`.`schedule`.`resource`(`resource_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `vibe_construction_v1`.`schedule`.`activity`(`activity_id`);

