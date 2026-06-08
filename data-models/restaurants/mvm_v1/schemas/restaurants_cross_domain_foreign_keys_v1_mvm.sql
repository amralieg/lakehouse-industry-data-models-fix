-- Cross-Domain Foreign Keys for Business: Restaurants | Version: v1_mvm
-- Generated on: 2026-05-06 04:01:11
-- Total cross-domain FK constraints: 827
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: finance, foodsafety, franchise, guest, inventory, loyalty, marketing, menu, order, realestate, restaurant, supply, workforce

-- ========= finance --> franchise (1 constraint(s)) =========
-- Requires: finance schema, franchise schema
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= finance --> guest (1 constraint(s)) =========
-- Requires: finance schema, guest schema
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);

-- ========= finance --> marketing (2 constraint(s)) =========
-- Requires: finance schema, marketing schema
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= finance --> realestate (2 constraint(s)) =========
-- Requires: finance schema, realestate schema
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `restaurants_ecm`.`realestate`.`lease`(`lease_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_maintenance_contract_id` FOREIGN KEY (`maintenance_contract_id`) REFERENCES `restaurants_ecm`.`realestate`.`maintenance_contract`(`maintenance_contract_id`);

-- ========= finance --> restaurant (9 constraint(s)) =========
-- Requires: finance schema, restaurant schema
ALTER TABLE `restaurants_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_budget_unit_id` FOREIGN KEY (`budget_unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);

-- ========= finance --> workforce (12 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_approver_user_employee_id` FOREIGN KEY (`approver_user_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_journal_employee_id` FOREIGN KEY (`primary_journal_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_tertiary_journal_last_modified_user_employee_id` FOREIGN KEY (`tertiary_journal_last_modified_user_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_primary_ap_created_by_user_employee_id` FOREIGN KEY (`primary_ap_created_by_user_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_tertiary_ap_modified_by_user_employee_id` FOREIGN KEY (`tertiary_ap_modified_by_user_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= foodsafety --> finance (9 constraint(s)) =========
-- Requires: foodsafety schema, finance schema
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ADD CONSTRAINT `fk_foodsafety_haccp_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ADD CONSTRAINT `fk_foodsafety_audit_finding_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ADD CONSTRAINT `fk_foodsafety_health_inspection_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `restaurants_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ADD CONSTRAINT `fk_foodsafety_health_inspection_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `restaurants_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ADD CONSTRAINT `fk_foodsafety_food_safety_certification_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `restaurants_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ADD CONSTRAINT `fk_foodsafety_food_safety_certification_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= foodsafety --> guest (2 constraint(s)) =========
-- Requires: foodsafety schema, guest schema
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `restaurants_ecm`.`guest`.`visit`(`visit_id`);

-- ========= foodsafety --> inventory (5 constraint(s)) =========
-- Requires: foodsafety schema, inventory schema
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ADD CONSTRAINT `fk_foodsafety_audit_finding_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_stock_location_id` FOREIGN KEY (`stock_location_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_location`(`stock_location_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= foodsafety --> marketing (1 constraint(s)) =========
-- Requires: foodsafety schema, marketing schema
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= foodsafety --> menu (1 constraint(s)) =========
-- Requires: foodsafety schema, menu schema
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_item`(`menu_item_id`);

-- ========= foodsafety --> realestate (13 constraint(s)) =========
-- Requires: foodsafety schema, realestate schema
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ADD CONSTRAINT `fk_foodsafety_haccp_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ADD CONSTRAINT `fk_foodsafety_critical_control_point_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ADD CONSTRAINT `fk_foodsafety_audit_finding_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ADD CONSTRAINT `fk_foodsafety_health_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ADD CONSTRAINT `fk_foodsafety_health_inspection_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ADD CONSTRAINT `fk_foodsafety_inspection_violation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ADD CONSTRAINT `fk_foodsafety_food_safety_certification_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);

-- ========= foodsafety --> restaurant (8 constraint(s)) =========
-- Requires: foodsafety schema, restaurant schema
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ADD CONSTRAINT `fk_foodsafety_audit_finding_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ADD CONSTRAINT `fk_foodsafety_health_inspection_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`inspection_violation` ADD CONSTRAINT `fk_foodsafety_inspection_violation_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `restaurants_ecm`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `restaurants_ecm`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);

-- ========= foodsafety --> workforce (17 constraint(s)) =========
-- Requires: foodsafety schema, workforce schema
ALTER TABLE `restaurants_ecm`.`foodsafety`.`haccp_plan` ADD CONSTRAINT `fk_foodsafety_haccp_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`critical_control_point` ADD CONSTRAINT `fk_foodsafety_critical_control_point_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_audit` ADD CONSTRAINT `fk_foodsafety_food_safety_audit_primary_food_employee_id` FOREIGN KEY (`primary_food_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`audit_finding` ADD CONSTRAINT `fk_foodsafety_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`health_inspection` ADD CONSTRAINT `fk_foodsafety_health_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_tertiary_corrective_verified_by_employee_id` FOREIGN KEY (`tertiary_corrective_verified_by_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`corrective_action` ADD CONSTRAINT `fk_foodsafety_corrective_action_training_completion_id` FOREIGN KEY (`training_completion_id`) REFERENCES `restaurants_ecm`.`workforce`.`training_completion`(`training_completion_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`temperature_log` ADD CONSTRAINT `fk_foodsafety_temperature_log_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`sanitation_task_log` ADD CONSTRAINT `fk_foodsafety_sanitation_task_log_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ADD CONSTRAINT `fk_foodsafety_food_safety_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`food_safety_certification` ADD CONSTRAINT `fk_foodsafety_food_safety_certification_certification_id` FOREIGN KEY (`certification_id`) REFERENCES `restaurants_ecm`.`workforce`.`certification`(`certification_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`foodsafety`.`illness_report` ADD CONSTRAINT `fk_foodsafety_illness_report_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);

-- ========= franchise --> finance (29 constraint(s)) =========
-- Requires: franchise schema, finance schema
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ADD CONSTRAINT `fk_franchise_franchisee_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `restaurants_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ADD CONSTRAINT `fk_franchise_franchisee_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_agreement_legal_entity_id` FOREIGN KEY (`agreement_legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ADD CONSTRAINT `fk_franchise_territory_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ADD CONSTRAINT `fk_franchise_billing_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `restaurants_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ADD CONSTRAINT `fk_franchise_billing_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ADD CONSTRAINT `fk_franchise_billing_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `restaurants_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ADD CONSTRAINT `fk_franchise_development_schedule_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `restaurants_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ADD CONSTRAINT `fk_franchise_development_schedule_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ADD CONSTRAINT `fk_franchise_development_schedule_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ADD CONSTRAINT `fk_franchise_training_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ADD CONSTRAINT `fk_franchise_training_enrollment_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ADD CONSTRAINT `fk_franchise_performance_scorecard_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ADD CONSTRAINT `fk_franchise_performance_scorecard_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= franchise --> foodsafety (5 constraint(s)) =========
-- Requires: franchise schema, foodsafety schema
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_health_inspection_id` FOREIGN KEY (`health_inspection_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`health_inspection`(`health_inspection_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ADD CONSTRAINT `fk_franchise_training_enrollment_food_safety_certification_id` FOREIGN KEY (`food_safety_certification_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`food_safety_certification`(`food_safety_certification_id`);

-- ========= franchise --> loyalty (2 constraint(s)) =========
-- Requires: franchise schema, loyalty schema
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_program_id` FOREIGN KEY (`program_id`) REFERENCES `restaurants_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_program_id` FOREIGN KEY (`program_id`) REFERENCES `restaurants_ecm`.`loyalty`.`program`(`program_id`);

-- ========= franchise --> menu (2 constraint(s)) =========
-- Requires: franchise schema, menu schema
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `restaurants_ecm`.`menu`.`menu`(`menu_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `restaurants_ecm`.`menu`.`menu`(`menu_id`);

-- ========= franchise --> order (2 constraint(s)) =========
-- Requires: franchise schema, order schema
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_delivery_platform_id` FOREIGN KEY (`delivery_platform_id`) REFERENCES `restaurants_ecm`.`order`.`delivery_platform`(`delivery_platform_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `restaurants_ecm`.`order`.`channel`(`channel_id`);

-- ========= franchise --> realestate (4 constraint(s)) =========
-- Requires: franchise schema, realestate schema
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ADD CONSTRAINT `fk_franchise_development_schedule_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);

-- ========= franchise --> restaurant (10 constraint(s)) =========
-- Requires: franchise schema, restaurant schema
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ADD CONSTRAINT `fk_franchise_territory_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ADD CONSTRAINT `fk_franchise_development_schedule_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_brand_standard_id` FOREIGN KEY (`brand_standard_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand_standard`(`brand_standard_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ADD CONSTRAINT `fk_franchise_training_enrollment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ADD CONSTRAINT `fk_franchise_performance_scorecard_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);

-- ========= franchise --> supply (3 constraint(s)) =========
-- Requires: franchise schema, supply schema
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ADD CONSTRAINT `fk_franchise_franchisee_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `restaurants_ecm`.`supply`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `restaurants_ecm`.`supply`.`distribution_center`(`distribution_center_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `restaurants_ecm`.`supply`.`recall_event`(`recall_event_id`);

-- ========= franchise --> workforce (6 constraint(s)) =========
-- Requires: franchise schema, workforce schema
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_primary_compliance_employee_id` FOREIGN KEY (`primary_compliance_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ADD CONSTRAINT `fk_franchise_training_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ADD CONSTRAINT `fk_franchise_training_enrollment_tertiary_training_trainer_employee_id` FOREIGN KEY (`tertiary_training_trainer_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= guest --> finance (3 constraint(s)) =========
-- Requires: guest schema, finance schema
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ADD CONSTRAINT `fk_guest_lifetime_value_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= guest --> foodsafety (2 constraint(s)) =========
-- Requires: guest schema, foodsafety schema
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_health_inspection_id` FOREIGN KEY (`health_inspection_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`health_inspection`(`health_inspection_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_illness_report_id` FOREIGN KEY (`illness_report_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`illness_report`(`illness_report_id`);

-- ========= guest --> franchise (5 constraint(s)) =========
-- Requires: guest schema, franchise schema
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_performance_scorecard_id` FOREIGN KEY (`performance_scorecard_id`) REFERENCES `restaurants_ecm`.`franchise`.`performance_scorecard`(`performance_scorecard_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `restaurants_ecm`.`franchise`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= guest --> inventory (2 constraint(s)) =========
-- Requires: guest schema, inventory schema
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= guest --> loyalty (13 constraint(s)) =========
-- Requires: guest schema, loyalty schema
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_program_id` FOREIGN KEY (`program_id`) REFERENCES `restaurants_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `restaurants_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_program_id` FOREIGN KEY (`program_id`) REFERENCES `restaurants_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ADD CONSTRAINT `fk_guest_consent_record_program_id` FOREIGN KEY (`program_id`) REFERENCES `restaurants_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_program_id` FOREIGN KEY (`program_id`) REFERENCES `restaurants_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ADD CONSTRAINT `fk_guest_lifetime_value_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `restaurants_ecm`.`loyalty`.`tier`(`tier_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ADD CONSTRAINT `fk_guest_lifetime_value_program_id` FOREIGN KEY (`program_id`) REFERENCES `restaurants_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_member_id` FOREIGN KEY (`member_id`) REFERENCES `restaurants_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_member_id` FOREIGN KEY (`member_id`) REFERENCES `restaurants_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ADD CONSTRAINT `fk_guest_channel_identity_member_id` FOREIGN KEY (`member_id`) REFERENCES `restaurants_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ADD CONSTRAINT `fk_guest_channel_identity_program_id` FOREIGN KEY (`program_id`) REFERENCES `restaurants_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_member_id` FOREIGN KEY (`member_id`) REFERENCES `restaurants_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ADD CONSTRAINT `fk_guest_digital_account_member_id` FOREIGN KEY (`member_id`) REFERENCES `restaurants_ecm`.`loyalty`.`member`(`member_id`);

-- ========= guest --> marketing (2 constraint(s)) =========
-- Requires: guest schema, marketing schema
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);

-- ========= guest --> menu (4 constraint(s)) =========
-- Requires: guest schema, menu schema
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_allergen_declaration_id` FOREIGN KEY (`allergen_declaration_id`) REFERENCES `restaurants_ecm`.`menu`.`allergen_declaration`(`allergen_declaration_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_preference_unsafe_menu_item_id` FOREIGN KEY (`preference_unsafe_menu_item_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_item`(`menu_item_id`);

-- ========= guest --> order (4 constraint(s)) =========
-- Requires: guest schema, order schema
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `restaurants_ecm`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `restaurants_ecm`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_order_item_id` FOREIGN KEY (`order_item_id`) REFERENCES `restaurants_ecm`.`order`.`order_item`(`order_item_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `restaurants_ecm`.`order`.`guest_order`(`guest_order_id`);

-- ========= guest --> realestate (1 constraint(s)) =========
-- Requires: guest schema, realestate schema
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);

-- ========= guest --> restaurant (20 constraint(s)) =========
-- Requires: guest schema, restaurant schema
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_location_profile_id` FOREIGN KEY (`location_profile_id`) REFERENCES `restaurants_ecm`.`restaurant`.`location_profile`(`location_profile_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`profile` ADD CONSTRAINT `fk_guest_profile_profile_unit_id` FOREIGN KEY (`profile_unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`consent_record` ADD CONSTRAINT `fk_guest_consent_record_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`segment` ADD CONSTRAINT `fk_guest_segment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ADD CONSTRAINT `fk_guest_lifetime_value_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`lifetime_value` ADD CONSTRAINT `fk_guest_lifetime_value_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_tertiary_satisfaction_unit_id` FOREIGN KEY (`tertiary_satisfaction_unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_complaint_unit_id` FOREIGN KEY (`complaint_unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `restaurants_ecm`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`channel_identity` ADD CONSTRAINT `fk_guest_channel_identity_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `restaurants_ecm`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ADD CONSTRAINT `fk_guest_digital_account_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`digital_account` ADD CONSTRAINT `fk_guest_digital_account_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);

-- ========= guest --> supply (3 constraint(s)) =========
-- Requires: guest schema, supply schema
ALTER TABLE `restaurants_ecm`.`guest`.`preference` ADD CONSTRAINT `fk_guest_preference_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `restaurants_ecm`.`supply`.`recall_event`(`recall_event_id`);

-- ========= guest --> workforce (6 constraint(s)) =========
-- Requires: guest schema, workforce schema
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`satisfaction_survey` ADD CONSTRAINT `fk_guest_satisfaction_survey_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`complaint` ADD CONSTRAINT `fk_guest_complaint_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`guest`.`visit` ADD CONSTRAINT `fk_guest_visit_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);

-- ========= inventory --> finance (25 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `restaurants_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `restaurants_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `restaurants_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `restaurants_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `restaurants_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ADD CONSTRAINT `fk_inventory_vendor_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= inventory --> foodsafety (8 constraint(s)) =========
-- Requires: inventory schema, foodsafety schema
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_health_inspection_id` FOREIGN KEY (`health_inspection_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`health_inspection`(`health_inspection_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_illness_report_id` FOREIGN KEY (`illness_report_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`illness_report`(`illness_report_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_inspection_violation_id` FOREIGN KEY (`inspection_violation_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`inspection_violation`(`inspection_violation_id`);

-- ========= inventory --> franchise (9 constraint(s)) =========
-- Requires: inventory schema, franchise schema
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_sales_report_id` FOREIGN KEY (`sales_report_id`) REFERENCES `restaurants_ecm`.`franchise`.`sales_report`(`sales_report_id`);

-- ========= inventory --> marketing (4 constraint(s)) =========
-- Requires: inventory schema, marketing schema
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= inventory --> menu (1 constraint(s)) =========
-- Requires: inventory schema, menu schema
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `restaurants_ecm`.`menu`.`recipe`(`recipe_id`);

-- ========= inventory --> order (3 constraint(s)) =========
-- Requires: inventory schema, order schema
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_order_item_id` FOREIGN KEY (`order_item_id`) REFERENCES `restaurants_ecm`.`order`.`order_item`(`order_item_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_catering_order_id` FOREIGN KEY (`catering_order_id`) REFERENCES `restaurants_ecm`.`order`.`catering_order`(`catering_order_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_catering_order_id` FOREIGN KEY (`catering_order_id`) REFERENCES `restaurants_ecm`.`order`.`catering_order`(`catering_order_id`);

-- ========= inventory --> realestate (9 constraint(s)) =========
-- Requires: inventory schema, realestate schema
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_maintenance_work_order_id` FOREIGN KEY (`maintenance_work_order_id`) REFERENCES `restaurants_ecm`.`realestate`.`maintenance_work_order`(`maintenance_work_order_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);

-- ========= inventory --> restaurant (15 constraint(s)) =========
-- Requires: inventory schema, restaurant schema
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_brand_standard_id` FOREIGN KEY (`brand_standard_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand_standard`(`brand_standard_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `restaurants_ecm`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`on_hand_balance` ADD CONSTRAINT `fk_inventory_on_hand_balance_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_receiving_unit_id` FOREIGN KEY (`receiving_unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `restaurants_ecm`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_origin_restaurant_unit_id` FOREIGN KEY (`origin_restaurant_unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_unit_performance_id` FOREIGN KEY (`unit_performance_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit_performance`(`unit_performance_id`);

-- ========= inventory --> supply (10 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_item` ADD CONSTRAINT `fk_inventory_stock_item_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `restaurants_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_inbound_shipment_id` FOREIGN KEY (`inbound_shipment_id`) REFERENCES `restaurants_ecm`.`supply`.`inbound_shipment`(`inbound_shipment_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `restaurants_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `restaurants_ecm`.`supply`.`recall_event`(`recall_event_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `restaurants_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `restaurants_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `restaurants_ecm`.`supply`.`recall_event`(`recall_event_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ADD CONSTRAINT `fk_inventory_vendor_item_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ADD CONSTRAINT `fk_inventory_vendor_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= inventory --> workforce (23 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_location` ADD CONSTRAINT `fk_inventory_stock_location_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_receiving_manager_employee_id` FOREIGN KEY (`receiving_manager_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`receiving_order` ADD CONSTRAINT `fk_inventory_receiving_order_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`physical_count` ADD CONSTRAINT `fk_inventory_physical_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`waste_log` ADD CONSTRAINT `fk_inventory_waste_log_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_tertiary_stock_received_by_employee_id` FOREIGN KEY (`tertiary_stock_received_by_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_primary_replenishment_employee_id` FOREIGN KEY (`primary_replenishment_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_quaternary_replenishment_employee_id` FOREIGN KEY (`quaternary_replenishment_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_receiving_user_employee_id` FOREIGN KEY (`receiving_user_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_tertiary_replenishment_cancelled_by_user_employee_id` FOREIGN KEY (`tertiary_replenishment_cancelled_by_user_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_tertiary_replenishment_created_by_user_employee_id` FOREIGN KEY (`tertiary_replenishment_created_by_user_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_adjustment_employee_id` FOREIGN KEY (`adjustment_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_primary_inventory_adjusted_by_employee_id` FOREIGN KEY (`primary_inventory_adjusted_by_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_labor_budget_id` FOREIGN KEY (`labor_budget_id`) REFERENCES `restaurants_ecm`.`workforce`.`labor_budget`(`labor_budget_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`food_cost_period` ADD CONSTRAINT `fk_inventory_food_cost_period_tertiary_food_employee_id` FOREIGN KEY (`tertiary_food_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`inventory`.`vendor_item` ADD CONSTRAINT `fk_inventory_vendor_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= loyalty --> finance (14 constraint(s)) =========
-- Requires: loyalty schema, finance schema
ALTER TABLE `restaurants_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`program` ADD CONSTRAINT `fk_loyalty_program_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);

-- ========= loyalty --> franchise (5 constraint(s)) =========
-- Requires: loyalty schema, franchise schema
ALTER TABLE `restaurants_ecm`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= loyalty --> guest (2 constraint(s)) =========
-- Requires: loyalty schema, guest schema
ALTER TABLE `restaurants_ecm`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_member_profile_id` FOREIGN KEY (`member_profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);

-- ========= loyalty --> inventory (2 constraint(s)) =========
-- Requires: loyalty schema, inventory schema
ALTER TABLE `restaurants_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= loyalty --> marketing (14 constraint(s)) =========
-- Requires: loyalty schema, marketing schema
ALTER TABLE `restaurants_ecm`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer_assignment` ADD CONSTRAINT `fk_loyalty_offer_assignment_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);

-- ========= loyalty --> menu (5 constraint(s)) =========
-- Requires: loyalty schema, menu schema
ALTER TABLE `restaurants_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_item`(`menu_item_id`);

-- ========= loyalty --> order (9 constraint(s)) =========
-- Requires: loyalty schema, order schema
ALTER TABLE `restaurants_ecm`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `restaurants_ecm`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `restaurants_ecm`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `restaurants_ecm`.`order`.`channel`(`channel_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_source_transaction_guest_order_id` FOREIGN KEY (`source_transaction_guest_order_id`) REFERENCES `restaurants_ecm`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `restaurants_ecm`.`order`.`channel`(`channel_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `restaurants_ecm`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `restaurants_ecm`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `restaurants_ecm`.`order`.`channel`(`channel_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `restaurants_ecm`.`order`.`guest_order`(`guest_order_id`);

-- ========= loyalty --> realestate (1 constraint(s)) =========
-- Requires: loyalty schema, realestate schema
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);

-- ========= loyalty --> restaurant (17 constraint(s)) =========
-- Requires: loyalty schema, restaurant schema
ALTER TABLE `restaurants_ecm`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_member_unit_id` FOREIGN KEY (`member_unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`tier` ADD CONSTRAINT `fk_loyalty_tier_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `restaurants_ecm`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_redemption_unit_id` FOREIGN KEY (`redemption_unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_area_management_id` FOREIGN KEY (`area_management_id`) REFERENCES `restaurants_ecm`.`restaurant`.`area_management`(`area_management_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_area_management_id` FOREIGN KEY (`area_management_id`) REFERENCES `restaurants_ecm`.`restaurant`.`area_management`(`area_management_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `restaurants_ecm`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`program` ADD CONSTRAINT `fk_loyalty_program_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);

-- ========= loyalty --> supply (3 constraint(s)) =========
-- Requires: loyalty schema, supply schema
ALTER TABLE `restaurants_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= loyalty --> workforce (10 constraint(s)) =========
-- Requires: loyalty schema, workforce schema
ALTER TABLE `restaurants_ecm`.`loyalty`.`member` ADD CONSTRAINT `fk_loyalty_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`tier` ADD CONSTRAINT `fk_loyalty_tier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`tier_history` ADD CONSTRAINT `fk_loyalty_tier_history_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`points_ledger` ADD CONSTRAINT `fk_loyalty_points_ledger_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`reward` ADD CONSTRAINT `fk_loyalty_reward_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`redemption` ADD CONSTRAINT `fk_loyalty_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`accrual_rule` ADD CONSTRAINT `fk_loyalty_accrual_rule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer` ADD CONSTRAINT `fk_loyalty_offer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`offer_redemption` ADD CONSTRAINT `fk_loyalty_offer_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`loyalty`.`enrollment_event` ADD CONSTRAINT `fk_loyalty_enrollment_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= marketing --> finance (9 constraint(s)) =========
-- Requires: marketing schema, finance schema
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `restaurants_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `restaurants_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= marketing --> foodsafety (1 constraint(s)) =========
-- Requires: marketing schema, foodsafety schema
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_health_inspection_id` FOREIGN KEY (`health_inspection_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`health_inspection`(`health_inspection_id`);

-- ========= marketing --> franchise (6 constraint(s)) =========
-- Requires: marketing schema, franchise schema
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= marketing --> guest (6 constraint(s)) =========
-- Requires: marketing schema, guest schema
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `restaurants_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `restaurants_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `restaurants_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_digital_account_id` FOREIGN KEY (`digital_account_id`) REFERENCES `restaurants_ecm`.`guest`.`digital_account`(`digital_account_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_visit_id` FOREIGN KEY (`visit_id`) REFERENCES `restaurants_ecm`.`guest`.`visit`(`visit_id`);

-- ========= marketing --> loyalty (4 constraint(s)) =========
-- Requires: marketing schema, loyalty schema
ALTER TABLE `restaurants_ecm`.`marketing`.`marketing_lto` ADD CONSTRAINT `fk_marketing_marketing_lto_reward_id` FOREIGN KEY (`reward_id`) REFERENCES `restaurants_ecm`.`loyalty`.`reward`(`reward_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_member_id` FOREIGN KEY (`member_id`) REFERENCES `restaurants_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ADD CONSTRAINT `fk_marketing_coupon_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `restaurants_ecm`.`loyalty`.`offer`(`offer_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ADD CONSTRAINT `fk_marketing_coupon_reward_id` FOREIGN KEY (`reward_id`) REFERENCES `restaurants_ecm`.`loyalty`.`reward`(`reward_id`);

-- ========= marketing --> menu (1 constraint(s)) =========
-- Requires: marketing schema, menu schema
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ADD CONSTRAINT `fk_marketing_coupon_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_item`(`menu_item_id`);

-- ========= marketing --> order (3 constraint(s)) =========
-- Requires: marketing schema, order schema
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `restaurants_ecm`.`order`.`channel`(`channel_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_guest_order_id` FOREIGN KEY (`guest_order_id`) REFERENCES `restaurants_ecm`.`order`.`guest_order`(`guest_order_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ADD CONSTRAINT `fk_marketing_coupon_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `restaurants_ecm`.`order`.`channel`(`channel_id`);

-- ========= marketing --> realestate (4 constraint(s)) =========
-- Requires: marketing schema, realestate schema
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_nro_project_id` FOREIGN KEY (`nro_project_id`) REFERENCES `restaurants_ecm`.`realestate`.`nro_project`(`nro_project_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_campaign_remodel_project_nro_project_id` FOREIGN KEY (`campaign_remodel_project_nro_project_id`) REFERENCES `restaurants_ecm`.`realestate`.`nro_project`(`nro_project_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_nro_project_id` FOREIGN KEY (`nro_project_id`) REFERENCES `restaurants_ecm`.`realestate`.`nro_project`(`nro_project_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);

-- ========= marketing --> restaurant (10 constraint(s)) =========
-- Requires: marketing schema, restaurant schema
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_area_management_id` FOREIGN KEY (`area_management_id`) REFERENCES `restaurants_ecm`.`restaurant`.`area_management`(`area_management_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_area_management_id` FOREIGN KEY (`area_management_id`) REFERENCES `restaurants_ecm`.`restaurant`.`area_management`(`area_management_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_area_management_id` FOREIGN KEY (`area_management_id`) REFERENCES `restaurants_ecm`.`restaurant`.`area_management`(`area_management_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`coupon` ADD CONSTRAINT `fk_marketing_coupon_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);

-- ========= marketing --> supply (5 constraint(s)) =========
-- Requires: marketing schema, supply schema
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`marketing_lto` ADD CONSTRAINT `fk_marketing_marketing_lto_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);

-- ========= marketing --> workforce (5 constraint(s)) =========
-- Requires: marketing schema, workforce schema
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign` ADD CONSTRAINT `fk_marketing_campaign_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`campaign_execution` ADD CONSTRAINT `fk_marketing_campaign_execution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`media_plan` ADD CONSTRAINT `fk_marketing_media_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion` ADD CONSTRAINT `fk_marketing_promotion_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`marketing`.`promotion_redemption` ADD CONSTRAINT `fk_marketing_promotion_redemption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= menu --> finance (14 constraint(s)) =========
-- Requires: menu schema, finance schema
ALTER TABLE `restaurants_ecm`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`modifier_group` ADD CONSTRAINT `fk_menu_modifier_group_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_cost` ADD CONSTRAINT `fk_menu_item_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_cost` ADD CONSTRAINT `fk_menu_item_cost_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_cost` ADD CONSTRAINT `fk_menu_item_cost_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_cost` ADD CONSTRAINT `fk_menu_item_cost_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`combo_meal` ADD CONSTRAINT `fk_menu_combo_meal_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`combo_meal` ADD CONSTRAINT `fk_menu_combo_meal_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);

-- ========= menu --> foodsafety (8 constraint(s)) =========
-- Requires: menu schema, foodsafety schema
ALTER TABLE `restaurants_ecm`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`allergen_declaration` ADD CONSTRAINT `fk_menu_allergen_declaration_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_food_safety_audit_id` FOREIGN KEY (`food_safety_audit_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`food_safety_audit`(`food_safety_audit_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_inspection_violation_id` FOREIGN KEY (`inspection_violation_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`inspection_violation`(`inspection_violation_id`);

-- ========= menu --> franchise (9 constraint(s)) =========
-- Requires: menu schema, franchise schema
ALTER TABLE `restaurants_ecm`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`modifier_group` ADD CONSTRAINT `fk_menu_modifier_group_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_cost` ADD CONSTRAINT `fk_menu_item_cost_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= menu --> guest (2 constraint(s)) =========
-- Requires: menu schema, guest schema
ALTER TABLE `restaurants_ecm`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `restaurants_ecm`.`guest`.`segment`(`segment_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `restaurants_ecm`.`guest`.`segment`(`segment_id`);

-- ========= menu --> inventory (4 constraint(s)) =========
-- Requires: menu schema, inventory schema
ALTER TABLE `restaurants_ecm`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu_modifier` ADD CONSTRAINT `fk_menu_menu_modifier_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= menu --> loyalty (2 constraint(s)) =========
-- Requires: menu schema, loyalty schema
ALTER TABLE `restaurants_ecm`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_program_id` FOREIGN KEY (`program_id`) REFERENCES `restaurants_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `restaurants_ecm`.`loyalty`.`offer`(`offer_id`);

-- ========= menu --> marketing (8 constraint(s)) =========
-- Requires: menu schema, marketing schema
ALTER TABLE `restaurants_ecm`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`combo_meal` ADD CONSTRAINT `fk_menu_combo_meal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`combo_meal` ADD CONSTRAINT `fk_menu_combo_meal_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);

-- ========= menu --> order (1 constraint(s)) =========
-- Requires: menu schema, order schema
ALTER TABLE `restaurants_ecm`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `restaurants_ecm`.`order`.`channel`(`channel_id`);

-- ========= menu --> realestate (6 constraint(s)) =========
-- Requires: menu schema, realestate schema
ALTER TABLE `restaurants_ecm`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_nro_project_id` FOREIGN KEY (`nro_project_id`) REFERENCES `restaurants_ecm`.`realestate`.`nro_project`(`nro_project_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_maintenance_work_order_id` FOREIGN KEY (`maintenance_work_order_id`) REFERENCES `restaurants_ecm`.`realestate`.`maintenance_work_order`(`maintenance_work_order_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);

-- ========= menu --> restaurant (13 constraint(s)) =========
-- Requires: menu schema, restaurant schema
ALTER TABLE `restaurants_ecm`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`modifier_group` ADD CONSTRAINT `fk_menu_modifier_group_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `restaurants_ecm`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`pmix_record` ADD CONSTRAINT `fk_menu_pmix_record_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`combo_meal` ADD CONSTRAINT `fk_menu_combo_meal_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_equipment_asset_id` FOREIGN KEY (`equipment_asset_id`) REFERENCES `restaurants_ecm`.`restaurant`.`equipment_asset`(`equipment_asset_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);

-- ========= menu --> supply (10 constraint(s)) =========
-- Requires: menu schema, supply schema
ALTER TABLE `restaurants_ecm`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier`(`supplier_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_primary_recipe_substitute_ingredient_id` FOREIGN KEY (`primary_recipe_substitute_ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`allergen_declaration` ADD CONSTRAINT `fk_menu_allergen_declaration_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `restaurants_ecm`.`supply`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu_modifier` ADD CONSTRAINT `fk_menu_menu_modifier_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `restaurants_ecm`.`supply`.`recall_event`(`recall_event_id`);

-- ========= menu --> workforce (14 constraint(s)) =========
-- Requires: menu schema, workforce schema
ALTER TABLE `restaurants_ecm`.`menu`.`menu_item` ADD CONSTRAINT `fk_menu_menu_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu` ADD CONSTRAINT `fk_menu_menu_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`recipe` ADD CONSTRAINT `fk_menu_recipe_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`recipe_ingredient` ADD CONSTRAINT `fk_menu_recipe_ingredient_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_price` ADD CONSTRAINT `fk_menu_item_price_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`nutrition_profile` ADD CONSTRAINT `fk_menu_nutrition_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`allergen_declaration` ADD CONSTRAINT `fk_menu_allergen_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu_lto` ADD CONSTRAINT `fk_menu_menu_lto_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`modifier_group` ADD CONSTRAINT `fk_menu_modifier_group_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`menu_modifier` ADD CONSTRAINT `fk_menu_menu_modifier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_cost` ADD CONSTRAINT `fk_menu_item_cost_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`combo_meal` ADD CONSTRAINT `fk_menu_combo_meal_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`menu`.`item_86_event` ADD CONSTRAINT `fk_menu_item_86_event_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);

-- ========= order --> finance (18 constraint(s)) =========
-- Requires: order schema, finance schema
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `restaurants_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `restaurants_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`order`.`channel` ADD CONSTRAINT `fk_order_channel_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`order`.`delivery_platform` ADD CONSTRAINT `fk_order_delivery_platform_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= order --> foodsafety (2 constraint(s)) =========
-- Requires: order schema, foodsafety schema
ALTER TABLE `restaurants_ecm`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `restaurants_ecm`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_illness_report_id` FOREIGN KEY (`illness_report_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`illness_report`(`illness_report_id`);

-- ========= order --> franchise (4 constraint(s)) =========
-- Requires: order schema, franchise schema
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `restaurants_ecm`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= order --> guest (7 constraint(s)) =========
-- Requires: order schema, guest schema
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_digital_account_id` FOREIGN KEY (`digital_account_id`) REFERENCES `restaurants_ecm`.`guest`.`digital_account`(`digital_account_id`);
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);
ALTER TABLE `restaurants_ecm`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_refund_profile_id` FOREIGN KEY (`refund_profile_id`) REFERENCES `restaurants_ecm`.`guest`.`profile`(`profile_id`);

-- ========= order --> loyalty (9 constraint(s)) =========
-- Requires: order schema, loyalty schema
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_member_id` FOREIGN KEY (`member_id`) REFERENCES `restaurants_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_program_id` FOREIGN KEY (`program_id`) REFERENCES `restaurants_ecm`.`loyalty`.`program`(`program_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_reward_id` FOREIGN KEY (`reward_id`) REFERENCES `restaurants_ecm`.`loyalty`.`reward`(`reward_id`);
ALTER TABLE `restaurants_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_member_id` FOREIGN KEY (`member_id`) REFERENCES `restaurants_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `restaurants_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `restaurants_ecm`.`loyalty`.`redemption`(`redemption_id`);
ALTER TABLE `restaurants_ecm`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_member_id` FOREIGN KEY (`member_id`) REFERENCES `restaurants_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `restaurants_ecm`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_member_id` FOREIGN KEY (`member_id`) REFERENCES `restaurants_ecm`.`loyalty`.`member`(`member_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `restaurants_ecm`.`loyalty`.`offer`(`offer_id`);
ALTER TABLE `restaurants_ecm`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_redemption_id` FOREIGN KEY (`redemption_id`) REFERENCES `restaurants_ecm`.`loyalty`.`redemption`(`redemption_id`);

-- ========= order --> marketing (8 constraint(s)) =========
-- Requires: order schema, marketing schema
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `restaurants_ecm`.`marketing`.`coupon`(`coupon_id`);
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_coupon_id` FOREIGN KEY (`coupon_id`) REFERENCES `restaurants_ecm`.`marketing`.`coupon`(`coupon_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);

-- ========= order --> menu (15 constraint(s)) =========
-- Requires: order schema, menu schema
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `restaurants_ecm`.`menu`.`menu`(`menu_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_allergen_declaration_id` FOREIGN KEY (`allergen_declaration_id`) REFERENCES `restaurants_ecm`.`menu`.`allergen_declaration`(`allergen_declaration_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_menu_lto_id` FOREIGN KEY (`menu_lto_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_lto`(`menu_lto_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_menu_modifier_id` FOREIGN KEY (`menu_modifier_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_modifier`(`menu_modifier_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_nutrition_profile_id` FOREIGN KEY (`nutrition_profile_id`) REFERENCES `restaurants_ecm`.`menu`.`nutrition_profile`(`nutrition_profile_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_combo_meal_id` FOREIGN KEY (`combo_meal_id`) REFERENCES `restaurants_ecm`.`menu`.`combo_meal`(`combo_meal_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `restaurants_ecm`.`menu`.`recipe`(`recipe_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_modifier_group_id` FOREIGN KEY (`modifier_group_id`) REFERENCES `restaurants_ecm`.`menu`.`modifier_group`(`modifier_group_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_menu_modifier_id` FOREIGN KEY (`menu_modifier_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_modifier`(`menu_modifier_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_source_modifier_menu_modifier_id` FOREIGN KEY (`source_modifier_menu_modifier_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_modifier`(`menu_modifier_id`);
ALTER TABLE `restaurants_ecm`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `restaurants_ecm`.`menu`.`menu`(`menu_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_combo_meal_id` FOREIGN KEY (`combo_meal_id`) REFERENCES `restaurants_ecm`.`menu`.`combo_meal`(`combo_meal_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_item`(`menu_item_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_menu_lto_id` FOREIGN KEY (`menu_lto_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_lto`(`menu_lto_id`);

-- ========= order --> realestate (11 constraint(s)) =========
-- Requires: order schema, realestate schema
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);

-- ========= order --> restaurant (15 constraint(s)) =========
-- Requires: order schema, restaurant schema
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_department_id` FOREIGN KEY (`department_id`) REFERENCES `restaurants_ecm`.`restaurant`.`department`(`department_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `restaurants_ecm`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `restaurants_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `restaurants_ecm`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `restaurants_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `restaurants_ecm`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_pos_terminal_id` FOREIGN KEY (`pos_terminal_id`) REFERENCES `restaurants_ecm`.`restaurant`.`pos_terminal`(`pos_terminal_id`);
ALTER TABLE `restaurants_ecm`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`order`.`tax` ADD CONSTRAINT `fk_order_tax_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);

-- ========= order --> supply (1 constraint(s)) =========
-- Requires: order schema, supply schema
ALTER TABLE `restaurants_ecm`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_ingredient_id` FOREIGN KEY (`ingredient_id`) REFERENCES `restaurants_ecm`.`supply`.`ingredient`(`ingredient_id`);

-- ========= order --> workforce (15 constraint(s)) =========
-- Requires: order schema, workforce schema
ALTER TABLE `restaurants_ecm`.`order`.`guest_order` ADD CONSTRAINT `fk_order_guest_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_item` ADD CONSTRAINT `fk_order_order_item_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`order`.`order_modifier` ADD CONSTRAINT `fk_order_order_modifier_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`order`.`payment` ADD CONSTRAINT `fk_order_payment_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `restaurants_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`order`.`delivery_order` ADD CONSTRAINT `fk_order_delivery_order_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `restaurants_ecm`.`order`.`catering_order` ADD CONSTRAINT `fk_order_catering_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`order`.`discount` ADD CONSTRAINT `fk_order_discount_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `restaurants_ecm`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_refund_processing_employee_id` FOREIGN KEY (`refund_processing_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_refund_voided_by_employee_id` FOREIGN KEY (`refund_voided_by_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`order`.`refund` ADD CONSTRAINT `fk_order_refund_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `restaurants_ecm`.`workforce`.`shift`(`shift_id`);

-- ========= realestate --> finance (28 constraint(s)) =========
-- Requires: realestate schema, finance schema
ALTER TABLE `restaurants_ecm`.`realestate`.`site` ADD CONSTRAINT `fk_realestate_site_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`site` ADD CONSTRAINT `fk_realestate_site_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`lease` ADD CONSTRAINT `fk_realestate_lease_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`lease` ADD CONSTRAINT `fk_realestate_lease_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_schedule` ADD CONSTRAINT `fk_realestate_rent_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_schedule` ADD CONSTRAINT `fk_realestate_rent_schedule_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_schedule` ADD CONSTRAINT `fk_realestate_rent_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_schedule` ADD CONSTRAINT `fk_realestate_rent_schedule_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `restaurants_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `restaurants_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`nro_project` ADD CONSTRAINT `fk_realestate_nro_project_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `restaurants_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`nro_project` ADD CONSTRAINT `fk_realestate_nro_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`nro_project` ADD CONSTRAINT `fk_realestate_nro_project_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`capex_budget` ADD CONSTRAINT `fk_realestate_capex_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`capex_budget` ADD CONSTRAINT `fk_realestate_capex_budget_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`capex_budget` ADD CONSTRAINT `fk_realestate_capex_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`capex_budget` ADD CONSTRAINT `fk_realestate_capex_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`capex_budget` ADD CONSTRAINT `fk_realestate_capex_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`maintenance_work_order` ADD CONSTRAINT `fk_realestate_maintenance_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`maintenance_work_order` ADD CONSTRAINT `fk_realestate_maintenance_work_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`maintenance_contract` ADD CONSTRAINT `fk_realestate_maintenance_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`maintenance_contract` ADD CONSTRAINT `fk_realestate_maintenance_contract_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`maintenance_contract` ADD CONSTRAINT `fk_realestate_maintenance_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`lease_amendment` ADD CONSTRAINT `fk_realestate_lease_amendment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= realestate --> franchise (9 constraint(s)) =========
-- Requires: realestate schema, franchise schema
ALTER TABLE `restaurants_ecm`.`realestate`.`site` ADD CONSTRAINT `fk_realestate_site_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`site` ADD CONSTRAINT `fk_realestate_site_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`site` ADD CONSTRAINT `fk_realestate_site_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`lease` ADD CONSTRAINT `fk_realestate_lease_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`lease` ADD CONSTRAINT `fk_realestate_lease_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_schedule` ADD CONSTRAINT `fk_realestate_rent_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`nro_project` ADD CONSTRAINT `fk_realestate_nro_project_nro_pipeline_id` FOREIGN KEY (`nro_pipeline_id`) REFERENCES `restaurants_ecm`.`franchise`.`nro_pipeline`(`nro_pipeline_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`nro_project` ADD CONSTRAINT `fk_realestate_nro_project_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`maintenance_work_order` ADD CONSTRAINT `fk_realestate_maintenance_work_order_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= realestate --> guest (1 constraint(s)) =========
-- Requires: realestate schema, guest schema
ALTER TABLE `restaurants_ecm`.`realestate`.`maintenance_work_order` ADD CONSTRAINT `fk_realestate_maintenance_work_order_complaint_id` FOREIGN KEY (`complaint_id`) REFERENCES `restaurants_ecm`.`guest`.`complaint`(`complaint_id`);

-- ========= realestate --> restaurant (6 constraint(s)) =========
-- Requires: realestate schema, restaurant schema
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_schedule` ADD CONSTRAINT `fk_realestate_rent_schedule_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`nro_project` ADD CONSTRAINT `fk_realestate_nro_project_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`facility` ADD CONSTRAINT `fk_realestate_facility_brand_standard_id` FOREIGN KEY (`brand_standard_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand_standard`(`brand_standard_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`maintenance_work_order` ADD CONSTRAINT `fk_realestate_maintenance_work_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`lease_amendment` ADD CONSTRAINT `fk_realestate_lease_amendment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);

-- ========= realestate --> workforce (6 constraint(s)) =========
-- Requires: realestate schema, workforce schema
ALTER TABLE `restaurants_ecm`.`realestate`.`rent_payment` ADD CONSTRAINT `fk_realestate_rent_payment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`nro_project` ADD CONSTRAINT `fk_realestate_nro_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`capex_budget` ADD CONSTRAINT `fk_realestate_capex_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`maintenance_work_order` ADD CONSTRAINT `fk_realestate_maintenance_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`maintenance_contract` ADD CONSTRAINT `fk_realestate_maintenance_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`realestate`.`lease_amendment` ADD CONSTRAINT `fk_realestate_lease_amendment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= restaurant --> finance (12 constraint(s)) =========
-- Requires: restaurant schema, finance schema
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`equipment_asset` ADD CONSTRAINT `fk_restaurant_equipment_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`equipment_asset` ADD CONSTRAINT `fk_restaurant_equipment_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `restaurants_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit_performance` ADD CONSTRAINT `fk_restaurant_unit_performance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit_performance` ADD CONSTRAINT `fk_restaurant_unit_performance_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit_performance` ADD CONSTRAINT `fk_restaurant_unit_performance_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`area_management` ADD CONSTRAINT `fk_restaurant_area_management_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit_ownership` ADD CONSTRAINT `fk_restaurant_unit_ownership_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`pos_terminal` ADD CONSTRAINT `fk_restaurant_pos_terminal_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `restaurants_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`brand` ADD CONSTRAINT `fk_restaurant_brand_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`department` ADD CONSTRAINT `fk_restaurant_department_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= restaurant --> foodsafety (1 constraint(s)) =========
-- Requires: restaurant schema, foodsafety schema
ALTER TABLE `restaurants_ecm`.`restaurant`.`equipment_asset` ADD CONSTRAINT `fk_restaurant_equipment_asset_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);

-- ========= restaurant --> franchise (5 constraint(s)) =========
-- Requires: restaurant schema, franchise schema
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`location_profile` ADD CONSTRAINT `fk_restaurant_location_profile_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit_ownership` ADD CONSTRAINT `fk_restaurant_unit_ownership_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit_ownership` ADD CONSTRAINT `fk_restaurant_unit_ownership_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`department` ADD CONSTRAINT `fk_restaurant_department_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= restaurant --> loyalty (1 constraint(s)) =========
-- Requires: restaurant schema, loyalty schema
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_program_id` FOREIGN KEY (`program_id`) REFERENCES `restaurants_ecm`.`loyalty`.`program`(`program_id`);

-- ========= restaurant --> realestate (7 constraint(s)) =========
-- Requires: restaurant schema, realestate schema
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_landlord_id` FOREIGN KEY (`landlord_id`) REFERENCES `restaurants_ecm`.`realestate`.`landlord`(`landlord_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `restaurants_ecm`.`realestate`.`lease`(`lease_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`location_profile` ADD CONSTRAINT `fk_restaurant_location_profile_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `restaurants_ecm`.`realestate`.`lease`(`lease_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`location_profile` ADD CONSTRAINT `fk_restaurant_location_profile_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`equipment_asset` ADD CONSTRAINT `fk_restaurant_equipment_asset_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);

-- ========= restaurant --> supply (1 constraint(s)) =========
-- Requires: restaurant schema, supply schema
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit` ADD CONSTRAINT `fk_restaurant_unit_distribution_center_id` FOREIGN KEY (`distribution_center_id`) REFERENCES `restaurants_ecm`.`supply`.`distribution_center`(`distribution_center_id`);

-- ========= restaurant --> workforce (3 constraint(s)) =========
-- Requires: restaurant schema, workforce schema
ALTER TABLE `restaurants_ecm`.`restaurant`.`operating_hours` ADD CONSTRAINT `fk_restaurant_operating_hours_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit_ownership` ADD CONSTRAINT `fk_restaurant_unit_ownership_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`restaurant`.`unit_ownership` ADD CONSTRAINT `fk_restaurant_unit_ownership_tertiary_unit_last_modified_by_user_employee_id` FOREIGN KEY (`tertiary_unit_last_modified_by_user_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> finance (27 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `restaurants_ecm`.`supply`.`supplier` ADD CONSTRAINT `fk_supply_supplier_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`supplier` ADD CONSTRAINT `fk_supply_supplier_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ADD CONSTRAINT `fk_supply_ingredient_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `restaurants_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `restaurants_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`invoice` ADD CONSTRAINT `fk_supply_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ADD CONSTRAINT `fk_supply_distribution_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ADD CONSTRAINT `fk_supply_distribution_center_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`distribution_center` ADD CONSTRAINT `fk_supply_distribution_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ADD CONSTRAINT `fk_supply_recall_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ADD CONSTRAINT `fk_supply_recall_event_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ADD CONSTRAINT `fk_supply_recall_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= supply --> foodsafety (4 constraint(s)) =========
-- Requires: supply schema, foodsafety schema
ALTER TABLE `restaurants_ecm`.`supply`.`ingredient` ADD CONSTRAINT `fk_supply_ingredient_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ADD CONSTRAINT `fk_supply_recall_event_critical_control_point_id` FOREIGN KEY (`critical_control_point_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`critical_control_point`(`critical_control_point_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ADD CONSTRAINT `fk_supply_recall_event_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);

-- ========= supply --> franchise (3 constraint(s)) =========
-- Requires: supply schema, franchise schema
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ADD CONSTRAINT `fk_supply_recall_event_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);

-- ========= supply --> inventory (2 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `restaurants_ecm`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ADD CONSTRAINT `fk_supply_recall_event_stock_item_id` FOREIGN KEY (`stock_item_id`) REFERENCES `restaurants_ecm`.`inventory`.`stock_item`(`stock_item_id`);

-- ========= supply --> realestate (4 constraint(s)) =========
-- Requires: supply schema, realestate schema
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_nro_project_id` FOREIGN KEY (`nro_project_id`) REFERENCES `restaurants_ecm`.`realestate`.`nro_project`(`nro_project_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_site_id` FOREIGN KEY (`site_id`) REFERENCES `restaurants_ecm`.`realestate`.`site`(`site_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_nro_project_id` FOREIGN KEY (`nro_project_id`) REFERENCES `restaurants_ecm`.`realestate`.`nro_project`(`nro_project_id`);

-- ========= supply --> restaurant (4 constraint(s)) =========
-- Requires: supply schema, restaurant schema
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand`(`brand_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`inbound_shipment` ADD CONSTRAINT `fk_supply_inbound_shipment_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);

-- ========= supply --> workforce (5 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `restaurants_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_primary_goods_employee_id` FOREIGN KEY (`primary_goods_employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`supplier_contract` ADD CONSTRAINT `fk_supply_supplier_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `restaurants_ecm`.`supply`.`recall_event` ADD CONSTRAINT `fk_supply_recall_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `restaurants_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> finance (15 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ADD CONSTRAINT `fk_workforce_labor_forecast_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ADD CONSTRAINT `fk_workforce_labor_forecast_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ADD CONSTRAINT `fk_workforce_labor_forecast_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `restaurants_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `restaurants_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `restaurants_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_financial_period_id` FOREIGN KEY (`financial_period_id`) REFERENCES `restaurants_ecm`.`finance`.`financial_period`(`financial_period_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `restaurants_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `restaurants_ecm`.`finance`.`profit_center`(`profit_center_id`);

-- ========= workforce --> foodsafety (1 constraint(s)) =========
-- Requires: workforce schema, foodsafety schema
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `restaurants_ecm`.`foodsafety`.`haccp_plan`(`haccp_plan_id`);

-- ========= workforce --> franchise (6 constraint(s)) =========
-- Requires: workforce schema, franchise schema
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_nro_pipeline_id` FOREIGN KEY (`nro_pipeline_id`) REFERENCES `restaurants_ecm`.`franchise`.`nro_pipeline`(`nro_pipeline_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ADD CONSTRAINT `fk_workforce_labor_forecast_nro_pipeline_id` FOREIGN KEY (`nro_pipeline_id`) REFERENCES `restaurants_ecm`.`franchise`.`nro_pipeline`(`nro_pipeline_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_training_enrollment_id` FOREIGN KEY (`training_enrollment_id`) REFERENCES `restaurants_ecm`.`franchise`.`training_enrollment`(`training_enrollment_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_nro_pipeline_id` FOREIGN KEY (`nro_pipeline_id`) REFERENCES `restaurants_ecm`.`franchise`.`nro_pipeline`(`nro_pipeline_id`);

-- ========= workforce --> marketing (2 constraint(s)) =========
-- Requires: workforce schema, marketing schema
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ADD CONSTRAINT `fk_workforce_labor_forecast_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `restaurants_ecm`.`marketing`.`campaign`(`campaign_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ADD CONSTRAINT `fk_workforce_labor_forecast_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `restaurants_ecm`.`marketing`.`promotion`(`promotion_id`);

-- ========= workforce --> menu (2 constraint(s)) =========
-- Requires: workforce schema, menu schema
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ADD CONSTRAINT `fk_workforce_labor_forecast_menu_lto_id` FOREIGN KEY (`menu_lto_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_lto`(`menu_lto_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_menu_item_id` FOREIGN KEY (`menu_item_id`) REFERENCES `restaurants_ecm`.`menu`.`menu_item`(`menu_item_id`);

-- ========= workforce --> order (1 constraint(s)) =========
-- Requires: workforce schema, order schema
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `restaurants_ecm`.`order`.`payment`(`payment_id`);

-- ========= workforce --> realestate (5 constraint(s)) =========
-- Requires: workforce schema, realestate schema
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `restaurants_ecm`.`realestate`.`facility`(`facility_id`);

-- ========= workforce --> restaurant (16 constraint(s)) =========
-- Requires: workforce schema, restaurant schema
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_department_id` FOREIGN KEY (`department_id`) REFERENCES `restaurants_ecm`.`restaurant`.`department`(`department_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_employee_unit_id` FOREIGN KEY (`employee_unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_employee_work_location_unit_id` FOREIGN KEY (`employee_work_location_unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_schedule_unit_id` FOREIGN KEY (`schedule_unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_department_id` FOREIGN KEY (`department_id`) REFERENCES `restaurants_ecm`.`restaurant`.`department`(`department_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_forecast` ADD CONSTRAINT `fk_workforce_labor_forecast_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_department_id` FOREIGN KEY (`department_id`) REFERENCES `restaurants_ecm`.`restaurant`.`department`(`department_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`payroll_record` ADD CONSTRAINT `fk_workforce_payroll_record_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_brand_standard_id` FOREIGN KEY (`brand_standard_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand_standard`(`brand_standard_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_brand_standard_id` FOREIGN KEY (`brand_standard_id`) REFERENCES `restaurants_ecm`.`restaurant`.`brand_standard`(`brand_standard_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`training_completion` ADD CONSTRAINT `fk_workforce_training_completion_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);
ALTER TABLE `restaurants_ecm`.`workforce`.`labor_budget` ADD CONSTRAINT `fk_workforce_labor_budget_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `restaurants_ecm`.`restaurant`.`unit`(`unit_id`);

