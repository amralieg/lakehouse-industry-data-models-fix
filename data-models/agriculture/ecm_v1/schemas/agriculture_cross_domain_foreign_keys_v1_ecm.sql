-- Cross-Domain Foreign Keys for Business: Agriculture | Version: v1_ecm
-- Generated on: 2026-05-01 16:23:41
-- Total cross-domain FK constraints: 2148
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: compliance, crop, customer, equipment, finance, inventory, invoice, land, livestock, procurement, product, quality, research, sales, supply, sustainability, weather, workforce

-- ========= compliance --> crop (8 constraint(s)) =========
-- Requires: compliance schema, crop schema
ALTER TABLE `agriculture_ecm`.`compliance`.`event` ADD CONSTRAINT `fk_compliance_event_protection_event_id` FOREIGN KEY (`protection_event_id`) REFERENCES `agriculture_ecm`.`crop`.`protection_event`(`protection_event_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`event` ADD CONSTRAINT `fk_compliance_event_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_protection_event_id` FOREIGN KEY (`protection_event_id`) REFERENCES `agriculture_ecm`.`crop`.`protection_event`(`protection_event_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_vra_prescription_id` FOREIGN KEY (`vra_prescription_id`) REFERENCES `agriculture_ecm`.`crop`.`vra_prescription`(`vra_prescription_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_seed_lot_id` FOREIGN KEY (`seed_lot_id`) REFERENCES `agriculture_ecm`.`crop`.`seed_lot`(`seed_lot_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`violation_record` ADD CONSTRAINT `fk_compliance_violation_record_protection_event_id` FOREIGN KEY (`protection_event_id`) REFERENCES `agriculture_ecm`.`crop`.`protection_event`(`protection_event_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`organic_compliance_record` ADD CONSTRAINT `fk_compliance_organic_compliance_record_rotation_plan_id` FOREIGN KEY (`rotation_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`rotation_plan`(`rotation_plan_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`organic_compliance_record` ADD CONSTRAINT `fk_compliance_organic_compliance_record_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);

-- ========= compliance --> customer (2 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_lot` ADD CONSTRAINT `fk_compliance_recall_lot_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_lot` ADD CONSTRAINT `fk_compliance_recall_lot_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);

-- ========= compliance --> finance (20 constraint(s)) =========
-- Requires: compliance schema, finance schema
ALTER TABLE `agriculture_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`event` ADD CONSTRAINT `fk_compliance_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_change` ADD CONSTRAINT `fk_compliance_regulatory_change_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`violation_record` ADD CONSTRAINT `fk_compliance_violation_record_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`violation_record` ADD CONSTRAINT `fk_compliance_violation_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`violation_record` ADD CONSTRAINT `fk_compliance_violation_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_event` ADD CONSTRAINT `fk_compliance_recall_event_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_event` ADD CONSTRAINT `fk_compliance_recall_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_event` ADD CONSTRAINT `fk_compliance_recall_event_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`worker_protection_record` ADD CONSTRAINT `fk_compliance_worker_protection_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`bioterrorism_registration` ADD CONSTRAINT `fk_compliance_bioterrorism_registration_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= compliance --> inventory (4 constraint(s)) =========
-- Requires: compliance schema, inventory schema
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `agriculture_ecm`.`inventory`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_lot` ADD CONSTRAINT `fk_compliance_recall_lot_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_lot` ADD CONSTRAINT `fk_compliance_recall_lot_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `agriculture_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= compliance --> land (38 constraint(s)) =========
-- Requires: compliance schema, land schema
ALTER TABLE `agriculture_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_water_right_id` FOREIGN KEY (`water_right_id`) REFERENCES `agriculture_ecm`.`land`.`water_right`(`water_right_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`event` ADD CONSTRAINT `fk_compliance_event_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`event` ADD CONSTRAINT `fk_compliance_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`inspection_record` ADD CONSTRAINT `fk_compliance_inspection_record_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`inspection_record` ADD CONSTRAINT `fk_compliance_inspection_record_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_finding` ADD CONSTRAINT `fk_compliance_regulatory_finding_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_finding` ADD CONSTRAINT `fk_compliance_regulatory_finding_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`food_safety_plan` ADD CONSTRAINT `fk_compliance_food_safety_plan_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_water_right_id` FOREIGN KEY (`water_right_id`) REFERENCES `agriculture_ecm`.`land`.`water_right`(`water_right_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`monitoring_result` ADD CONSTRAINT `fk_compliance_monitoring_result_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`monitoring_result` ADD CONSTRAINT `fk_compliance_monitoring_result_water_right_id` FOREIGN KEY (`water_right_id`) REFERENCES `agriculture_ecm`.`land`.`water_right`(`water_right_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`compliance_audit` ADD CONSTRAINT `fk_compliance_compliance_audit_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`compliance_audit` ADD CONSTRAINT `fk_compliance_compliance_audit_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`violation_record` ADD CONSTRAINT `fk_compliance_violation_record_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`violation_record` ADD CONSTRAINT `fk_compliance_violation_record_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_event` ADD CONSTRAINT `fk_compliance_recall_event_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_lot` ADD CONSTRAINT `fk_compliance_recall_lot_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_lot` ADD CONSTRAINT `fk_compliance_recall_lot_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`worker_protection_record` ADD CONSTRAINT `fk_compliance_worker_protection_record_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`worker_protection_record` ADD CONSTRAINT `fk_compliance_worker_protection_record_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`organic_compliance_record` ADD CONSTRAINT `fk_compliance_organic_compliance_record_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`organic_compliance_record` ADD CONSTRAINT `fk_compliance_organic_compliance_record_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`organic_compliance_record` ADD CONSTRAINT `fk_compliance_organic_compliance_record_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`calendar_entry` ADD CONSTRAINT `fk_compliance_calendar_entry_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);

-- ========= compliance --> procurement (1 constraint(s)) =========
-- Requires: compliance schema, procurement schema
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `agriculture_ecm`.`procurement`.`chemical_compliance`(`chemical_compliance_id`);

-- ========= compliance --> product (13 constraint(s)) =========
-- Requires: compliance schema, product schema
ALTER TABLE `agriculture_ecm`.`compliance`.`event` ADD CONSTRAINT `fk_compliance_event_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`event` ADD CONSTRAINT `fk_compliance_event_product_certification_id` FOREIGN KEY (`product_certification_id`) REFERENCES `agriculture_ecm`.`product`.`product_certification`(`product_certification_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`inspection_record` ADD CONSTRAINT `fk_compliance_inspection_record_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`monitoring_result` ADD CONSTRAINT `fk_compliance_monitoring_result_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_event` ADD CONSTRAINT `fk_compliance_recall_event_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_event` ADD CONSTRAINT `fk_compliance_recall_event_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_lot` ADD CONSTRAINT `fk_compliance_recall_lot_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_lot` ADD CONSTRAINT `fk_compliance_recall_lot_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`organic_compliance_record` ADD CONSTRAINT `fk_compliance_organic_compliance_record_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_plan` ADD CONSTRAINT `fk_compliance_recall_plan_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);

-- ========= compliance --> quality (8 constraint(s)) =========
-- Requires: compliance schema, quality schema
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_finding` ADD CONSTRAINT `fk_compliance_regulatory_finding_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`monitoring_result` ADD CONSTRAINT `fk_compliance_monitoring_result_field_sample_id` FOREIGN KEY (`field_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`monitoring_result` ADD CONSTRAINT `fk_compliance_monitoring_result_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`monitoring_result` ADD CONSTRAINT `fk_compliance_monitoring_result_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `agriculture_ecm`.`quality`.`laboratory`(`laboratory_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`monitoring_result` ADD CONSTRAINT `fk_compliance_monitoring_result_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`monitoring_result` ADD CONSTRAINT `fk_compliance_monitoring_result_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `agriculture_ecm`.`quality`.`test_result`(`test_result_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_event` ADD CONSTRAINT `fk_compliance_recall_event_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);

-- ========= compliance --> research (5 constraint(s)) =========
-- Requires: compliance schema, research schema
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_input_usage_id` FOREIGN KEY (`input_usage_id`) REFERENCES `agriculture_ecm`.`research`.`input_usage`(`input_usage_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_treatment_application_id` FOREIGN KEY (`treatment_application_id`) REFERENCES `agriculture_ecm`.`research`.`treatment_application`(`treatment_application_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_treatment_id` FOREIGN KEY (`treatment_id`) REFERENCES `agriculture_ecm`.`research`.`treatment`(`treatment_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_trial_plot_id` FOREIGN KEY (`trial_plot_id`) REFERENCES `agriculture_ecm`.`research`.`trial_plot`(`trial_plot_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`violation_record` ADD CONSTRAINT `fk_compliance_violation_record_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);

-- ========= compliance --> sales (3 constraint(s)) =========
-- Requires: compliance schema, sales schema
ALTER TABLE `agriculture_ecm`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_event` ADD CONSTRAINT `fk_compliance_recall_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_lot` ADD CONSTRAINT `fk_compliance_recall_lot_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `agriculture_ecm`.`sales`.`order_line`(`order_line_id`);

-- ========= compliance --> supply (23 constraint(s)) =========
-- Requires: compliance schema, supply schema
ALTER TABLE `agriculture_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`event` ADD CONSTRAINT `fk_compliance_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`inspection_record` ADD CONSTRAINT `fk_compliance_inspection_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_finding` ADD CONSTRAINT `fk_compliance_regulatory_finding_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`food_safety_plan` ADD CONSTRAINT `fk_compliance_food_safety_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`monitoring_result` ADD CONSTRAINT `fk_compliance_monitoring_result_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `agriculture_ecm`.`supply`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`compliance_audit` ADD CONSTRAINT `fk_compliance_compliance_audit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`violation_record` ADD CONSTRAINT `fk_compliance_violation_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_event` ADD CONSTRAINT `fk_compliance_recall_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_lot` ADD CONSTRAINT `fk_compliance_recall_lot_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`worker_protection_record` ADD CONSTRAINT `fk_compliance_worker_protection_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`organic_compliance_record` ADD CONSTRAINT `fk_compliance_organic_compliance_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`calendar_entry` ADD CONSTRAINT `fk_compliance_calendar_entry_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`bioterrorism_registration` ADD CONSTRAINT `fk_compliance_bioterrorism_registration_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`recall_plan` ADD CONSTRAINT `fk_compliance_recall_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`outfall` ADD CONSTRAINT `fk_compliance_outfall_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

-- ========= compliance --> sustainability (4 constraint(s)) =========
-- Requires: compliance schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_carbon_footprint_id` FOREIGN KEY (`carbon_footprint_id`) REFERENCES `agriculture_ecm`.`sustainability`.`carbon_footprint`(`carbon_footprint_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`event` ADD CONSTRAINT `fk_compliance_event_practice_adoption_id` FOREIGN KEY (`practice_adoption_id`) REFERENCES `agriculture_ecm`.`sustainability`.`practice_adoption`(`practice_adoption_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`trade_compliance_record` ADD CONSTRAINT `fk_compliance_trade_compliance_record_deforestation_risk_id` FOREIGN KEY (`deforestation_risk_id`) REFERENCES `agriculture_ecm`.`sustainability`.`deforestation_risk`(`deforestation_risk_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`violation_record` ADD CONSTRAINT `fk_compliance_violation_record_land_use_change_id` FOREIGN KEY (`land_use_change_id`) REFERENCES `agriculture_ecm`.`sustainability`.`land_use_change`(`land_use_change_id`);

-- ========= compliance --> weather (6 constraint(s)) =========
-- Requires: compliance schema, weather schema
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_drought_index_id` FOREIGN KEY (`drought_index_id`) REFERENCES `agriculture_ecm`.`weather`.`drought_index`(`drought_index_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`event` ADD CONSTRAINT `fk_compliance_event_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`event` ADD CONSTRAINT `fk_compliance_event_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`pesticide_use_record` ADD CONSTRAINT `fk_compliance_pesticide_use_record_spray_window_id` FOREIGN KEY (`spray_window_id`) REFERENCES `agriculture_ecm`.`weather`.`spray_window`(`spray_window_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_climate_normal_id` FOREIGN KEY (`climate_normal_id`) REFERENCES `agriculture_ecm`.`weather`.`climate_normal`(`climate_normal_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`monitoring_result` ADD CONSTRAINT `fk_compliance_monitoring_result_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);

-- ========= compliance --> workforce (16 constraint(s)) =========
-- Requires: compliance schema, workforce schema
ALTER TABLE `agriculture_ecm`.`compliance`.`license` ADD CONSTRAINT `fk_compliance_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_primary_regulatory_employee_id` FOREIGN KEY (`primary_regulatory_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`event` ADD CONSTRAINT `fk_compliance_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`inspection_record` ADD CONSTRAINT `fk_compliance_inspection_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`regulatory_finding` ADD CONSTRAINT `fk_compliance_regulatory_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`food_safety_plan` ADD CONSTRAINT `fk_compliance_food_safety_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`compliance_audit` ADD CONSTRAINT `fk_compliance_compliance_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_primary_audit_employee_id` FOREIGN KEY (`primary_audit_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`worker_protection_record` ADD CONSTRAINT `fk_compliance_worker_protection_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`calendar_entry` ADD CONSTRAINT `fk_compliance_calendar_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`compliance`.`document` ADD CONSTRAINT `fk_compliance_document_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= crop --> compliance (2 constraint(s)) =========
-- Requires: crop schema, compliance schema
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= crop --> customer (5 constraint(s)) =========
-- Requires: crop schema, customer schema
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`grain_delivery` ADD CONSTRAINT `fk_crop_grain_delivery_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);

-- ========= crop --> equipment (17 constraint(s)) =========
-- Requires: crop schema, equipment schema
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `agriculture_ecm`.`equipment`.`work_order`(`work_order_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`vra_prescription` ADD CONSTRAINT `fk_crop_vra_prescription_precision_device_id` FOREIGN KEY (`precision_device_id`) REFERENCES `agriculture_ecm`.`equipment`.`precision_device`(`precision_device_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_fault_id` FOREIGN KEY (`fault_id`) REFERENCES `agriculture_ecm`.`equipment`.`fault`(`fault_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `agriculture_ecm`.`equipment`.`work_order`(`work_order_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);

-- ========= crop --> finance (5 constraint(s)) =========
-- Requires: crop schema, finance schema
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_commodity_hedge_id` FOREIGN KEY (`commodity_hedge_id`) REFERENCES `agriculture_ecm`.`finance`.`commodity_hedge`(`commodity_hedge_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_government_program_id` FOREIGN KEY (`government_program_id`) REFERENCES `agriculture_ecm`.`finance`.`government_program`(`government_program_id`);

-- ========= crop --> inventory (9 constraint(s)) =========
-- Requires: crop schema, inventory schema
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `agriculture_ecm`.`inventory`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_inventory_goods_receipt_id` FOREIGN KEY (`inventory_goods_receipt_id`) REFERENCES `agriculture_ecm`.`inventory`.`inventory_goods_receipt`(`inventory_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);

-- ========= crop --> invoice (1 constraint(s)) =========
-- Requires: crop schema, invoice schema
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `agriculture_ecm`.`invoice`.`weight_ticket`(`weight_ticket_id`);

-- ========= crop --> land (24 constraint(s)) =========
-- Requires: crop schema, land schema
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_land_soil_sample_id` FOREIGN KEY (`land_soil_sample_id`) REFERENCES `agriculture_ecm`.`land`.`land_soil_sample`(`land_soil_sample_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_soil_profile_id` FOREIGN KEY (`soil_profile_id`) REFERENCES `agriculture_ecm`.`land`.`soil_profile`(`soil_profile_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_land_soil_sample_id` FOREIGN KEY (`land_soil_sample_id`) REFERENCES `agriculture_ecm`.`land`.`land_soil_sample`(`land_soil_sample_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_irrigation_zone_id` FOREIGN KEY (`irrigation_zone_id`) REFERENCES `agriculture_ecm`.`land`.`irrigation_zone`(`irrigation_zone_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`vra_prescription` ADD CONSTRAINT `fk_crop_vra_prescription_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_soil_profile_id` FOREIGN KEY (`soil_profile_id`) REFERENCES `agriculture_ecm`.`land`.`soil_profile`(`soil_profile_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`zone_map` ADD CONSTRAINT `fk_crop_zone_map_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`zone_map` ADD CONSTRAINT `fk_crop_zone_map_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);

-- ========= crop --> livestock (2 constraint(s)) =========
-- Requires: crop schema, livestock schema
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);

-- ========= crop --> procurement (5 constraint(s)) =========
-- Requires: crop schema, procurement schema
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `agriculture_ecm`.`procurement`.`budget`(`budget_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= crop --> product (20 constraint(s)) =========
-- Requires: crop schema, product schema
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`vra_prescription` ADD CONSTRAINT `fk_crop_vra_prescription_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`prescription_zone_rate` ADD CONSTRAINT `fk_crop_prescription_zone_rate_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);

-- ========= crop --> quality (9 constraint(s)) =========
-- Requires: crop schema, quality schema
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_quality_audit_id` FOREIGN KEY (`quality_audit_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_audit`(`quality_audit_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_certification`(`quality_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`seed_lot` ADD CONSTRAINT `fk_crop_seed_lot_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);

-- ========= crop --> sales (4 constraint(s)) =========
-- Requires: crop schema, sales schema
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `agriculture_ecm`.`sales`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);

-- ========= crop --> weather (18 constraint(s)) =========
-- Requires: crop schema, weather schema
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_climate_risk_indicator_id` FOREIGN KEY (`climate_risk_indicator_id`) REFERENCES `agriculture_ecm`.`weather`.`climate_risk_indicator`(`climate_risk_indicator_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_planting_window_id` FOREIGN KEY (`planting_window_id`) REFERENCES `agriculture_ecm`.`weather`.`planting_window`(`planting_window_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `agriculture_ecm`.`weather`.`forecast`(`forecast_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_planting_window_id` FOREIGN KEY (`planting_window_id`) REFERENCES `agriculture_ecm`.`weather`.`planting_window`(`planting_window_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_spray_window_id` FOREIGN KEY (`spray_window_id`) REFERENCES `agriculture_ecm`.`weather`.`spray_window`(`spray_window_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_spray_window_id` FOREIGN KEY (`spray_window_id`) REFERENCES `agriculture_ecm`.`weather`.`spray_window`(`spray_window_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_irrigation_schedule_id` FOREIGN KEY (`irrigation_schedule_id`) REFERENCES `agriculture_ecm`.`weather`.`irrigation_schedule`(`irrigation_schedule_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_pump_station_id` FOREIGN KEY (`pump_station_id`) REFERENCES `agriculture_ecm`.`weather`.`station`(`station_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_station_id` FOREIGN KEY (`station_id`) REFERENCES `agriculture_ecm`.`weather`.`station`(`station_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`vra_prescription` ADD CONSTRAINT `fk_crop_vra_prescription_spray_window_id` FOREIGN KEY (`spray_window_id`) REFERENCES `agriculture_ecm`.`weather`.`spray_window`(`spray_window_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_drought_index_id` FOREIGN KEY (`drought_index_id`) REFERENCES `agriculture_ecm`.`weather`.`drought_index`(`drought_index_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_station_id` FOREIGN KEY (`station_id`) REFERENCES `agriculture_ecm`.`weather`.`station`(`station_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);

-- ========= crop --> workforce (16 constraint(s)) =========
-- Requires: crop schema, workforce schema
ALTER TABLE `agriculture_ecm`.`crop`.`growing_season` ADD CONSTRAINT `fk_crop_growing_season_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`field_crop_plan` ADD CONSTRAINT `fk_crop_field_crop_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`planting_event` ADD CONSTRAINT `fk_crop_planting_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`fertilization_event` ADD CONSTRAINT `fk_crop_fertilization_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_workforce_certification_id` FOREIGN KEY (`workforce_certification_id`) REFERENCES `agriculture_ecm`.`workforce`.`workforce_certification`(`workforce_certification_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`protection_event` ADD CONSTRAINT `fk_crop_protection_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`irrigation_event` ADD CONSTRAINT `fk_crop_irrigation_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`scouting_observation` ADD CONSTRAINT `fk_crop_scouting_observation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`vra_prescription` ADD CONSTRAINT `fk_crop_vra_prescription_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`yield_record` ADD CONSTRAINT `fk_crop_yield_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`rotation_plan` ADD CONSTRAINT `fk_crop_rotation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`loss_event` ADD CONSTRAINT `fk_crop_loss_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`cover_crop` ADD CONSTRAINT `fk_crop_cover_crop_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`crop`.`harvest_event` ADD CONSTRAINT `fk_crop_harvest_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= customer --> compliance (15 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `agriculture_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `agriculture_ecm`.`compliance`.`recall_event`(`recall_event_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_regulatory_finding_id` FOREIGN KEY (`regulatory_finding_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_finding`(`regulatory_finding_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`certification_record` ADD CONSTRAINT `fk_customer_certification_record_organic_compliance_record_id` FOREIGN KEY (`organic_compliance_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`organic_compliance_record`(`organic_compliance_record_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`certification_record` ADD CONSTRAINT `fk_customer_certification_record_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`cool_preference` ADD CONSTRAINT `fk_customer_cool_preference_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`consent_record` ADD CONSTRAINT `fk_customer_consent_record_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`delivery_location` ADD CONSTRAINT `fk_customer_delivery_location_bioterrorism_registration_id` FOREIGN KEY (`bioterrorism_registration_id`) REFERENCES `agriculture_ecm`.`compliance`.`bioterrorism_registration`(`bioterrorism_registration_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`delivery_location` ADD CONSTRAINT `fk_customer_delivery_location_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`delivery_location` ADD CONSTRAINT `fk_customer_delivery_location_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`delivery_location` ADD CONSTRAINT `fk_customer_delivery_location_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`audit_participation` ADD CONSTRAINT `fk_customer_audit_participation_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `agriculture_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);

-- ========= customer --> crop (1 constraint(s)) =========
-- Requires: customer schema, crop schema
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);

-- ========= customer --> equipment (1 constraint(s)) =========
-- Requires: customer schema, equipment schema
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_fault_id` FOREIGN KEY (`fault_id`) REFERENCES `agriculture_ecm`.`equipment`.`fault`(`fault_id`);

-- ========= customer --> finance (5 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `agriculture_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`delivery_location` ADD CONSTRAINT `fk_customer_delivery_location_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= customer --> inventory (3 constraint(s)) =========
-- Requires: customer schema, inventory schema
ALTER TABLE `agriculture_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`cool_preference` ADD CONSTRAINT `fk_customer_cool_preference_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);

-- ========= customer --> invoice (5 constraint(s)) =========
-- Requires: customer schema, invoice schema
ALTER TABLE `agriculture_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `agriculture_ecm`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `agriculture_ecm`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `agriculture_ecm`.`invoice`.`payment_term`(`payment_term_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `agriculture_ecm`.`invoice`.`invoice`(`invoice_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `agriculture_ecm`.`invoice`.`payment_term`(`payment_term_id`);

-- ========= customer --> procurement (1 constraint(s)) =========
-- Requires: customer schema, procurement schema
ALTER TABLE `agriculture_ecm`.`customer`.`dual_role_partnership` ADD CONSTRAINT `fk_customer_dual_role_partnership_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= customer --> product (15 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `agriculture_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`certification_record` ADD CONSTRAINT `fk_customer_certification_record_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`certification_record` ADD CONSTRAINT `fk_customer_certification_record_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`account_relationship` ADD CONSTRAINT `fk_customer_account_relationship_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`cool_preference` ADD CONSTRAINT `fk_customer_cool_preference_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`account_commodity_program` ADD CONSTRAINT `fk_customer_account_commodity_program_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`bundle_enrollment` ADD CONSTRAINT `fk_customer_bundle_enrollment_bundle_id` FOREIGN KEY (`bundle_id`) REFERENCES `agriculture_ecm`.`product`.`bundle`(`bundle_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`location_commodity_authorization` ADD CONSTRAINT `fk_customer_location_commodity_authorization_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= customer --> sales (1 constraint(s)) =========
-- Requires: customer schema, sales schema
ALTER TABLE `agriculture_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `agriculture_ecm`.`sales`.`opportunity`(`opportunity_id`);

-- ========= customer --> sustainability (5 constraint(s)) =========
-- Requires: customer schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`customer`.`preference` ADD CONSTRAINT `fk_customer_preference_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `agriculture_ecm`.`sustainability`.`environmental_incident`(`environmental_incident_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`certification_record` ADD CONSTRAINT `fk_customer_certification_record_sustainability_audit_id` FOREIGN KEY (`sustainability_audit_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_audit`(`sustainability_audit_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`delivery_location` ADD CONSTRAINT `fk_customer_delivery_location_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);

-- ========= customer --> weather (3 constraint(s)) =========
-- Requires: customer schema, weather schema
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`delivery_location` ADD CONSTRAINT `fk_customer_delivery_location_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);

-- ========= customer --> workforce (10 constraint(s)) =========
-- Requires: customer schema, workforce schema
ALTER TABLE `agriculture_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`account_hierarchy` ADD CONSTRAINT `fk_customer_account_hierarchy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`lead` ADD CONSTRAINT `fk_customer_lead_lead_employee_id` FOREIGN KEY (`lead_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`case` ADD CONSTRAINT `fk_customer_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`certification_record` ADD CONSTRAINT `fk_customer_certification_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`account_relationship` ADD CONSTRAINT `fk_customer_account_relationship_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`account_relationship` ADD CONSTRAINT `fk_customer_account_relationship_primary_account_employee_id` FOREIGN KEY (`primary_account_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`customer`.`onboarding` ADD CONSTRAINT `fk_customer_onboarding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= equipment --> compliance (11 constraint(s)) =========
-- Requires: equipment schema, compliance schema
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`fault` ADD CONSTRAINT `fk_equipment_fault_event_id` FOREIGN KEY (`event_id`) REFERENCES `agriculture_ecm`.`compliance`.`event`(`event_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`fault` ADD CONSTRAINT `fk_equipment_fault_violation_record_id` FOREIGN KEY (`violation_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`violation_record`(`violation_record_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`calibration_event` ADD CONSTRAINT `fk_equipment_calibration_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_inspection` ADD CONSTRAINT `fk_equipment_asset_inspection_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_inspection` ADD CONSTRAINT `fk_equipment_asset_inspection_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= equipment --> crop (5 constraint(s)) =========
-- Requires: equipment schema, crop schema
ALTER TABLE `agriculture_ecm`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_vra_prescription_id` FOREIGN KEY (`vra_prescription_id`) REFERENCES `agriculture_ecm`.`crop`.`vra_prescription`(`vra_prescription_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_vra_prescription_id` FOREIGN KEY (`vra_prescription_id`) REFERENCES `agriculture_ecm`.`crop`.`vra_prescription`(`vra_prescription_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);

-- ========= equipment --> customer (3 constraint(s)) =========
-- Requires: equipment schema, customer schema
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`custom_hire_contract` ADD CONSTRAINT `fk_equipment_custom_hire_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);

-- ========= equipment --> finance (9 constraint(s)) =========
-- Requires: equipment schema, finance schema
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `agriculture_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `agriculture_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`parts_inventory` ADD CONSTRAINT `fk_equipment_parts_inventory_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`warranty_claim` ADD CONSTRAINT `fk_equipment_warranty_claim_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= equipment --> inventory (2 constraint(s)) =========
-- Requires: equipment schema, inventory schema
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);

-- ========= equipment --> invoice (3 constraint(s)) =========
-- Requires: equipment schema, invoice schema
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_line_id` FOREIGN KEY (`line_id`) REFERENCES `agriculture_ecm`.`invoice`.`line`(`line_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `agriculture_ecm`.`invoice`.`invoice`(`invoice_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_billing_schedule_id` FOREIGN KEY (`billing_schedule_id`) REFERENCES `agriculture_ecm`.`invoice`.`billing_schedule`(`billing_schedule_id`);

-- ========= equipment --> land (17 constraint(s)) =========
-- Requires: equipment schema, land schema
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`fault` ADD CONSTRAINT `fk_equipment_fault_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_conservation_practice_id` FOREIGN KEY (`conservation_practice_id`) REFERENCES `agriculture_ecm`.`land`.`conservation_practice`(`conservation_practice_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_irrigation_zone_id` FOREIGN KEY (`irrigation_zone_id`) REFERENCES `agriculture_ecm`.`land`.`irrigation_zone`(`irrigation_zone_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_land_soil_sample_id` FOREIGN KEY (`land_soil_sample_id`) REFERENCES `agriculture_ecm`.`land`.`land_soil_sample`(`land_soil_sample_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_use_plan_id` FOREIGN KEY (`use_plan_id`) REFERENCES `agriculture_ecm`.`land`.`use_plan`(`use_plan_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_water_right_id` FOREIGN KEY (`water_right_id`) REFERENCES `agriculture_ecm`.`land`.`water_right`(`water_right_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`calibration_event` ADD CONSTRAINT `fk_equipment_calibration_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_inspection` ADD CONSTRAINT `fk_equipment_asset_inspection_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);

-- ========= equipment --> procurement (12 constraint(s)) =========
-- Requires: equipment schema, procurement schema
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`parts_inventory` ADD CONSTRAINT `fk_equipment_parts_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`precision_device` ADD CONSTRAINT `fk_equipment_precision_device_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`precision_device` ADD CONSTRAINT `fk_equipment_precision_device_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`calibration_event` ADD CONSTRAINT `fk_equipment_calibration_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`warranty_claim` ADD CONSTRAINT `fk_equipment_warranty_claim_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= equipment --> product (6 constraint(s)) =========
-- Requires: equipment schema, product schema
ALTER TABLE `agriculture_ecm`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`input_compatibility` ADD CONSTRAINT `fk_equipment_input_compatibility_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);

-- ========= equipment --> quality (6 constraint(s)) =========
-- Requires: equipment schema, quality schema
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`fault` ADD CONSTRAINT `fk_equipment_fault_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`calibration_event` ADD CONSTRAINT `fk_equipment_calibration_event_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `agriculture_ecm`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`calibration_event` ADD CONSTRAINT `fk_equipment_calibration_event_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_inspection` ADD CONSTRAINT `fk_equipment_asset_inspection_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `agriculture_ecm`.`quality`.`corrective_action`(`corrective_action_id`);

-- ========= equipment --> research (2 constraint(s)) =========
-- Requires: equipment schema, research schema
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`calibration_event` ADD CONSTRAINT `fk_equipment_calibration_event_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);

-- ========= equipment --> sales (4 constraint(s)) =========
-- Requires: equipment schema, sales schema
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `agriculture_ecm`.`sales`.`territory`(`territory_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_contract_allocation` ADD CONSTRAINT `fk_equipment_asset_contract_allocation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);

-- ========= equipment --> supply (8 constraint(s)) =========
-- Requires: equipment schema, supply schema
ALTER TABLE `agriculture_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`parts_inventory` ADD CONSTRAINT `fk_equipment_parts_inventory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`calibration_event` ADD CONSTRAINT `fk_equipment_calibration_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`rental_lease` ADD CONSTRAINT `fk_equipment_rental_lease_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_center` ADD CONSTRAINT `fk_equipment_work_center_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

-- ========= equipment --> sustainability (1 constraint(s)) =========
-- Requires: equipment schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_certification_scope` ADD CONSTRAINT `fk_equipment_asset_certification_scope_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);

-- ========= equipment --> weather (12 constraint(s)) =========
-- Requires: equipment schema, weather schema
ALTER TABLE `agriculture_ecm`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_climate_normal_id` FOREIGN KEY (`climate_normal_id`) REFERENCES `agriculture_ecm`.`weather`.`climate_normal`(`climate_normal_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`maintenance_plan` ADD CONSTRAINT `fk_equipment_maintenance_plan_climate_risk_indicator_id` FOREIGN KEY (`climate_risk_indicator_id`) REFERENCES `agriculture_ecm`.`weather`.`climate_risk_indicator`(`climate_risk_indicator_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`fault` ADD CONSTRAINT `fk_equipment_fault_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`fault` ADD CONSTRAINT `fk_equipment_fault_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_spray_window_id` FOREIGN KEY (`spray_window_id`) REFERENCES `agriculture_ecm`.`weather`.`spray_window`(`spray_window_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`calibration_event` ADD CONSTRAINT `fk_equipment_calibration_event_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_inspection` ADD CONSTRAINT `fk_equipment_asset_inspection_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`warranty_claim` ADD CONSTRAINT `fk_equipment_warranty_claim_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);

-- ========= equipment --> workforce (13 constraint(s)) =========
-- Requires: equipment schema, workforce schema
ALTER TABLE `agriculture_ecm`.`equipment`.`telematics_reading` ADD CONSTRAINT `fk_equipment_telematics_reading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_order` ADD CONSTRAINT `fk_equipment_work_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`fault` ADD CONSTRAINT `fk_equipment_fault_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `agriculture_ecm`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`equipment_field_operation` ADD CONSTRAINT `fk_equipment_equipment_field_operation_workforce_certification_id` FOREIGN KEY (`workforce_certification_id`) REFERENCES `agriculture_ecm`.`workforce`.`workforce_certification`(`workforce_certification_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`calibration_event` ADD CONSTRAINT `fk_equipment_calibration_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_inspection` ADD CONSTRAINT `fk_equipment_asset_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`asset_assignment` ADD CONSTRAINT `fk_equipment_asset_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`equipment`.`work_center` ADD CONSTRAINT `fk_equipment_work_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= finance --> compliance (4 constraint(s)) =========
-- Requires: finance schema, compliance schema
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ADD CONSTRAINT `fk_finance_government_program_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= finance --> customer (1 constraint(s)) =========
-- Requires: finance schema, customer schema
ALTER TABLE `agriculture_ecm`.`finance`.`patronage_distribution` ADD CONSTRAINT `fk_finance_patronage_distribution_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);

-- ========= finance --> inventory (1 constraint(s)) =========
-- Requires: finance schema, inventory schema
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);

-- ========= finance --> land (11 constraint(s)) =========
-- Requires: finance schema, land schema
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ADD CONSTRAINT `fk_finance_commodity_hedge_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ADD CONSTRAINT `fk_finance_government_program_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);

-- ========= finance --> livestock (5 constraint(s)) =========
-- Requires: finance schema, livestock schema
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ADD CONSTRAINT `fk_finance_commodity_hedge_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ADD CONSTRAINT `fk_finance_commodity_hedge_production_group_id` FOREIGN KEY (`production_group_id`) REFERENCES `agriculture_ecm`.`livestock`.`production_group`(`production_group_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ADD CONSTRAINT `fk_finance_government_program_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ADD CONSTRAINT `fk_finance_government_program_production_group_id` FOREIGN KEY (`production_group_id`) REFERENCES `agriculture_ecm`.`livestock`.`production_group`(`production_group_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);

-- ========= finance --> procurement (11 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ADD CONSTRAINT `fk_finance_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`finance_ap_invoice` ADD CONSTRAINT `fk_finance_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`financing_arrangement` ADD CONSTRAINT `fk_finance_financing_arrangement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= finance --> product (10 constraint(s)) =========
-- Requires: finance schema, product schema
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`ap_invoice_line` ADD CONSTRAINT `fk_finance_ap_invoice_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`commodity_hedge` ADD CONSTRAINT `fk_finance_commodity_hedge_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`government_program` ADD CONSTRAINT `fk_finance_government_program_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`loan` ADD CONSTRAINT `fk_finance_loan_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= finance --> research (1 constraint(s)) =========
-- Requires: finance schema, research schema
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_program_id` FOREIGN KEY (`program_id`) REFERENCES `agriculture_ecm`.`research`.`program`(`program_id`);

-- ========= finance --> sales (3 constraint(s)) =========
-- Requires: finance schema, sales schema
ALTER TABLE `agriculture_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`tax_record` ADD CONSTRAINT `fk_finance_tax_record_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);

-- ========= finance --> supply (1 constraint(s)) =========
-- Requires: finance schema, supply schema
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `agriculture_ecm`.`supply`.`plant`(`plant_id`);

-- ========= finance --> sustainability (4 constraint(s)) =========
-- Requires: finance schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_carbon_footprint_id` FOREIGN KEY (`carbon_footprint_id`) REFERENCES `agriculture_ecm`.`sustainability`.`carbon_footprint`(`carbon_footprint_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`crop_enterprise_budget` ADD CONSTRAINT `fk_finance_crop_enterprise_budget_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `agriculture_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_esg_report_id` FOREIGN KEY (`esg_report_id`) REFERENCES `agriculture_ecm`.`sustainability`.`esg_report`(`esg_report_id`);

-- ========= finance --> workforce (15 constraint(s)) =========
-- Requires: finance schema, workforce schema
ALTER TABLE `agriculture_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`capital_project` ADD CONSTRAINT `fk_finance_capital_project_primary_capital_requestor_employee_id` FOREIGN KEY (`primary_capital_requestor_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_primary_period_employee_id` FOREIGN KEY (`primary_period_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_approved_by_user_employee_id` FOREIGN KEY (`approved_by_user_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`payment_run` ADD CONSTRAINT `fk_finance_payment_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`patronage_distribution` ADD CONSTRAINT `fk_finance_patronage_distribution_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`finance`.`financing_arrangement` ADD CONSTRAINT `fk_finance_financing_arrangement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= inventory --> compliance (6 constraint(s)) =========
-- Requires: inventory schema, compliance schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_organic_compliance_record_id` FOREIGN KEY (`organic_compliance_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`organic_compliance_record`(`organic_compliance_record_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `agriculture_ecm`.`compliance`.`recall_event`(`recall_event_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_regulatory_finding_id` FOREIGN KEY (`regulatory_finding_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_finding`(`regulatory_finding_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`lot_pesticide_exposure` ADD CONSTRAINT `fk_inventory_lot_pesticide_exposure_pesticide_use_record_id` FOREIGN KEY (`pesticide_use_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`pesticide_use_record`(`pesticide_use_record_id`);

-- ========= inventory --> crop (5 constraint(s)) =========
-- Requires: inventory schema, crop schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_vra_prescription_id` FOREIGN KEY (`vra_prescription_id`) REFERENCES `agriculture_ecm`.`crop`.`vra_prescription`(`vra_prescription_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_protection_event_id` FOREIGN KEY (`protection_event_id`) REFERENCES `agriculture_ecm`.`crop`.`protection_event`(`protection_event_id`);

-- ========= inventory --> customer (6 constraint(s)) =========
-- Requires: inventory schema, customer schema
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_case_id` FOREIGN KEY (`case_id`) REFERENCES `agriculture_ecm`.`customer`.`case`(`case_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`lot_allocation` ADD CONSTRAINT `fk_inventory_lot_allocation_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);

-- ========= inventory --> equipment (7 constraint(s)) =========
-- Requires: inventory schema, equipment schema
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `agriculture_ecm`.`equipment`.`work_order`(`work_order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `agriculture_ecm`.`equipment`.`work_order`(`work_order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`warehouse_task` ADD CONSTRAINT `fk_inventory_warehouse_task_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= inventory --> finance (22 constraint(s)) =========
-- Requires: inventory schema, finance schema
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_commodity_hedge_id` FOREIGN KEY (`commodity_hedge_id`) REFERENCES `agriculture_ecm`.`finance`.`commodity_hedge`(`commodity_hedge_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_government_program_id` FOREIGN KEY (`government_program_id`) REFERENCES `agriculture_ecm`.`finance`.`government_program`(`government_program_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `agriculture_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_finance_ap_invoice_id` FOREIGN KEY (`finance_ap_invoice_id`) REFERENCES `agriculture_ecm`.`finance`.`finance_ap_invoice`(`finance_ap_invoice_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_intercompany_transaction_id` FOREIGN KEY (`intercompany_transaction_id`) REFERENCES `agriculture_ecm`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= inventory --> land (5 constraint(s)) =========
-- Requires: inventory schema, land schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);

-- ========= inventory --> procurement (12 constraint(s)) =========
-- Requires: inventory schema, procurement schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `agriculture_ecm`.`procurement`.`chemical_compliance`(`chemical_compliance_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `agriculture_ecm`.`procurement`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`approved_vendor_material` ADD CONSTRAINT `fk_inventory_approved_vendor_material_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= inventory --> product (9 constraint(s)) =========
-- Requires: inventory schema, product schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);

-- ========= inventory --> quality (4 constraint(s)) =========
-- Requires: inventory schema, quality schema
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_supplier_assessment_id` FOREIGN KEY (`supplier_assessment_id`) REFERENCES `agriculture_ecm`.`quality`.`supplier_assessment`(`supplier_assessment_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);

-- ========= inventory --> research (5 constraint(s)) =========
-- Requires: inventory schema, research schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);

-- ========= inventory --> sales (10 constraint(s)) =========
-- Requires: inventory schema, sales schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `agriculture_ecm`.`sales`.`order_line`(`order_line_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `agriculture_ecm`.`sales`.`demand_forecast`(`demand_forecast_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`warehouse_task` ADD CONSTRAINT `fk_inventory_warehouse_task_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`lot_fulfillment` ADD CONSTRAINT `fk_inventory_lot_fulfillment_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);

-- ========= inventory --> supply (16 constraint(s)) =========
-- Requires: inventory schema, supply schema
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `agriculture_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `agriculture_ecm`.`supply`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_inbound_plan_id` FOREIGN KEY (`inbound_plan_id`) REFERENCES `agriculture_ecm`.`supply`.`inbound_plan`(`inbound_plan_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`bin_location` ADD CONSTRAINT `fk_inventory_bin_location_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `agriculture_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `agriculture_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`warehouse_task` ADD CONSTRAINT `fk_inventory_warehouse_task_inbound_plan_id` FOREIGN KEY (`inbound_plan_id`) REFERENCES `agriculture_ecm`.`supply`.`inbound_plan`(`inbound_plan_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`warehouse_task` ADD CONSTRAINT `fk_inventory_warehouse_task_load_plan_id` FOREIGN KEY (`load_plan_id`) REFERENCES `agriculture_ecm`.`supply`.`load_plan`(`load_plan_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`warehouse_task` ADD CONSTRAINT `fk_inventory_warehouse_task_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `agriculture_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);

-- ========= inventory --> sustainability (5 constraint(s)) =========
-- Requires: inventory schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `agriculture_ecm`.`sustainability`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`material_master` ADD CONSTRAINT `fk_inventory_material_master_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `agriculture_ecm`.`sustainability`.`environmental_incident`(`environmental_incident_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_waste_event_id` FOREIGN KEY (`waste_event_id`) REFERENCES `agriculture_ecm`.`sustainability`.`waste_event`(`waste_event_id`);

-- ========= inventory --> weather (14 constraint(s)) =========
-- Requires: inventory schema, weather schema
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_drought_index_id` FOREIGN KEY (`drought_index_id`) REFERENCES `agriculture_ecm`.`weather`.`drought_index`(`drought_index_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`commodity_lot` ADD CONSTRAINT `fk_inventory_commodity_lot_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_station_id` FOREIGN KEY (`station_id`) REFERENCES `agriculture_ecm`.`weather`.`station`(`station_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`storage_location` ADD CONSTRAINT `fk_inventory_storage_location_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_spray_window_id` FOREIGN KEY (`spray_window_id`) REFERENCES `agriculture_ecm`.`weather`.`spray_window`(`spray_window_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);

-- ========= inventory --> workforce (11 constraint(s)) =========
-- Requires: inventory schema, workforce schema
ALTER TABLE `agriculture_ecm`.`inventory`.`inventory_goods_receipt` ADD CONSTRAINT `fk_inventory_inventory_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`goods_issue` ADD CONSTRAINT `fk_inventory_goods_issue_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_transfer` ADD CONSTRAINT `fk_inventory_stock_transfer_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`stock_reservation` ADD CONSTRAINT `fk_inventory_stock_reservation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`reorder_policy` ADD CONSTRAINT `fk_inventory_reorder_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`warehouse_task` ADD CONSTRAINT `fk_inventory_warehouse_task_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`warehouse_task` ADD CONSTRAINT `fk_inventory_warehouse_task_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= invoice --> compliance (7 constraint(s)) =========
-- Requires: invoice schema, compliance schema
ALTER TABLE `agriculture_ecm`.`invoice`.`credit_memo` ADD CONSTRAINT `fk_invoice_credit_memo_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `agriculture_ecm`.`compliance`.`recall_event`(`recall_event_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_regulatory_finding_id` FOREIGN KEY (`regulatory_finding_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_finding`(`regulatory_finding_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`revenue_recognition` ADD CONSTRAINT `fk_invoice_revenue_recognition_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_organic_compliance_record_id` FOREIGN KEY (`organic_compliance_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`organic_compliance_record`(`organic_compliance_record_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_regulatory_finding_id` FOREIGN KEY (`regulatory_finding_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_finding`(`regulatory_finding_id`);

-- ========= invoice --> crop (5 constraint(s)) =========
-- Requires: invoice schema, crop schema
ALTER TABLE `agriculture_ecm`.`invoice`.`advance_payment` ADD CONSTRAINT `fk_invoice_advance_payment_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`receivable_financing` ADD CONSTRAINT `fk_invoice_receivable_financing_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);

-- ========= invoice --> customer (13 constraint(s)) =========
-- Requires: invoice schema, customer schema
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`credit_memo` ADD CONSTRAINT `fk_invoice_credit_memo_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`debit_memo` ADD CONSTRAINT `fk_invoice_debit_memo_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_account` ADD CONSTRAINT `fk_invoice_billing_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_account` ADD CONSTRAINT `fk_invoice_billing_account_billing_customer_account_id` FOREIGN KEY (`billing_customer_account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`revenue_recognition` ADD CONSTRAINT `fk_invoice_revenue_recognition_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dunning_notice` ADD CONSTRAINT `fk_invoice_dunning_notice_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`advance_payment` ADD CONSTRAINT `fk_invoice_advance_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`write_off` ADD CONSTRAINT `fk_invoice_write_off_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`receivable_financing` ADD CONSTRAINT `fk_invoice_receivable_financing_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);

-- ========= invoice --> equipment (3 constraint(s)) =========
-- Requires: invoice schema, equipment schema
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_trailer_asset_id` FOREIGN KEY (`trailer_asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= invoice --> finance (35 constraint(s)) =========
-- Requires: invoice schema, finance schema
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_commodity_hedge_id` FOREIGN KEY (`commodity_hedge_id`) REFERENCES `agriculture_ecm`.`finance`.`commodity_hedge`(`commodity_hedge_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `agriculture_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment_allocation` ADD CONSTRAINT `fk_invoice_payment_allocation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment_allocation` ADD CONSTRAINT `fk_invoice_payment_allocation_patronage_distribution_id` FOREIGN KEY (`patronage_distribution_id`) REFERENCES `agriculture_ecm`.`finance`.`patronage_distribution`(`patronage_distribution_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`credit_memo` ADD CONSTRAINT `fk_invoice_credit_memo_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`credit_memo` ADD CONSTRAINT `fk_invoice_credit_memo_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`debit_memo` ADD CONSTRAINT `fk_invoice_debit_memo_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`debit_memo` ADD CONSTRAINT `fk_invoice_debit_memo_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_account` ADD CONSTRAINT `fk_invoice_billing_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`revenue_recognition` ADD CONSTRAINT `fk_invoice_revenue_recognition_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`revenue_recognition` ADD CONSTRAINT `fk_invoice_revenue_recognition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`revenue_recognition` ADD CONSTRAINT `fk_invoice_revenue_recognition_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dunning_notice` ADD CONSTRAINT `fk_invoice_dunning_notice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`advance_payment` ADD CONSTRAINT `fk_invoice_advance_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `agriculture_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`advance_payment` ADD CONSTRAINT `fk_invoice_advance_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`advance_payment` ADD CONSTRAINT `fk_invoice_advance_payment_loan_id` FOREIGN KEY (`loan_id`) REFERENCES `agriculture_ecm`.`finance`.`loan`(`loan_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`write_off` ADD CONSTRAINT `fk_invoice_write_off_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`write_off` ADD CONSTRAINT `fk_invoice_write_off_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `agriculture_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`receivable_financing` ADD CONSTRAINT `fk_invoice_receivable_financing_financing_arrangement_id` FOREIGN KEY (`financing_arrangement_id`) REFERENCES `agriculture_ecm`.`finance`.`financing_arrangement`(`financing_arrangement_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`receivable_financing` ADD CONSTRAINT `fk_invoice_receivable_financing_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `agriculture_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`receivable_financing` ADD CONSTRAINT `fk_invoice_receivable_financing_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`receivable_financing` ADD CONSTRAINT `fk_invoice_receivable_financing_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= invoice --> inventory (15 constraint(s)) =========
-- Requires: invoice schema, inventory schema
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`credit_memo` ADD CONSTRAINT `fk_invoice_credit_memo_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`credit_memo` ADD CONSTRAINT `fk_invoice_credit_memo_inventory_goods_receipt_id` FOREIGN KEY (`inventory_goods_receipt_id`) REFERENCES `agriculture_ecm`.`inventory`.`inventory_goods_receipt`(`inventory_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`debit_memo` ADD CONSTRAINT `fk_invoice_debit_memo_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_inventory_goods_receipt_id` FOREIGN KEY (`inventory_goods_receipt_id`) REFERENCES `agriculture_ecm`.`inventory`.`inventory_goods_receipt`(`inventory_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_inventory_goods_receipt_id` FOREIGN KEY (`inventory_goods_receipt_id`) REFERENCES `agriculture_ecm`.`inventory`.`inventory_goods_receipt`(`inventory_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`revenue_recognition` ADD CONSTRAINT `fk_invoice_revenue_recognition_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_basis` ADD CONSTRAINT `fk_invoice_price_basis_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`advance_payment` ADD CONSTRAINT `fk_invoice_advance_payment_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_inventory_goods_receipt_id` FOREIGN KEY (`inventory_goods_receipt_id`) REFERENCES `agriculture_ecm`.`inventory`.`inventory_goods_receipt`(`inventory_goods_receipt_id`);

-- ========= invoice --> land (6 constraint(s)) =========
-- Requires: invoice schema, land schema
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`advance_payment` ADD CONSTRAINT `fk_invoice_advance_payment_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_lease_id` FOREIGN KEY (`lease_id`) REFERENCES `agriculture_ecm`.`land`.`lease`(`lease_id`);

-- ========= invoice --> livestock (1 constraint(s)) =========
-- Requires: invoice schema, livestock schema
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_animal_transaction_id` FOREIGN KEY (`animal_transaction_id`) REFERENCES `agriculture_ecm`.`livestock`.`animal_transaction`(`animal_transaction_id`);

-- ========= invoice --> product (16 constraint(s)) =========
-- Requires: invoice schema, product schema
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`debit_memo` ADD CONSTRAINT `fk_invoice_debit_memo_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`revenue_recognition` ADD CONSTRAINT `fk_invoice_revenue_recognition_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_basis` ADD CONSTRAINT `fk_invoice_price_basis_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_basis` ADD CONSTRAINT `fk_invoice_price_basis_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`advance_payment` ADD CONSTRAINT `fk_invoice_advance_payment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`receivable_financing` ADD CONSTRAINT `fk_invoice_receivable_financing_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= invoice --> quality (10 constraint(s)) =========
-- Requires: invoice schema, quality schema
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`credit_memo` ADD CONSTRAINT `fk_invoice_credit_memo_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`credit_memo` ADD CONSTRAINT `fk_invoice_credit_memo_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `agriculture_ecm`.`quality`.`test_result`(`test_result_id`);

-- ========= invoice --> research (7 constraint(s)) =========
-- Requires: invoice schema, research schema
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_ip_record_id` FOREIGN KEY (`ip_record_id`) REFERENCES `agriculture_ecm`.`research`.`ip_record`(`ip_record_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);

-- ========= invoice --> sales (11 constraint(s)) =========
-- Requires: invoice schema, sales schema
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`payment` ADD CONSTRAINT `fk_invoice_payment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`debit_memo` ADD CONSTRAINT `fk_invoice_debit_memo_sales_organization_id` FOREIGN KEY (`sales_organization_id`) REFERENCES `agriculture_ecm`.`sales`.`sales_organization`(`sales_organization_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`revenue_recognition` ADD CONSTRAINT `fk_invoice_revenue_recognition_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_basis` ADD CONSTRAINT `fk_invoice_price_basis_market_price_id` FOREIGN KEY (`market_price_id`) REFERENCES `agriculture_ecm`.`sales`.`market_price`(`market_price_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`advance_payment` ADD CONSTRAINT `fk_invoice_advance_payment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`receivable_financing` ADD CONSTRAINT `fk_invoice_receivable_financing_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);

-- ========= invoice --> supply (12 constraint(s)) =========
-- Requires: invoice schema, supply schema
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `agriculture_ecm`.`supply`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`invoice` ADD CONSTRAINT `fk_invoice_invoice_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`credit_memo` ADD CONSTRAINT `fk_invoice_credit_memo_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`credit_memo` ADD CONSTRAINT `fk_invoice_credit_memo_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`revenue_recognition` ADD CONSTRAINT `fk_invoice_revenue_recognition_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`revenue_recognition` ADD CONSTRAINT `fk_invoice_revenue_recognition_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_cold_chain_reading_id` FOREIGN KEY (`cold_chain_reading_id`) REFERENCES `agriculture_ecm`.`supply`.`cold_chain_reading`(`cold_chain_reading_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);

-- ========= invoice --> sustainability (10 constraint(s)) =========
-- Requires: invoice schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`credit_memo` ADD CONSTRAINT `fk_invoice_credit_memo_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`revenue_recognition` ADD CONSTRAINT `fk_invoice_revenue_recognition_carbon_credit_id` FOREIGN KEY (`carbon_credit_id`) REFERENCES `agriculture_ecm`.`sustainability`.`carbon_credit`(`carbon_credit_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_schedule` ADD CONSTRAINT `fk_invoice_billing_schedule_conservation_enrollment_id` FOREIGN KEY (`conservation_enrollment_id`) REFERENCES `agriculture_ecm`.`sustainability`.`conservation_enrollment`(`conservation_enrollment_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_basis` ADD CONSTRAINT `fk_invoice_price_basis_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`advance_payment` ADD CONSTRAINT `fk_invoice_advance_payment_conservation_enrollment_id` FOREIGN KEY (`conservation_enrollment_id`) REFERENCES `agriculture_ecm`.`sustainability`.`conservation_enrollment`(`conservation_enrollment_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_practice_adoption_id` FOREIGN KEY (`practice_adoption_id`) REFERENCES `agriculture_ecm`.`sustainability`.`practice_adoption`(`practice_adoption_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);

-- ========= invoice --> weather (14 constraint(s)) =========
-- Requires: invoice schema, weather schema
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_irrigation_schedule_id` FOREIGN KEY (`irrigation_schedule_id`) REFERENCES `agriculture_ecm`.`weather`.`irrigation_schedule`(`irrigation_schedule_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`line` ADD CONSTRAINT `fk_invoice_line_spray_window_id` FOREIGN KEY (`spray_window_id`) REFERENCES `agriculture_ecm`.`weather`.`spray_window`(`spray_window_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`credit_memo` ADD CONSTRAINT `fk_invoice_credit_memo_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`credit_memo` ADD CONSTRAINT `fk_invoice_credit_memo_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_basis` ADD CONSTRAINT `fk_invoice_price_basis_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`advance_payment` ADD CONSTRAINT `fk_invoice_advance_payment_drought_index_id` FOREIGN KEY (`drought_index_id`) REFERENCES `agriculture_ecm`.`weather`.`drought_index`(`drought_index_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`advance_payment` ADD CONSTRAINT `fk_invoice_advance_payment_planting_window_id` FOREIGN KEY (`planting_window_id`) REFERENCES `agriculture_ecm`.`weather`.`planting_window`(`planting_window_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_drought_index_id` FOREIGN KEY (`drought_index_id`) REFERENCES `agriculture_ecm`.`weather`.`drought_index`(`drought_index_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`settlement_statement` ADD CONSTRAINT `fk_invoice_settlement_statement_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`price_adjustment` ADD CONSTRAINT `fk_invoice_price_adjustment_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);

-- ========= invoice --> workforce (4 constraint(s)) =========
-- Requires: invoice schema, workforce schema
ALTER TABLE `agriculture_ecm`.`invoice`.`weight_ticket` ADD CONSTRAINT `fk_invoice_weight_ticket_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`billing_account` ADD CONSTRAINT `fk_invoice_billing_account_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dispute` ADD CONSTRAINT `fk_invoice_dispute_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`invoice`.`dunning_notice` ADD CONSTRAINT `fk_invoice_dunning_notice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= land --> compliance (7 constraint(s)) =========
-- Requires: land schema, compliance schema
ALTER TABLE `agriculture_ecm`.`land`.`use_plan` ADD CONSTRAINT `fk_land_use_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`land`.`use_plan` ADD CONSTRAINT `fk_land_use_plan_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`land`.`conservation_practice` ADD CONSTRAINT `fk_land_conservation_practice_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`land`.`conservation_practice` ADD CONSTRAINT `fk_land_conservation_practice_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`land`.`irrigation_zone` ADD CONSTRAINT `fk_land_irrigation_zone_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`land`.`easement` ADD CONSTRAINT `fk_land_easement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`land`.`easement` ADD CONSTRAINT `fk_land_easement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= land --> crop (3 constraint(s)) =========
-- Requires: land schema, crop schema
ALTER TABLE `agriculture_ecm`.`land`.`management_zone` ADD CONSTRAINT `fk_land_management_zone_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`land`.`use_plan` ADD CONSTRAINT `fk_land_use_plan_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`land`.`use_plan` ADD CONSTRAINT `fk_land_use_plan_rotation_plan_id` FOREIGN KEY (`rotation_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`rotation_plan`(`rotation_plan_id`);

-- ========= land --> customer (6 constraint(s)) =========
-- Requires: land schema, customer schema
ALTER TABLE `agriculture_ecm`.`land`.`ownership` ADD CONSTRAINT `fk_land_ownership_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`land`.`lease` ADD CONSTRAINT `fk_land_lease_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`land`.`farm_unit` ADD CONSTRAINT `fk_land_farm_unit_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`land`.`water_right` ADD CONSTRAINT `fk_land_water_right_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`land`.`land_field_operation` ADD CONSTRAINT `fk_land_land_field_operation_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);

-- ========= land --> procurement (3 constraint(s)) =========
-- Requires: land schema, procurement schema
ALTER TABLE `agriculture_ecm`.`land`.`land_soil_sample` ADD CONSTRAINT `fk_land_land_soil_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`land`.`conservation_practice` ADD CONSTRAINT `fk_land_conservation_practice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`land`.`farm_vendor_approval` ADD CONSTRAINT `fk_land_farm_vendor_approval_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= land --> product (5 constraint(s)) =========
-- Requires: land schema, product schema
ALTER TABLE `agriculture_ecm`.`land`.`use_plan` ADD CONSTRAINT `fk_land_use_plan_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`land`.`use_plan` ADD CONSTRAINT `fk_land_use_plan_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`land`.`use_plan` ADD CONSTRAINT `fk_land_use_plan_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`land`.`farm_unit` ADD CONSTRAINT `fk_land_farm_unit_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`land`.`field_input_restriction` ADD CONSTRAINT `fk_land_field_input_restriction_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);

-- ========= land --> supply (1 constraint(s)) =========
-- Requires: land schema, supply schema
ALTER TABLE `agriculture_ecm`.`land`.`farm_operation` ADD CONSTRAINT `fk_land_farm_operation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

-- ========= land --> sustainability (1 constraint(s)) =========
-- Requires: land schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`land`.`field_certification_scope` ADD CONSTRAINT `fk_land_field_certification_scope_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);

-- ========= land --> weather (4 constraint(s)) =========
-- Requires: land schema, weather schema
ALTER TABLE `agriculture_ecm`.`land`.`field` ADD CONSTRAINT `fk_land_field_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`land`.`irrigation_zone` ADD CONSTRAINT `fk_land_irrigation_zone_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`land`.`farm_unit` ADD CONSTRAINT `fk_land_farm_unit_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`land`.`water_right` ADD CONSTRAINT `fk_land_water_right_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);

-- ========= land --> workforce (2 constraint(s)) =========
-- Requires: land schema, workforce schema
ALTER TABLE `agriculture_ecm`.`land`.`farm_unit` ADD CONSTRAINT `fk_land_farm_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`land`.`farm_operation` ADD CONSTRAINT `fk_land_farm_operation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= livestock --> compliance (18 constraint(s)) =========
-- Requires: livestock schema, compliance schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_ration` ADD CONSTRAINT `fk_livestock_feed_ration_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_violation_record_id` FOREIGN KEY (`violation_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`violation_record`(`violation_record_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_welfare_assessment` ADD CONSTRAINT `fk_livestock_animal_welfare_assessment_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_welfare_assessment` ADD CONSTRAINT `fk_livestock_animal_welfare_assessment_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`semen_inventory` ADD CONSTRAINT `fk_livestock_semen_inventory_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`veterinary_prescription` ADD CONSTRAINT `fk_livestock_veterinary_prescription_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`production_group` ADD CONSTRAINT `fk_livestock_production_group_organic_compliance_record_id` FOREIGN KEY (`organic_compliance_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`organic_compliance_record`(`organic_compliance_record_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_protocol` ADD CONSTRAINT `fk_livestock_health_protocol_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_protocol` ADD CONSTRAINT `fk_livestock_health_protocol_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);

-- ========= livestock --> customer (5 constraint(s)) =========
-- Requires: livestock schema, customer schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);

-- ========= livestock --> equipment (6 constraint(s)) =========
-- Requires: livestock schema, equipment schema
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`weight_measurement` ADD CONSTRAINT `fk_livestock_weight_measurement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`semen_inventory` ADD CONSTRAINT `fk_livestock_semen_inventory_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= livestock --> finance (11 constraint(s)) =========
-- Requires: livestock schema, finance schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_finance_ap_invoice_id` FOREIGN KEY (`finance_ap_invoice_id`) REFERENCES `agriculture_ecm`.`finance`.`finance_ap_invoice`(`finance_ap_invoice_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`production_group` ADD CONSTRAINT `fk_livestock_production_group_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`production_group` ADD CONSTRAINT `fk_livestock_production_group_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= livestock --> inventory (5 constraint(s)) =========
-- Requires: livestock schema, inventory schema
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`ration_ingredient` ADD CONSTRAINT `fk_livestock_ration_ingredient_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);

-- ========= livestock --> invoice (5 constraint(s)) =========
-- Requires: livestock schema, invoice schema
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `agriculture_ecm`.`invoice`.`invoice`(`invoice_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `agriculture_ecm`.`invoice`.`invoice`(`invoice_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `agriculture_ecm`.`invoice`.`billing_account`(`billing_account_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `agriculture_ecm`.`invoice`.`weight_ticket`(`weight_ticket_id`);

-- ========= livestock --> land (4 constraint(s)) =========
-- Requires: livestock schema, land schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`pen_location` ADD CONSTRAINT `fk_livestock_pen_location_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`production_group` ADD CONSTRAINT `fk_livestock_production_group_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);

-- ========= livestock --> procurement (9 constraint(s)) =========
-- Requires: livestock schema, procurement schema
ALTER TABLE `agriculture_ecm`.`livestock`.`animal` ADD CONSTRAINT `fk_livestock_animal_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal` ADD CONSTRAINT `fk_livestock_animal_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`semen_inventory` ADD CONSTRAINT `fk_livestock_semen_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`genomic_test` ADD CONSTRAINT `fk_livestock_genomic_test_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`protocol_drug_authorization` ADD CONSTRAINT `fk_livestock_protocol_drug_authorization_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);

-- ========= livestock --> product (10 constraint(s)) =========
-- Requires: livestock schema, product schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_livestock_product_id` FOREIGN KEY (`livestock_product_id`) REFERENCES `agriculture_ecm`.`product`.`livestock_product`(`livestock_product_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`veterinary_prescription` ADD CONSTRAINT `fk_livestock_veterinary_prescription_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`production_group` ADD CONSTRAINT `fk_livestock_production_group_livestock_product_id` FOREIGN KEY (`livestock_product_id`) REFERENCES `agriculture_ecm`.`product`.`livestock_product`(`livestock_product_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`production_group` ADD CONSTRAINT `fk_livestock_production_group_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_livestock_product_id` FOREIGN KEY (`livestock_product_id`) REFERENCES `agriculture_ecm`.`product`.`livestock_product`(`livestock_product_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_protocol` ADD CONSTRAINT `fk_livestock_health_protocol_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);

-- ========= livestock --> quality (12 constraint(s)) =========
-- Requires: livestock schema, quality schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_quality_audit_id` FOREIGN KEY (`quality_audit_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_audit`(`quality_audit_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_hold_record_id` FOREIGN KEY (`hold_record_id`) REFERENCES `agriculture_ecm`.`quality`.`hold_record`(`hold_record_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_ration` ADD CONSTRAINT `fk_livestock_feed_ration_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`semen_inventory` ADD CONSTRAINT `fk_livestock_semen_inventory_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`genomic_test` ADD CONSTRAINT `fk_livestock_genomic_test_lab_sample_id` FOREIGN KEY (`lab_sample_id`) REFERENCES `agriculture_ecm`.`quality`.`lab_sample`(`lab_sample_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_hold` ADD CONSTRAINT `fk_livestock_animal_hold_hold_record_id` FOREIGN KEY (`hold_record_id`) REFERENCES `agriculture_ecm`.`quality`.`hold_record`(`hold_record_id`);

-- ========= livestock --> research (8 constraint(s)) =========
-- Requires: livestock schema, research schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_program_id` FOREIGN KEY (`program_id`) REFERENCES `agriculture_ecm`.`research`.`program`(`program_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_ration` ADD CONSTRAINT `fk_livestock_feed_ration_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_welfare_assessment` ADD CONSTRAINT `fk_livestock_animal_welfare_assessment_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`production_group` ADD CONSTRAINT `fk_livestock_production_group_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`genomic_test` ADD CONSTRAINT `fk_livestock_genomic_test_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);

-- ========= livestock --> sales (7 constraint(s)) =========
-- Requires: livestock schema, sales schema
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_origin_declaration_id` FOREIGN KEY (`origin_declaration_id`) REFERENCES `agriculture_ecm`.`sales`.`origin_declaration`(`origin_declaration_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `agriculture_ecm`.`sales`.`broker`(`broker_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_price_agreement_id` FOREIGN KEY (`price_agreement_id`) REFERENCES `agriculture_ecm`.`sales`.`price_agreement`(`price_agreement_id`);

-- ========= livestock --> supply (32 constraint(s)) =========
-- Requires: livestock schema, supply schema
ALTER TABLE `agriculture_ecm`.`livestock`.`animal` ADD CONSTRAINT `fk_livestock_animal_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_premises_facility_id` FOREIGN KEY (`premises_facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`pen_location` ADD CONSTRAINT `fk_livestock_pen_location_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`parturition_record` ADD CONSTRAINT `fk_livestock_parturition_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`weight_measurement` ADD CONSTRAINT `fk_livestock_weight_measurement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_bill_of_lading_id` FOREIGN KEY (`bill_of_lading_id`) REFERENCES `agriculture_ecm`.`supply`.`bill_of_lading`(`bill_of_lading_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `agriculture_ecm`.`supply`.`carrier`(`carrier_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_destination_location_facility_id` FOREIGN KEY (`destination_location_facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_destination_premises_facility_id` FOREIGN KEY (`destination_premises_facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_primary_animal_facility_id` FOREIGN KEY (`primary_animal_facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_transport_order_id` FOREIGN KEY (`transport_order_id`) REFERENCES `agriculture_ecm`.`supply`.`transport_order`(`transport_order_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_welfare_assessment` ADD CONSTRAINT `fk_livestock_animal_welfare_assessment_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`semen_inventory` ADD CONSTRAINT `fk_livestock_semen_inventory_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`production_group` ADD CONSTRAINT `fk_livestock_production_group_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`production_group` ADD CONSTRAINT `fk_livestock_production_group_premises_facility_id` FOREIGN KEY (`premises_facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `agriculture_ecm`.`supply`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`bulk_tank` ADD CONSTRAINT `fk_livestock_bulk_tank_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`semen_canister` ADD CONSTRAINT `fk_livestock_semen_canister_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

-- ========= livestock --> sustainability (6 constraint(s)) =========
-- Requires: livestock schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_ration` ADD CONSTRAINT `fk_livestock_feed_ration_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_welfare_assessment` ADD CONSTRAINT `fk_livestock_animal_welfare_assessment_sustainability_audit_id` FOREIGN KEY (`sustainability_audit_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_audit`(`sustainability_audit_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_welfare_assessment` ADD CONSTRAINT `fk_livestock_animal_welfare_assessment_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_deforestation_risk_id` FOREIGN KEY (`deforestation_risk_id`) REFERENCES `agriculture_ecm`.`sustainability`.`deforestation_risk`(`deforestation_risk_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`production_group` ADD CONSTRAINT `fk_livestock_production_group_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);

-- ========= livestock --> weather (14 constraint(s)) =========
-- Requires: livestock schema, weather schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_drought_index_id` FOREIGN KEY (`drought_index_id`) REFERENCES `agriculture_ecm`.`weather`.`drought_index`(`drought_index_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_station_id` FOREIGN KEY (`station_id`) REFERENCES `agriculture_ecm`.`weather`.`station`(`station_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`pen_location` ADD CONSTRAINT `fk_livestock_pen_location_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`pen_location` ADD CONSTRAINT `fk_livestock_pen_location_station_id` FOREIGN KEY (`station_id`) REFERENCES `agriculture_ecm`.`weather`.`station`(`station_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`parturition_record` ADD CONSTRAINT `fk_livestock_parturition_record_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_treatment` ADD CONSTRAINT `fk_livestock_health_treatment_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`weight_measurement` ADD CONSTRAINT `fk_livestock_weight_measurement_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_welfare_assessment` ADD CONSTRAINT `fk_livestock_animal_welfare_assessment_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);

-- ========= livestock --> workforce (21 constraint(s)) =========
-- Requires: livestock schema, workforce schema
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`herd` ADD CONSTRAINT `fk_livestock_herd_herd_veterinarian_employee_id` FOREIGN KEY (`herd_veterinarian_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`breeding_event` ADD CONSTRAINT `fk_livestock_breeding_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`parturition_record` ADD CONSTRAINT `fk_livestock_parturition_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`vaccination_record` ADD CONSTRAINT `fk_livestock_vaccination_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`weight_measurement` ADD CONSTRAINT `fk_livestock_weight_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_ration` ADD CONSTRAINT `fk_livestock_feed_ration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`feed_delivery` ADD CONSTRAINT `fk_livestock_feed_delivery_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_movement` ADD CONSTRAINT `fk_livestock_animal_movement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_disposition` ADD CONSTRAINT `fk_livestock_animal_disposition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_welfare_assessment` ADD CONSTRAINT `fk_livestock_animal_welfare_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`veterinary_prescription` ADD CONSTRAINT `fk_livestock_veterinary_prescription_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`animal_transaction` ADD CONSTRAINT `fk_livestock_animal_transaction_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`production_group` ADD CONSTRAINT `fk_livestock_production_group_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`milk_production_record` ADD CONSTRAINT `fk_livestock_milk_production_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`health_protocol` ADD CONSTRAINT `fk_livestock_health_protocol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`livestock`.`genomic_test` ADD CONSTRAINT `fk_livestock_genomic_test_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= procurement --> compliance (8 constraint(s)) =========
-- Requires: procurement schema, compliance schema
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_license_id` FOREIGN KEY (`license_id`) REFERENCES `agriculture_ecm`.`compliance`.`license`(`license_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_organic_compliance_record_id` FOREIGN KEY (`organic_compliance_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`organic_compliance_record`(`organic_compliance_record_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`chemical_compliance` ADD CONSTRAINT `fk_procurement_chemical_compliance_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_regulatory_finding_id` FOREIGN KEY (`regulatory_finding_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_finding`(`regulatory_finding_id`);

-- ========= procurement --> crop (4 constraint(s)) =========
-- Requires: procurement schema, crop schema
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_loss_event_id` FOREIGN KEY (`loss_event_id`) REFERENCES `agriculture_ecm`.`crop`.`loss_event`(`loss_event_id`);

-- ========= procurement --> customer (1 constraint(s)) =========
-- Requires: procurement schema, customer schema
ALTER TABLE `agriculture_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_preference_id` FOREIGN KEY (`preference_id`) REFERENCES `agriculture_ecm`.`customer`.`preference`(`preference_id`);

-- ========= procurement --> finance (16 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `agriculture_ecm`.`finance`.`capital_project`(`capital_project_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`input_catalog` ADD CONSTRAINT `fk_procurement_input_catalog_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchasing_group` ADD CONSTRAINT `fk_procurement_purchasing_group_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);

-- ========= procurement --> inventory (12 constraint(s)) =========
-- Requires: procurement schema, inventory schema
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_inventory_goods_receipt_id` FOREIGN KEY (`inventory_goods_receipt_id`) REFERENCES `agriculture_ecm`.`inventory`.`inventory_goods_receipt`(`inventory_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_quarantine_hold_id` FOREIGN KEY (`quarantine_hold_id`) REFERENCES `agriculture_ecm`.`inventory`.`quarantine_hold`(`quarantine_hold_id`);

-- ========= procurement --> invoice (6 constraint(s)) =========
-- Requires: procurement schema, invoice schema
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `agriculture_ecm`.`invoice`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `agriculture_ecm`.`invoice`.`weight_ticket`(`weight_ticket_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_price_adjustment_id` FOREIGN KEY (`price_adjustment_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_adjustment`(`price_adjustment_id`);

-- ========= procurement --> land (6 constraint(s)) =========
-- Requires: procurement schema, land schema
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);

-- ========= procurement --> product (38 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`input_catalog` ADD CONSTRAINT `fk_procurement_input_catalog_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`input_catalog` ADD CONSTRAINT `fk_procurement_input_catalog_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`input_catalog` ADD CONSTRAINT `fk_procurement_input_catalog_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`chemical_compliance` ADD CONSTRAINT `fk_procurement_chemical_compliance_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_product_approval` ADD CONSTRAINT `fk_procurement_vendor_product_approval_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_commodity_approval` ADD CONSTRAINT `fk_procurement_vendor_commodity_approval_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= procurement --> quality (4 constraint(s)) =========
-- Requires: procurement schema, quality schema
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_hold_record_id` FOREIGN KEY (`hold_record_id`) REFERENCES `agriculture_ecm`.`quality`.`hold_record`(`hold_record_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_test_result_id` FOREIGN KEY (`test_result_id`) REFERENCES `agriculture_ecm`.`quality`.`test_result`(`test_result_id`);

-- ========= procurement --> supply (6 constraint(s)) =========
-- Requires: procurement schema, supply schema
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `agriculture_ecm`.`supply`.`plant`(`plant_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_inbound_plan_id` FOREIGN KEY (`inbound_plan_id`) REFERENCES `agriculture_ecm`.`supply`.`inbound_plan`(`inbound_plan_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchasing_group` ADD CONSTRAINT `fk_procurement_purchasing_group_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `agriculture_ecm`.`supply`.`plant`(`plant_id`);

-- ========= procurement --> sustainability (7 constraint(s)) =========
-- Requires: procurement schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_supplier_sustainability_id` FOREIGN KEY (`supplier_sustainability_id`) REFERENCES `agriculture_ecm`.`sustainability`.`supplier_sustainability`(`supplier_sustainability_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `agriculture_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`input_catalog` ADD CONSTRAINT `fk_procurement_input_catalog_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `agriculture_ecm`.`sustainability`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_audit` ADD CONSTRAINT `fk_procurement_vendor_audit_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `agriculture_ecm`.`sustainability`.`environmental_incident`(`environmental_incident_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);

-- ========= procurement --> weather (8 constraint(s)) =========
-- Requires: procurement schema, weather schema
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_drought_index_id` FOREIGN KEY (`drought_index_id`) REFERENCES `agriculture_ecm`.`weather`.`drought_index`(`drought_index_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `agriculture_ecm`.`weather`.`forecast`(`forecast_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `agriculture_ecm`.`weather`.`forecast`(`forecast_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `agriculture_ecm`.`weather`.`forecast`(`forecast_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_planting_window_id` FOREIGN KEY (`planting_window_id`) REFERENCES `agriculture_ecm`.`weather`.`planting_window`(`planting_window_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);

-- ========= procurement --> workforce (12 constraint(s)) =========
-- Requires: procurement schema, workforce schema
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_contract` ADD CONSTRAINT `fk_procurement_vendor_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_quotation` ADD CONSTRAINT `fk_procurement_vendor_quotation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`procurement_ap_invoice` ADD CONSTRAINT `fk_procurement_procurement_ap_invoice_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`vendor_audit` ADD CONSTRAINT `fk_procurement_vendor_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`budget` ADD CONSTRAINT `fk_procurement_budget_budget_employee_id` FOREIGN KEY (`budget_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`return_claim` ADD CONSTRAINT `fk_procurement_return_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`procurement`.`purchasing_group` ADD CONSTRAINT `fk_procurement_purchasing_group_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `agriculture_ecm`.`workforce`.`org_unit`(`org_unit_id`);

-- ========= product --> compliance (7 constraint(s)) =========
-- Requires: product schema, compliance schema
ALTER TABLE `agriculture_ecm`.`product`.`seed_variety` ADD CONSTRAINT `fk_product_seed_variety_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`product`.`organic_certification` ADD CONSTRAINT `fk_product_organic_certification_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `agriculture_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `agriculture_ecm`.`product`.`gmo_declaration` ADD CONSTRAINT `fk_product_gmo_declaration_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`product`.`gmo_declaration` ADD CONSTRAINT `fk_product_gmo_declaration_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);
ALTER TABLE `agriculture_ecm`.`product`.`product_certification` ADD CONSTRAINT `fk_product_product_certification_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `agriculture_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `agriculture_ecm`.`product`.`regulatory_status` ADD CONSTRAINT `fk_product_regulatory_status_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`product`.`regulatory_status` ADD CONSTRAINT `fk_product_regulatory_status_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);

-- ========= product --> customer (1 constraint(s)) =========
-- Requires: product schema, customer schema
ALTER TABLE `agriculture_ecm`.`product`.`bundle` ADD CONSTRAINT `fk_product_bundle_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `agriculture_ecm`.`customer`.`segment`(`segment_id`);

-- ========= product --> procurement (1 constraint(s)) =========
-- Requires: product schema, procurement schema
ALTER TABLE `agriculture_ecm`.`product`.`seed_supply_agreement` ADD CONSTRAINT `fk_product_seed_supply_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= product --> research (5 constraint(s)) =========
-- Requires: product schema, research schema
ALTER TABLE `agriculture_ecm`.`product`.`master` ADD CONSTRAINT `fk_product_master_program_id` FOREIGN KEY (`program_id`) REFERENCES `agriculture_ecm`.`research`.`program`(`program_id`);
ALTER TABLE `agriculture_ecm`.`product`.`seed_variety` ADD CONSTRAINT `fk_product_seed_variety_breeding_pipeline_id` FOREIGN KEY (`breeding_pipeline_id`) REFERENCES `agriculture_ecm`.`research`.`breeding_pipeline`(`breeding_pipeline_id`);
ALTER TABLE `agriculture_ecm`.`product`.`seed_variety` ADD CONSTRAINT `fk_product_seed_variety_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`product`.`gmo_declaration` ADD CONSTRAINT `fk_product_gmo_declaration_trait_evaluation_id` FOREIGN KEY (`trait_evaluation_id`) REFERENCES `agriculture_ecm`.`research`.`trait_evaluation`(`trait_evaluation_id`);
ALTER TABLE `agriculture_ecm`.`product`.`regulatory_status` ADD CONSTRAINT `fk_product_regulatory_status_biotech_submission_id` FOREIGN KEY (`biotech_submission_id`) REFERENCES `agriculture_ecm`.`research`.`biotech_submission`(`biotech_submission_id`);

-- ========= product --> sales (2 constraint(s)) =========
-- Requires: product schema, sales schema
ALTER TABLE `agriculture_ecm`.`product`.`substitution_rule` ADD CONSTRAINT `fk_product_substitution_rule_sales_organization_id` FOREIGN KEY (`sales_organization_id`) REFERENCES `agriculture_ecm`.`sales`.`sales_organization`(`sales_organization_id`);
ALTER TABLE `agriculture_ecm`.`product`.`commodity_broker_authorization` ADD CONSTRAINT `fk_product_commodity_broker_authorization_broker_id` FOREIGN KEY (`broker_id`) REFERENCES `agriculture_ecm`.`sales`.`broker`(`broker_id`);

-- ========= product --> supply (2 constraint(s)) =========
-- Requires: product schema, supply schema
ALTER TABLE `agriculture_ecm`.`product`.`substitution_rule` ADD CONSTRAINT `fk_product_substitution_rule_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`product`.`transformation_event` ADD CONSTRAINT `fk_product_transformation_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

-- ========= product --> sustainability (10 constraint(s)) =========
-- Requires: product schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`product`.`agrochemical_product` ADD CONSTRAINT `fk_product_agrochemical_product_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`product`.`seed_variety` ADD CONSTRAINT `fk_product_seed_variety_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`product`.`livestock_product` ADD CONSTRAINT `fk_product_livestock_product_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`product`.`processed_good` ADD CONSTRAINT `fk_product_processed_good_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`product`.`input_product` ADD CONSTRAINT `fk_product_input_product_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `agriculture_ecm`.`sustainability`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `agriculture_ecm`.`product`.`input_product` ADD CONSTRAINT `fk_product_input_product_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`product`.`gmo_declaration` ADD CONSTRAINT `fk_product_gmo_declaration_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`product`.`label` ADD CONSTRAINT `fk_product_label_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`product`.`product_certification` ADD CONSTRAINT `fk_product_product_certification_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`product`.`agrochemical_practice_compatibility` ADD CONSTRAINT `fk_product_agrochemical_practice_compatibility_regenerative_practice_id` FOREIGN KEY (`regenerative_practice_id`) REFERENCES `agriculture_ecm`.`sustainability`.`regenerative_practice`(`regenerative_practice_id`);

-- ========= product --> workforce (1 constraint(s)) =========
-- Requires: product schema, workforce schema
ALTER TABLE `agriculture_ecm`.`product`.`transformation_event` ADD CONSTRAINT `fk_product_transformation_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= quality --> compliance (20 constraint(s)) =========
-- Requires: quality schema, compliance schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_event_id` FOREIGN KEY (`event_id`) REFERENCES `agriculture_ecm`.`compliance`.`event`(`event_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_document_id` FOREIGN KEY (`document_id`) REFERENCES `agriculture_ecm`.`compliance`.`document`(`document_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `agriculture_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`facility_monitoring` ADD CONSTRAINT `fk_quality_facility_monitoring_permit_condition_id` FOREIGN KEY (`permit_condition_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit_condition`(`permit_condition_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`facility_monitoring` ADD CONSTRAINT `fk_quality_facility_monitoring_worker_protection_record_id` FOREIGN KEY (`worker_protection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`worker_protection_record`(`worker_protection_record_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `agriculture_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `agriculture_ecm`.`compliance`.`recall_event`(`recall_event_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`regulatory_submission` ADD CONSTRAINT `fk_quality_regulatory_submission_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`regulatory_submission` ADD CONSTRAINT `fk_quality_regulatory_submission_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);

-- ========= quality --> customer (4 constraint(s)) =========
-- Requires: quality schema, customer schema
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_case_id` FOREIGN KEY (`case_id`) REFERENCES `agriculture_ecm`.`customer`.`case`(`case_id`);

-- ========= quality --> equipment (1 constraint(s)) =========
-- Requires: quality schema, equipment schema
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= quality --> finance (13 constraint(s)) =========
-- Requires: quality schema, finance schema
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`facility_monitoring` ADD CONSTRAINT `fk_quality_facility_monitoring_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`regulatory_submission` ADD CONSTRAINT `fk_quality_regulatory_submission_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`regulatory_submission` ADD CONSTRAINT `fk_quality_regulatory_submission_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= quality --> inventory (9 constraint(s)) =========
-- Requires: quality schema, inventory schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`facility_monitoring` ADD CONSTRAINT `fk_quality_facility_monitoring_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`regulatory_submission` ADD CONSTRAINT `fk_quality_regulatory_submission_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);

-- ========= quality --> land (17 constraint(s)) =========
-- Requires: quality schema, land schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_land_soil_sample_id` FOREIGN KEY (`land_soil_sample_id`) REFERENCES `agriculture_ecm`.`land`.`land_soil_sample`(`land_soil_sample_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`regulatory_submission` ADD CONSTRAINT `fk_quality_regulatory_submission_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`regulatory_submission` ADD CONSTRAINT `fk_quality_regulatory_submission_water_right_id` FOREIGN KEY (`water_right_id`) REFERENCES `agriculture_ecm`.`land`.`water_right`(`water_right_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_irrigation_zone_id` FOREIGN KEY (`irrigation_zone_id`) REFERENCES `agriculture_ecm`.`land`.`irrigation_zone`(`irrigation_zone_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_water_right_id` FOREIGN KEY (`water_right_id`) REFERENCES `agriculture_ecm`.`land`.`water_right`(`water_right_id`);

-- ========= quality --> livestock (1 constraint(s)) =========
-- Requires: quality schema, livestock schema
ALTER TABLE `agriculture_ecm`.`quality`.`facility_monitoring` ADD CONSTRAINT `fk_quality_facility_monitoring_pen_location_id` FOREIGN KEY (`pen_location_id`) REFERENCES `agriculture_ecm`.`livestock`.`pen_location`(`pen_location_id`);

-- ========= quality --> procurement (12 constraint(s)) =========
-- Requires: quality schema, procurement schema
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_vendor_audit_id` FOREIGN KEY (`vendor_audit_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_audit`(`vendor_audit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_vendor_audit_id` FOREIGN KEY (`vendor_audit_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_audit`(`vendor_audit_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= quality --> product (21 constraint(s)) =========
-- Requires: quality schema, product schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`certificate_of_analysis` ADD CONSTRAINT `fk_quality_certificate_of_analysis_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_livestock_product_id` FOREIGN KEY (`livestock_product_id`) REFERENCES `agriculture_ecm`.`product`.`livestock_product`(`livestock_product_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_processed_good_id` FOREIGN KEY (`processed_good_id`) REFERENCES `agriculture_ecm`.`product`.`processed_good`(`processed_good_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`facility_monitoring` ADD CONSTRAINT `fk_quality_facility_monitoring_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`regulatory_submission` ADD CONSTRAINT `fk_quality_regulatory_submission_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);

-- ========= quality --> research (6 constraint(s)) =========
-- Requires: quality schema, research schema
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_trial_site_id` FOREIGN KEY (`trial_site_id`) REFERENCES `agriculture_ecm`.`research`.`trial_site`(`trial_site_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_cooperator_id` FOREIGN KEY (`cooperator_id`) REFERENCES `agriculture_ecm`.`research`.`cooperator`(`cooperator_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`regulatory_submission` ADD CONSTRAINT `fk_quality_regulatory_submission_biotech_submission_id` FOREIGN KEY (`biotech_submission_id`) REFERENCES `agriculture_ecm`.`research`.`biotech_submission`(`biotech_submission_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);

-- ========= quality --> supply (14 constraint(s)) =========
-- Requires: quality schema, supply schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`facility_monitoring` ADD CONSTRAINT `fk_quality_facility_monitoring_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`regulatory_submission` ADD CONSTRAINT `fk_quality_regulatory_submission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`sample_site` ADD CONSTRAINT `fk_quality_sample_site_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

-- ========= quality --> sustainability (8 constraint(s)) =========
-- Requires: quality schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_certification` ADD CONSTRAINT `fk_quality_quality_certification_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_supplier_sustainability_id` FOREIGN KEY (`supplier_sustainability_id`) REFERENCES `agriculture_ecm`.`sustainability`.`supplier_sustainability`(`supplier_sustainability_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`regulatory_submission` ADD CONSTRAINT `fk_quality_regulatory_submission_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `agriculture_ecm`.`sustainability`.`environmental_incident`(`environmental_incident_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `agriculture_ecm`.`sustainability`.`environmental_incident`(`environmental_incident_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_water_stewardship_plan_id` FOREIGN KEY (`water_stewardship_plan_id`) REFERENCES `agriculture_ecm`.`sustainability`.`water_stewardship_plan`(`water_stewardship_plan_id`);

-- ========= quality --> weather (14 constraint(s)) =========
-- Requires: quality schema, weather schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_spray_window_id` FOREIGN KEY (`spray_window_id`) REFERENCES `agriculture_ecm`.`weather`.`spray_window`(`spray_window_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`nonconformance` ADD CONSTRAINT `fk_quality_nonconformance_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_spray_window_id` FOREIGN KEY (`spray_window_id`) REFERENCES `agriculture_ecm`.`weather`.`spray_window`(`spray_window_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`facility_monitoring` ADD CONSTRAINT `fk_quality_facility_monitoring_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`facility_monitoring` ADD CONSTRAINT `fk_quality_facility_monitoring_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`regulatory_submission` ADD CONSTRAINT `fk_quality_regulatory_submission_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);

-- ========= quality --> workforce (21 constraint(s)) =========
-- Requires: quality schema, workforce schema
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection` ADD CONSTRAINT `fk_quality_inspection_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_finding` ADD CONSTRAINT `fk_quality_inspection_finding_safety_event_id` FOREIGN KEY (`safety_event_id`) REFERENCES `agriculture_ecm`.`workforce`.`safety_event`(`safety_event_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_training_event_id` FOREIGN KEY (`training_event_id`) REFERENCES `agriculture_ecm`.`workforce`.`training_event`(`training_event_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`lab_sample` ADD CONSTRAINT `fk_quality_lab_sample_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`test_result` ADD CONSTRAINT `fk_quality_test_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`haccp_plan` ADD CONSTRAINT `fk_quality_haccp_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`quality_audit` ADD CONSTRAINT `fk_quality_quality_audit_workforce_certification_id` FOREIGN KEY (`workforce_certification_id`) REFERENCES `agriculture_ecm`.`workforce`.`workforce_certification`(`workforce_certification_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`facility_monitoring` ADD CONSTRAINT `fk_quality_facility_monitoring_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`facility_monitoring` ADD CONSTRAINT `fk_quality_facility_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`supplier_assessment` ADD CONSTRAINT `fk_quality_supplier_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`hold_record` ADD CONSTRAINT `fk_quality_hold_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`regulatory_submission` ADD CONSTRAINT `fk_quality_regulatory_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`environmental_monitoring` ADD CONSTRAINT `fk_quality_environmental_monitoring_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_approved_by_employee_id` FOREIGN KEY (`approved_by_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `agriculture_ecm`.`workforce`.`plan`(`plan_id`);

-- ========= research --> compliance (12 constraint(s)) =========
-- Requires: research schema, compliance schema
ALTER TABLE `agriculture_ecm`.`research`.`trial` ADD CONSTRAINT `fk_research_trial_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trait_evaluation` ADD CONSTRAINT `fk_research_trait_evaluation_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`research`.`ip_record` ADD CONSTRAINT `fk_research_ip_record_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`research`.`program` ADD CONSTRAINT `fk_research_program_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`research`.`program` ADD CONSTRAINT `fk_research_program_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_site` ADD CONSTRAINT `fk_research_trial_site_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`research`.`biotech_submission` ADD CONSTRAINT `fk_research_biotech_submission_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `agriculture_ecm`.`research`.`biotech_submission` ADD CONSTRAINT `fk_research_biotech_submission_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`research`.`precision_ag_pilot` ADD CONSTRAINT `fk_research_precision_ag_pilot_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_protocol` ADD CONSTRAINT `fk_research_trial_protocol_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `agriculture_ecm`.`research`.`accession` ADD CONSTRAINT `fk_research_accession_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`research`.`breeding_pipeline` ADD CONSTRAINT `fk_research_breeding_pipeline_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);

-- ========= research --> crop (11 constraint(s)) =========
-- Requires: research schema, crop schema
ALTER TABLE `agriculture_ecm`.`research`.`trial_plot` ADD CONSTRAINT `fk_research_trial_plot_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_plot` ADD CONSTRAINT `fk_research_trial_plot_seed_lot_id` FOREIGN KEY (`seed_lot_id`) REFERENCES `agriculture_ecm`.`crop`.`seed_lot`(`seed_lot_id`);
ALTER TABLE `agriculture_ecm`.`research`.`yield_measurement` ADD CONSTRAINT `fk_research_yield_measurement_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`research`.`yield_measurement` ADD CONSTRAINT `fk_research_yield_measurement_seed_lot_id` FOREIGN KEY (`seed_lot_id`) REFERENCES `agriculture_ecm`.`crop`.`seed_lot`(`seed_lot_id`);
ALTER TABLE `agriculture_ecm`.`research`.`research_soil_sample` ADD CONSTRAINT `fk_research_research_soil_sample_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`research`.`ipm_study` ADD CONSTRAINT `fk_research_ipm_study_scouting_observation_id` FOREIGN KEY (`scouting_observation_id`) REFERENCES `agriculture_ecm`.`crop`.`scouting_observation`(`scouting_observation_id`);
ALTER TABLE `agriculture_ecm`.`research`.`performance_benchmark` ADD CONSTRAINT `fk_research_performance_benchmark_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`research`.`precision_ag_pilot` ADD CONSTRAINT `fk_research_precision_ag_pilot_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`research`.`precision_ag_pilot` ADD CONSTRAINT `fk_research_precision_ag_pilot_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`research`.`telemetry_event` ADD CONSTRAINT `fk_research_telemetry_event_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`research`.`telemetry_event` ADD CONSTRAINT `fk_research_telemetry_event_vra_prescription_id` FOREIGN KEY (`vra_prescription_id`) REFERENCES `agriculture_ecm`.`crop`.`vra_prescription`(`vra_prescription_id`);

-- ========= research --> customer (6 constraint(s)) =========
-- Requires: research schema, customer schema
ALTER TABLE `agriculture_ecm`.`research`.`ip_record` ADD CONSTRAINT `fk_research_ip_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`research`.`performance_benchmark` ADD CONSTRAINT `fk_research_performance_benchmark_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `agriculture_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `agriculture_ecm`.`research`.`precision_ag_pilot` ADD CONSTRAINT `fk_research_precision_ag_pilot_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`research`.`cooperator` ADD CONSTRAINT `fk_research_cooperator_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`research`.`cooperator` ADD CONSTRAINT `fk_research_cooperator_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`research`.`variety_license` ADD CONSTRAINT `fk_research_variety_license_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);

-- ========= research --> equipment (8 constraint(s)) =========
-- Requires: research schema, equipment schema
ALTER TABLE `agriculture_ecm`.`research`.`trial_observation` ADD CONSTRAINT `fk_research_trial_observation_precision_device_id` FOREIGN KEY (`precision_device_id`) REFERENCES `agriculture_ecm`.`equipment`.`precision_device`(`precision_device_id`);
ALTER TABLE `agriculture_ecm`.`research`.`yield_measurement` ADD CONSTRAINT `fk_research_yield_measurement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`research`.`yield_measurement` ADD CONSTRAINT `fk_research_yield_measurement_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);
ALTER TABLE `agriculture_ecm`.`research`.`precision_ag_pilot` ADD CONSTRAINT `fk_research_precision_ag_pilot_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`research`.`telemetry_event` ADD CONSTRAINT `fk_research_telemetry_event_precision_device_id` FOREIGN KEY (`precision_device_id`) REFERENCES `agriculture_ecm`.`equipment`.`precision_device`(`precision_device_id`);
ALTER TABLE `agriculture_ecm`.`research`.`input_usage` ADD CONSTRAINT `fk_research_input_usage_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= research --> finance (7 constraint(s)) =========
-- Requires: research schema, finance schema
ALTER TABLE `agriculture_ecm`.`research`.`trial` ADD CONSTRAINT `fk_research_trial_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`research`.`ip_record` ADD CONSTRAINT `fk_research_ip_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`research`.`ip_record` ADD CONSTRAINT `fk_research_ip_record_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `agriculture_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `agriculture_ecm`.`research`.`program` ADD CONSTRAINT `fk_research_program_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`research`.`precision_ag_pilot` ADD CONSTRAINT `fk_research_precision_ag_pilot_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`research`.`input_usage` ADD CONSTRAINT `fk_research_input_usage_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= research --> inventory (9 constraint(s)) =========
-- Requires: research schema, inventory schema
ALTER TABLE `agriculture_ecm`.`research`.`yield_measurement` ADD CONSTRAINT `fk_research_yield_measurement_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `agriculture_ecm`.`inventory`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_inventory_drawdown_goods_issue_id` FOREIGN KEY (`inventory_drawdown_goods_issue_id`) REFERENCES `agriculture_ecm`.`inventory`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`research`.`input_usage` ADD CONSTRAINT `fk_research_input_usage_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`research`.`input_usage` ADD CONSTRAINT `fk_research_input_usage_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `agriculture_ecm`.`inventory`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `agriculture_ecm`.`research`.`input_usage` ADD CONSTRAINT `fk_research_input_usage_inventory_drawdown_goods_issue_id` FOREIGN KEY (`inventory_drawdown_goods_issue_id`) REFERENCES `agriculture_ecm`.`inventory`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `agriculture_ecm`.`research`.`input_usage` ADD CONSTRAINT `fk_research_input_usage_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);

-- ========= research --> land (15 constraint(s)) =========
-- Requires: research schema, land schema
ALTER TABLE `agriculture_ecm`.`research`.`trial` ADD CONSTRAINT `fk_research_trial_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_plot` ADD CONSTRAINT `fk_research_trial_plot_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_plot` ADD CONSTRAINT `fk_research_trial_plot_irrigation_zone_id` FOREIGN KEY (`irrigation_zone_id`) REFERENCES `agriculture_ecm`.`land`.`irrigation_zone`(`irrigation_zone_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_plot` ADD CONSTRAINT `fk_research_trial_plot_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_plot` ADD CONSTRAINT `fk_research_trial_plot_soil_profile_id` FOREIGN KEY (`soil_profile_id`) REFERENCES `agriculture_ecm`.`land`.`soil_profile`(`soil_profile_id`);
ALTER TABLE `agriculture_ecm`.`research`.`yield_measurement` ADD CONSTRAINT `fk_research_yield_measurement_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`research`.`yield_measurement` ADD CONSTRAINT `fk_research_yield_measurement_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_site` ADD CONSTRAINT `fk_research_trial_site_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_site` ADD CONSTRAINT `fk_research_trial_site_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_site` ADD CONSTRAINT `fk_research_trial_site_soil_profile_id` FOREIGN KEY (`soil_profile_id`) REFERENCES `agriculture_ecm`.`land`.`soil_profile`(`soil_profile_id`);
ALTER TABLE `agriculture_ecm`.`research`.`precision_ag_pilot` ADD CONSTRAINT `fk_research_precision_ag_pilot_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`research`.`precision_ag_pilot` ADD CONSTRAINT `fk_research_precision_ag_pilot_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`research`.`telemetry_event` ADD CONSTRAINT `fk_research_telemetry_event_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`research`.`cooperator` ADD CONSTRAINT `fk_research_cooperator_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`research`.`research_project` ADD CONSTRAINT `fk_research_research_project_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);

-- ========= research --> procurement (11 constraint(s)) =========
-- Requires: research schema, procurement schema
ALTER TABLE `agriculture_ecm`.`research`.`treatment` ADD CONSTRAINT `fk_research_treatment_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `agriculture_ecm`.`procurement`.`chemical_compliance`(`chemical_compliance_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment` ADD CONSTRAINT `fk_research_treatment_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`research`.`variety` ADD CONSTRAINT `fk_research_variety_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`research`.`ipm_study` ADD CONSTRAINT `fk_research_ipm_study_chemical_compliance_id` FOREIGN KEY (`chemical_compliance_id`) REFERENCES `agriculture_ecm`.`procurement`.`chemical_compliance`(`chemical_compliance_id`);
ALTER TABLE `agriculture_ecm`.`research`.`ipm_study` ADD CONSTRAINT `fk_research_ipm_study_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`research`.`precision_ag_pilot` ADD CONSTRAINT `fk_research_precision_ag_pilot_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `agriculture_ecm`.`research`.`precision_ag_pilot` ADD CONSTRAINT `fk_research_precision_ag_pilot_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`research`.`input_usage` ADD CONSTRAINT `fk_research_input_usage_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`research`.`input_usage` ADD CONSTRAINT `fk_research_input_usage_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);

-- ========= research --> product (19 constraint(s)) =========
-- Requires: research schema, product schema
ALTER TABLE `agriculture_ecm`.`research`.`trial_plot` ADD CONSTRAINT `fk_research_trial_plot_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment` ADD CONSTRAINT `fk_research_treatment_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment` ADD CONSTRAINT `fk_research_treatment_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`research`.`variety` ADD CONSTRAINT `fk_research_variety_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`research`.`yield_measurement` ADD CONSTRAINT `fk_research_yield_measurement_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`research`.`statistical_result` ADD CONSTRAINT `fk_research_statistical_result_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`research`.`ipm_study` ADD CONSTRAINT `fk_research_ipm_study_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`research`.`ipm_study` ADD CONSTRAINT `fk_research_ipm_study_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`research`.`ipm_study` ADD CONSTRAINT `fk_research_ipm_study_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trait_evaluation` ADD CONSTRAINT `fk_research_trait_evaluation_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`research`.`performance_benchmark` ADD CONSTRAINT `fk_research_performance_benchmark_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`research`.`cooperator` ADD CONSTRAINT `fk_research_cooperator_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`research`.`accession` ADD CONSTRAINT `fk_research_accession_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`research`.`breeding_pipeline` ADD CONSTRAINT `fk_research_breeding_pipeline_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`research`.`input_usage` ADD CONSTRAINT `fk_research_input_usage_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`research`.`input_usage` ADD CONSTRAINT `fk_research_input_usage_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_treatment` ADD CONSTRAINT `fk_research_trial_treatment_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);

-- ========= research --> sustainability (11 constraint(s)) =========
-- Requires: research schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`research`.`trial` ADD CONSTRAINT `fk_research_trial_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_plot` ADD CONSTRAINT `fk_research_trial_plot_practice_adoption_id` FOREIGN KEY (`practice_adoption_id`) REFERENCES `agriculture_ecm`.`sustainability`.`practice_adoption`(`practice_adoption_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment` ADD CONSTRAINT `fk_research_treatment_emission_factor_id` FOREIGN KEY (`emission_factor_id`) REFERENCES `agriculture_ecm`.`sustainability`.`emission_factor`(`emission_factor_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment` ADD CONSTRAINT `fk_research_treatment_regenerative_practice_id` FOREIGN KEY (`regenerative_practice_id`) REFERENCES `agriculture_ecm`.`sustainability`.`regenerative_practice`(`regenerative_practice_id`);
ALTER TABLE `agriculture_ecm`.`research`.`variety` ADD CONSTRAINT `fk_research_variety_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`research`.`research_soil_sample` ADD CONSTRAINT `fk_research_research_soil_sample_soil_carbon_sequestration_id` FOREIGN KEY (`soil_carbon_sequestration_id`) REFERENCES `agriculture_ecm`.`sustainability`.`soil_carbon_sequestration`(`soil_carbon_sequestration_id`);
ALTER TABLE `agriculture_ecm`.`research`.`ipm_study` ADD CONSTRAINT `fk_research_ipm_study_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`research`.`program` ADD CONSTRAINT `fk_research_program_target_id` FOREIGN KEY (`target_id`) REFERENCES `agriculture_ecm`.`sustainability`.`target`(`target_id`);
ALTER TABLE `agriculture_ecm`.`research`.`precision_ag_pilot` ADD CONSTRAINT `fk_research_precision_ag_pilot_initiative_id` FOREIGN KEY (`initiative_id`) REFERENCES `agriculture_ecm`.`sustainability`.`initiative`(`initiative_id`);
ALTER TABLE `agriculture_ecm`.`research`.`cooperator` ADD CONSTRAINT `fk_research_cooperator_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`research`.`breeding_pipeline` ADD CONSTRAINT `fk_research_breeding_pipeline_target_id` FOREIGN KEY (`target_id`) REFERENCES `agriculture_ecm`.`sustainability`.`target`(`target_id`);

-- ========= research --> weather (10 constraint(s)) =========
-- Requires: research schema, weather schema
ALTER TABLE `agriculture_ecm`.`research`.`trial_observation` ADD CONSTRAINT `fk_research_trial_observation_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`research`.`yield_measurement` ADD CONSTRAINT `fk_research_yield_measurement_growing_degree_day_id` FOREIGN KEY (`growing_degree_day_id`) REFERENCES `agriculture_ecm`.`weather`.`growing_degree_day`(`growing_degree_day_id`);
ALTER TABLE `agriculture_ecm`.`research`.`yield_measurement` ADD CONSTRAINT `fk_research_yield_measurement_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_spray_window_id` FOREIGN KEY (`spray_window_id`) REFERENCES `agriculture_ecm`.`weather`.`spray_window`(`spray_window_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_site` ADD CONSTRAINT `fk_research_trial_site_climate_normal_id` FOREIGN KEY (`climate_normal_id`) REFERENCES `agriculture_ecm`.`weather`.`climate_normal`(`climate_normal_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_site` ADD CONSTRAINT `fk_research_trial_site_station_id` FOREIGN KEY (`station_id`) REFERENCES `agriculture_ecm`.`weather`.`station`(`station_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_site` ADD CONSTRAINT `fk_research_trial_site_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`research`.`performance_benchmark` ADD CONSTRAINT `fk_research_performance_benchmark_climate_normal_id` FOREIGN KEY (`climate_normal_id`) REFERENCES `agriculture_ecm`.`weather`.`climate_normal`(`climate_normal_id`);
ALTER TABLE `agriculture_ecm`.`research`.`precision_ag_pilot` ADD CONSTRAINT `fk_research_precision_ag_pilot_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `agriculture_ecm`.`weather`.`forecast`(`forecast_id`);
ALTER TABLE `agriculture_ecm`.`research`.`input_usage` ADD CONSTRAINT `fk_research_input_usage_spray_window_id` FOREIGN KEY (`spray_window_id`) REFERENCES `agriculture_ecm`.`weather`.`spray_window`(`spray_window_id`);

-- ========= research --> workforce (21 constraint(s)) =========
-- Requires: research schema, workforce schema
ALTER TABLE `agriculture_ecm`.`research`.`trial` ADD CONSTRAINT `fk_research_trial_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_plot` ADD CONSTRAINT `fk_research_trial_plot_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`research`.`experimental_design` ADD CONSTRAINT `fk_research_experimental_design_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_observation` ADD CONSTRAINT `fk_research_trial_observation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`yield_measurement` ADD CONSTRAINT `fk_research_yield_measurement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`treatment_application` ADD CONSTRAINT `fk_research_treatment_application_workforce_certification_id` FOREIGN KEY (`workforce_certification_id`) REFERENCES `agriculture_ecm`.`workforce`.`workforce_certification`(`workforce_certification_id`);
ALTER TABLE `agriculture_ecm`.`research`.`statistical_result` ADD CONSTRAINT `fk_research_statistical_result_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`ipm_study` ADD CONSTRAINT `fk_research_ipm_study_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trait_evaluation` ADD CONSTRAINT `fk_research_trait_evaluation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_site` ADD CONSTRAINT `fk_research_trial_site_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`performance_benchmark` ADD CONSTRAINT `fk_research_performance_benchmark_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`biotech_submission` ADD CONSTRAINT `fk_research_biotech_submission_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`precision_ag_pilot` ADD CONSTRAINT `fk_research_precision_ag_pilot_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_protocol` ADD CONSTRAINT `fk_research_trial_protocol_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`accession` ADD CONSTRAINT `fk_research_accession_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`breeding_pipeline` ADD CONSTRAINT `fk_research_breeding_pipeline_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`input_usage` ADD CONSTRAINT `fk_research_input_usage_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`trial_staff_assignment` ADD CONSTRAINT `fk_research_trial_staff_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`research`.`research_project` ADD CONSTRAINT `fk_research_research_project_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sales --> compliance (11 constraint(s)) =========
-- Requires: sales schema, compliance schema
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_organic_compliance_record_id` FOREIGN KEY (`organic_compliance_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`organic_compliance_record`(`organic_compliance_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`broker` ADD CONSTRAINT `fk_sales_broker_license_id` FOREIGN KEY (`license_id`) REFERENCES `agriculture_ecm`.`compliance`.`license`(`license_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_organic_compliance_record_id` FOREIGN KEY (`organic_compliance_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`organic_compliance_record`(`organic_compliance_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_trade_compliance_record_id` FOREIGN KEY (`trade_compliance_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`trade_compliance_record`(`trade_compliance_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_recall_event_id` FOREIGN KEY (`recall_event_id`) REFERENCES `agriculture_ecm`.`compliance`.`recall_event`(`recall_event_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_regulatory_finding_id` FOREIGN KEY (`regulatory_finding_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_finding`(`regulatory_finding_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);

-- ========= sales --> crop (9 constraint(s)) =========
-- Requires: sales schema, crop schema
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ADD CONSTRAINT `fk_sales_market_price_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);

-- ========= sales --> customer (32 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_preference_id` FOREIGN KEY (`preference_id`) REFERENCES `agriculture_ecm`.`customer`.`preference`(`preference_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_preference_id` FOREIGN KEY (`preference_id`) REFERENCES `agriculture_ecm`.`customer`.`preference`(`preference_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_cool_preference_id` FOREIGN KEY (`cool_preference_id`) REFERENCES `agriculture_ecm`.`customer`.`cool_preference`(`cool_preference_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `agriculture_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `agriculture_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_cool_preference_id` FOREIGN KEY (`cool_preference_id`) REFERENCES `agriculture_ecm`.`customer`.`cool_preference`(`cool_preference_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `agriculture_ecm`.`customer`.`segment`(`segment_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_contact_id` FOREIGN KEY (`contact_id`) REFERENCES `agriculture_ecm`.`customer`.`contact`(`contact_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract_certification_verification` ADD CONSTRAINT `fk_sales_contract_certification_verification_certification_record_id` FOREIGN KEY (`certification_record_id`) REFERENCES `agriculture_ecm`.`customer`.`certification_record`(`certification_record_id`);

-- ========= sales --> finance (8 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_government_program_id` FOREIGN KEY (`government_program_id`) REFERENCES `agriculture_ecm`.`finance`.`government_program`(`government_program_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= sales --> invoice (7 constraint(s)) =========
-- Requires: sales schema, invoice schema
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_price_basis_id` FOREIGN KEY (`price_basis_id`) REFERENCES `agriculture_ecm`.`invoice`.`price_basis`(`price_basis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_line_id` FOREIGN KEY (`line_id`) REFERENCES `agriculture_ecm`.`invoice`.`line`(`line_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_weight_ticket_id` FOREIGN KEY (`weight_ticket_id`) REFERENCES `agriculture_ecm`.`invoice`.`weight_ticket`(`weight_ticket_id`);

-- ========= sales --> land (4 constraint(s)) =========
-- Requires: sales schema, land schema
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);

-- ========= sales --> livestock (1 constraint(s)) =========
-- Requires: sales schema, livestock schema
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_production_group_id` FOREIGN KEY (`production_group_id`) REFERENCES `agriculture_ecm`.`livestock`.`production_group`(`production_group_id`);

-- ========= sales --> procurement (1 constraint(s)) =========
-- Requires: sales schema, procurement schema
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= sales --> product (24 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`market_price` ADD CONSTRAINT `fk_sales_market_price_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);

-- ========= sales --> quality (11 constraint(s)) =========
-- Requires: sales schema, quality schema
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_quality_audit_id` FOREIGN KEY (`quality_audit_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_audit`(`quality_audit_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `agriculture_ecm`.`quality`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_hold_record_id` FOREIGN KEY (`hold_record_id`) REFERENCES `agriculture_ecm`.`quality`.`hold_record`(`hold_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);

-- ========= sales --> research (13 constraint(s)) =========
-- Requires: sales schema, research schema
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_biotech_submission_id` FOREIGN KEY (`biotech_submission_id`) REFERENCES `agriculture_ecm`.`research`.`biotech_submission`(`biotech_submission_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_breeding_pipeline_id` FOREIGN KEY (`breeding_pipeline_id`) REFERENCES `agriculture_ecm`.`research`.`breeding_pipeline`(`breeding_pipeline_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_ip_record_id` FOREIGN KEY (`ip_record_id`) REFERENCES `agriculture_ecm`.`research`.`ip_record`(`ip_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_ip_record_id` FOREIGN KEY (`ip_record_id`) REFERENCES `agriculture_ecm`.`research`.`ip_record`(`ip_record_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_breeding_pipeline_id` FOREIGN KEY (`breeding_pipeline_id`) REFERENCES `agriculture_ecm`.`research`.`breeding_pipeline`(`breeding_pipeline_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_performance_benchmark_id` FOREIGN KEY (`performance_benchmark_id`) REFERENCES `agriculture_ecm`.`research`.`performance_benchmark`(`performance_benchmark_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);

-- ========= sales --> supply (6 constraint(s)) =========
-- Requires: sales schema, supply schema
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `agriculture_ecm`.`supply`.`carrier`(`carrier_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`distribution_channel` ADD CONSTRAINT `fk_sales_distribution_channel_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

-- ========= sales --> sustainability (17 constraint(s)) =========
-- Requires: sales schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_carbon_footprint_id` FOREIGN KEY (`carbon_footprint_id`) REFERENCES `agriculture_ecm`.`sustainability`.`carbon_footprint`(`carbon_footprint_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_deforestation_risk_id` FOREIGN KEY (`deforestation_risk_id`) REFERENCES `agriculture_ecm`.`sustainability`.`deforestation_risk`(`deforestation_risk_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_carbon_footprint_id` FOREIGN KEY (`carbon_footprint_id`) REFERENCES `agriculture_ecm`.`sustainability`.`carbon_footprint`(`carbon_footprint_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order_line` ADD CONSTRAINT `fk_sales_order_line_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_deforestation_risk_id` FOREIGN KEY (`deforestation_risk_id`) REFERENCES `agriculture_ecm`.`sustainability`.`deforestation_risk`(`deforestation_risk_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_deforestation_risk_id` FOREIGN KEY (`deforestation_risk_id`) REFERENCES `agriculture_ecm`.`sustainability`.`deforestation_risk`(`deforestation_risk_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_climate_risk_assessment_id` FOREIGN KEY (`climate_risk_assessment_id`) REFERENCES `agriculture_ecm`.`sustainability`.`climate_risk_assessment`(`climate_risk_assessment_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_deforestation_risk_id` FOREIGN KEY (`deforestation_risk_id`) REFERENCES `agriculture_ecm`.`sustainability`.`deforestation_risk`(`deforestation_risk_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `agriculture_ecm`.`sustainability`.`environmental_incident`(`environmental_incident_id`);

-- ========= sales --> weather (8 constraint(s)) =========
-- Requires: sales schema, weather schema
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_climate_normal_id` FOREIGN KEY (`climate_normal_id`) REFERENCES `agriculture_ecm`.`weather`.`climate_normal`(`climate_normal_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`delivery_order` ADD CONSTRAINT `fk_sales_delivery_order_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_climate_risk_indicator_id` FOREIGN KEY (`climate_risk_indicator_id`) REFERENCES `agriculture_ecm`.`weather`.`climate_risk_indicator`(`climate_risk_indicator_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_drought_index_id` FOREIGN KEY (`drought_index_id`) REFERENCES `agriculture_ecm`.`weather`.`drought_index`(`drought_index_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_drought_index_id` FOREIGN KEY (`drought_index_id`) REFERENCES `agriculture_ecm`.`weather`.`drought_index`(`drought_index_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);

-- ========= sales --> workforce (14 constraint(s)) =========
-- Requires: sales schema, workforce schema
ALTER TABLE `agriculture_ecm`.`sales`.`opportunity` ADD CONSTRAINT `fk_sales_opportunity_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`quote` ADD CONSTRAINT `fk_sales_quote_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`order` ADD CONSTRAINT `fk_sales_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract` ADD CONSTRAINT `fk_sales_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`price_agreement` ADD CONSTRAINT `fk_sales_price_agreement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`demand_forecast` ADD CONSTRAINT `fk_sales_demand_forecast_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`origin_declaration` ADD CONSTRAINT `fk_sales_origin_declaration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`customer_allocation` ADD CONSTRAINT `fk_sales_customer_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`return_order` ADD CONSTRAINT `fk_sales_return_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_territory_sales_manager_employee_id` FOREIGN KEY (`territory_sales_manager_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`territory` ADD CONSTRAINT `fk_sales_territory_territory_sales_rep_employee_id` FOREIGN KEY (`territory_sales_rep_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sales`.`contract_certification_verification` ADD CONSTRAINT `fk_sales_contract_certification_verification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= supply --> compliance (22 constraint(s)) =========
-- Requires: supply schema, compliance schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_recall_lot_id` FOREIGN KEY (`recall_lot_id`) REFERENCES `agriculture_ecm`.`compliance`.`recall_lot`(`recall_lot_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`carrier` ADD CONSTRAINT `fk_supply_carrier_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `agriculture_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`carrier` ADD CONSTRAINT `fk_supply_carrier_license_id` FOREIGN KEY (`license_id`) REFERENCES `agriculture_ecm`.`compliance`.`license`(`license_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`carrier` ADD CONSTRAINT `fk_supply_carrier_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`route` ADD CONSTRAINT `fk_supply_route_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`cold_chain_reading` ADD CONSTRAINT `fk_supply_cold_chain_reading_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_organic_compliance_record_id` FOREIGN KEY (`organic_compliance_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`organic_compliance_record`(`organic_compliance_record_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`carrier_performance` ADD CONSTRAINT `fk_supply_carrier_performance_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `agriculture_ecm`.`compliance`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`customs_declaration` ADD CONSTRAINT `fk_supply_customs_declaration_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`load_plan` ADD CONSTRAINT `fk_supply_load_plan_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`inbound_plan` ADD CONSTRAINT `fk_supply_inbound_plan_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`inbound_plan` ADD CONSTRAINT `fk_supply_inbound_plan_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`fsma_compliance` ADD CONSTRAINT `fk_supply_fsma_compliance_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`fsma_compliance` ADD CONSTRAINT `fk_supply_fsma_compliance_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`inspection_record`(`inspection_record_id`);

-- ========= supply --> crop (5 constraint(s)) =========
-- Requires: supply schema, crop schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`fsma_compliance` ADD CONSTRAINT `fk_supply_fsma_compliance_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);

-- ========= supply --> customer (9 constraint(s)) =========
-- Requires: supply schema, customer schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`carrier_location_approval` ADD CONSTRAINT `fk_supply_carrier_location_approval_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`route_stop` ADD CONSTRAINT `fk_supply_route_stop_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);

-- ========= supply --> equipment (5 constraint(s)) =========
-- Requires: supply schema, equipment schema
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`load_plan` ADD CONSTRAINT `fk_supply_load_plan_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`fsma_compliance` ADD CONSTRAINT `fk_supply_fsma_compliance_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);

-- ========= supply --> finance (15 constraint(s)) =========
-- Requires: supply schema, finance schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_rate` ADD CONSTRAINT `fk_supply_freight_rate_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_invoice` ADD CONSTRAINT `fk_supply_freight_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_invoice` ADD CONSTRAINT `fk_supply_freight_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`facility` ADD CONSTRAINT `fk_supply_facility_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`facility` ADD CONSTRAINT `fk_supply_facility_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`customs_declaration` ADD CONSTRAINT `fk_supply_customs_declaration_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`customs_declaration` ADD CONSTRAINT `fk_supply_customs_declaration_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);

-- ========= supply --> inventory (12 constraint(s)) =========
-- Requires: supply schema, inventory schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_stock_reservation_id` FOREIGN KEY (`stock_reservation_id`) REFERENCES `agriculture_ecm`.`inventory`.`stock_reservation`(`stock_reservation_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`cold_chain_reading` ADD CONSTRAINT `fk_supply_cold_chain_reading_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`load_plan` ADD CONSTRAINT `fk_supply_load_plan_bin_location_id` FOREIGN KEY (`bin_location_id`) REFERENCES `agriculture_ecm`.`inventory`.`bin_location`(`bin_location_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`load_plan` ADD CONSTRAINT `fk_supply_load_plan_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`load_plan` ADD CONSTRAINT `fk_supply_load_plan_stock_reservation_id` FOREIGN KEY (`stock_reservation_id`) REFERENCES `agriculture_ecm`.`inventory`.`stock_reservation`(`stock_reservation_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`inbound_plan` ADD CONSTRAINT `fk_supply_inbound_plan_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `agriculture_ecm`.`inventory`.`material_master`(`material_master_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_commodity_lot_id` FOREIGN KEY (`commodity_lot_id`) REFERENCES `agriculture_ecm`.`inventory`.`commodity_lot`(`commodity_lot_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_stock_reservation_id` FOREIGN KEY (`stock_reservation_id`) REFERENCES `agriculture_ecm`.`inventory`.`stock_reservation`(`stock_reservation_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`fsma_compliance` ADD CONSTRAINT `fk_supply_fsma_compliance_inventory_goods_receipt_id` FOREIGN KEY (`inventory_goods_receipt_id`) REFERENCES `agriculture_ecm`.`inventory`.`inventory_goods_receipt`(`inventory_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`fsma_compliance` ADD CONSTRAINT `fk_supply_fsma_compliance_quarantine_hold_id` FOREIGN KEY (`quarantine_hold_id`) REFERENCES `agriculture_ecm`.`inventory`.`quarantine_hold`(`quarantine_hold_id`);

-- ========= supply --> land (2 constraint(s)) =========
-- Requires: supply schema, land schema
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`facility` ADD CONSTRAINT `fk_supply_facility_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);

-- ========= supply --> procurement (10 constraint(s)) =========
-- Requires: supply schema, procurement schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`carrier` ADD CONSTRAINT `fk_supply_carrier_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`inbound_plan` ADD CONSTRAINT `fk_supply_inbound_plan_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`inbound_plan` ADD CONSTRAINT `fk_supply_inbound_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `agriculture_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= supply --> product (26 constraint(s)) =========
-- Requires: supply schema, product schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`cold_chain_reading` ADD CONSTRAINT `fk_supply_cold_chain_reading_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_gmo_declaration_id` FOREIGN KEY (`gmo_declaration_id`) REFERENCES `agriculture_ecm`.`product`.`gmo_declaration`(`gmo_declaration_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_rate` ADD CONSTRAINT `fk_supply_freight_rate_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`customs_declaration` ADD CONSTRAINT `fk_supply_customs_declaration_mrl_threshold_id` FOREIGN KEY (`mrl_threshold_id`) REFERENCES `agriculture_ecm`.`product`.`mrl_threshold`(`mrl_threshold_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`load_plan` ADD CONSTRAINT `fk_supply_load_plan_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`inbound_plan` ADD CONSTRAINT `fk_supply_inbound_plan_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`inbound_plan` ADD CONSTRAINT `fk_supply_inbound_plan_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`fsma_compliance` ADD CONSTRAINT `fk_supply_fsma_compliance_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`facility_commodity_capability` ADD CONSTRAINT `fk_supply_facility_commodity_capability_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`contract_commodity_coverage` ADD CONSTRAINT `fk_supply_contract_commodity_coverage_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= supply --> quality (9 constraint(s)) =========
-- Requires: supply schema, quality schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_nonconformance_id` FOREIGN KEY (`nonconformance_id`) REFERENCES `agriculture_ecm`.`quality`.`nonconformance`(`nonconformance_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`cold_chain_reading` ADD CONSTRAINT `fk_supply_cold_chain_reading_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `agriculture_ecm`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_certification`(`quality_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`customs_declaration` ADD CONSTRAINT `fk_supply_customs_declaration_certificate_of_analysis_id` FOREIGN KEY (`certificate_of_analysis_id`) REFERENCES `agriculture_ecm`.`quality`.`certificate_of_analysis`(`certificate_of_analysis_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`load_plan` ADD CONSTRAINT `fk_supply_load_plan_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`fsma_compliance` ADD CONSTRAINT `fk_supply_fsma_compliance_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `agriculture_ecm`.`quality`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`fsma_compliance` ADD CONSTRAINT `fk_supply_fsma_compliance_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);

-- ========= supply --> research (13 constraint(s)) =========
-- Requires: supply schema, research schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_trial_site_id` FOREIGN KEY (`trial_site_id`) REFERENCES `agriculture_ecm`.`research`.`trial_site`(`trial_site_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`freight_booking` ADD CONSTRAINT `fk_supply_freight_booking_trial_site_id` FOREIGN KEY (`trial_site_id`) REFERENCES `agriculture_ecm`.`research`.`trial_site`(`trial_site_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_cooperator_id` FOREIGN KEY (`cooperator_id`) REFERENCES `agriculture_ecm`.`research`.`cooperator`(`cooperator_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_trial_site_id` FOREIGN KEY (`trial_site_id`) REFERENCES `agriculture_ecm`.`research`.`trial_site`(`trial_site_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_program_id` FOREIGN KEY (`program_id`) REFERENCES `agriculture_ecm`.`research`.`program`(`program_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`customs_declaration` ADD CONSTRAINT `fk_supply_customs_declaration_variety_id` FOREIGN KEY (`variety_id`) REFERENCES `agriculture_ecm`.`research`.`variety`(`variety_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`inbound_plan` ADD CONSTRAINT `fk_supply_inbound_plan_cooperator_id` FOREIGN KEY (`cooperator_id`) REFERENCES `agriculture_ecm`.`research`.`cooperator`(`cooperator_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`inbound_plan` ADD CONSTRAINT `fk_supply_inbound_plan_trial_id` FOREIGN KEY (`trial_id`) REFERENCES `agriculture_ecm`.`research`.`trial`(`trial_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`inbound_plan` ADD CONSTRAINT `fk_supply_inbound_plan_trial_site_id` FOREIGN KEY (`trial_site_id`) REFERENCES `agriculture_ecm`.`research`.`trial_site`(`trial_site_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_trial_site_id` FOREIGN KEY (`trial_site_id`) REFERENCES `agriculture_ecm`.`research`.`trial_site`(`trial_site_id`);

-- ========= supply --> sales (11 constraint(s)) =========
-- Requires: supply schema, sales schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `agriculture_ecm`.`sales`.`order_line`(`order_line_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`customs_declaration` ADD CONSTRAINT `fk_supply_customs_declaration_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`customs_declaration` ADD CONSTRAINT `fk_supply_customs_declaration_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`load_plan` ADD CONSTRAINT `fk_supply_load_plan_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_delivery_order_id` FOREIGN KEY (`delivery_order_id`) REFERENCES `agriculture_ecm`.`sales`.`delivery_order`(`delivery_order_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `agriculture_ecm`.`sales`.`contract`(`contract_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_order_id` FOREIGN KEY (`order_id`) REFERENCES `agriculture_ecm`.`sales`.`order`(`order_id`);

-- ========= supply --> sustainability (10 constraint(s)) =========
-- Requires: supply schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment_line` ADD CONSTRAINT `fk_supply_shipment_line_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_carbon_footprint_id` FOREIGN KEY (`carbon_footprint_id`) REFERENCES `agriculture_ecm`.`sustainability`.`carbon_footprint`(`carbon_footprint_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_deforestation_risk_id` FOREIGN KEY (`deforestation_risk_id`) REFERENCES `agriculture_ecm`.`sustainability`.`deforestation_risk`(`deforestation_risk_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`facility` ADD CONSTRAINT `fk_supply_facility_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`customs_declaration` ADD CONSTRAINT `fk_supply_customs_declaration_deforestation_risk_id` FOREIGN KEY (`deforestation_risk_id`) REFERENCES `agriculture_ecm`.`sustainability`.`deforestation_risk`(`deforestation_risk_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`customs_declaration` ADD CONSTRAINT `fk_supply_customs_declaration_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`inbound_plan` ADD CONSTRAINT `fk_supply_inbound_plan_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_sustainability_certification_id` FOREIGN KEY (`sustainability_certification_id`) REFERENCES `agriculture_ecm`.`sustainability`.`sustainability_certification`(`sustainability_certification_id`);

-- ========= supply --> weather (11 constraint(s)) =========
-- Requires: supply schema, weather schema
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `agriculture_ecm`.`weather`.`forecast`(`forecast_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`route` ADD CONSTRAINT `fk_supply_route_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`cold_chain_reading` ADD CONSTRAINT `fk_supply_cold_chain_reading_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`lot_trace` ADD CONSTRAINT `fk_supply_lot_trace_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`facility` ADD CONSTRAINT `fk_supply_facility_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`inbound_plan` ADD CONSTRAINT `fk_supply_inbound_plan_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `agriculture_ecm`.`weather`.`forecast`(`forecast_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`logistics_plan` ADD CONSTRAINT `fk_supply_logistics_plan_forecast_id` FOREIGN KEY (`forecast_id`) REFERENCES `agriculture_ecm`.`weather`.`forecast`(`forecast_id`);

-- ========= supply --> workforce (8 constraint(s)) =========
-- Requires: supply schema, workforce schema
ALTER TABLE `agriculture_ecm`.`supply`.`transport_order` ADD CONSTRAINT `fk_supply_transport_order_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`bill_of_lading` ADD CONSTRAINT `fk_supply_bill_of_lading_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`delivery_event` ADD CONSTRAINT `fk_supply_delivery_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`carrier_performance` ADD CONSTRAINT `fk_supply_carrier_performance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`service_contract` ADD CONSTRAINT `fk_supply_service_contract_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`load_plan` ADD CONSTRAINT `fk_supply_load_plan_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`inbound_plan` ADD CONSTRAINT `fk_supply_inbound_plan_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`supply`.`fsma_compliance` ADD CONSTRAINT `fk_supply_fsma_compliance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= sustainability --> compliance (21 constraint(s)) =========
-- Requires: sustainability schema, compliance schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`carbon_footprint` ADD CONSTRAINT `fk_sustainability_carbon_footprint_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`carbon_footprint` ADD CONSTRAINT `fk_sustainability_carbon_footprint_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`emission_factor` ADD CONSTRAINT `fk_sustainability_emission_factor_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_stewardship_plan` ADD CONSTRAINT `fk_sustainability_water_stewardship_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_stewardship_plan` ADD CONSTRAINT `fk_sustainability_water_stewardship_plan_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`biodiversity_assessment` ADD CONSTRAINT `fk_sustainability_biodiversity_assessment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`biodiversity_assessment` ADD CONSTRAINT `fk_sustainability_biodiversity_assessment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`conservation_enrollment` ADD CONSTRAINT `fk_sustainability_conservation_enrollment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`conservation_enrollment` ADD CONSTRAINT `fk_sustainability_conservation_enrollment_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`esg_report` ADD CONSTRAINT `fk_sustainability_esg_report_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`target` ADD CONSTRAINT `fk_sustainability_target_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`waste_event` ADD CONSTRAINT `fk_sustainability_waste_event_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`waste_event` ADD CONSTRAINT `fk_sustainability_waste_event_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_violation_record_id` FOREIGN KEY (`violation_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`violation_record`(`violation_record_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`land_use_change` ADD CONSTRAINT `fk_sustainability_land_use_change_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `agriculture_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`land_use_change` ADD CONSTRAINT `fk_sustainability_land_use_change_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`initiative` ADD CONSTRAINT `fk_sustainability_initiative_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= sustainability --> crop (25 constraint(s)) =========
-- Requires: sustainability schema, crop schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_fertilization_event_id` FOREIGN KEY (`fertilization_event_id`) REFERENCES `agriculture_ecm`.`crop`.`fertilization_event`(`fertilization_event_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_irrigation_event_id` FOREIGN KEY (`irrigation_event_id`) REFERENCES `agriculture_ecm`.`crop`.`irrigation_event`(`irrigation_event_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_stewardship_plan` ADD CONSTRAINT `fk_sustainability_water_stewardship_plan_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`soil_carbon_sequestration` ADD CONSTRAINT `fk_sustainability_soil_carbon_sequestration_rotation_plan_id` FOREIGN KEY (`rotation_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`rotation_plan`(`rotation_plan_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`soil_carbon_sequestration` ADD CONSTRAINT `fk_sustainability_soil_carbon_sequestration_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`biodiversity_assessment` ADD CONSTRAINT `fk_sustainability_biodiversity_assessment_rotation_plan_id` FOREIGN KEY (`rotation_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`rotation_plan`(`rotation_plan_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`biodiversity_assessment` ADD CONSTRAINT `fk_sustainability_biodiversity_assessment_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`conservation_enrollment` ADD CONSTRAINT `fk_sustainability_conservation_enrollment_cover_crop_id` FOREIGN KEY (`cover_crop_id`) REFERENCES `agriculture_ecm`.`crop`.`cover_crop`(`cover_crop_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`conservation_enrollment` ADD CONSTRAINT `fk_sustainability_conservation_enrollment_rotation_plan_id` FOREIGN KEY (`rotation_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`rotation_plan`(`rotation_plan_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`conservation_enrollment` ADD CONSTRAINT `fk_sustainability_conservation_enrollment_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`esg_metric` ADD CONSTRAINT `fk_sustainability_esg_metric_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`practice_adoption` ADD CONSTRAINT `fk_sustainability_practice_adoption_cover_crop_id` FOREIGN KEY (`cover_crop_id`) REFERENCES `agriculture_ecm`.`crop`.`cover_crop`(`cover_crop_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`practice_adoption` ADD CONSTRAINT `fk_sustainability_practice_adoption_rotation_plan_id` FOREIGN KEY (`rotation_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`rotation_plan`(`rotation_plan_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`practice_adoption` ADD CONSTRAINT `fk_sustainability_practice_adoption_fertilization_event_id` FOREIGN KEY (`fertilization_event_id`) REFERENCES `agriculture_ecm`.`crop`.`fertilization_event`(`fertilization_event_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`practice_adoption` ADD CONSTRAINT `fk_sustainability_practice_adoption_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`practice_adoption` ADD CONSTRAINT `fk_sustainability_practice_adoption_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`deforestation_risk` ADD CONSTRAINT `fk_sustainability_deforestation_risk_rotation_plan_id` FOREIGN KEY (`rotation_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`rotation_plan`(`rotation_plan_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_protection_event_id` FOREIGN KEY (`protection_event_id`) REFERENCES `agriculture_ecm`.`crop`.`protection_event`(`protection_event_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_fertilization_event_id` FOREIGN KEY (`fertilization_event_id`) REFERENCES `agriculture_ecm`.`crop`.`fertilization_event`(`fertilization_event_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`land_use_change` ADD CONSTRAINT `fk_sustainability_land_use_change_rotation_plan_id` FOREIGN KEY (`rotation_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`rotation_plan`(`rotation_plan_id`);

-- ========= sustainability --> customer (1 constraint(s)) =========
-- Requires: sustainability schema, customer schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`carbon_credit` ADD CONSTRAINT `fk_sustainability_carbon_credit_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);

-- ========= sustainability --> equipment (6 constraint(s)) =========
-- Requires: sustainability schema, equipment schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_equipment_field_operation_id` FOREIGN KEY (`equipment_field_operation_id`) REFERENCES `agriculture_ecm`.`equipment`.`equipment_field_operation`(`equipment_field_operation_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_telematics_reading_id` FOREIGN KEY (`telematics_reading_id`) REFERENCES `agriculture_ecm`.`equipment`.`telematics_reading`(`telematics_reading_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`waste_event` ADD CONSTRAINT `fk_sustainability_waste_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`waste_event` ADD CONSTRAINT `fk_sustainability_waste_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `agriculture_ecm`.`equipment`.`work_order`(`work_order_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= sustainability --> finance (16 constraint(s)) =========
-- Requires: sustainability schema, finance schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`carbon_footprint` ADD CONSTRAINT `fk_sustainability_carbon_footprint_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`carbon_credit` ADD CONSTRAINT `fk_sustainability_carbon_credit_finance_ap_invoice_id` FOREIGN KEY (`finance_ap_invoice_id`) REFERENCES `agriculture_ecm`.`finance`.`finance_ap_invoice`(`finance_ap_invoice_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`carbon_credit` ADD CONSTRAINT `fk_sustainability_carbon_credit_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`carbon_credit` ADD CONSTRAINT `fk_sustainability_carbon_credit_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`carbon_credit` ADD CONSTRAINT `fk_sustainability_carbon_credit_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`conservation_enrollment` ADD CONSTRAINT `fk_sustainability_conservation_enrollment_government_program_id` FOREIGN KEY (`government_program_id`) REFERENCES `agriculture_ecm`.`finance`.`government_program`(`government_program_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`esg_report` ADD CONSTRAINT `fk_sustainability_esg_report_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`esg_metric` ADD CONSTRAINT `fk_sustainability_esg_metric_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`sustainability_certification` ADD CONSTRAINT `fk_sustainability_sustainability_certification_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`target` ADD CONSTRAINT `fk_sustainability_target_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`deforestation_risk` ADD CONSTRAINT `fk_sustainability_deforestation_risk_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`waste_event` ADD CONSTRAINT `fk_sustainability_waste_event_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`initiative` ADD CONSTRAINT `fk_sustainability_initiative_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= sustainability --> invoice (1 constraint(s)) =========
-- Requires: sustainability schema, invoice schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`carbon_credit` ADD CONSTRAINT `fk_sustainability_carbon_credit_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `agriculture_ecm`.`invoice`.`invoice`(`invoice_id`);

-- ========= sustainability --> land (41 constraint(s)) =========
-- Requires: sustainability schema, land schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`carbon_footprint` ADD CONSTRAINT `fk_sustainability_carbon_footprint_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_water_right_id` FOREIGN KEY (`water_right_id`) REFERENCES `agriculture_ecm`.`land`.`water_right`(`water_right_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_stewardship_plan` ADD CONSTRAINT `fk_sustainability_water_stewardship_plan_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_stewardship_plan` ADD CONSTRAINT `fk_sustainability_water_stewardship_plan_irrigation_zone_id` FOREIGN KEY (`irrigation_zone_id`) REFERENCES `agriculture_ecm`.`land`.`irrigation_zone`(`irrigation_zone_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_stewardship_plan` ADD CONSTRAINT `fk_sustainability_water_stewardship_plan_water_right_id` FOREIGN KEY (`water_right_id`) REFERENCES `agriculture_ecm`.`land`.`water_right`(`water_right_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`soil_carbon_sequestration` ADD CONSTRAINT `fk_sustainability_soil_carbon_sequestration_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`soil_carbon_sequestration` ADD CONSTRAINT `fk_sustainability_soil_carbon_sequestration_management_zone_id` FOREIGN KEY (`management_zone_id`) REFERENCES `agriculture_ecm`.`land`.`management_zone`(`management_zone_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`carbon_credit` ADD CONSTRAINT `fk_sustainability_carbon_credit_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`biodiversity_assessment` ADD CONSTRAINT `fk_sustainability_biodiversity_assessment_conservation_practice_id` FOREIGN KEY (`conservation_practice_id`) REFERENCES `agriculture_ecm`.`land`.`conservation_practice`(`conservation_practice_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`biodiversity_assessment` ADD CONSTRAINT `fk_sustainability_biodiversity_assessment_easement_id` FOREIGN KEY (`easement_id`) REFERENCES `agriculture_ecm`.`land`.`easement`(`easement_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`biodiversity_assessment` ADD CONSTRAINT `fk_sustainability_biodiversity_assessment_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`biodiversity_assessment` ADD CONSTRAINT `fk_sustainability_biodiversity_assessment_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`conservation_enrollment` ADD CONSTRAINT `fk_sustainability_conservation_enrollment_conservation_practice_id` FOREIGN KEY (`conservation_practice_id`) REFERENCES `agriculture_ecm`.`land`.`conservation_practice`(`conservation_practice_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`conservation_enrollment` ADD CONSTRAINT `fk_sustainability_conservation_enrollment_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`conservation_enrollment` ADD CONSTRAINT `fk_sustainability_conservation_enrollment_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`esg_report` ADD CONSTRAINT `fk_sustainability_esg_report_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`sustainability_certification` ADD CONSTRAINT `fk_sustainability_sustainability_certification_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`practice_adoption` ADD CONSTRAINT `fk_sustainability_practice_adoption_conservation_practice_id` FOREIGN KEY (`conservation_practice_id`) REFERENCES `agriculture_ecm`.`land`.`conservation_practice`(`conservation_practice_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`practice_adoption` ADD CONSTRAINT `fk_sustainability_practice_adoption_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`practice_adoption` ADD CONSTRAINT `fk_sustainability_practice_adoption_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`target_progress` ADD CONSTRAINT `fk_sustainability_target_progress_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`deforestation_risk` ADD CONSTRAINT `fk_sustainability_deforestation_risk_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`deforestation_risk` ADD CONSTRAINT `fk_sustainability_deforestation_risk_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`deforestation_risk` ADD CONSTRAINT `fk_sustainability_deforestation_risk_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`waste_event` ADD CONSTRAINT `fk_sustainability_waste_event_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`land_use_change` ADD CONSTRAINT `fk_sustainability_land_use_change_easement_id` FOREIGN KEY (`easement_id`) REFERENCES `agriculture_ecm`.`land`.`easement`(`easement_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`land_use_change` ADD CONSTRAINT `fk_sustainability_land_use_change_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`land_use_change` ADD CONSTRAINT `fk_sustainability_land_use_change_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`land_use_change` ADD CONSTRAINT `fk_sustainability_land_use_change_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`initiative` ADD CONSTRAINT `fk_sustainability_initiative_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);

-- ========= sustainability --> livestock (9 constraint(s)) =========
-- Requires: sustainability schema, livestock schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_feed_ration_id` FOREIGN KEY (`feed_ration_id`) REFERENCES `agriculture_ecm`.`livestock`.`feed_ration`(`feed_ration_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_production_group_id` FOREIGN KEY (`production_group_id`) REFERENCES `agriculture_ecm`.`livestock`.`production_group`(`production_group_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`waste_event` ADD CONSTRAINT `fk_sustainability_waste_event_health_treatment_id` FOREIGN KEY (`health_treatment_id`) REFERENCES `agriculture_ecm`.`livestock`.`health_treatment`(`health_treatment_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`waste_event` ADD CONSTRAINT `fk_sustainability_waste_event_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);

-- ========= sustainability --> procurement (4 constraint(s)) =========
-- Requires: sustainability schema, procurement schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`waste_event` ADD CONSTRAINT `fk_sustainability_waste_event_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `agriculture_ecm`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`waste_event` ADD CONSTRAINT `fk_sustainability_waste_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`supplier_sustainability` ADD CONSTRAINT `fk_sustainability_supplier_sustainability_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`initiative` ADD CONSTRAINT `fk_sustainability_initiative_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `agriculture_ecm`.`procurement`.`budget`(`budget_id`);

-- ========= sustainability --> product (10 constraint(s)) =========
-- Requires: sustainability schema, product schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`carbon_footprint` ADD CONSTRAINT `fk_sustainability_carbon_footprint_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_organic_certification_id` FOREIGN KEY (`organic_certification_id`) REFERENCES `agriculture_ecm`.`product`.`organic_certification`(`organic_certification_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`practice_adoption` ADD CONSTRAINT `fk_sustainability_practice_adoption_input_product_id` FOREIGN KEY (`input_product_id`) REFERENCES `agriculture_ecm`.`product`.`input_product`(`input_product_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`target` ADD CONSTRAINT `fk_sustainability_target_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`deforestation_risk` ADD CONSTRAINT `fk_sustainability_deforestation_risk_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`supplier_sustainability` ADD CONSTRAINT `fk_sustainability_supplier_sustainability_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`land_use_change` ADD CONSTRAINT `fk_sustainability_land_use_change_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= sustainability --> research (2 constraint(s)) =========
-- Requires: sustainability schema, research schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_input_usage_id` FOREIGN KEY (`input_usage_id`) REFERENCES `agriculture_ecm`.`research`.`input_usage`(`input_usage_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_treatment_application_id` FOREIGN KEY (`treatment_application_id`) REFERENCES `agriculture_ecm`.`research`.`treatment_application`(`treatment_application_id`);

-- ========= sustainability --> supply (6 constraint(s)) =========
-- Requires: sustainability schema, supply schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`ghg_emission` ADD CONSTRAINT `fk_sustainability_ghg_emission_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `agriculture_ecm`.`supply`.`shipment`(`shipment_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`energy_consumption` ADD CONSTRAINT `fk_sustainability_energy_consumption_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`waste_event` ADD CONSTRAINT `fk_sustainability_waste_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

-- ========= sustainability --> weather (10 constraint(s)) =========
-- Requires: sustainability schema, weather schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`emission_factor` ADD CONSTRAINT `fk_sustainability_emission_factor_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `agriculture_ecm`.`weather`.`zone`(`zone_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_evapotranspiration_id` FOREIGN KEY (`evapotranspiration_id`) REFERENCES `agriculture_ecm`.`weather`.`evapotranspiration`(`evapotranspiration_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_irrigation_schedule_id` FOREIGN KEY (`irrigation_schedule_id`) REFERENCES `agriculture_ecm`.`weather`.`irrigation_schedule`(`irrigation_schedule_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_usage` ADD CONSTRAINT `fk_sustainability_water_usage_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_stewardship_plan` ADD CONSTRAINT `fk_sustainability_water_stewardship_plan_drought_index_id` FOREIGN KEY (`drought_index_id`) REFERENCES `agriculture_ecm`.`weather`.`drought_index`(`drought_index_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`soil_carbon_sequestration` ADD CONSTRAINT `fk_sustainability_soil_carbon_sequestration_soil_temperature_id` FOREIGN KEY (`soil_temperature_id`) REFERENCES `agriculture_ecm`.`weather`.`soil_temperature`(`soil_temperature_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`biodiversity_assessment` ADD CONSTRAINT `fk_sustainability_biodiversity_assessment_observation_id` FOREIGN KEY (`observation_id`) REFERENCES `agriculture_ecm`.`weather`.`observation`(`observation_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_climate_risk_indicator_id` FOREIGN KEY (`climate_risk_indicator_id`) REFERENCES `agriculture_ecm`.`weather`.`climate_risk_indicator`(`climate_risk_indicator_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_drought_index_id` FOREIGN KEY (`drought_index_id`) REFERENCES `agriculture_ecm`.`weather`.`drought_index`(`drought_index_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);

-- ========= sustainability --> workforce (10 constraint(s)) =========
-- Requires: sustainability schema, workforce schema
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_stewardship_plan` ADD CONSTRAINT `fk_sustainability_water_stewardship_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`water_stewardship_plan` ADD CONSTRAINT `fk_sustainability_water_stewardship_plan_primary_water_employee_id` FOREIGN KEY (`primary_water_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`sustainability_audit` ADD CONSTRAINT `fk_sustainability_sustainability_audit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`practice_adoption` ADD CONSTRAINT `fk_sustainability_practice_adoption_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`target` ADD CONSTRAINT `fk_sustainability_target_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`supplier_sustainability` ADD CONSTRAINT `fk_sustainability_supplier_sustainability_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`climate_risk_assessment` ADD CONSTRAINT `fk_sustainability_climate_risk_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`environmental_incident` ADD CONSTRAINT `fk_sustainability_environmental_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`initiative` ADD CONSTRAINT `fk_sustainability_initiative_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`sustainability`.`initiative` ADD CONSTRAINT `fk_sustainability_initiative_initiative_employee_id` FOREIGN KEY (`initiative_employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= weather --> crop (10 constraint(s)) =========
-- Requires: weather schema, crop schema
ALTER TABLE `agriculture_ecm`.`weather`.`growing_degree_day` ADD CONSTRAINT `fk_weather_growing_degree_day_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`growing_degree_day` ADD CONSTRAINT `fk_weather_growing_degree_day_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`growing_degree_day` ADD CONSTRAINT `fk_weather_growing_degree_day_planting_event_id` FOREIGN KEY (`planting_event_id`) REFERENCES `agriculture_ecm`.`crop`.`planting_event`(`planting_event_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`evapotranspiration` ADD CONSTRAINT `fk_weather_evapotranspiration_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`frost_alert` ADD CONSTRAINT `fk_weather_frost_alert_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`precipitation_event` ADD CONSTRAINT `fk_weather_precipitation_event_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`planting_window` ADD CONSTRAINT `fk_weather_planting_window_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_record` ADD CONSTRAINT `fk_weather_insurance_record_loss_event_id` FOREIGN KEY (`loss_event_id`) REFERENCES `agriculture_ecm`.`crop`.`loss_event`(`loss_event_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_record` ADD CONSTRAINT `fk_weather_insurance_record_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_record` ADD CONSTRAINT `fk_weather_insurance_record_yield_record_id` FOREIGN KEY (`yield_record_id`) REFERENCES `agriculture_ecm`.`crop`.`yield_record`(`yield_record_id`);

-- ========= weather --> customer (4 constraint(s)) =========
-- Requires: weather schema, customer schema
ALTER TABLE `agriculture_ecm`.`weather`.`alert` ADD CONSTRAINT `fk_weather_alert_delivery_location_id` FOREIGN KEY (`delivery_location_id`) REFERENCES `agriculture_ecm`.`customer`.`delivery_location`(`delivery_location_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_policy` ADD CONSTRAINT `fk_weather_insurance_policy_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_policy` ADD CONSTRAINT `fk_weather_insurance_policy_policyholder_account_id` FOREIGN KEY (`policyholder_account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_claim` ADD CONSTRAINT `fk_weather_insurance_claim_account_id` FOREIGN KEY (`account_id`) REFERENCES `agriculture_ecm`.`customer`.`account`(`account_id`);

-- ========= weather --> finance (5 constraint(s)) =========
-- Requires: weather schema, finance schema
ALTER TABLE `agriculture_ecm`.`weather`.`frost_alert` ADD CONSTRAINT `fk_weather_frost_alert_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`planting_window` ADD CONSTRAINT `fk_weather_planting_window_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`irrigation_schedule` ADD CONSTRAINT `fk_weather_irrigation_schedule_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_record` ADD CONSTRAINT `fk_weather_insurance_record_government_program_id` FOREIGN KEY (`government_program_id`) REFERENCES `agriculture_ecm`.`finance`.`government_program`(`government_program_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`sensor_calibration` ADD CONSTRAINT `fk_weather_sensor_calibration_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `agriculture_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= weather --> land (22 constraint(s)) =========
-- Requires: weather schema, land schema
ALTER TABLE `agriculture_ecm`.`weather`.`station` ADD CONSTRAINT `fk_weather_station_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`station` ADD CONSTRAINT `fk_weather_station_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`observation` ADD CONSTRAINT `fk_weather_observation_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`forecast` ADD CONSTRAINT `fk_weather_forecast_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`growing_degree_day` ADD CONSTRAINT `fk_weather_growing_degree_day_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`evapotranspiration` ADD CONSTRAINT `fk_weather_evapotranspiration_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`frost_alert` ADD CONSTRAINT `fk_weather_frost_alert_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`precipitation_event` ADD CONSTRAINT `fk_weather_precipitation_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`spray_window` ADD CONSTRAINT `fk_weather_spray_window_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`planting_window` ADD CONSTRAINT `fk_weather_planting_window_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`planting_window` ADD CONSTRAINT `fk_weather_planting_window_soil_profile_id` FOREIGN KEY (`soil_profile_id`) REFERENCES `agriculture_ecm`.`land`.`soil_profile`(`soil_profile_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`climate_risk_indicator` ADD CONSTRAINT `fk_weather_climate_risk_indicator_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`drought_index` ADD CONSTRAINT `fk_weather_drought_index_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`soil_temperature` ADD CONSTRAINT `fk_weather_soil_temperature_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`irrigation_schedule` ADD CONSTRAINT `fk_weather_irrigation_schedule_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`irrigation_schedule` ADD CONSTRAINT `fk_weather_irrigation_schedule_irrigation_zone_id` FOREIGN KEY (`irrigation_zone_id`) REFERENCES `agriculture_ecm`.`land`.`irrigation_zone`(`irrigation_zone_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`alert` ADD CONSTRAINT `fk_weather_alert_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_record` ADD CONSTRAINT `fk_weather_insurance_record_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_record` ADD CONSTRAINT `fk_weather_insurance_record_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `agriculture_ecm`.`land`.`parcel`(`parcel_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`sensor_calibration` ADD CONSTRAINT `fk_weather_sensor_calibration_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_claim` ADD CONSTRAINT `fk_weather_insurance_claim_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`sensor` ADD CONSTRAINT `fk_weather_sensor_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);

-- ========= weather --> product (7 constraint(s)) =========
-- Requires: weather schema, product schema
ALTER TABLE `agriculture_ecm`.`weather`.`growing_degree_day` ADD CONSTRAINT `fk_weather_growing_degree_day_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`frost_alert` ADD CONSTRAINT `fk_weather_frost_alert_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`spray_window` ADD CONSTRAINT `fk_weather_spray_window_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`planting_window` ADD CONSTRAINT `fk_weather_planting_window_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`climate_risk_indicator` ADD CONSTRAINT `fk_weather_climate_risk_indicator_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_record` ADD CONSTRAINT `fk_weather_insurance_record_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_record` ADD CONSTRAINT `fk_weather_insurance_record_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);

-- ========= weather --> workforce (9 constraint(s)) =========
-- Requires: weather schema, workforce schema
ALTER TABLE `agriculture_ecm`.`weather`.`station` ADD CONSTRAINT `fk_weather_station_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`frost_alert` ADD CONSTRAINT `fk_weather_frost_alert_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`spray_window` ADD CONSTRAINT `fk_weather_spray_window_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`irrigation_schedule` ADD CONSTRAINT `fk_weather_irrigation_schedule_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`alert` ADD CONSTRAINT `fk_weather_alert_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `agriculture_ecm`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_record` ADD CONSTRAINT `fk_weather_insurance_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`sensor_calibration` ADD CONSTRAINT `fk_weather_sensor_calibration_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_policy` ADD CONSTRAINT `fk_weather_insurance_policy_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `agriculture_ecm`.`weather`.`insurance_claim` ADD CONSTRAINT `fk_weather_insurance_claim_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `agriculture_ecm`.`workforce`.`employee`(`employee_id`);

-- ========= workforce --> compliance (10 constraint(s)) =========
-- Requires: workforce schema, compliance schema
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_event_id` FOREIGN KEY (`event_id`) REFERENCES `agriculture_ecm`.`compliance`.`event`(`event_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `agriculture_ecm`.`compliance`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_worker_protection_record_id` FOREIGN KEY (`worker_protection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`worker_protection_record`(`worker_protection_record_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_license_id` FOREIGN KEY (`license_id`) REFERENCES `agriculture_ecm`.`compliance`.`license`(`license_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_regulatory_agency_id` FOREIGN KEY (`regulatory_agency_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_agency`(`regulatory_agency_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_regulatory_change_id` FOREIGN KEY (`regulatory_change_id`) REFERENCES `agriculture_ecm`.`compliance`.`regulatory_change`(`regulatory_change_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_violation_record_id` FOREIGN KEY (`violation_record_id`) REFERENCES `agriculture_ecm`.`compliance`.`violation_record`(`violation_record_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_compliance` ADD CONSTRAINT `fk_workforce_labor_compliance_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `agriculture_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= workforce --> crop (6 constraint(s)) =========
-- Requires: workforce schema, crop schema
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_field_crop_plan_id` FOREIGN KEY (`field_crop_plan_id`) REFERENCES `agriculture_ecm`.`crop`.`field_crop_plan`(`field_crop_plan_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_compliance` ADD CONSTRAINT `fk_workforce_labor_compliance_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`plan` ADD CONSTRAINT `fk_workforce_plan_growing_season_id` FOREIGN KEY (`growing_season_id`) REFERENCES `agriculture_ecm`.`crop`.`growing_season`(`growing_season_id`);

-- ========= workforce --> equipment (3 constraint(s)) =========
-- Requires: workforce schema, equipment schema
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `agriculture_ecm`.`equipment`.`work_order`(`work_order_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `agriculture_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= workforce --> finance (20 constraint(s)) =========
-- Requires: workforce schema, finance schema
ALTER TABLE `agriculture_ecm`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_contract` ADD CONSTRAINT `fk_workforce_labor_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`payroll` ADD CONSTRAINT `fk_workforce_payroll_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `agriculture_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_compliance` ADD CONSTRAINT `fk_workforce_labor_compliance_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `agriculture_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`plan` ADD CONSTRAINT `fk_workforce_plan_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `agriculture_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`plan` ADD CONSTRAINT `fk_workforce_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`plan` ADD CONSTRAINT `fk_workforce_plan_crop_enterprise_budget_id` FOREIGN KEY (`crop_enterprise_budget_id`) REFERENCES `agriculture_ecm`.`finance`.`crop_enterprise_budget`(`crop_enterprise_budget_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `agriculture_ecm`.`finance`.`cost_center`(`cost_center_id`);

-- ========= workforce --> land (8 constraint(s)) =========
-- Requires: workforce schema, land schema
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_contract` ADD CONSTRAINT `fk_workforce_labor_contract_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_field_id` FOREIGN KEY (`field_id`) REFERENCES `agriculture_ecm`.`land`.`field`(`field_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`plan` ADD CONSTRAINT `fk_workforce_plan_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_farm_operation_id` FOREIGN KEY (`farm_operation_id`) REFERENCES `agriculture_ecm`.`land`.`farm_operation`(`farm_operation_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_farm_unit_id` FOREIGN KEY (`farm_unit_id`) REFERENCES `agriculture_ecm`.`land`.`farm_unit`(`farm_unit_id`);

-- ========= workforce --> livestock (6 constraint(s)) =========
-- Requires: workforce schema, livestock schema
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_production_group_id` FOREIGN KEY (`production_group_id`) REFERENCES `agriculture_ecm`.`livestock`.`production_group`(`production_group_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_production_group_id` FOREIGN KEY (`production_group_id`) REFERENCES `agriculture_ecm`.`livestock`.`production_group`(`production_group_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_animal_id` FOREIGN KEY (`animal_id`) REFERENCES `agriculture_ecm`.`livestock`.`animal`(`animal_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_herd_id` FOREIGN KEY (`herd_id`) REFERENCES `agriculture_ecm`.`livestock`.`herd`(`herd_id`);

-- ========= workforce --> procurement (5 constraint(s)) =========
-- Requires: workforce schema, procurement schema
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_contract` ADD CONSTRAINT `fk_workforce_labor_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `agriculture_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_input_catalog_id` FOREIGN KEY (`input_catalog_id`) REFERENCES `agriculture_ecm`.`procurement`.`input_catalog`(`input_catalog_id`);

-- ========= workforce --> product (12 constraint(s)) =========
-- Requires: workforce schema, product schema
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_contract` ADD CONSTRAINT `fk_workforce_labor_contract_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_livestock_product_id` FOREIGN KEY (`livestock_product_id`) REFERENCES `agriculture_ecm`.`product`.`livestock_product`(`livestock_product_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_processed_good_id` FOREIGN KEY (`processed_good_id`) REFERENCES `agriculture_ecm`.`product`.`processed_good`(`processed_good_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_seed_variety_id` FOREIGN KEY (`seed_variety_id`) REFERENCES `agriculture_ecm`.`product`.`seed_variety`(`seed_variety_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_grading_standard_id` FOREIGN KEY (`grading_standard_id`) REFERENCES `agriculture_ecm`.`product`.`grading_standard`(`grading_standard_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_agrochemical_product_id` FOREIGN KEY (`agrochemical_product_id`) REFERENCES `agriculture_ecm`.`product`.`agrochemical_product`(`agrochemical_product_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`plan` ADD CONSTRAINT `fk_workforce_plan_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`plan` ADD CONSTRAINT `fk_workforce_plan_master_id` FOREIGN KEY (`master_id`) REFERENCES `agriculture_ecm`.`product`.`master`(`master_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `agriculture_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= workforce --> quality (6 constraint(s)) =========
-- Requires: workforce schema, quality schema
ALTER TABLE `agriculture_ecm`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_quality_certification_id` FOREIGN KEY (`quality_certification_id`) REFERENCES `agriculture_ecm`.`quality`.`quality_certification`(`quality_certification_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_compliance` ADD CONSTRAINT `fk_workforce_labor_compliance_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection`(`inspection_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_inspection_finding_id` FOREIGN KEY (`inspection_finding_id`) REFERENCES `agriculture_ecm`.`quality`.`inspection_finding`(`inspection_finding_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_haccp_plan_id` FOREIGN KEY (`haccp_plan_id`) REFERENCES `agriculture_ecm`.`quality`.`haccp_plan`(`haccp_plan_id`);

-- ========= workforce --> sales (1 constraint(s)) =========
-- Requires: workforce schema, sales schema
ALTER TABLE `agriculture_ecm`.`workforce`.`plan` ADD CONSTRAINT `fk_workforce_plan_demand_forecast_id` FOREIGN KEY (`demand_forecast_id`) REFERENCES `agriculture_ecm`.`sales`.`demand_forecast`(`demand_forecast_id`);

-- ========= workforce --> supply (5 constraint(s)) =========
-- Requires: workforce schema, supply schema
ALTER TABLE `agriculture_ecm`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`labor_contract` ADD CONSTRAINT `fk_workforce_labor_contract_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`shift` ADD CONSTRAINT `fk_workforce_shift_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `agriculture_ecm`.`supply`.`facility`(`facility_id`);

-- ========= workforce --> sustainability (3 constraint(s)) =========
-- Requires: workforce schema, sustainability schema
ALTER TABLE `agriculture_ecm`.`workforce`.`training_event` ADD CONSTRAINT `fk_workforce_training_event_regenerative_practice_id` FOREIGN KEY (`regenerative_practice_id`) REFERENCES `agriculture_ecm`.`sustainability`.`regenerative_practice`(`regenerative_practice_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_environmental_incident_id` FOREIGN KEY (`environmental_incident_id`) REFERENCES `agriculture_ecm`.`sustainability`.`environmental_incident`(`environmental_incident_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`plan` ADD CONSTRAINT `fk_workforce_plan_target_id` FOREIGN KEY (`target_id`) REFERENCES `agriculture_ecm`.`sustainability`.`target`(`target_id`);

-- ========= workforce --> weather (7 constraint(s)) =========
-- Requires: workforce schema, weather schema
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_frost_alert_id` FOREIGN KEY (`frost_alert_id`) REFERENCES `agriculture_ecm`.`weather`.`frost_alert`(`frost_alert_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_planting_window_id` FOREIGN KEY (`planting_window_id`) REFERENCES `agriculture_ecm`.`weather`.`planting_window`(`planting_window_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`work_assignment` ADD CONSTRAINT `fk_workforce_work_assignment_spray_window_id` FOREIGN KEY (`spray_window_id`) REFERENCES `agriculture_ecm`.`weather`.`spray_window`(`spray_window_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `agriculture_ecm`.`weather`.`alert`(`alert_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`safety_event` ADD CONSTRAINT `fk_workforce_safety_event_precipitation_event_id` FOREIGN KEY (`precipitation_event_id`) REFERENCES `agriculture_ecm`.`weather`.`precipitation_event`(`precipitation_event_id`);
ALTER TABLE `agriculture_ecm`.`workforce`.`plan` ADD CONSTRAINT `fk_workforce_plan_planting_window_id` FOREIGN KEY (`planting_window_id`) REFERENCES `agriculture_ecm`.`weather`.`planting_window`(`planting_window_id`);

