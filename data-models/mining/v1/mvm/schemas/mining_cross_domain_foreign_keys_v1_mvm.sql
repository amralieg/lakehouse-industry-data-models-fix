-- Cross-Domain Foreign Keys for Business: Mining | Version: v1_mvm
-- Generated on: 2026-05-05 14:20:19
-- Total cross-domain FK constraints: 1452
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: customer, equipment, exploration, finance, geology, hse, laboratory, maintenance, mine, processing, procurement, product, sales, tailings, tenement

-- ========= customer --> finance (7 constraint(s)) =========
-- Requires: customer schema, finance schema
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ADD CONSTRAINT `fk_customer_counterparty_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `mining_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ADD CONSTRAINT `fk_customer_counterparty_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ADD CONSTRAINT `fk_customer_counterparty_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ADD CONSTRAINT `fk_customer_delivery_destination_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ADD CONSTRAINT `fk_customer_credit_limit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ADD CONSTRAINT `fk_customer_payment_term_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ADD CONSTRAINT `fk_customer_letter_of_credit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= customer --> procurement (2 constraint(s)) =========
-- Requires: customer schema, procurement schema
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ADD CONSTRAINT `fk_customer_delivery_destination_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ADD CONSTRAINT `fk_customer_letter_of_credit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= customer --> product (2 constraint(s)) =========
-- Requires: customer schema, product schema
ALTER TABLE `mining_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ADD CONSTRAINT `fk_customer_letter_of_credit_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= customer --> tenement (1 constraint(s)) =========
-- Requires: customer schema, tenement schema
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ADD CONSTRAINT `fk_customer_letter_of_credit_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= equipment --> customer (1 constraint(s)) =========
-- Requires: equipment schema, customer schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= equipment --> finance (20 constraint(s)) =========
-- Requires: equipment schema, finance schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`equipment`.`component_register` ADD CONSTRAINT `fk_equipment_component_register_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`equipment`.`component_register` ADD CONSTRAINT `fk_equipment_component_register_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `mining_ecm`.`equipment`.`component_register` ADD CONSTRAINT `fk_equipment_component_register_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`equipment`.`tyre_record` ADD CONSTRAINT `fk_equipment_tyre_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= equipment --> geology (1 constraint(s)) =========
-- Requires: equipment schema, geology schema
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_grade_control_sample_id` FOREIGN KEY (`grade_control_sample_id`) REFERENCES `mining_ecm`.`geology`.`grade_control_sample`(`grade_control_sample_id`);

-- ========= equipment --> hse (16 constraint(s)) =========
-- Requires: equipment schema, hse schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`equipment`.`telemetry_event` ADD CONSTRAINT `fk_equipment_telemetry_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `mining_ecm`.`hse`.`audit`(`audit_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`equipment`.`component_register` ADD CONSTRAINT `fk_equipment_component_register_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`equipment`.`tyre_record` ADD CONSTRAINT `fk_equipment_tyre_record_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);

-- ========= equipment --> maintenance (14 constraint(s)) =========
-- Requires: equipment schema, maintenance schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_shutdown_plan_id` FOREIGN KEY (`shutdown_plan_id`) REFERENCES `mining_ecm`.`maintenance`.`shutdown_plan`(`shutdown_plan_id`);
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `mining_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_standard_job_id` FOREIGN KEY (`standard_job_id`) REFERENCES `mining_ecm`.`maintenance`.`standard_job`(`standard_job_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_shutdown_plan_id` FOREIGN KEY (`shutdown_plan_id`) REFERENCES `mining_ecm`.`maintenance`.`shutdown_plan`(`shutdown_plan_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`equipment`.`tyre_record` ADD CONSTRAINT `fk_equipment_tyre_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= equipment --> mine (18 constraint(s)) =========
-- Requires: equipment schema, mine schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`equipment`.`telemetry_event` ADD CONSTRAINT `fk_equipment_telemetry_event_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_haulage_cycle_id` FOREIGN KEY (`haulage_cycle_id`) REFERENCES `mining_ecm`.`mine`.`haulage_cycle`(`haulage_cycle_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`equipment`.`tyre_record` ADD CONSTRAINT `fk_equipment_tyre_record_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);

-- ========= equipment --> processing (2 constraint(s)) =========
-- Requires: equipment schema, processing schema
ALTER TABLE `mining_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_shift_production_run_id` FOREIGN KEY (`shift_production_run_id`) REFERENCES `mining_ecm`.`processing`.`shift_production_run`(`shift_production_run_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_shift_production_run_id` FOREIGN KEY (`shift_production_run_id`) REFERENCES `mining_ecm`.`processing`.`shift_production_run`(`shift_production_run_id`);

-- ========= equipment --> procurement (10 constraint(s)) =========
-- Requires: equipment schema, procurement schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`equipment`.`component_register` ADD CONSTRAINT `fk_equipment_component_register_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `mining_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `mining_ecm`.`equipment`.`component_register` ADD CONSTRAINT `fk_equipment_component_register_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`equipment`.`component_register` ADD CONSTRAINT `fk_equipment_component_register_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`equipment`.`tyre_record` ADD CONSTRAINT `fk_equipment_tyre_record_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `mining_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `mining_ecm`.`equipment`.`tyre_record` ADD CONSTRAINT `fk_equipment_tyre_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`equipment`.`tyre_record` ADD CONSTRAINT `fk_equipment_tyre_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= equipment --> product (8 constraint(s)) =========
-- Requires: equipment schema, product schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_class` ADD CONSTRAINT `fk_equipment_asset_class_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);

-- ========= equipment --> sales (3 constraint(s)) =========
-- Requires: equipment schema, sales schema
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_shipment_nomination_id` FOREIGN KEY (`shipment_nomination_id`) REFERENCES `mining_ecm`.`sales`.`shipment_nomination`(`shipment_nomination_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_volume_plan_id` FOREIGN KEY (`volume_plan_id`) REFERENCES `mining_ecm`.`sales`.`volume_plan`(`volume_plan_id`);
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_commodity_order_id` FOREIGN KEY (`commodity_order_id`) REFERENCES `mining_ecm`.`sales`.`commodity_order`(`commodity_order_id`);

-- ========= equipment --> tailings (6 constraint(s)) =========
-- Requires: equipment schema, tailings schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`equipment`.`telemetry_event` ADD CONSTRAINT `fk_equipment_telemetry_event_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`equipment`.`telemetry_event` ADD CONSTRAINT `fk_equipment_telemetry_event_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);

-- ========= equipment --> tenement (12 constraint(s)) =========
-- Requires: equipment schema, tenement schema
ALTER TABLE `mining_ecm`.`equipment`.`asset` ADD CONSTRAINT `fk_equipment_asset_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fleet_assignment` ADD CONSTRAINT `fk_equipment_fleet_assignment_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`equipment`.`oee_record` ADD CONSTRAINT `fk_equipment_oee_record_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`equipment`.`downtime_event` ADD CONSTRAINT `fk_equipment_downtime_event_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`equipment`.`fuel_consumption` ADD CONSTRAINT `fk_equipment_fuel_consumption_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`equipment`.`utilisation_record` ADD CONSTRAINT `fk_equipment_utilisation_record_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`equipment`.`payload_cycle` ADD CONSTRAINT `fk_equipment_payload_cycle_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`equipment`.`inspection` ADD CONSTRAINT `fk_equipment_inspection_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_heritage_clearance_id` FOREIGN KEY (`heritage_clearance_id`) REFERENCES `mining_ecm`.`tenement`.`heritage_clearance`(`heritage_clearance_id`);
ALTER TABLE `mining_ecm`.`equipment`.`asset_lifecycle_event` ADD CONSTRAINT `fk_equipment_asset_lifecycle_event_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= exploration --> customer (1 constraint(s)) =========
-- Requires: exploration schema, customer schema
ALTER TABLE `mining_ecm`.`exploration`.`licence` ADD CONSTRAINT `fk_exploration_licence_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= exploration --> equipment (5 constraint(s)) =========
-- Requires: exploration schema, equipment schema
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ADD CONSTRAINT `fk_exploration_drill_hole_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ADD CONSTRAINT `fk_exploration_drill_hole_survey_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= exploration --> finance (20 constraint(s)) =========
-- Requires: exploration schema, finance schema
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`exploration`.`licence` ADD CONSTRAINT `fk_exploration_licence_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`licence` ADD CONSTRAINT `fk_exploration_licence_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`licence` ADD CONSTRAINT `fk_exploration_licence_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`exploration`.`survey` ADD CONSTRAINT `fk_exploration_survey_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ADD CONSTRAINT `fk_exploration_resource_estimate_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ADD CONSTRAINT `fk_exploration_ore_reserve_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= exploration --> geology (2 constraint(s)) =========
-- Requires: exploration schema, geology schema
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ADD CONSTRAINT `fk_exploration_resource_estimate_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ADD CONSTRAINT `fk_exploration_ore_reserve_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= exploration --> hse (9 constraint(s)) =========
-- Requires: exploration schema, hse schema
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`exploration`.`licence` ADD CONSTRAINT `fk_exploration_licence_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ADD CONSTRAINT `fk_exploration_drill_hole_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`exploration`.`geological_log` ADD CONSTRAINT `fk_exploration_geological_log_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);

-- ========= exploration --> maintenance (1 constraint(s)) =========
-- Requires: exploration schema, maintenance schema
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= exploration --> mine (1 constraint(s)) =========
-- Requires: exploration schema, mine schema
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);

-- ========= exploration --> procurement (10 constraint(s)) =========
-- Requires: exploration schema, procurement schema
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ADD CONSTRAINT `fk_exploration_drill_hole_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole_survey` ADD CONSTRAINT `fk_exploration_drill_hole_survey_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`exploration`.`survey` ADD CONSTRAINT `fk_exploration_survey_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`exploration`.`survey` ADD CONSTRAINT `fk_exploration_survey_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= exploration --> product (11 constraint(s)) =========
-- Requires: exploration schema, product schema
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_hole` ADD CONSTRAINT `fk_exploration_drill_hole_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`exploration`.`survey` ADD CONSTRAINT `fk_exploration_survey_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ADD CONSTRAINT `fk_exploration_resource_estimate_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`exploration`.`resource_estimate` ADD CONSTRAINT `fk_exploration_resource_estimate_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ADD CONSTRAINT `fk_exploration_ore_reserve_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ADD CONSTRAINT `fk_exploration_ore_reserve_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `mining_ecm`.`product`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ADD CONSTRAINT `fk_exploration_ore_reserve_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`exploration`.`ore_reserve` ADD CONSTRAINT `fk_exploration_ore_reserve_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);

-- ========= exploration --> tenement (8 constraint(s)) =========
-- Requires: exploration schema, tenement schema
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_heritage_clearance_id` FOREIGN KEY (`heritage_clearance_id`) REFERENCES `mining_ecm`.`tenement`.`heritage_clearance`(`heritage_clearance_id`);
ALTER TABLE `mining_ecm`.`exploration`.`prospect` ADD CONSTRAINT `fk_exploration_prospect_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`exploration`.`licence` ADD CONSTRAINT `fk_exploration_licence_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_expenditure_commitment_id` FOREIGN KEY (`expenditure_commitment_id`) REFERENCES `mining_ecm`.`tenement`.`expenditure_commitment`(`expenditure_commitment_id`);
ALTER TABLE `mining_ecm`.`exploration`.`drill_program` ADD CONSTRAINT `fk_exploration_drill_program_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`exploration`.`exploration_sample` ADD CONSTRAINT `fk_exploration_exploration_sample_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_expenditure_commitment_id` FOREIGN KEY (`expenditure_commitment_id`) REFERENCES `mining_ecm`.`tenement`.`expenditure_commitment`(`expenditure_commitment_id`);
ALTER TABLE `mining_ecm`.`exploration`.`expenditure` ADD CONSTRAINT `fk_exploration_expenditure_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= finance --> equipment (2 constraint(s)) =========
-- Requires: finance schema, equipment schema
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ADD CONSTRAINT `fk_finance_capex_budget_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);

-- ========= finance --> mine (9 constraint(s)) =========
-- Requires: finance schema, mine schema
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ADD CONSTRAINT `fk_finance_capex_budget_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ADD CONSTRAINT `fk_finance_opex_budget_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ADD CONSTRAINT `fk_finance_cost_performance_report_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`finance`.`cost_performance_report` ADD CONSTRAINT `fk_finance_cost_performance_report_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`finance`.`rehabilitation_provision` ADD CONSTRAINT `fk_finance_rehabilitation_provision_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);

-- ========= finance --> processing (3 constraint(s)) =========
-- Requires: finance schema, processing schema
ALTER TABLE `mining_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ADD CONSTRAINT `fk_finance_opex_budget_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);

-- ========= finance --> procurement (6 constraint(s)) =========
-- Requires: finance schema, procurement schema
ALTER TABLE `mining_ecm`.`finance`.`capex_budget` ADD CONSTRAINT `fk_finance_capex_budget_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`finance`.`opex_budget` ADD CONSTRAINT `fk_finance_opex_budget_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `mining_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`finance`.`vendor_invoice` ADD CONSTRAINT `fk_finance_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= finance --> tenement (1 constraint(s)) =========
-- Requires: finance schema, tenement schema
ALTER TABLE `mining_ecm`.`finance`.`royalty_obligation` ADD CONSTRAINT `fk_finance_royalty_obligation_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= geology --> equipment (3 constraint(s)) =========
-- Requires: geology schema, equipment schema
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ADD CONSTRAINT `fk_geology_production_drillhole_survey_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= geology --> exploration (11 constraint(s)) =========
-- Requires: geology schema, exploration schema
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_drill_program_id` FOREIGN KEY (`drill_program_id`) REFERENCES `mining_ecm`.`exploration`.`drill_program`(`drill_program_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole_survey` ADD CONSTRAINT `fk_geology_production_drillhole_survey_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ADD CONSTRAINT `fk_geology_lithology_log_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`geology`.`structural_measurement` ADD CONSTRAINT `fk_geology_structural_measurement_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ADD CONSTRAINT `fk_geology_geotechnical_log_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model` ADD CONSTRAINT `fk_geology_block_model_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ADD CONSTRAINT `fk_geology_geological_domain_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);

-- ========= geology --> finance (15 constraint(s)) =========
-- Requires: geology schema, finance schema
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model` ADD CONSTRAINT `fk_geology_block_model_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ADD CONSTRAINT `fk_geology_geological_domain_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ADD CONSTRAINT `fk_geology_geological_domain_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ADD CONSTRAINT `fk_geology_wireframe_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ADD CONSTRAINT `fk_geology_wireframe_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_project_valuation_id` FOREIGN KEY (`project_valuation_id`) REFERENCES `mining_ecm`.`finance`.`project_valuation`(`project_valuation_id`);

-- ========= geology --> laboratory (9 constraint(s)) =========
-- Requires: geology schema, laboratory schema
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_sample_program_id` FOREIGN KEY (`sample_program_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_program`(`sample_program_id`);
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ADD CONSTRAINT `fk_geology_lithology_log_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`geology`.`lithology_log` ADD CONSTRAINT `fk_geology_lithology_log_sample_program_id` FOREIGN KEY (`sample_program_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_program`(`sample_program_id`);
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ADD CONSTRAINT `fk_geology_geotechnical_log_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`geology`.`geotechnical_log` ADD CONSTRAINT `fk_geology_geotechnical_log_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_sample_program_id` FOREIGN KEY (`sample_program_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_program`(`sample_program_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);

-- ========= geology --> mine (16 constraint(s)) =========
-- Requires: geology schema, mine schema
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_bench_id` FOREIGN KEY (`bench_id`) REFERENCES `mining_ecm`.`mine`.`bench`(`bench_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_blast_execution_id` FOREIGN KEY (`blast_execution_id`) REFERENCES `mining_ecm`.`mine`.`blast_execution`(`blast_execution_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_blast_pattern_id` FOREIGN KEY (`blast_pattern_id`) REFERENCES `mining_ecm`.`mine`.`blast_pattern`(`blast_pattern_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ADD CONSTRAINT `fk_geology_block_model_cell_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ADD CONSTRAINT `fk_geology_block_model_cell_pit_design_id` FOREIGN KEY (`pit_design_id`) REFERENCES `mining_ecm`.`mine`.`pit_design`(`pit_design_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_bench_id` FOREIGN KEY (`bench_id`) REFERENCES `mining_ecm`.`mine`.`bench`(`bench_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_blast_pattern_id` FOREIGN KEY (`blast_pattern_id`) REFERENCES `mining_ecm`.`mine`.`blast_pattern`(`blast_pattern_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_pit_or_level_id` FOREIGN KEY (`pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ADD CONSTRAINT `fk_geology_geological_domain_bench_id` FOREIGN KEY (`bench_id`) REFERENCES `mining_ecm`.`mine`.`bench`(`bench_id`);
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ADD CONSTRAINT `fk_geology_wireframe_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);

-- ========= geology --> procurement (2 constraint(s)) =========
-- Requires: geology schema, procurement schema
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= geology --> product (10 constraint(s)) =========
-- Requires: geology schema, product schema
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`geology`.`geological_unit` ADD CONSTRAINT `fk_geology_geological_unit_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model` ADD CONSTRAINT `fk_geology_block_model_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`geology`.`block_model_cell` ADD CONSTRAINT `fk_geology_block_model_cell_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`geology`.`grade_control_sample` ADD CONSTRAINT `fk_geology_grade_control_sample_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`geology`.`geological_domain` ADD CONSTRAINT `fk_geology_geological_domain_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`geology`.`wireframe` ADD CONSTRAINT `fk_geology_wireframe_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);

-- ========= geology --> tenement (5 constraint(s)) =========
-- Requires: geology schema, tenement schema
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `mining_ecm`.`tenement`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `mining_ecm`.`geology`.`orebody` ADD CONSTRAINT `fk_geology_orebody_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`geology`.`production_drillhole` ADD CONSTRAINT `fk_geology_production_drillhole_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `mining_ecm`.`tenement`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `mining_ecm`.`geology`.`resource_statement` ADD CONSTRAINT `fk_geology_resource_statement_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= hse --> customer (9 constraint(s)) =========
-- Requires: hse schema, customer schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);

-- ========= hse --> equipment (6 constraint(s)) =========
-- Requires: hse schema, equipment schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `mining_ecm`.`equipment`.`inspection`(`inspection_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= hse --> exploration (1 constraint(s)) =========
-- Requires: hse schema, exploration schema
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);

-- ========= hse --> finance (23 constraint(s)) =========
-- Requires: hse schema, finance schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ADD CONSTRAINT `fk_hse_environmental_permit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ADD CONSTRAINT `fk_hse_environmental_permit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ADD CONSTRAINT `fk_hse_environmental_permit_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_royalty_obligation_id` FOREIGN KEY (`royalty_obligation_id`) REFERENCES `mining_ecm`.`finance`.`royalty_obligation`(`royalty_obligation_id`);
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= hse --> geology (16 constraint(s)) =========
-- Requires: hse schema, geology schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_production_drillhole_id` FOREIGN KEY (`production_drillhole_id`) REFERENCES `mining_ecm`.`geology`.`production_drillhole`(`production_drillhole_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);

-- ========= hse --> laboratory (7 constraint(s)) =========
-- Requires: hse schema, laboratory schema
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `mining_ecm`.`laboratory`.`instrument`(`instrument_id`);

-- ========= hse --> mine (13 constraint(s)) =========
-- Requires: hse schema, mine schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ADD CONSTRAINT `fk_hse_environmental_permit_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);

-- ========= hse --> processing (7 constraint(s)) =========
-- Requires: hse schema, processing schema
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);

-- ========= hse --> procurement (20 constraint(s)) =========
-- Requires: hse schema, procurement schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= hse --> product (19 constraint(s)) =========
-- Requires: hse schema, product schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ADD CONSTRAINT `fk_hse_environmental_permit_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`hse`.`hazard` ADD CONSTRAINT `fk_hse_hazard_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= hse --> sales (3 constraint(s)) =========
-- Requires: hse schema, sales schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `mining_ecm`.`sales`.`vessel`(`vessel_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);

-- ========= hse --> tenement (21 constraint(s)) =========
-- Requires: hse schema, tenement schema
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`hse`.`incident` ADD CONSTRAINT `fk_hse_incident_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`hse`.`corrective_action` ADD CONSTRAINT `fk_hse_corrective_action_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`hse`.`risk_assessment` ADD CONSTRAINT `fk_hse_risk_assessment_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`safety_observation` ADD CONSTRAINT `fk_hse_safety_observation_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_monitoring` ADD CONSTRAINT `fk_hse_environmental_monitoring_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`environmental_permit` ADD CONSTRAINT `fk_hse_environmental_permit_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_application_id` FOREIGN KEY (`application_id`) REFERENCES `mining_ecm`.`tenement`.`application`(`application_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`hse`.`regulatory_submission` ADD CONSTRAINT `fk_hse_regulatory_submission_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`emergency_response_plan` ADD CONSTRAINT `fk_hse_emergency_response_plan_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`hse`.`training_record` ADD CONSTRAINT `fk_hse_training_record_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`chemical_register` ADD CONSTRAINT `fk_hse_chemical_register_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`hse`.`audit` ADD CONSTRAINT `fk_hse_audit_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`hse`.`investigation` ADD CONSTRAINT `fk_hse_investigation_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= laboratory --> customer (5 constraint(s)) =========
-- Requires: laboratory schema, customer schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ADD CONSTRAINT `fk_laboratory_crm_standard_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ADD CONSTRAINT `fk_laboratory_laboratory_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= laboratory --> equipment (6 constraint(s)) =========
-- Requires: laboratory schema, equipment schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_component_register_id` FOREIGN KEY (`component_register_id`) REFERENCES `mining_ecm`.`equipment`.`component_register`(`component_register_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= laboratory --> exploration (5 constraint(s)) =========
-- Requires: laboratory schema, exploration schema
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_drill_program_id` FOREIGN KEY (`drill_program_id`) REFERENCES `mining_ecm`.`exploration`.`drill_program`(`drill_program_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_licence_id` FOREIGN KEY (`licence_id`) REFERENCES `mining_ecm`.`exploration`.`licence`(`licence_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);

-- ========= laboratory --> finance (9 constraint(s)) =========
-- Requires: laboratory schema, finance schema
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_project_valuation_id` FOREIGN KEY (`project_valuation_id`) REFERENCES `mining_ecm`.`finance`.`project_valuation`(`project_valuation_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `mining_ecm`.`finance`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);

-- ========= laboratory --> geology (2 constraint(s)) =========
-- Requires: laboratory schema, geology schema
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= laboratory --> hse (20 constraint(s)) =========
-- Requires: laboratory schema, hse schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ADD CONSTRAINT `fk_laboratory_qaqc_result_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ADD CONSTRAINT `fk_laboratory_crm_standard_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ADD CONSTRAINT `fk_laboratory_laboratory_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);

-- ========= laboratory --> maintenance (3 constraint(s)) =========
-- Requires: laboratory schema, maintenance schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_shutdown_plan_id` FOREIGN KEY (`shutdown_plan_id`) REFERENCES `mining_ecm`.`maintenance`.`shutdown_plan`(`shutdown_plan_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= laboratory --> mine (11 constraint(s)) =========
-- Requires: laboratory schema, mine schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_pit_or_level_id` FOREIGN KEY (`pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ADD CONSTRAINT `fk_laboratory_laboratory_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_pit_or_level_id` FOREIGN KEY (`pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);

-- ========= laboratory --> processing (1 constraint(s)) =========
-- Requires: laboratory schema, processing schema
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_shift_production_run_id` FOREIGN KEY (`shift_production_run_id`) REFERENCES `mining_ecm`.`processing`.`shift_production_run`(`shift_production_run_id`);

-- ========= laboratory --> procurement (2 constraint(s)) =========
-- Requires: laboratory schema, procurement schema
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= laboratory --> product (19 constraint(s)) =========
-- Requires: laboratory schema, product schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ADD CONSTRAINT `fk_laboratory_qaqc_sample_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ADD CONSTRAINT `fk_laboratory_qaqc_sample_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ADD CONSTRAINT `fk_laboratory_qaqc_result_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ADD CONSTRAINT `fk_laboratory_qaqc_result_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ADD CONSTRAINT `fk_laboratory_crm_standard_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);

-- ========= laboratory --> tailings (3 constraint(s)) =========
-- Requires: laboratory schema, tailings schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);

-- ========= laboratory --> tenement (4 constraint(s)) =========
-- Requires: laboratory schema, tenement schema
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_expenditure_commitment_id` FOREIGN KEY (`expenditure_commitment_id`) REFERENCES `mining_ecm`.`tenement`.`expenditure_commitment`(`expenditure_commitment_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= maintenance --> customer (3 constraint(s)) =========
-- Requires: maintenance schema, customer schema
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ADD CONSTRAINT `fk_maintenance_labour_record_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= maintenance --> equipment (18 constraint(s)) =========
-- Requires: maintenance schema, equipment schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_component_register_id` FOREIGN KEY (`component_register_id`) REFERENCES `mining_ecm`.`equipment`.`component_register`(`component_register_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ADD CONSTRAINT `fk_maintenance_asset_bom_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ADD CONSTRAINT `fk_maintenance_asset_bom_primary_component_asset_id` FOREIGN KEY (`primary_component_asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_component_register_id` FOREIGN KEY (`component_register_id`) REFERENCES `mining_ecm`.`equipment`.`component_register`(`component_register_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_component_register_id` FOREIGN KEY (`component_register_id`) REFERENCES `mining_ecm`.`equipment`.`component_register`(`component_register_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_downtime_event_id` FOREIGN KEY (`downtime_event_id`) REFERENCES `mining_ecm`.`equipment`.`downtime_event`(`downtime_event_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_component_register_id` FOREIGN KEY (`component_register_id`) REFERENCES `mining_ecm`.`equipment`.`component_register`(`component_register_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ADD CONSTRAINT `fk_maintenance_work_order_cost_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ADD CONSTRAINT `fk_maintenance_standard_job_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ADD CONSTRAINT `fk_maintenance_strategy_asset_class_id` FOREIGN KEY (`asset_class_id`) REFERENCES `mining_ecm`.`equipment`.`asset_class`(`asset_class_id`);

-- ========= maintenance --> exploration (2 constraint(s)) =========
-- Requires: maintenance schema, exploration schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_drill_program_id` FOREIGN KEY (`drill_program_id`) REFERENCES `mining_ecm`.`exploration`.`drill_program`(`drill_program_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_drill_program_id` FOREIGN KEY (`drill_program_id`) REFERENCES `mining_ecm`.`exploration`.`drill_program`(`drill_program_id`);

-- ========= maintenance --> finance (23 constraint(s)) =========
-- Requires: maintenance schema, finance schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ADD CONSTRAINT `fk_maintenance_labour_record_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ADD CONSTRAINT `fk_maintenance_labour_record_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ADD CONSTRAINT `fk_maintenance_labour_record_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ADD CONSTRAINT `fk_maintenance_work_order_cost_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ADD CONSTRAINT `fk_maintenance_work_order_cost_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ADD CONSTRAINT `fk_maintenance_work_order_cost_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ADD CONSTRAINT `fk_maintenance_strategy_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);

-- ========= maintenance --> geology (6 constraint(s)) =========
-- Requires: maintenance schema, geology schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_production_drillhole_id` FOREIGN KEY (`production_drillhole_id`) REFERENCES `mining_ecm`.`geology`.`production_drillhole`(`production_drillhole_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= maintenance --> hse (21 constraint(s)) =========
-- Requires: maintenance schema, hse schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `mining_ecm`.`hse`.`audit`(`audit_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_safety_observation_id` FOREIGN KEY (`safety_observation_id`) REFERENCES `mining_ecm`.`hse`.`safety_observation`(`safety_observation_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ADD CONSTRAINT `fk_maintenance_standard_job_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ADD CONSTRAINT `fk_maintenance_standard_job_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_hazard_id` FOREIGN KEY (`hazard_id`) REFERENCES `mining_ecm`.`hse`.`hazard`(`hazard_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ADD CONSTRAINT `fk_maintenance_strategy_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);

-- ========= maintenance --> laboratory (3 constraint(s)) =========
-- Requires: maintenance schema, laboratory schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `mining_ecm`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `mining_ecm`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `mining_ecm`.`laboratory`.`instrument`(`instrument_id`);

-- ========= maintenance --> mine (3 constraint(s)) =========
-- Requires: maintenance schema, mine schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);

-- ========= maintenance --> procurement (10 constraint(s)) =========
-- Requires: maintenance schema, procurement schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `mining_ecm`.`procurement`.`requisition`(`requisition_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ADD CONSTRAINT `fk_maintenance_asset_bom_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ADD CONSTRAINT `fk_maintenance_spare_part_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `mining_ecm`.`procurement`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);

-- ========= maintenance --> product (4 constraint(s)) =========
-- Requires: maintenance schema, product schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);

-- ========= maintenance --> sales (2 constraint(s)) =========
-- Requires: maintenance schema, sales schema
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_offtake_agreement_id` FOREIGN KEY (`offtake_agreement_id`) REFERENCES `mining_ecm`.`sales`.`offtake_agreement`(`offtake_agreement_id`);

-- ========= maintenance --> tailings (17 constraint(s)) =========
-- Requires: maintenance schema, tailings schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_geotechnical_instrument_id` FOREIGN KEY (`geotechnical_instrument_id`) REFERENCES `mining_ecm`.`tailings`.`geotechnical_instrument`(`geotechnical_instrument_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_geotechnical_instrument_id` FOREIGN KEY (`geotechnical_instrument_id`) REFERENCES `mining_ecm`.`tailings`.`geotechnical_instrument`(`geotechnical_instrument_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_geotechnical_instrument_id` FOREIGN KEY (`geotechnical_instrument_id`) REFERENCES `mining_ecm`.`tailings`.`geotechnical_instrument`(`geotechnical_instrument_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_geotechnical_instrument_id` FOREIGN KEY (`geotechnical_instrument_id`) REFERENCES `mining_ecm`.`tailings`.`geotechnical_instrument`(`geotechnical_instrument_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ADD CONSTRAINT `fk_maintenance_strategy_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);

-- ========= maintenance --> tenement (13 constraint(s)) =========
-- Requires: maintenance schema, tenement schema
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_heritage_clearance_id` FOREIGN KEY (`heritage_clearance_id`) REFERENCES `mining_ecm`.`tenement`.`heritage_clearance`(`heritage_clearance_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_surface_right_id` FOREIGN KEY (`surface_right_id`) REFERENCES `mining_ecm`.`tenement`.`surface_right`(`surface_right_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_expenditure_commitment_id` FOREIGN KEY (`expenditure_commitment_id`) REFERENCES `mining_ecm`.`tenement`.`expenditure_commitment`(`expenditure_commitment_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_heritage_clearance_id` FOREIGN KEY (`heritage_clearance_id`) REFERENCES `mining_ecm`.`tenement`.`heritage_clearance`(`heritage_clearance_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_heritage_clearance_id` FOREIGN KEY (`heritage_clearance_id`) REFERENCES `mining_ecm`.`tenement`.`heritage_clearance`(`heritage_clearance_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_surface_right_id` FOREIGN KEY (`surface_right_id`) REFERENCES `mining_ecm`.`tenement`.`surface_right`(`surface_right_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= mine --> customer (3 constraint(s)) =========
-- Requires: mine schema, customer schema
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `mining_ecm`.`customer`.`payment_term`(`payment_term_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);

-- ========= mine --> equipment (3 constraint(s)) =========
-- Requires: mine schema, equipment schema
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= mine --> exploration (16 constraint(s)) =========
-- Requires: mine schema, exploration schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);

-- ========= mine --> finance (42 constraint(s)) =========
-- Requires: mine schema, finance schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_project_valuation_id` FOREIGN KEY (`project_valuation_id`) REFERENCES `mining_ecm`.`finance`.`project_valuation`(`project_valuation_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_royalty_obligation_id` FOREIGN KEY (`royalty_obligation_id`) REFERENCES `mining_ecm`.`finance`.`royalty_obligation`(`royalty_obligation_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_royalty_obligation_id` FOREIGN KEY (`royalty_obligation_id`) REFERENCES `mining_ecm`.`finance`.`royalty_obligation`(`royalty_obligation_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_cost_performance_report_id` FOREIGN KEY (`cost_performance_report_id`) REFERENCES `mining_ecm`.`finance`.`cost_performance_report`(`cost_performance_report_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_cost_performance_report_id` FOREIGN KEY (`cost_performance_report_id`) REFERENCES `mining_ecm`.`finance`.`cost_performance_report`(`cost_performance_report_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_royalty_obligation_id` FOREIGN KEY (`royalty_obligation_id`) REFERENCES `mining_ecm`.`finance`.`royalty_obligation`(`royalty_obligation_id`);
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ADD CONSTRAINT `fk_mine_mine_site_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `mining_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ADD CONSTRAINT `fk_mine_mine_site_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ADD CONSTRAINT `fk_mine_mine_site_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`area` ADD CONSTRAINT `fk_mine_area_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`area` ADD CONSTRAINT `fk_mine_area_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ADD CONSTRAINT `fk_mine_pit_or_level_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ADD CONSTRAINT `fk_mine_pit_or_level_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ADD CONSTRAINT `fk_mine_pit_or_level_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);

-- ========= mine --> geology (23 constraint(s)) =========
-- Requires: mine schema, geology schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_wireframe_id` FOREIGN KEY (`wireframe_id`) REFERENCES `mining_ecm`.`geology`.`wireframe`(`wireframe_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_wireframe_id` FOREIGN KEY (`wireframe_id`) REFERENCES `mining_ecm`.`geology`.`wireframe`(`wireframe_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_wireframe_id` FOREIGN KEY (`wireframe_id`) REFERENCES `mining_ecm`.`geology`.`wireframe`(`wireframe_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` ADD CONSTRAINT `fk_mine_blast_pattern_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);

-- ========= mine --> hse (25 constraint(s)) =========
-- Requires: mine schema, hse schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_safety_observation_id` FOREIGN KEY (`safety_observation_id`) REFERENCES `mining_ecm`.`hse`.`safety_observation`(`safety_observation_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`mine`.`area` ADD CONSTRAINT `fk_mine_area_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` ADD CONSTRAINT `fk_mine_blast_pattern_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ADD CONSTRAINT `fk_mine_pit_or_level_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);

-- ========= mine --> maintenance (12 constraint(s)) =========
-- Requires: mine schema, maintenance schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_shutdown_plan_id` FOREIGN KEY (`shutdown_plan_id`) REFERENCES `mining_ecm`.`maintenance`.`shutdown_plan`(`shutdown_plan_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_primary_material_functional_location_id` FOREIGN KEY (`primary_material_functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`haulage_cycle` ADD CONSTRAINT `fk_mine_haulage_cycle_tertiary_haulage_functional_location_id` FOREIGN KEY (`tertiary_haulage_functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ADD CONSTRAINT `fk_mine_pit_or_level_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`bench` ADD CONSTRAINT `fk_mine_bench_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);

-- ========= mine --> procurement (4 constraint(s)) =========
-- Requires: mine schema, procurement schema
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_pattern` ADD CONSTRAINT `fk_mine_blast_pattern_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);

-- ========= mine --> product (17 constraint(s)) =========
-- Requires: mine schema, product schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`mine_site` ADD CONSTRAINT `fk_mine_mine_site_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`area` ADD CONSTRAINT `fk_mine_area_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ADD CONSTRAINT `fk_mine_pit_or_level_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= mine --> tenement (30 constraint(s)) =========
-- Requires: mine schema, tenement schema
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_heritage_clearance_id` FOREIGN KEY (`heritage_clearance_id`) REFERENCES `mining_ecm`.`tenement`.`heritage_clearance`(`heritage_clearance_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_surface_right_id` FOREIGN KEY (`surface_right_id`) REFERENCES `mining_ecm`.`tenement`.`surface_right`(`surface_right_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_design` ADD CONSTRAINT `fk_mine_pit_design_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`stope_design` ADD CONSTRAINT `fk_mine_stope_design_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_expenditure_commitment_id` FOREIGN KEY (`expenditure_commitment_id`) REFERENCES `mining_ecm`.`tenement`.`expenditure_commitment`(`expenditure_commitment_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_native_title_agreement_id` FOREIGN KEY (`native_title_agreement_id`) REFERENCES `mining_ecm`.`tenement`.`native_title_agreement`(`native_title_agreement_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_renewal_obligation_id` FOREIGN KEY (`renewal_obligation_id`) REFERENCES `mining_ecm`.`tenement`.`renewal_obligation`(`renewal_obligation_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `mining_ecm`.`tenement`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `mining_ecm`.`mine`.`lom_plan` ADD CONSTRAINT `fk_mine_lom_plan_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_expenditure_commitment_id` FOREIGN KEY (`expenditure_commitment_id`) REFERENCES `mining_ecm`.`tenement`.`expenditure_commitment`(`expenditure_commitment_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `mining_ecm`.`tenement`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_schedule` ADD CONSTRAINT `fk_mine_production_schedule_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`mining_block` ADD CONSTRAINT `fk_mine_mining_block_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_heritage_clearance_id` FOREIGN KEY (`heritage_clearance_id`) REFERENCES `mining_ecm`.`tenement`.`heritage_clearance`(`heritage_clearance_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`mine`.`blast_execution` ADD CONSTRAINT `fk_mine_blast_execution_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`material_movement` ADD CONSTRAINT `fk_mine_material_movement_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`rom_stockpile` ADD CONSTRAINT `fk_mine_rom_stockpile_surface_right_id` FOREIGN KEY (`surface_right_id`) REFERENCES `mining_ecm`.`tenement`.`surface_right`(`surface_right_id`);
ALTER TABLE `mining_ecm`.`mine`.`shift_report` ADD CONSTRAINT `fk_mine_shift_report_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_surface_right_id` FOREIGN KEY (`surface_right_id`) REFERENCES `mining_ecm`.`tenement`.`surface_right`(`surface_right_id`);
ALTER TABLE `mining_ecm`.`mine`.`waste_dump` ADD CONSTRAINT `fk_mine_waste_dump_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `mining_ecm`.`tenement`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `mining_ecm`.`mine`.`production_reconciliation` ADD CONSTRAINT `fk_mine_production_reconciliation_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`area` ADD CONSTRAINT `fk_mine_area_native_title_agreement_id` FOREIGN KEY (`native_title_agreement_id`) REFERENCES `mining_ecm`.`tenement`.`native_title_agreement`(`native_title_agreement_id`);
ALTER TABLE `mining_ecm`.`mine`.`area` ADD CONSTRAINT `fk_mine_area_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ADD CONSTRAINT `fk_mine_pit_or_level_surface_right_id` FOREIGN KEY (`surface_right_id`) REFERENCES `mining_ecm`.`tenement`.`surface_right`(`surface_right_id`);
ALTER TABLE `mining_ecm`.`mine`.`pit_or_level` ADD CONSTRAINT `fk_mine_pit_or_level_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`mine`.`bench` ADD CONSTRAINT `fk_mine_bench_heritage_clearance_id` FOREIGN KEY (`heritage_clearance_id`) REFERENCES `mining_ecm`.`tenement`.`heritage_clearance`(`heritage_clearance_id`);
ALTER TABLE `mining_ecm`.`mine`.`bench` ADD CONSTRAINT `fk_mine_bench_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= processing --> customer (3 constraint(s)) =========
-- Requires: processing schema, customer schema
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_letter_of_credit_id` FOREIGN KEY (`letter_of_credit_id`) REFERENCES `mining_ecm`.`customer`.`letter_of_credit`(`letter_of_credit_id`);

-- ========= processing --> equipment (9 constraint(s)) =========
-- Requires: processing schema, equipment schema
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`slurry_measurement` ADD CONSTRAINT `fk_processing_slurry_measurement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_downtime_event_id` FOREIGN KEY (`downtime_event_id`) REFERENCES `mining_ecm`.`equipment`.`downtime_event`(`downtime_event_id`);
ALTER TABLE `mining_ecm`.`processing`.`measurement_point` ADD CONSTRAINT `fk_processing_measurement_point_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= processing --> exploration (11 constraint(s)) =========
-- Requires: processing schema, exploration schema
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_competent_person_id` FOREIGN KEY (`competent_person_id`) REFERENCES `mining_ecm`.`exploration`.`competent_person`(`competent_person_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_exploration_sample_id` FOREIGN KEY (`exploration_sample_id`) REFERENCES `mining_ecm`.`exploration`.`exploration_sample`(`exploration_sample_id`);

-- ========= processing --> finance (20 constraint(s)) =========
-- Requires: processing schema, finance schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_royalty_obligation_id` FOREIGN KEY (`royalty_obligation_id`) REFERENCES `mining_ecm`.`finance`.`royalty_obligation`(`royalty_obligation_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_royalty_obligation_id` FOREIGN KEY (`royalty_obligation_id`) REFERENCES `mining_ecm`.`finance`.`royalty_obligation`(`royalty_obligation_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);

-- ========= processing --> geology (14 constraint(s)) =========
-- Requires: processing schema, geology schema
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_geological_domain_id` FOREIGN KEY (`geological_domain_id`) REFERENCES `mining_ecm`.`geology`.`geological_domain`(`geological_domain_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= processing --> hse (15 constraint(s)) =========
-- Requires: processing schema, hse schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_chemical_register_id` FOREIGN KEY (`chemical_register_id`) REFERENCES `mining_ecm`.`hse`.`chemical_register`(`chemical_register_id`);
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`processing`.`measurement_point` ADD CONSTRAINT `fk_processing_measurement_point_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);

-- ========= processing --> laboratory (13 constraint(s)) =========
-- Requires: processing schema, laboratory schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_sample_program_id` FOREIGN KEY (`sample_program_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_program`(`sample_program_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_sample_program_id` FOREIGN KEY (`sample_program_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_program`(`sample_program_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_assay_result_id` FOREIGN KEY (`assay_result_id`) REFERENCES `mining_ecm`.`laboratory`.`assay_result`(`assay_result_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_metallurgical_test_id` FOREIGN KEY (`metallurgical_test_id`) REFERENCES `mining_ecm`.`laboratory`.`metallurgical_test`(`metallurgical_test_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_assay_result_id` FOREIGN KEY (`assay_result_id`) REFERENCES `mining_ecm`.`laboratory`.`assay_result`(`assay_result_id`);

-- ========= processing --> maintenance (15 constraint(s)) =========
-- Requires: processing schema, maintenance schema
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_shutdown_plan_id` FOREIGN KEY (`shutdown_plan_id`) REFERENCES `mining_ecm`.`maintenance`.`shutdown_plan`(`shutdown_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_failure_report_id` FOREIGN KEY (`failure_report_id`) REFERENCES `mining_ecm`.`maintenance`.`failure_report`(`failure_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_shutdown_plan_id` FOREIGN KEY (`shutdown_plan_id`) REFERENCES `mining_ecm`.`maintenance`.`shutdown_plan`(`shutdown_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`measurement_point` ADD CONSTRAINT `fk_processing_measurement_point_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `mining_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);

-- ========= processing --> mine (39 constraint(s)) =========
-- Requires: processing schema, mine schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`slurry_measurement` ADD CONSTRAINT `fk_processing_slurry_measurement_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_blast_execution_id` FOREIGN KEY (`blast_execution_id`) REFERENCES `mining_ecm`.`mine`.`blast_execution`(`blast_execution_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_blast_execution_id` FOREIGN KEY (`blast_execution_id`) REFERENCES `mining_ecm`.`mine`.`blast_execution`(`blast_execution_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);

-- ========= processing --> procurement (4 constraint(s)) =========
-- Requires: processing schema, procurement schema
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_goods_issue_id` FOREIGN KEY (`goods_issue_id`) REFERENCES `mining_ecm`.`procurement`.`goods_issue`(`goods_issue_id`);
ALTER TABLE `mining_ecm`.`processing`.`reagent_consumption` ADD CONSTRAINT `fk_processing_reagent_consumption_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `mining_ecm`.`procurement`.`freight_order`(`freight_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);

-- ========= processing --> product (39 constraint(s)) =========
-- Requires: processing schema, product schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`sxew_event` ADD CONSTRAINT `fk_processing_sxew_event_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `mining_ecm`.`product`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_blend_id` FOREIGN KEY (`blend_id`) REFERENCES `mining_ecm`.`product`.`blend`(`blend_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`processing`.`measurement_point` ADD CONSTRAINT `fk_processing_measurement_point_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);

-- ========= processing --> sales (7 constraint(s)) =========
-- Requires: processing schema, sales schema
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_commodity_order_id` FOREIGN KEY (`commodity_order_id`) REFERENCES `mining_ecm`.`sales`.`commodity_order`(`commodity_order_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_quality_certificate_id` FOREIGN KEY (`quality_certificate_id`) REFERENCES `mining_ecm`.`sales`.`quality_certificate`(`quality_certificate_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_volume_plan_id` FOREIGN KEY (`volume_plan_id`) REFERENCES `mining_ecm`.`sales`.`volume_plan`(`volume_plan_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_offtake_schedule_id` FOREIGN KEY (`offtake_schedule_id`) REFERENCES `mining_ecm`.`sales`.`offtake_schedule`(`offtake_schedule_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_shipment_nomination_id` FOREIGN KEY (`shipment_nomination_id`) REFERENCES `mining_ecm`.`sales`.`shipment_nomination`(`shipment_nomination_id`);

-- ========= processing --> tailings (13 constraint(s)) =========
-- Requires: processing schema, tailings schema
ALTER TABLE `mining_ecm`.`processing`.`circuit` ADD CONSTRAINT `fk_processing_circuit_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`unit_operation_event` ADD CONSTRAINT `fk_processing_unit_operation_event_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`flotation_event` ADD CONSTRAINT `fk_processing_flotation_event_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`leach_event` ADD CONSTRAINT `fk_processing_leach_event_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`slurry_measurement` ADD CONSTRAINT `fk_processing_slurry_measurement_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_waste_rock_dump_id` FOREIGN KEY (`waste_rock_dump_id`) REFERENCES `mining_ecm`.`tailings`.`waste_rock_dump`(`waste_rock_dump_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_ard_assessment_id` FOREIGN KEY (`ard_assessment_id`) REFERENCES `mining_ecm`.`tailings`.`ard_assessment`(`ard_assessment_id`);
ALTER TABLE `mining_ecm`.`processing`.`process_sample` ADD CONSTRAINT `fk_processing_process_sample_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_tsf_id` FOREIGN KEY (`tsf_id`) REFERENCES `mining_ecm`.`tailings`.`tsf`(`tsf_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_water_balance_id` FOREIGN KEY (`water_balance_id`) REFERENCES `mining_ecm`.`tailings`.`water_balance`(`water_balance_id`);

-- ========= processing --> tenement (10 constraint(s)) =========
-- Requires: processing schema, tenement schema
ALTER TABLE `mining_ecm`.`processing`.`plant` ADD CONSTRAINT `fk_processing_plant_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`processing`.`feed_stream` ADD CONSTRAINT `fk_processing_feed_stream_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`processing`.`shift_production_run` ADD CONSTRAINT `fk_processing_shift_production_run_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_batch` ADD CONSTRAINT `fk_processing_concentrate_batch_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`processing`.`metallurgical_balance` ADD CONSTRAINT `fk_processing_metallurgical_balance_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`processing`.`recovery_target` ADD CONSTRAINT `fk_processing_recovery_target_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`processing`.`operational_exception` ADD CONSTRAINT `fk_processing_operational_exception_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`processing`.`concentrate_stockpile` ADD CONSTRAINT `fk_processing_concentrate_stockpile_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`processing`.`plant_utility_consumption` ADD CONSTRAINT `fk_processing_plant_utility_consumption_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);

-- ========= procurement --> customer (4 constraint(s)) =========
-- Requires: procurement schema, customer schema
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ADD CONSTRAINT `fk_procurement_outbound_shipment_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ADD CONSTRAINT `fk_procurement_outbound_shipment_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ADD CONSTRAINT `fk_procurement_freight_order_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ADD CONSTRAINT `fk_procurement_freight_order_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);

-- ========= procurement --> exploration (1 constraint(s)) =========
-- Requires: procurement schema, exploration schema
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);

-- ========= procurement --> finance (20 constraint(s)) =========
-- Requires: procurement schema, finance schema
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ADD CONSTRAINT `fk_procurement_purchase_order_line_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ADD CONSTRAINT `fk_procurement_purchase_order_line_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ADD CONSTRAINT `fk_procurement_stock_transfer_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ADD CONSTRAINT `fk_procurement_warehouse_location_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ADD CONSTRAINT `fk_procurement_framework_agreement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ADD CONSTRAINT `fk_procurement_physical_inventory_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ADD CONSTRAINT `fk_procurement_physical_inventory_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ADD CONSTRAINT `fk_procurement_physical_inventory_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `mining_ecm`.`finance`.`journal_entry`(`journal_entry_id`);

-- ========= procurement --> mine (8 constraint(s)) =========
-- Requires: procurement schema, mine schema
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_blast_execution_id` FOREIGN KEY (`blast_execution_id`) REFERENCES `mining_ecm`.`mine`.`blast_execution`(`blast_execution_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_stope_design_id` FOREIGN KEY (`stope_design_id`) REFERENCES `mining_ecm`.`mine`.`stope_design`(`stope_design_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_waste_dump_id` FOREIGN KEY (`waste_dump_id`) REFERENCES `mining_ecm`.`mine`.`waste_dump`(`waste_dump_id`);
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ADD CONSTRAINT `fk_procurement_warehouse_location_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);

-- ========= procurement --> processing (4 constraint(s)) =========
-- Requires: procurement schema, processing schema
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ADD CONSTRAINT `fk_procurement_inventory_balance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ADD CONSTRAINT `fk_procurement_stock_transfer_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ADD CONSTRAINT `fk_procurement_stock_transfer_sending_plant_id` FOREIGN KEY (`sending_plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);

-- ========= procurement --> product (14 constraint(s)) =========
-- Requires: procurement schema, product schema
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ADD CONSTRAINT `fk_procurement_material_master_grade_parameter_id` FOREIGN KEY (`grade_parameter_id`) REFERENCES `mining_ecm`.`product`.`grade_parameter`(`grade_parameter_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ADD CONSTRAINT `fk_procurement_purchase_order_line_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ADD CONSTRAINT `fk_procurement_inbound_delivery_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ADD CONSTRAINT `fk_procurement_inbound_delivery_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ADD CONSTRAINT `fk_procurement_outbound_shipment_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ADD CONSTRAINT `fk_procurement_outbound_shipment_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ADD CONSTRAINT `fk_procurement_procurement_vendor_performance_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ADD CONSTRAINT `fk_procurement_framework_agreement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ADD CONSTRAINT `fk_procurement_freight_order_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `mining_ecm`.`product`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `mining_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ADD CONSTRAINT `fk_procurement_price_schedule_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= procurement --> sales (6 constraint(s)) =========
-- Requires: procurement schema, sales schema
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ADD CONSTRAINT `fk_procurement_outbound_shipment_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ADD CONSTRAINT `fk_procurement_outbound_shipment_quality_certificate_id` FOREIGN KEY (`quality_certificate_id`) REFERENCES `mining_ecm`.`sales`.`quality_certificate`(`quality_certificate_id`);
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ADD CONSTRAINT `fk_procurement_outbound_shipment_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `mining_ecm`.`sales`.`vessel`(`vessel_id`);
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ADD CONSTRAINT `fk_procurement_freight_order_vessel_id` FOREIGN KEY (`vessel_id`) REFERENCES `mining_ecm`.`sales`.`vessel`(`vessel_id`);
ALTER TABLE `mining_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `mining_ecm`.`sales`.`price_index`(`price_index_id`);
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ADD CONSTRAINT `fk_procurement_price_schedule_price_index_id` FOREIGN KEY (`price_index_id`) REFERENCES `mining_ecm`.`sales`.`price_index`(`price_index_id`);

-- ========= product --> customer (6 constraint(s)) =========
-- Requires: product schema, customer schema
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ADD CONSTRAINT `fk_product_pricing_basis_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ADD CONSTRAINT `fk_product_pricing_configuration_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= product --> finance (12 constraint(s)) =========
-- Requires: product schema, finance schema
ALTER TABLE `mining_ecm`.`product`.`commodity` ADD CONSTRAINT `fk_product_commodity_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_royalty_obligation_id` FOREIGN KEY (`royalty_obligation_id`) REFERENCES `mining_ecm`.`finance`.`royalty_obligation`(`royalty_obligation_id`);
ALTER TABLE `mining_ecm`.`product`.`pricing_basis` ADD CONSTRAINT `fk_product_pricing_basis_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`product`.`pricing_configuration` ADD CONSTRAINT `fk_product_pricing_configuration_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);

-- ========= product --> geology (2 constraint(s)) =========
-- Requires: product schema, geology schema
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= product --> laboratory (3 constraint(s)) =========
-- Requires: product schema, laboratory schema
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`product`.`specification` ADD CONSTRAINT `fk_product_specification_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`product`.`grade_limit` ADD CONSTRAINT `fk_product_grade_limit_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);

-- ========= product --> processing (1 constraint(s)) =========
-- Requires: product schema, processing schema
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);

-- ========= product --> tenement (4 constraint(s)) =========
-- Requires: product schema, tenement schema
ALTER TABLE `mining_ecm`.`product`.`saleable_product` ADD CONSTRAINT `fk_product_saleable_product_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`product`.`certification` ADD CONSTRAINT `fk_product_certification_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`product`.`blend` ADD CONSTRAINT `fk_product_blend_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= sales --> customer (19 constraint(s)) =========
-- Requires: sales schema, customer schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_credit_limit_id` FOREIGN KEY (`credit_limit_id`) REFERENCES `mining_ecm`.`customer`.`credit_limit`(`credit_limit_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `mining_ecm`.`customer`.`payment_term`(`payment_term_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `mining_ecm`.`customer`.`bank_account`(`bank_account_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_letter_of_credit_id` FOREIGN KEY (`letter_of_credit_id`) REFERENCES `mining_ecm`.`customer`.`letter_of_credit`(`letter_of_credit_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `mining_ecm`.`customer`.`payment_term`(`payment_term_id`);
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_letter_of_credit_id` FOREIGN KEY (`letter_of_credit_id`) REFERENCES `mining_ecm`.`customer`.`letter_of_credit`(`letter_of_credit_id`);
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ADD CONSTRAINT `fk_sales_quality_certificate_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);

-- ========= sales --> exploration (5 constraint(s)) =========
-- Requires: sales schema, exploration schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_ore_reserve_id` FOREIGN KEY (`ore_reserve_id`) REFERENCES `mining_ecm`.`exploration`.`ore_reserve`(`ore_reserve_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_resource_estimate_id` FOREIGN KEY (`resource_estimate_id`) REFERENCES `mining_ecm`.`exploration`.`resource_estimate`(`resource_estimate_id`);

-- ========= sales --> finance (33 constraint(s)) =========
-- Requires: sales schema, finance schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_project_valuation_id` FOREIGN KEY (`project_valuation_id`) REFERENCES `mining_ecm`.`finance`.`project_valuation`(`project_valuation_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_royalty_obligation_id` FOREIGN KEY (`royalty_obligation_id`) REFERENCES `mining_ecm`.`finance`.`royalty_obligation`(`royalty_obligation_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= sales --> geology (8 constraint(s)) =========
-- Requires: sales schema, geology schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_block_model_id` FOREIGN KEY (`block_model_id`) REFERENCES `mining_ecm`.`geology`.`block_model`(`block_model_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_resource_statement_id` FOREIGN KEY (`resource_statement_id`) REFERENCES `mining_ecm`.`geology`.`resource_statement`(`resource_statement_id`);

-- ========= sales --> laboratory (3 constraint(s)) =========
-- Requires: sales schema, laboratory schema
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_assay_result_id` FOREIGN KEY (`assay_result_id`) REFERENCES `mining_ecm`.`laboratory`.`assay_result`(`assay_result_id`);
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ADD CONSTRAINT `fk_sales_quality_certificate_assay_result_id` FOREIGN KEY (`assay_result_id`) REFERENCES `mining_ecm`.`laboratory`.`assay_result`(`assay_result_id`);
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ADD CONSTRAINT `fk_sales_quality_certificate_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);

-- ========= sales --> mine (22 constraint(s)) =========
-- Requires: sales schema, mine schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_production_reconciliation_id` FOREIGN KEY (`production_reconciliation_id`) REFERENCES `mining_ecm`.`mine`.`production_reconciliation`(`production_reconciliation_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ADD CONSTRAINT `fk_sales_quality_certificate_production_reconciliation_id` FOREIGN KEY (`production_reconciliation_id`) REFERENCES `mining_ecm`.`mine`.`production_reconciliation`(`production_reconciliation_id`);
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ADD CONSTRAINT `fk_sales_quality_certificate_rom_stockpile_id` FOREIGN KEY (`rom_stockpile_id`) REFERENCES `mining_ecm`.`mine`.`rom_stockpile`(`rom_stockpile_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);

-- ========= sales --> procurement (1 constraint(s)) =========
-- Requires: sales schema, procurement schema
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `mining_ecm`.`procurement`.`freight_order`(`freight_order_id`);

-- ========= sales --> product (23 constraint(s)) =========
-- Requires: sales schema, product schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_pricing_basis_id` FOREIGN KEY (`pricing_basis_id`) REFERENCES `mining_ecm`.`product`.`pricing_basis`(`pricing_basis_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_pricing_configuration_id` FOREIGN KEY (`pricing_configuration_id`) REFERENCES `mining_ecm`.`product`.`pricing_configuration`(`pricing_configuration_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_pricing_configuration_id` FOREIGN KEY (`pricing_configuration_id`) REFERENCES `mining_ecm`.`product`.`pricing_configuration`(`pricing_configuration_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`commodity_order` ADD CONSTRAINT `fk_sales_commodity_order_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`shipment_nomination` ADD CONSTRAINT `fk_sales_shipment_nomination_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`sales`.`benchmark_price` ADD CONSTRAINT `fk_sales_benchmark_price_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_pricing_configuration_id` FOREIGN KEY (`pricing_configuration_id`) REFERENCES `mining_ecm`.`product`.`pricing_configuration`(`pricing_configuration_id`);
ALTER TABLE `mining_ecm`.`sales`.`invoice` ADD CONSTRAINT `fk_sales_invoice_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`provisional_adjustment` ADD CONSTRAINT `fk_sales_provisional_adjustment_pricing_configuration_id` FOREIGN KEY (`pricing_configuration_id`) REFERENCES `mining_ecm`.`product`.`pricing_configuration`(`pricing_configuration_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`sales`.`bill_of_lading` ADD CONSTRAINT `fk_sales_bill_of_lading_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`sales`.`quality_certificate` ADD CONSTRAINT `fk_sales_quality_certificate_specification_id` FOREIGN KEY (`specification_id`) REFERENCES `mining_ecm`.`product`.`specification`(`specification_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_schedule` ADD CONSTRAINT `fk_sales_offtake_schedule_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);

-- ========= sales --> tailings (1 constraint(s)) =========
-- Requires: sales schema, tailings schema
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_tsf_capacity_survey_id` FOREIGN KEY (`tsf_capacity_survey_id`) REFERENCES `mining_ecm`.`tailings`.`tsf_capacity_survey`(`tsf_capacity_survey_id`);

-- ========= sales --> tenement (5 constraint(s)) =========
-- Requires: sales schema, tenement schema
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `mining_ecm`.`tenement`.`royalty_agreement`(`royalty_agreement_id`);
ALTER TABLE `mining_ecm`.`sales`.`offtake_agreement` ADD CONSTRAINT `fk_sales_offtake_agreement_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`sales`.`revenue_forecast` ADD CONSTRAINT `fk_sales_revenue_forecast_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`sales`.`volume_plan` ADD CONSTRAINT `fk_sales_volume_plan_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`sales`.`cargo_shipment` ADD CONSTRAINT `fk_sales_cargo_shipment_royalty_agreement_id` FOREIGN KEY (`royalty_agreement_id`) REFERENCES `mining_ecm`.`tenement`.`royalty_agreement`(`royalty_agreement_id`);

-- ========= tailings --> equipment (3 constraint(s)) =========
-- Requires: tailings schema, equipment schema
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `mining_ecm`.`equipment`.`asset`(`asset_id`);

-- ========= tailings --> exploration (3 constraint(s)) =========
-- Requires: tailings schema, exploration schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `mining_ecm`.`exploration`.`prospect`(`prospect_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_drill_hole_id` FOREIGN KEY (`drill_hole_id`) REFERENCES `mining_ecm`.`exploration`.`drill_hole`(`drill_hole_id`);

-- ========= tailings --> finance (39 constraint(s)) =========
-- Requires: tailings schema, finance schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ADD CONSTRAINT `fk_tailings_geotechnical_instrument_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ADD CONSTRAINT `fk_tailings_geotechnical_instrument_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_opex_budget_id` FOREIGN KEY (`opex_budget_id`) REFERENCES `mining_ecm`.`finance`.`opex_budget`(`opex_budget_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_capex_budget_id` FOREIGN KEY (`capex_budget_id`) REFERENCES `mining_ecm`.`finance`.`capex_budget`(`capex_budget_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `mining_ecm`.`finance`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ADD CONSTRAINT `fk_tailings_tsf_capacity_survey_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ADD CONSTRAINT `fk_tailings_tsf_capacity_survey_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);

-- ========= tailings --> geology (8 constraint(s)) =========
-- Requires: tailings schema, geology schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ADD CONSTRAINT `fk_tailings_geotechnical_instrument_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_geological_unit_id` FOREIGN KEY (`geological_unit_id`) REFERENCES `mining_ecm`.`geology`.`geological_unit`(`geological_unit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_lithology_log_id` FOREIGN KEY (`lithology_log_id`) REFERENCES `mining_ecm`.`geology`.`lithology_log`(`lithology_log_id`);

-- ========= tailings --> hse (34 constraint(s)) =========
-- Requires: tailings schema, hse schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ADD CONSTRAINT `fk_tailings_geotechnical_reading_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `mining_ecm`.`hse`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_corrective_action_id` FOREIGN KEY (`corrective_action_id`) REFERENCES `mining_ecm`.`hse`.`corrective_action`(`corrective_action_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `mining_ecm`.`hse`.`incident`(`incident_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `mining_ecm`.`hse`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_environmental_monitoring_id` FOREIGN KEY (`environmental_monitoring_id`) REFERENCES `mining_ecm`.`hse`.`environmental_monitoring`(`environmental_monitoring_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ADD CONSTRAINT `fk_tailings_tsf_capacity_survey_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `mining_ecm`.`hse`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ADD CONSTRAINT `fk_tailings_tsf_capacity_survey_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_emergency_response_plan_id` FOREIGN KEY (`emergency_response_plan_id`) REFERENCES `mining_ecm`.`hse`.`emergency_response_plan`(`emergency_response_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `mining_ecm`.`hse`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_risk_assessment_id` FOREIGN KEY (`risk_assessment_id`) REFERENCES `mining_ecm`.`hse`.`risk_assessment`(`risk_assessment_id`);

-- ========= tailings --> laboratory (4 constraint(s)) =========
-- Requires: tailings schema, laboratory schema
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_reading` ADD CONSTRAINT `fk_tailings_geotechnical_reading_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `mining_ecm`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);

-- ========= tailings --> maintenance (6 constraint(s)) =========
-- Requires: tailings schema, maintenance schema
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_condition_monitoring_id` FOREIGN KEY (`condition_monitoring_id`) REFERENCES `mining_ecm`.`maintenance`.`condition_monitoring`(`condition_monitoring_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ADD CONSTRAINT `fk_tailings_tsf_capacity_survey_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);

-- ========= tailings --> mine (23 constraint(s)) =========
-- Requires: tailings schema, mine schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_waste_dump_id` FOREIGN KEY (`waste_dump_id`) REFERENCES `mining_ecm`.`mine`.`waste_dump`(`waste_dump_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_blast_execution_id` FOREIGN KEY (`blast_execution_id`) REFERENCES `mining_ecm`.`mine`.`blast_execution`(`blast_execution_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_pit_design_id` FOREIGN KEY (`pit_design_id`) REFERENCES `mining_ecm`.`mine`.`pit_design`(`pit_design_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_shift_report_id` FOREIGN KEY (`shift_report_id`) REFERENCES `mining_ecm`.`mine`.`shift_report`(`shift_report_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_waste_dump_id` FOREIGN KEY (`waste_dump_id`) REFERENCES `mining_ecm`.`mine`.`waste_dump`(`waste_dump_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `mining_ecm`.`mine`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_lom_plan_id` FOREIGN KEY (`lom_plan_id`) REFERENCES `mining_ecm`.`mine`.`lom_plan`(`lom_plan_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_pit_or_level_id` FOREIGN KEY (`pit_or_level_id`) REFERENCES `mining_ecm`.`mine`.`pit_or_level`(`pit_or_level_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_mine_site_id` FOREIGN KEY (`mine_site_id`) REFERENCES `mining_ecm`.`mine`.`mine_site`(`mine_site_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_area_id` FOREIGN KEY (`area_id`) REFERENCES `mining_ecm`.`mine`.`area`(`area_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_mining_block_id` FOREIGN KEY (`mining_block_id`) REFERENCES `mining_ecm`.`mine`.`mining_block`(`mining_block_id`);

-- ========= tailings --> processing (7 constraint(s)) =========
-- Requires: tailings schema, processing schema
ALTER TABLE `mining_ecm`.`tailings`.`tarp_trigger` ADD CONSTRAINT `fk_tailings_tarp_trigger_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_circuit_id` FOREIGN KEY (`circuit_id`) REFERENCES `mining_ecm`.`processing`.`circuit`(`circuit_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`tailings`.`deposition` ADD CONSTRAINT `fk_tailings_deposition_shift_production_run_id` FOREIGN KEY (`shift_production_run_id`) REFERENCES `mining_ecm`.`processing`.`shift_production_run`(`shift_production_run_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `mining_ecm`.`processing`.`plant`(`plant_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_circuit_id` FOREIGN KEY (`circuit_id`) REFERENCES `mining_ecm`.`processing`.`circuit`(`circuit_id`);

-- ========= tailings --> procurement (24 constraint(s)) =========
-- Requires: tailings schema, procurement schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_raise` ADD CONSTRAINT `fk_tailings_tsf_raise_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ADD CONSTRAINT `fk_tailings_geotechnical_instrument_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ADD CONSTRAINT `fk_tailings_geotechnical_instrument_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`tailings`.`geotechnical_instrument` ADD CONSTRAINT `fk_tailings_geotechnical_instrument_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_placement` ADD CONSTRAINT `fk_tailings_waste_placement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ADD CONSTRAINT `fk_tailings_tsf_capacity_survey_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf_capacity_survey` ADD CONSTRAINT `fk_tailings_tsf_capacity_survey_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`tailings`.`consequence_classification` ADD CONSTRAINT `fk_tailings_consequence_classification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= tailings --> product (5 constraint(s)) =========
-- Requires: tailings schema, product schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_liability` ADD CONSTRAINT `fk_tailings_closure_liability_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);

-- ========= tailings --> tenement (15 constraint(s)) =========
-- Requires: tailings schema, tenement schema
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_surface_right_id` FOREIGN KEY (`surface_right_id`) REFERENCES `mining_ecm`.`tenement`.`surface_right`(`surface_right_id`);
ALTER TABLE `mining_ecm`.`tailings`.`tsf` ADD CONSTRAINT `fk_tailings_tsf_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tailings`.`dam_safety_inspection` ADD CONSTRAINT `fk_tailings_dam_safety_inspection_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`tailings`.`seepage_monitoring` ADD CONSTRAINT `fk_tailings_seepage_monitoring_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_surface_right_id` FOREIGN KEY (`surface_right_id`) REFERENCES `mining_ecm`.`tenement`.`surface_right`(`surface_right_id`);
ALTER TABLE `mining_ecm`.`tailings`.`waste_rock_dump` ADD CONSTRAINT `fk_tailings_waste_rock_dump_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tailings`.`water_balance` ADD CONSTRAINT `fk_tailings_water_balance_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_heritage_clearance_id` FOREIGN KEY (`heritage_clearance_id`) REFERENCES `mining_ecm`.`tenement`.`heritage_clearance`(`heritage_clearance_id`);
ALTER TABLE `mining_ecm`.`tailings`.`closure_plan` ADD CONSTRAINT `fk_tailings_closure_plan_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_heritage_clearance_id` FOREIGN KEY (`heritage_clearance_id`) REFERENCES `mining_ecm`.`tenement`.`heritage_clearance`(`heritage_clearance_id`);
ALTER TABLE `mining_ecm`.`tailings`.`rehabilitation_activity` ADD CONSTRAINT `fk_tailings_rehabilitation_activity_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_regulatory_condition_id` FOREIGN KEY (`regulatory_condition_id`) REFERENCES `mining_ecm`.`tenement`.`regulatory_condition`(`regulatory_condition_id`);
ALTER TABLE `mining_ecm`.`tailings`.`ard_assessment` ADD CONSTRAINT `fk_tailings_ard_assessment_tenement_id` FOREIGN KEY (`tenement_id`) REFERENCES `mining_ecm`.`tenement`.`tenement`(`tenement_id`);

-- ========= tenement --> customer (6 constraint(s)) =========
-- Requires: tenement schema, customer schema
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ADD CONSTRAINT `fk_tenement_surface_right_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ADD CONSTRAINT `fk_tenement_royalty_agreement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ADD CONSTRAINT `fk_tenement_royalty_agreement_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `mining_ecm`.`customer`.`payment_term`(`payment_term_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ADD CONSTRAINT `fk_tenement_royalty_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `mining_ecm`.`customer`.`bank_account`(`bank_account_id`);
ALTER TABLE `mining_ecm`.`tenement`.`application` ADD CONSTRAINT `fk_tenement_application_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`tenement`.`holder` ADD CONSTRAINT `fk_tenement_holder_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= tenement --> finance (28 constraint(s)) =========
-- Requires: tenement schema, finance schema
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ADD CONSTRAINT `fk_tenement_tenement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ADD CONSTRAINT `fk_tenement_tenement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ADD CONSTRAINT `fk_tenement_tenement_profit_centre_id` FOREIGN KEY (`profit_centre_id`) REFERENCES `mining_ecm`.`finance`.`profit_centre`(`profit_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ADD CONSTRAINT `fk_tenement_tenement_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`tenement`.`tenement` ADD CONSTRAINT `fk_tenement_tenement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ADD CONSTRAINT `fk_tenement_expenditure_commitment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ADD CONSTRAINT `fk_tenement_expenditure_commitment_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ADD CONSTRAINT `fk_tenement_expenditure_commitment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ADD CONSTRAINT `fk_tenement_renewal_obligation_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ADD CONSTRAINT `fk_tenement_renewal_obligation_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ADD CONSTRAINT `fk_tenement_regulatory_condition_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ADD CONSTRAINT `fk_tenement_native_title_agreement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`native_title_agreement` ADD CONSTRAINT `fk_tenement_native_title_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ADD CONSTRAINT `fk_tenement_heritage_clearance_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ADD CONSTRAINT `fk_tenement_surface_right_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ADD CONSTRAINT `fk_tenement_surface_right_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `mining_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ADD CONSTRAINT `fk_tenement_royalty_agreement_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ADD CONSTRAINT `fk_tenement_royalty_agreement_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ADD CONSTRAINT `fk_tenement_royalty_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `mining_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ADD CONSTRAINT `fk_tenement_royalty_agreement_royalty_obligation_id` FOREIGN KEY (`royalty_obligation_id`) REFERENCES `mining_ecm`.`finance`.`royalty_obligation`(`royalty_obligation_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ADD CONSTRAINT `fk_tenement_royalty_payment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ADD CONSTRAINT `fk_tenement_royalty_payment_general_ledger_account_id` FOREIGN KEY (`general_ledger_account_id`) REFERENCES `mining_ecm`.`finance`.`general_ledger_account`(`general_ledger_account_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ADD CONSTRAINT `fk_tenement_royalty_payment_royalty_obligation_id` FOREIGN KEY (`royalty_obligation_id`) REFERENCES `mining_ecm`.`finance`.`royalty_obligation`(`royalty_obligation_id`);
ALTER TABLE `mining_ecm`.`tenement`.`application` ADD CONSTRAINT `fk_tenement_application_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`application` ADD CONSTRAINT `fk_tenement_application_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ADD CONSTRAINT `fk_tenement_relinquishment_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `mining_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ADD CONSTRAINT `fk_tenement_relinquishment_rehabilitation_provision_id` FOREIGN KEY (`rehabilitation_provision_id`) REFERENCES `mining_ecm`.`finance`.`rehabilitation_provision`(`rehabilitation_provision_id`);
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ADD CONSTRAINT `fk_tenement_relinquishment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `mining_ecm`.`finance`.`wbs_element`(`wbs_element_id`);

-- ========= tenement --> geology (2 constraint(s)) =========
-- Requires: tenement schema, geology schema
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ADD CONSTRAINT `fk_tenement_heritage_clearance_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ADD CONSTRAINT `fk_tenement_relinquishment_orebody_id` FOREIGN KEY (`orebody_id`) REFERENCES `mining_ecm`.`geology`.`orebody`(`orebody_id`);

-- ========= tenement --> processing (1 constraint(s)) =========
-- Requires: tenement schema, processing schema
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ADD CONSTRAINT `fk_tenement_royalty_payment_metallurgical_balance_id` FOREIGN KEY (`metallurgical_balance_id`) REFERENCES `mining_ecm`.`processing`.`metallurgical_balance`(`metallurgical_balance_id`);

-- ========= tenement --> procurement (6 constraint(s)) =========
-- Requires: tenement schema, procurement schema
ALTER TABLE `mining_ecm`.`tenement`.`expenditure_commitment` ADD CONSTRAINT `fk_tenement_expenditure_commitment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`tenement`.`renewal_obligation` ADD CONSTRAINT `fk_tenement_renewal_obligation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`tenement`.`regulatory_condition` ADD CONSTRAINT `fk_tenement_regulatory_condition_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`tenement`.`heritage_clearance` ADD CONSTRAINT `fk_tenement_heritage_clearance_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`tenement`.`surface_right` ADD CONSTRAINT `fk_tenement_surface_right_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`tenement`.`relinquishment` ADD CONSTRAINT `fk_tenement_relinquishment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);

-- ========= tenement --> product (2 constraint(s)) =========
-- Requires: tenement schema, product schema
ALTER TABLE `mining_ecm`.`tenement`.`royalty_agreement` ADD CONSTRAINT `fk_tenement_royalty_agreement_commodity_id` FOREIGN KEY (`commodity_id`) REFERENCES `mining_ecm`.`product`.`commodity`(`commodity_id`);
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ADD CONSTRAINT `fk_tenement_royalty_payment_saleable_product_id` FOREIGN KEY (`saleable_product_id`) REFERENCES `mining_ecm`.`product`.`saleable_product`(`saleable_product_id`);

-- ========= tenement --> sales (1 constraint(s)) =========
-- Requires: tenement schema, sales schema
ALTER TABLE `mining_ecm`.`tenement`.`royalty_payment` ADD CONSTRAINT `fk_tenement_royalty_payment_cargo_shipment_id` FOREIGN KEY (`cargo_shipment_id`) REFERENCES `mining_ecm`.`sales`.`cargo_shipment`(`cargo_shipment_id`);

