-- Cross-Domain Foreign Keys for Business: Energy Utilities | Version: v1_mvm
-- Generated on: 2026-05-05 00:40:07
-- Total cross-domain FK constraints: 1477
--
-- EXECUTION ORDER:
--   1. Run ALL domain schema files first (any order).
--   2. Run this file LAST.
--
-- PREREQUISITE DOMAINS: asset, billing, compliance, customer, demand, distribution, forecast, generation, grid, interconnection, metering, outage, renewable, trading, transmission

-- ========= asset --> compliance (6 constraint(s)) =========
-- Requires: asset schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`rate_case`(`rate_case_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`valuation` ADD CONSTRAINT `fk_asset_valuation_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`rate_case`(`rate_case_id`);

-- ========= asset --> demand (2 constraint(s)) =========
-- Requires: asset schema, demand schema
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_direct_load_control_device_id` FOREIGN KEY (`direct_load_control_device_id`) REFERENCES `energy_utilities_ecm`.`demand`.`direct_load_control_device`(`direct_load_control_device_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ADD CONSTRAINT `fk_asset_spare_parts_inventory_direct_load_control_device_id` FOREIGN KEY (`direct_load_control_device_id`) REFERENCES `energy_utilities_ecm`.`demand`.`direct_load_control_device`(`direct_load_control_device_id`);

-- ========= asset --> distribution (16 constraint(s)) =========
-- Requires: asset schema, distribution schema
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`network_segment`(`network_segment_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`transformer`(`transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`transformer`(`transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_capacitor_bank_id` FOREIGN KEY (`capacitor_bank_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`capacitor_bank`(`capacitor_bank_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`network_segment`(`network_segment_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_sectionalizing_device_id` FOREIGN KEY (`sectionalizing_device_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`sectionalizing_device`(`sectionalizing_device_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`network_segment`(`network_segment_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`transformer`(`transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_capacitor_bank_id` FOREIGN KEY (`capacitor_bank_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`capacitor_bank`(`capacitor_bank_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`transformer`(`transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`network_segment`(`network_segment_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_sectionalizing_device_id` FOREIGN KEY (`sectionalizing_device_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`sectionalizing_device`(`sectionalizing_device_id`);

-- ========= asset --> forecast (5 constraint(s)) =========
-- Requires: asset schema, forecast schema
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_irp_scenario_id` FOREIGN KEY (`irp_scenario_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`irp_scenario`(`irp_scenario_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);

-- ========= asset --> renewable (5 constraint(s)) =========
-- Requires: asset schema, renewable schema
ALTER TABLE `energy_utilities_ecm`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`spare_parts_inventory` ADD CONSTRAINT `fk_asset_spare_parts_inventory_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);

-- ========= asset --> transmission (17 constraint(s)) =========
-- Requires: asset schema, transmission schema
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_power_transformer_id` FOREIGN KEY (`power_transformer_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`power_transformer`(`power_transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_protection_device_id` FOREIGN KEY (`protection_device_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`protection_device`(`protection_device_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_power_transformer_id` FOREIGN KEY (`power_transformer_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`power_transformer`(`power_transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_protection_device_id` FOREIGN KEY (`protection_device_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`protection_device`(`protection_device_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`maintenance_plan` ADD CONSTRAINT `fk_asset_maintenance_plan_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_power_transformer_id` FOREIGN KEY (`power_transformer_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`power_transformer`(`power_transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_protection_device_id` FOREIGN KEY (`protection_device_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`protection_device`(`protection_device_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`capital_project` ADD CONSTRAINT `fk_asset_capital_project_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_power_transformer_id` FOREIGN KEY (`power_transformer_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`power_transformer`(`power_transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_protection_device_id` FOREIGN KEY (`protection_device_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`protection_device`(`protection_device_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);

-- ========= billing --> asset (6 constraint(s)) =========
-- Requires: billing schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_failure_event_id` FOREIGN KEY (`failure_event_id`) REFERENCES `energy_utilities_ecm`.`asset`.`failure_event`(`failure_event_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `energy_utilities_ecm`.`asset`.`inspection`(`inspection_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `energy_utilities_ecm`.`asset`.`capital_project`(`capital_project_id`);

-- ========= billing --> compliance (11 constraint(s)) =========
-- Requires: billing schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`rate_case`(`rate_case_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ADD CONSTRAINT `fk_billing_dunning_notice_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_enforcement_action_id` FOREIGN KEY (`enforcement_action_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`enforcement_action`(`enforcement_action_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ADD CONSTRAINT `fk_billing_assistance_program_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= billing --> customer (13 constraint(s)) =========
-- Requires: billing schema, customer schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`deposit` ADD CONSTRAINT `fk_billing_deposit_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ADD CONSTRAINT `fk_billing_dunning_notice_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`dunning_notice` ADD CONSTRAINT `fk_billing_dunning_notice_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ADD CONSTRAINT `fk_billing_collections_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ADD CONSTRAINT `fk_billing_budget_plan_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);

-- ========= billing --> demand (5 constraint(s)) =========
-- Requires: billing schema, demand schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_dr_program_id` FOREIGN KEY (`dr_program_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_program`(`dr_program_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_dr_incentive_payment_id` FOREIGN KEY (`dr_incentive_payment_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_incentive_payment`(`dr_incentive_payment_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_dr_enrollment_id` FOREIGN KEY (`dr_enrollment_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_enrollment`(`dr_enrollment_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_dr_incentive_payment_id` FOREIGN KEY (`dr_incentive_payment_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_incentive_payment`(`dr_incentive_payment_id`);

-- ========= billing --> distribution (8 constraint(s)) =========
-- Requires: billing schema, distribution schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);

-- ========= billing --> forecast (11 constraint(s)) =========
-- Requires: billing schema, forecast schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_capacity_requirement_id` FOREIGN KEY (`capacity_requirement_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`capacity_requirement`(`capacity_requirement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_peak_demand_id` FOREIGN KEY (`peak_demand_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`peak_demand`(`peak_demand_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_peak_demand_id` FOREIGN KEY (`peak_demand_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`peak_demand`(`peak_demand_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`budget_plan` ADD CONSTRAINT `fk_billing_budget_plan_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ADD CONSTRAINT `fk_billing_assistance_program_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ADD CONSTRAINT `fk_billing_assistance_program_irp_scenario_id` FOREIGN KEY (`irp_scenario_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`irp_scenario`(`irp_scenario_id`);

-- ========= billing --> generation (4 constraint(s)) =========
-- Requires: billing schema, generation schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_fuel_contract_id` FOREIGN KEY (`fuel_contract_id`) REFERENCES `energy_utilities_ecm`.`generation`.`fuel_contract`(`fuel_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_outage_event_id` FOREIGN KEY (`outage_event_id`) REFERENCES `energy_utilities_ecm`.`generation`.`outage_event`(`outage_event_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_outage_event_id` FOREIGN KEY (`outage_event_id`) REFERENCES `energy_utilities_ecm`.`generation`.`outage_event`(`outage_event_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_output_telemetry_id` FOREIGN KEY (`output_telemetry_id`) REFERENCES `energy_utilities_ecm`.`generation`.`output_telemetry`(`output_telemetry_id`);

-- ========= billing --> grid (3 constraint(s)) =========
-- Requires: billing schema, grid schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_grid_reliability_event_id` FOREIGN KEY (`grid_reliability_event_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_reliability_event`(`grid_reliability_event_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_grid_reliability_event_id` FOREIGN KEY (`grid_reliability_event_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_reliability_event`(`grid_reliability_event_id`);

-- ========= billing --> interconnection (9 constraint(s)) =========
-- Requires: billing schema, interconnection schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`agreement`(`agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_nem_agreement_id` FOREIGN KEY (`nem_agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`nem_agreement`(`nem_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_nem_agreement_id` FOREIGN KEY (`nem_agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`nem_agreement`(`nem_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`agreement`(`agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_nem_agreement_id` FOREIGN KEY (`nem_agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`nem_agreement`(`nem_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`agreement`(`agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_nem_agreement_id` FOREIGN KEY (`nem_agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`nem_agreement`(`nem_agreement_id`);

-- ========= billing --> metering (4 constraint(s)) =========
-- Requires: billing schema, metering schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);

-- ========= billing --> outage (5 constraint(s)) =========
-- Requires: billing schema, outage schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_interruption_id` FOREIGN KEY (`interruption_id`) REFERENCES `energy_utilities_ecm`.`outage`.`interruption`(`interruption_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);

-- ========= billing --> renewable (35 constraint(s)) =========
-- Requires: billing schema, renewable schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_incentive_program_id` FOREIGN KEY (`incentive_program_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`incentive_program`(`incentive_program_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_incentive_program_id` FOREIGN KEY (`incentive_program_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`incentive_program`(`incentive_program_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`nem_account`(`nem_account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ppa_settlement_id` FOREIGN KEY (`ppa_settlement_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_settlement`(`ppa_settlement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_curtailment_event_id` FOREIGN KEY (`curtailment_event_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`curtailment_event`(`curtailment_event_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_generation_meter_read_id` FOREIGN KEY (`generation_meter_read_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`generation_meter_read`(`generation_meter_read_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_ppa_settlement_id` FOREIGN KEY (`ppa_settlement_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_settlement`(`ppa_settlement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_curtailment_event_id` FOREIGN KEY (`curtailment_event_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`curtailment_event`(`curtailment_event_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_generation_meter_read_id` FOREIGN KEY (`generation_meter_read_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`generation_meter_read`(`generation_meter_read_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`nem_account`(`nem_account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_curtailment_event_id` FOREIGN KEY (`curtailment_event_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`curtailment_event`(`curtailment_event_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_incentive_application_id` FOREIGN KEY (`incentive_application_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`incentive_application`(`incentive_application_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_incentive_program_id` FOREIGN KEY (`incentive_program_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`incentive_program`(`incentive_program_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`nem_account`(`nem_account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_ppa_settlement_id` FOREIGN KEY (`ppa_settlement_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_settlement`(`ppa_settlement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_rps_obligation_id` FOREIGN KEY (`rps_obligation_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`rps_obligation`(`rps_obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_curtailment_event_id` FOREIGN KEY (`curtailment_event_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`curtailment_event`(`curtailment_event_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_generation_meter_read_id` FOREIGN KEY (`generation_meter_read_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`generation_meter_read`(`generation_meter_read_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_incentive_application_id` FOREIGN KEY (`incentive_application_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`incentive_application`(`incentive_application_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_incentive_program_id` FOREIGN KEY (`incentive_program_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`incentive_program`(`incentive_program_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`nem_account`(`nem_account_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_ppa_settlement_id` FOREIGN KEY (`ppa_settlement_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_settlement`(`ppa_settlement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_rps_obligation_id` FOREIGN KEY (`rps_obligation_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`rps_obligation`(`rps_obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`assistance_program` ADD CONSTRAINT `fk_billing_assistance_program_incentive_program_id` FOREIGN KEY (`incentive_program_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`incentive_program`(`incentive_program_id`);

-- ========= billing --> trading (24 constraint(s)) =========
-- Requires: billing schema, trading schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_lmp_price_id` FOREIGN KEY (`lmp_price_id`) REFERENCES `energy_utilities_ecm`.`trading`.`lmp_price`(`lmp_price_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `energy_utilities_ecm`.`trading`.`contract`(`contract_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_market_settlement_id` FOREIGN KEY (`market_settlement_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_settlement`(`market_settlement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ppa_id` FOREIGN KEY (`ppa_id`) REFERENCES `energy_utilities_ecm`.`trading`.`ppa`(`ppa_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_settlement_statement_id` FOREIGN KEY (`settlement_statement_id`) REFERENCES `energy_utilities_ecm`.`trading`.`settlement_statement`(`settlement_statement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_settlement_statement_id` FOREIGN KEY (`settlement_statement_id`) REFERENCES `energy_utilities_ecm`.`trading`.`settlement_statement`(`settlement_statement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_energy_schedule_id` FOREIGN KEY (`energy_schedule_id`) REFERENCES `energy_utilities_ecm`.`trading`.`energy_schedule`(`energy_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_lmp_price_id` FOREIGN KEY (`lmp_price_id`) REFERENCES `energy_utilities_ecm`.`trading`.`lmp_price`(`lmp_price_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_market_settlement_id` FOREIGN KEY (`market_settlement_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_settlement`(`market_settlement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_ppa_delivery_id` FOREIGN KEY (`ppa_delivery_id`) REFERENCES `energy_utilities_ecm`.`trading`.`ppa_delivery`(`ppa_delivery_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_market_settlement_id` FOREIGN KEY (`market_settlement_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_settlement`(`market_settlement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_settlement_statement_id` FOREIGN KEY (`settlement_statement_id`) REFERENCES `energy_utilities_ecm`.`trading`.`settlement_statement`(`settlement_statement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `energy_utilities_ecm`.`trading`.`trade`(`trade_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`collections` ADD CONSTRAINT `fk_billing_collections_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_market_settlement_id` FOREIGN KEY (`market_settlement_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_settlement`(`market_settlement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_market_run_id` FOREIGN KEY (`market_run_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_run`(`market_run_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_energy_schedule_id` FOREIGN KEY (`energy_schedule_id`) REFERENCES `energy_utilities_ecm`.`trading`.`energy_schedule`(`energy_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_market_settlement_id` FOREIGN KEY (`market_settlement_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_settlement`(`market_settlement_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_ppa_id` FOREIGN KEY (`ppa_id`) REFERENCES `energy_utilities_ecm`.`trading`.`ppa`(`ppa_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `energy_utilities_ecm`.`trading`.`trade`(`trade_id`);

-- ========= billing --> transmission (5 constraint(s)) =========
-- Requires: billing schema, transmission schema
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`determinant` ADD CONSTRAINT `fk_billing_determinant_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_outage`(`transmission_outage_id`);

-- ========= compliance --> asset (2 constraint(s)) =========
-- Requires: compliance schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ADD CONSTRAINT `fk_compliance_nerc_cip_asset_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= compliance --> customer (4 constraint(s)) =========
-- Requires: compliance schema, customer schema
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ADD CONSTRAINT `fk_compliance_evidence_record_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ADD CONSTRAINT `fk_compliance_evidence_record_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);

-- ========= compliance --> forecast (4 constraint(s)) =========
-- Requires: compliance schema, forecast schema
ALTER TABLE `energy_utilities_ecm`.`compliance`.`obligation` ADD CONSTRAINT `fk_compliance_obligation_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ADD CONSTRAINT `fk_compliance_emissions_report_generation_forecast_interval_id` FOREIGN KEY (`generation_forecast_interval_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`generation_forecast_interval`(`generation_forecast_interval_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ADD CONSTRAINT `fk_compliance_compliance_rec_certificate_forecast_renewable_id` FOREIGN KEY (`forecast_renewable_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_renewable`(`forecast_renewable_id`);

-- ========= compliance --> generation (8 constraint(s)) =========
-- Requires: compliance schema, generation schema
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_power_plant_id` FOREIGN KEY (`power_plant_id`) REFERENCES `energy_utilities_ecm`.`generation`.`power_plant`(`power_plant_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ADD CONSTRAINT `fk_compliance_emissions_report_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`emissions_report` ADD CONSTRAINT `fk_compliance_emissions_report_power_plant_id` FOREIGN KEY (`power_plant_id`) REFERENCES `energy_utilities_ecm`.`generation`.`power_plant`(`power_plant_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`environmental_permit` ADD CONSTRAINT `fk_compliance_environmental_permit_power_plant_id` FOREIGN KEY (`power_plant_id`) REFERENCES `energy_utilities_ecm`.`generation`.`power_plant`(`power_plant_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ADD CONSTRAINT `fk_compliance_compliance_rec_certificate_power_plant_id` FOREIGN KEY (`power_plant_id`) REFERENCES `energy_utilities_ecm`.`generation`.`power_plant`(`power_plant_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);

-- ========= compliance --> grid (1 constraint(s)) =========
-- Requires: compliance schema, grid schema
ALTER TABLE `energy_utilities_ecm`.`compliance`.`nerc_cip_asset` ADD CONSTRAINT `fk_compliance_nerc_cip_asset_control_center_id` FOREIGN KEY (`control_center_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_center`(`control_center_id`);

-- ========= compliance --> interconnection (6 constraint(s)) =========
-- Requires: compliance schema, interconnection schema
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`audit_finding` ADD CONSTRAINT `fk_compliance_audit_finding_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`enforcement_action` ADD CONSTRAINT `fk_compliance_enforcement_action_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`corrective_action_plan` ADD CONSTRAINT `fk_compliance_corrective_action_plan_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`evidence_record` ADD CONSTRAINT `fk_compliance_evidence_record_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);

-- ========= compliance --> renewable (1 constraint(s)) =========
-- Requires: compliance schema, renewable schema
ALTER TABLE `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate` ADD CONSTRAINT `fk_compliance_compliance_rec_certificate_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);

-- ========= customer --> asset (15 constraint(s)) =========
-- Requires: customer schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_agreement` ADD CONSTRAINT `fk_customer_customer_service_agreement_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_failure_event_id` FOREIGN KEY (`failure_event_id`) REFERENCES `energy_utilities_ecm`.`asset`.`failure_event`(`failure_event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_failure_event_id` FOREIGN KEY (`failure_event_id`) REFERENCES `energy_utilities_ecm`.`asset`.`failure_event`(`failure_event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `energy_utilities_ecm`.`asset`.`inspection`(`inspection_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `energy_utilities_ecm`.`asset`.`inspection`(`inspection_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`field_order` ADD CONSTRAINT `fk_customer_field_order_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`field_order` ADD CONSTRAINT `fk_customer_field_order_warranty_id` FOREIGN KEY (`warranty_id`) REFERENCES `energy_utilities_ecm`.`asset`.`warranty`(`warranty_id`);

-- ========= customer --> billing (11 constraint(s)) =========
-- Requires: customer schema, billing schema
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_agreement` ADD CONSTRAINT `fk_customer_customer_service_agreement_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_agreement` ADD CONSTRAINT `fk_customer_customer_service_agreement_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `energy_utilities_ecm`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_payment_arrangement_id` FOREIGN KEY (`payment_arrangement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`payment_arrangement`(`payment_arrangement_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_dunning_notice_id` FOREIGN KEY (`dunning_notice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`dunning_notice`(`dunning_notice_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_assistance_program_id` FOREIGN KEY (`assistance_program_id`) REFERENCES `energy_utilities_ecm`.`billing`.`assistance_program`(`assistance_program_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`field_order` ADD CONSTRAINT `fk_customer_field_order_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= customer --> compliance (3 constraint(s)) =========
-- Requires: customer schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`rate_case`(`rate_case_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_agreement` ADD CONSTRAINT `fk_customer_customer_service_agreement_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`rate_case`(`rate_case_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= customer --> demand (10 constraint(s)) =========
-- Requires: customer schema, demand schema
ALTER TABLE `energy_utilities_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_dr_program_id` FOREIGN KEY (`dr_program_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_program`(`dr_program_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_dr_enrollment_id` FOREIGN KEY (`dr_enrollment_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_enrollment`(`dr_enrollment_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_dr_program_id` FOREIGN KEY (`dr_program_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_program`(`dr_program_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_dr_program_id` FOREIGN KEY (`dr_program_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_program`(`dr_program_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_dr_program_id` FOREIGN KEY (`dr_program_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_program`(`dr_program_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_aggregator_id` FOREIGN KEY (`aggregator_id`) REFERENCES `energy_utilities_ecm`.`demand`.`aggregator`(`aggregator_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_dr_program_id` FOREIGN KEY (`dr_program_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_program`(`dr_program_id`);

-- ========= customer --> distribution (13 constraint(s)) =========
-- Requires: customer schema, distribution schema
ALTER TABLE `energy_utilities_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`transformer`(`transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`network_segment`(`network_segment_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`address` ADD CONSTRAINT `fk_customer_address_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`transformer`(`transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);

-- ========= customer --> forecast (2 constraint(s)) =========
-- Requires: customer schema, forecast schema
ALTER TABLE `energy_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);

-- ========= customer --> grid (7 constraint(s)) =========
-- Requires: customer schema, grid schema
ALTER TABLE `energy_utilities_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_grid_reliability_event_id` FOREIGN KEY (`grid_reliability_event_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_reliability_event`(`grid_reliability_event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_grid_reliability_event_id` FOREIGN KEY (`grid_reliability_event_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_reliability_event`(`grid_reliability_event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_grid_reliability_event_id` FOREIGN KEY (`grid_reliability_event_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_reliability_event`(`grid_reliability_event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`field_order` ADD CONSTRAINT `fk_customer_field_order_grid_switching_order_id` FOREIGN KEY (`grid_switching_order_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_switching_order`(`grid_switching_order_id`);

-- ========= customer --> interconnection (8 constraint(s)) =========
-- Requires: customer schema, interconnection schema
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`agreement`(`agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_nem_agreement_id` FOREIGN KEY (`nem_agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`nem_agreement`(`nem_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`field_order` ADD CONSTRAINT `fk_customer_field_order_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);

-- ========= customer --> metering (13 constraint(s)) =========
-- Requires: customer schema, metering schema
ALTER TABLE `energy_utilities_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`service_point`(`service_point_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_meter_reading_route_id` FOREIGN KEY (`meter_reading_route_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_reading_route`(`meter_reading_route_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_agreement` ADD CONSTRAINT `fk_customer_customer_service_agreement_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`service_point`(`service_point_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_meter_read_id` FOREIGN KEY (`meter_read_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_read`(`meter_read_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_vee_exception_id` FOREIGN KEY (`vee_exception_id`) REFERENCES `energy_utilities_ecm`.`metering`.`vee_exception`(`vee_exception_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_tou_rate_program_id` FOREIGN KEY (`tou_rate_program_id`) REFERENCES `energy_utilities_ecm`.`metering`.`tou_rate_program`(`tou_rate_program_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`field_order` ADD CONSTRAINT `fk_customer_field_order_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`field_order` ADD CONSTRAINT `fk_customer_field_order_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);

-- ========= customer --> outage (13 constraint(s)) =========
-- Requires: customer schema, outage schema
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_interruption_id` FOREIGN KEY (`interruption_id`) REFERENCES `energy_utilities_ecm`.`outage`.`interruption`(`interruption_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`field_order` ADD CONSTRAINT `fk_customer_field_order_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`field_order` ADD CONSTRAINT `fk_customer_field_order_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);

-- ========= customer --> renewable (16 constraint(s)) =========
-- Requires: customer schema, renewable schema
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_incentive_program_id` FOREIGN KEY (`incentive_program_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`incentive_program`(`incentive_program_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_interconnection_queue_id` FOREIGN KEY (`interconnection_queue_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`interconnection_queue`(`interconnection_queue_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_request` ADD CONSTRAINT `fk_customer_customer_service_request_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`nem_account`(`nem_account_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_incentive_program_id` FOREIGN KEY (`incentive_program_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`incentive_program`(`incentive_program_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_interconnection_queue_id` FOREIGN KEY (`interconnection_queue_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`interconnection_queue`(`interconnection_queue_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`nem_account`(`nem_account_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_incentive_program_id` FOREIGN KEY (`incentive_program_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`incentive_program`(`incentive_program_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_interconnection_queue_id` FOREIGN KEY (`interconnection_queue_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`interconnection_queue`(`interconnection_queue_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`nem_account`(`nem_account_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`field_order` ADD CONSTRAINT `fk_customer_field_order_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);

-- ========= customer --> trading (3 constraint(s)) =========
-- Requires: customer schema, trading schema
ALTER TABLE `energy_utilities_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `energy_utilities_ecm`.`trading`.`contract`(`contract_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`customer_service_agreement` ADD CONSTRAINT `fk_customer_customer_service_agreement_ppa_id` FOREIGN KEY (`ppa_id`) REFERENCES `energy_utilities_ecm`.`trading`.`ppa`(`ppa_id`);

-- ========= customer --> transmission (3 constraint(s)) =========
-- Requires: customer schema, transmission schema
ALTER TABLE `energy_utilities_ecm`.`customer`.`account` ADD CONSTRAINT `fk_customer_account_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`premise` ADD CONSTRAINT `fk_customer_premise_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_outage`(`transmission_outage_id`);

-- ========= demand --> asset (2 constraint(s)) =========
-- Requires: demand schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`direct_load_control_device` ADD CONSTRAINT `fk_demand_direct_load_control_device_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= demand --> billing (1 constraint(s)) =========
-- Requires: demand schema, billing schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`interruptible_tariff_agreement` ADD CONSTRAINT `fk_demand_interruptible_tariff_agreement_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);

-- ========= demand --> compliance (13 constraint(s)) =========
-- Requires: demand schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_program` ADD CONSTRAINT `fk_demand_dr_program_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_program` ADD CONSTRAINT `fk_demand_dr_program_program_id` FOREIGN KEY (`program_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_program` ADD CONSTRAINT `fk_demand_dr_program_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`curtailment_measurement` ADD CONSTRAINT `fk_demand_curtailment_measurement_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_incentive_payment` ADD CONSTRAINT `fk_demand_dr_incentive_payment_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`aggregator` ADD CONSTRAINT `fk_demand_aggregator_program_id` FOREIGN KEY (`program_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`interruptible_tariff_agreement` ADD CONSTRAINT `fk_demand_interruptible_tariff_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`interruptible_tariff_agreement` ADD CONSTRAINT `fk_demand_interruptible_tariff_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`direct_load_control_device` ADD CONSTRAINT `fk_demand_direct_load_control_device_nerc_cip_asset_id` FOREIGN KEY (`nerc_cip_asset_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`nerc_cip_asset`(`nerc_cip_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_program_id` FOREIGN KEY (`program_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= demand --> customer (13 constraint(s)) =========
-- Requires: demand schema, customer schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_enrollment` ADD CONSTRAINT `fk_demand_dr_enrollment_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_enrollment` ADD CONSTRAINT `fk_demand_dr_enrollment_customer_service_agreement_id` FOREIGN KEY (`customer_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`customer`.`customer_service_agreement`(`customer_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event_participant` ADD CONSTRAINT `fk_demand_dr_event_participant_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event_participant` ADD CONSTRAINT `fk_demand_dr_event_participant_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`load_baseline` ADD CONSTRAINT `fk_demand_load_baseline_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_incentive_payment` ADD CONSTRAINT `fk_demand_dr_incentive_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_incentive_payment` ADD CONSTRAINT `fk_demand_dr_incentive_payment_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `energy_utilities_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`interruptible_tariff_agreement` ADD CONSTRAINT `fk_demand_interruptible_tariff_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`interruptible_tariff_agreement` ADD CONSTRAINT `fk_demand_interruptible_tariff_agreement_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`direct_load_control_device` ADD CONSTRAINT `fk_demand_direct_load_control_device_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`direct_load_control_device` ADD CONSTRAINT `fk_demand_direct_load_control_device_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);

-- ========= demand --> distribution (22 constraint(s)) =========
-- Requires: demand schema, distribution schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_program` ADD CONSTRAINT `fk_demand_dr_program_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_program` ADD CONSTRAINT `fk_demand_dr_program_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_enrollment` ADD CONSTRAINT `fk_demand_dr_enrollment_der_interconnection_point_id` FOREIGN KEY (`der_interconnection_point_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`der_interconnection_point`(`der_interconnection_point_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_enrollment` ADD CONSTRAINT `fk_demand_dr_enrollment_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`transformer`(`transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_enrollment` ADD CONSTRAINT `fk_demand_dr_enrollment_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`network_segment`(`network_segment_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`load_baseline` ADD CONSTRAINT `fk_demand_load_baseline_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`curtailment_measurement` ADD CONSTRAINT `fk_demand_curtailment_measurement_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_incentive_payment` ADD CONSTRAINT `fk_demand_dr_incentive_payment_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`aggregator` ADD CONSTRAINT `fk_demand_aggregator_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`interruptible_tariff_agreement` ADD CONSTRAINT `fk_demand_interruptible_tariff_agreement_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`interruptible_tariff_agreement` ADD CONSTRAINT `fk_demand_interruptible_tariff_agreement_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`direct_load_control_device` ADD CONSTRAINT `fk_demand_direct_load_control_device_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`transformer`(`transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`direct_load_control_device` ADD CONSTRAINT `fk_demand_direct_load_control_device_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_der_interconnection_point_id` FOREIGN KEY (`der_interconnection_point_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`der_interconnection_point`(`der_interconnection_point_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);

-- ========= demand --> forecast (31 constraint(s)) =========
-- Requires: demand schema, forecast schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_program` ADD CONSTRAINT `fk_demand_dr_program_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_program` ADD CONSTRAINT `fk_demand_dr_program_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_program` ADD CONSTRAINT `fk_demand_dr_program_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_enrollment` ADD CONSTRAINT `fk_demand_dr_enrollment_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_peak_demand_id` FOREIGN KEY (`peak_demand_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`peak_demand`(`peak_demand_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event_participant` ADD CONSTRAINT `fk_demand_dr_event_participant_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`load_baseline` ADD CONSTRAINT `fk_demand_load_baseline_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`load_baseline` ADD CONSTRAINT `fk_demand_load_baseline_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`load_baseline` ADD CONSTRAINT `fk_demand_load_baseline_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`curtailment_measurement` ADD CONSTRAINT `fk_demand_curtailment_measurement_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_incentive_payment` ADD CONSTRAINT `fk_demand_dr_incentive_payment_peak_demand_id` FOREIGN KEY (`peak_demand_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`peak_demand`(`peak_demand_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_incentive_payment` ADD CONSTRAINT `fk_demand_dr_incentive_payment_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`aggregator` ADD CONSTRAINT `fk_demand_aggregator_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`aggregator` ADD CONSTRAINT `fk_demand_aggregator_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`aggregator` ADD CONSTRAINT `fk_demand_aggregator_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`interruptible_tariff_agreement` ADD CONSTRAINT `fk_demand_interruptible_tariff_agreement_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`direct_load_control_device` ADD CONSTRAINT `fk_demand_direct_load_control_device_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_forecast_generation_id` FOREIGN KEY (`forecast_generation_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_generation`(`forecast_generation_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_peak_demand_id` FOREIGN KEY (`peak_demand_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`peak_demand`(`peak_demand_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_capacity_requirement_id` FOREIGN KEY (`capacity_requirement_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`capacity_requirement`(`capacity_requirement_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_peak_demand_id` FOREIGN KEY (`peak_demand_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`peak_demand`(`peak_demand_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);

-- ========= demand --> generation (1 constraint(s)) =========
-- Requires: demand schema, generation schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_dispatch_schedule_id` FOREIGN KEY (`dispatch_schedule_id`) REFERENCES `energy_utilities_ecm`.`generation`.`dispatch_schedule`(`dispatch_schedule_id`);

-- ========= demand --> grid (16 constraint(s)) =========
-- Requires: demand schema, grid schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_program` ADD CONSTRAINT `fk_demand_dr_program_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_grid_reliability_event_id` FOREIGN KEY (`grid_reliability_event_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_reliability_event`(`grid_reliability_event_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_agc_signal_id` FOREIGN KEY (`agc_signal_id`) REFERENCES `energy_utilities_ecm`.`grid`.`agc_signal`(`agc_signal_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_contingency_analysis_run_id` FOREIGN KEY (`contingency_analysis_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency_analysis_run`(`contingency_analysis_run_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_load_forecast_id` FOREIGN KEY (`load_forecast_id`) REFERENCES `energy_utilities_ecm`.`grid`.`load_forecast`(`load_forecast_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_operating_limit_id` FOREIGN KEY (`operating_limit_id`) REFERENCES `energy_utilities_ecm`.`grid`.`operating_limit`(`operating_limit_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`load_baseline` ADD CONSTRAINT `fk_demand_load_baseline_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`load_baseline` ADD CONSTRAINT `fk_demand_load_baseline_load_forecast_id` FOREIGN KEY (`load_forecast_id`) REFERENCES `energy_utilities_ecm`.`grid`.`load_forecast`(`load_forecast_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`curtailment_measurement` ADD CONSTRAINT `fk_demand_curtailment_measurement_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`aggregator` ADD CONSTRAINT `fk_demand_aggregator_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_agc_signal_id` FOREIGN KEY (`agc_signal_id`) REFERENCES `energy_utilities_ecm`.`grid`.`agc_signal`(`agc_signal_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_generation_dispatch_id` FOREIGN KEY (`generation_dispatch_id`) REFERENCES `energy_utilities_ecm`.`grid`.`generation_dispatch`(`generation_dispatch_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_state_estimation_run_id` FOREIGN KEY (`state_estimation_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`state_estimation_run`(`state_estimation_run_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);

-- ========= demand --> interconnection (12 constraint(s)) =========
-- Requires: demand schema, interconnection schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_program` ADD CONSTRAINT `fk_demand_dr_program_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_enrollment` ADD CONSTRAINT `fk_demand_dr_enrollment_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event_participant` ADD CONSTRAINT `fk_demand_dr_event_participant_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event_participant` ADD CONSTRAINT `fk_demand_dr_event_participant_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`load_baseline` ADD CONSTRAINT `fk_demand_load_baseline_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`curtailment_measurement` ADD CONSTRAINT `fk_demand_curtailment_measurement_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_incentive_payment` ADD CONSTRAINT `fk_demand_dr_incentive_payment_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`direct_load_control_device` ADD CONSTRAINT `fk_demand_direct_load_control_device_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);

-- ========= demand --> metering (17 constraint(s)) =========
-- Requires: demand schema, metering schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_program` ADD CONSTRAINT `fk_demand_dr_program_tou_rate_program_id` FOREIGN KEY (`tou_rate_program_id`) REFERENCES `energy_utilities_ecm`.`metering`.`tou_rate_program`(`tou_rate_program_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_enrollment` ADD CONSTRAINT `fk_demand_dr_enrollment_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event_participant` ADD CONSTRAINT `fk_demand_dr_event_participant_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`load_baseline` ADD CONSTRAINT `fk_demand_load_baseline_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`load_baseline` ADD CONSTRAINT `fk_demand_load_baseline_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`load_baseline` ADD CONSTRAINT `fk_demand_load_baseline_interval_reading_id` FOREIGN KEY (`interval_reading_id`) REFERENCES `energy_utilities_ecm`.`metering`.`interval_reading`(`interval_reading_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`curtailment_measurement` ADD CONSTRAINT `fk_demand_curtailment_measurement_interval_reading_id` FOREIGN KEY (`interval_reading_id`) REFERENCES `energy_utilities_ecm`.`metering`.`interval_reading`(`interval_reading_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`curtailment_measurement` ADD CONSTRAINT `fk_demand_curtailment_measurement_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`curtailment_measurement` ADD CONSTRAINT `fk_demand_curtailment_measurement_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`curtailment_measurement` ADD CONSTRAINT `fk_demand_curtailment_measurement_vee_rule_id` FOREIGN KEY (`vee_rule_id`) REFERENCES `energy_utilities_ecm`.`metering`.`vee_rule`(`vee_rule_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_incentive_payment` ADD CONSTRAINT `fk_demand_dr_incentive_payment_meter_read_id` FOREIGN KEY (`meter_read_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_read`(`meter_read_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`interruptible_tariff_agreement` ADD CONSTRAINT `fk_demand_interruptible_tariff_agreement_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`interruptible_tariff_agreement` ADD CONSTRAINT `fk_demand_interruptible_tariff_agreement_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`direct_load_control_device` ADD CONSTRAINT `fk_demand_direct_load_control_device_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`direct_load_control_device` ADD CONSTRAINT `fk_demand_direct_load_control_device_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);

-- ========= demand --> outage (4 constraint(s)) =========
-- Requires: demand schema, outage schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_incentive_payment` ADD CONSTRAINT `fk_demand_dr_incentive_payment_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);

-- ========= demand --> renewable (6 constraint(s)) =========
-- Requires: demand schema, renewable schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event_participant` ADD CONSTRAINT `fk_demand_dr_event_participant_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`load_baseline` ADD CONSTRAINT `fk_demand_load_baseline_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`curtailment_measurement` ADD CONSTRAINT `fk_demand_curtailment_measurement_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);

-- ========= demand --> trading (1 constraint(s)) =========
-- Requires: demand schema, trading schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`curtailment_measurement` ADD CONSTRAINT `fk_demand_curtailment_measurement_lmp_price_id` FOREIGN KEY (`lmp_price_id`) REFERENCES `energy_utilities_ecm`.`trading`.`lmp_price`(`lmp_price_id`);

-- ========= demand --> transmission (13 constraint(s)) =========
-- Requires: demand schema, transmission schema
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_program` ADD CONSTRAINT `fk_demand_dr_program_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_program` ADD CONSTRAINT `fk_demand_dr_program_constraint_id` FOREIGN KEY (`constraint_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`constraint`(`constraint_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_enrollment` ADD CONSTRAINT `fk_demand_dr_enrollment_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_congestion_event_id` FOREIGN KEY (`congestion_event_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`congestion_event`(`congestion_event_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_flowgate_id` FOREIGN KEY (`flowgate_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`flowgate`(`flowgate_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_outage`(`transmission_outage_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_event` ADD CONSTRAINT `fk_demand_dr_event_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`curtailment_measurement` ADD CONSTRAINT `fk_demand_curtailment_measurement_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_incentive_payment` ADD CONSTRAINT `fk_demand_dr_incentive_payment_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_constraint_id` FOREIGN KEY (`constraint_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`constraint`(`constraint_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`vpp_dispatch` ADD CONSTRAINT `fk_demand_vpp_dispatch_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`demand`.`dr_capacity_registration` ADD CONSTRAINT `fk_demand_dr_capacity_registration_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);

-- ========= distribution --> asset (8 constraint(s)) =========
-- Requires: distribution schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`transformer` ADD CONSTRAINT `fk_distribution_transformer_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`sectionalizing_device` ADD CONSTRAINT `fk_distribution_sectionalizing_device_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`service_drop` ADD CONSTRAINT `fk_distribution_service_drop_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`capacitor_bank` ADD CONSTRAINT `fk_distribution_capacitor_bank_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_reliability_event` ADD CONSTRAINT `fk_distribution_distribution_reliability_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= distribution --> compliance (19 constraint(s)) =========
-- Requires: distribution schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_program_id` FOREIGN KEY (`program_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_bes_facility_id` FOREIGN KEY (`bes_facility_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`bes_facility`(`bes_facility_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_nerc_cip_asset_id` FOREIGN KEY (`nerc_cip_asset_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`nerc_cip_asset`(`nerc_cip_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`sectionalizing_device` ADD CONSTRAINT `fk_distribution_sectionalizing_device_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`network_segment` ADD CONSTRAINT `fk_distribution_network_segment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`flisr_event` ADD CONSTRAINT `fk_distribution_flisr_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`flisr_event` ADD CONSTRAINT `fk_distribution_flisr_event_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`volt_var_action` ADD CONSTRAINT `fk_distribution_volt_var_action_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`capacitor_bank` ADD CONSTRAINT `fk_distribution_capacitor_bank_nerc_cip_asset_id` FOREIGN KEY (`nerc_cip_asset_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`nerc_cip_asset`(`nerc_cip_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_reliability_event` ADD CONSTRAINT `fk_distribution_distribution_reliability_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_reliability_event` ADD CONSTRAINT `fk_distribution_distribution_reliability_event_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`der_interconnection_point` ADD CONSTRAINT `fk_distribution_der_interconnection_point_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`der_interconnection_point` ADD CONSTRAINT `fk_distribution_der_interconnection_point_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`der_interconnection_point` ADD CONSTRAINT `fk_distribution_der_interconnection_point_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`rate_case`(`rate_case_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`service_territory` ADD CONSTRAINT `fk_distribution_service_territory_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`service_territory` ADD CONSTRAINT `fk_distribution_service_territory_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`rate_case`(`rate_case_id`);

-- ========= distribution --> customer (4 constraint(s)) =========
-- Requires: distribution schema, customer schema
ALTER TABLE `energy_utilities_ecm`.`distribution`.`service_drop` ADD CONSTRAINT `fk_distribution_service_drop_customer_service_agreement_id` FOREIGN KEY (`customer_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`customer`.`customer_service_agreement`(`customer_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`service_drop` ADD CONSTRAINT `fk_distribution_service_drop_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`der_interconnection_point` ADD CONSTRAINT `fk_distribution_der_interconnection_point_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);

-- ========= distribution --> demand (5 constraint(s)) =========
-- Requires: distribution schema, demand schema
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`flisr_event` ADD CONSTRAINT `fk_distribution_flisr_event_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`volt_var_action` ADD CONSTRAINT `fk_distribution_volt_var_action_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_reliability_event` ADD CONSTRAINT `fk_distribution_distribution_reliability_event_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder_load_reading` ADD CONSTRAINT `fk_distribution_feeder_load_reading_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);

-- ========= distribution --> forecast (10 constraint(s)) =========
-- Requires: distribution schema, forecast schema
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`load_zone` ADD CONSTRAINT `fk_distribution_load_zone_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`flisr_event` ADD CONSTRAINT `fk_distribution_flisr_event_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_reliability_event` ADD CONSTRAINT `fk_distribution_distribution_reliability_event_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder_load_reading` ADD CONSTRAINT `fk_distribution_feeder_load_reading_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder_load_reading` ADD CONSTRAINT `fk_distribution_feeder_load_reading_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`service_territory` ADD CONSTRAINT `fk_distribution_service_territory_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`service_territory` ADD CONSTRAINT `fk_distribution_service_territory_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);

-- ========= distribution --> grid (19 constraint(s)) =========
-- Requires: distribution schema, grid schema
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`transformer` ADD CONSTRAINT `fk_distribution_transformer_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`network_segment` ADD CONSTRAINT `fk_distribution_network_segment_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`load_zone` ADD CONSTRAINT `fk_distribution_load_zone_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_control_center_id` FOREIGN KEY (`control_center_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_center`(`control_center_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_state_estimation_run_id` FOREIGN KEY (`state_estimation_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`state_estimation_run`(`state_estimation_run_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`flisr_event` ADD CONSTRAINT `fk_distribution_flisr_event_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`volt_var_action` ADD CONSTRAINT `fk_distribution_volt_var_action_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`volt_var_action` ADD CONSTRAINT `fk_distribution_volt_var_action_state_estimation_run_id` FOREIGN KEY (`state_estimation_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`state_estimation_run`(`state_estimation_run_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`capacitor_bank` ADD CONSTRAINT `fk_distribution_capacitor_bank_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`capacitor_bank` ADD CONSTRAINT `fk_distribution_capacitor_bank_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_reliability_event` ADD CONSTRAINT `fk_distribution_distribution_reliability_event_control_center_id` FOREIGN KEY (`control_center_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_center`(`control_center_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_reliability_event` ADD CONSTRAINT `fk_distribution_distribution_reliability_event_grid_reliability_event_id` FOREIGN KEY (`grid_reliability_event_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_reliability_event`(`grid_reliability_event_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder_load_reading` ADD CONSTRAINT `fk_distribution_feeder_load_reading_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder_load_reading` ADD CONSTRAINT `fk_distribution_feeder_load_reading_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`der_interconnection_point` ADD CONSTRAINT `fk_distribution_der_interconnection_point_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`der_interconnection_point` ADD CONSTRAINT `fk_distribution_der_interconnection_point_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`service_territory` ADD CONSTRAINT `fk_distribution_service_territory_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);

-- ========= distribution --> interconnection (2 constraint(s)) =========
-- Requires: distribution schema, interconnection schema
ALTER TABLE `energy_utilities_ecm`.`distribution`.`der_interconnection_point` ADD CONSTRAINT `fk_distribution_der_interconnection_point_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`agreement`(`agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`der_interconnection_point` ADD CONSTRAINT `fk_distribution_der_interconnection_point_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);

-- ========= distribution --> metering (4 constraint(s)) =========
-- Requires: distribution schema, metering schema
ALTER TABLE `energy_utilities_ecm`.`distribution`.`service_drop` ADD CONSTRAINT `fk_distribution_service_drop_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`service_drop` ADD CONSTRAINT `fk_distribution_service_drop_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`service_point`(`service_point_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder_load_reading` ADD CONSTRAINT `fk_distribution_feeder_load_reading_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`der_interconnection_point` ADD CONSTRAINT `fk_distribution_der_interconnection_point_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);

-- ========= distribution --> outage (15 constraint(s)) =========
-- Requires: distribution schema, outage schema
ALTER TABLE `energy_utilities_ecm`.`distribution`.`sectionalizing_device` ADD CONSTRAINT `fk_distribution_sectionalizing_device_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`flisr_event` ADD CONSTRAINT `fk_distribution_flisr_event_cause_id` FOREIGN KEY (`cause_id`) REFERENCES `energy_utilities_ecm`.`outage`.`cause`(`cause_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`flisr_event` ADD CONSTRAINT `fk_distribution_flisr_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`flisr_event` ADD CONSTRAINT `fk_distribution_flisr_event_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_reliability_event` ADD CONSTRAINT `fk_distribution_distribution_reliability_event_cause_id` FOREIGN KEY (`cause_id`) REFERENCES `energy_utilities_ecm`.`outage`.`cause`(`cause_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_reliability_event` ADD CONSTRAINT `fk_distribution_distribution_reliability_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_reliability_event` ADD CONSTRAINT `fk_distribution_distribution_reliability_event_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_reliability_event` ADD CONSTRAINT `fk_distribution_distribution_reliability_event_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder_load_reading` ADD CONSTRAINT `fk_distribution_feeder_load_reading_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder_load_reading` ADD CONSTRAINT `fk_distribution_feeder_load_reading_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder_load_reading` ADD CONSTRAINT `fk_distribution_feeder_load_reading_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`der_interconnection_point` ADD CONSTRAINT `fk_distribution_der_interconnection_point_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);

-- ========= distribution --> renewable (2 constraint(s)) =========
-- Requires: distribution schema, renewable schema
ALTER TABLE `energy_utilities_ecm`.`distribution`.`volt_var_action` ADD CONSTRAINT `fk_distribution_volt_var_action_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`der_interconnection_point` ADD CONSTRAINT `fk_distribution_der_interconnection_point_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);

-- ========= distribution --> trading (5 constraint(s)) =========
-- Requires: distribution schema, trading schema
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_energy_schedule_id` FOREIGN KEY (`energy_schedule_id`) REFERENCES `energy_utilities_ecm`.`trading`.`energy_schedule`(`energy_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`flisr_event` ADD CONSTRAINT `fk_distribution_flisr_event_energy_schedule_id` FOREIGN KEY (`energy_schedule_id`) REFERENCES `energy_utilities_ecm`.`trading`.`energy_schedule`(`energy_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`volt_var_action` ADD CONSTRAINT `fk_distribution_volt_var_action_energy_schedule_id` FOREIGN KEY (`energy_schedule_id`) REFERENCES `energy_utilities_ecm`.`trading`.`energy_schedule`(`energy_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`der_interconnection_point` ADD CONSTRAINT `fk_distribution_der_interconnection_point_ppa_id` FOREIGN KEY (`ppa_id`) REFERENCES `energy_utilities_ecm`.`trading`.`ppa`(`ppa_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`service_territory` ADD CONSTRAINT `fk_distribution_service_territory_market_participant_id` FOREIGN KEY (`market_participant_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_participant`(`market_participant_id`);

-- ========= distribution --> transmission (6 constraint(s)) =========
-- Requires: distribution schema, transmission schema
ALTER TABLE `energy_utilities_ecm`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_substation` ADD CONSTRAINT `fk_distribution_distribution_substation_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`load_zone` ADD CONSTRAINT `fk_distribution_load_zone_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_transmission_switching_order_id` FOREIGN KEY (`transmission_switching_order_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_switching_order`(`transmission_switching_order_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`distribution_reliability_event` ADD CONSTRAINT `fk_distribution_distribution_reliability_event_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_outage`(`transmission_outage_id`);
ALTER TABLE `energy_utilities_ecm`.`distribution`.`der_interconnection_point` ADD CONSTRAINT `fk_distribution_der_interconnection_point_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);

-- ========= forecast --> asset (2 constraint(s)) =========
-- Requires: forecast schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ADD CONSTRAINT `fk_forecast_forecast_renewable_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ADD CONSTRAINT `fk_forecast_renewable_forecast_interval_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= forecast --> compliance (2 constraint(s)) =========
-- Requires: forecast schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ADD CONSTRAINT `fk_forecast_irp_scenario_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ADD CONSTRAINT `fk_forecast_irp_scenario_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= forecast --> distribution (1 constraint(s)) =========
-- Requires: forecast schema, distribution schema
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ADD CONSTRAINT `fk_forecast_load_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);

-- ========= forecast --> generation (2 constraint(s)) =========
-- Requires: forecast schema, generation schema
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ADD CONSTRAINT `fk_forecast_forecast_generation_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ADD CONSTRAINT `fk_forecast_generation_forecast_interval_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);

-- ========= forecast --> grid (13 constraint(s)) =========
-- Requires: forecast schema, grid schema
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load` ADD CONSTRAINT `fk_forecast_load_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ADD CONSTRAINT `fk_forecast_load_forecast_interval_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`generation_forecast_interval` ADD CONSTRAINT `fk_forecast_generation_forecast_interval_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ADD CONSTRAINT `fk_forecast_forecast_renewable_operating_limit_id` FOREIGN KEY (`operating_limit_id`) REFERENCES `energy_utilities_ecm`.`grid`.`operating_limit`(`operating_limit_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ADD CONSTRAINT `fk_forecast_renewable_forecast_interval_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ADD CONSTRAINT `fk_forecast_renewable_forecast_interval_operating_limit_id` FOREIGN KEY (`operating_limit_id`) REFERENCES `energy_utilities_ecm`.`grid`.`operating_limit`(`operating_limit_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ADD CONSTRAINT `fk_forecast_peak_demand_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ADD CONSTRAINT `fk_forecast_accuracy_load_forecast_id` FOREIGN KEY (`load_forecast_id`) REFERENCES `energy_utilities_ecm`.`grid`.`load_forecast`(`load_forecast_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ADD CONSTRAINT `fk_forecast_accuracy_state_estimation_run_id` FOREIGN KEY (`state_estimation_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`state_estimation_run`(`state_estimation_run_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ADD CONSTRAINT `fk_forecast_irp_scenario_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`irp_scenario` ADD CONSTRAINT `fk_forecast_irp_scenario_load_forecast_id` FOREIGN KEY (`load_forecast_id`) REFERENCES `energy_utilities_ecm`.`grid`.`load_forecast`(`load_forecast_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ADD CONSTRAINT `fk_forecast_capacity_requirement_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ADD CONSTRAINT `fk_forecast_energy_price_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);

-- ========= forecast --> metering (6 constraint(s)) =========
-- Requires: forecast schema, metering schema
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ADD CONSTRAINT `fk_forecast_load_forecast_interval_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_generation` ADD CONSTRAINT `fk_forecast_forecast_generation_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`peak_demand` ADD CONSTRAINT `fk_forecast_peak_demand_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ADD CONSTRAINT `fk_forecast_accuracy_interval_reading_id` FOREIGN KEY (`interval_reading_id`) REFERENCES `energy_utilities_ecm`.`metering`.`interval_reading`(`interval_reading_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ADD CONSTRAINT `fk_forecast_accuracy_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`accuracy` ADD CONSTRAINT `fk_forecast_accuracy_meter_read_id` FOREIGN KEY (`meter_read_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_read`(`meter_read_id`);

-- ========= forecast --> trading (1 constraint(s)) =========
-- Requires: forecast schema, trading schema
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ADD CONSTRAINT `fk_forecast_forecast_renewable_ppa_id` FOREIGN KEY (`ppa_id`) REFERENCES `energy_utilities_ecm`.`trading`.`ppa`(`ppa_id`);

-- ========= forecast --> transmission (5 constraint(s)) =========
-- Requires: forecast schema, transmission schema
ALTER TABLE `energy_utilities_ecm`.`forecast`.`load_forecast_interval` ADD CONSTRAINT `fk_forecast_load_forecast_interval_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`forecast_renewable` ADD CONSTRAINT `fk_forecast_forecast_renewable_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`renewable_forecast_interval` ADD CONSTRAINT `fk_forecast_renewable_forecast_interval_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`capacity_requirement` ADD CONSTRAINT `fk_forecast_capacity_requirement_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`forecast`.`energy_price` ADD CONSTRAINT `fk_forecast_energy_price_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);

-- ========= generation --> asset (14 constraint(s)) =========
-- Requires: generation schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`generation`.`power_plant` ADD CONSTRAINT `fk_generation_power_plant_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`power_plant` ADD CONSTRAINT `fk_generation_power_plant_valuation_id` FOREIGN KEY (`valuation_id`) REFERENCES `energy_utilities_ecm`.`asset`.`valuation`(`valuation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `energy_utilities_ecm`.`asset`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`heat_rate_test` ADD CONSTRAINT `fk_generation_heat_rate_test_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `energy_utilities_ecm`.`asset`.`inspection`(`inspection_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`heat_rate_test` ADD CONSTRAINT `fk_generation_heat_rate_test_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`fuel_inventory` ADD CONSTRAINT `fk_generation_fuel_inventory_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`emissions_reading` ADD CONSTRAINT `fk_generation_emissions_reading_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_failure_event_id` FOREIGN KEY (`failure_event_id`) REFERENCES `energy_utilities_ecm`.`asset`.`failure_event`(`failure_event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `energy_utilities_ecm`.`asset`.`inspection`(`inspection_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `energy_utilities_ecm`.`asset`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`startup_event` ADD CONSTRAINT `fk_generation_startup_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= generation --> compliance (18 constraint(s)) =========
-- Requires: generation schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_bes_facility_id` FOREIGN KEY (`bes_facility_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`bes_facility`(`bes_facility_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_program_id` FOREIGN KEY (`program_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`heat_rate_test` ADD CONSTRAINT `fk_generation_heat_rate_test_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`heat_rate_test` ADD CONSTRAINT `fk_generation_heat_rate_test_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`emissions_reading` ADD CONSTRAINT `fk_generation_emissions_reading_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`emissions_reading` ADD CONSTRAINT `fk_generation_emissions_reading_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`startup_event` ADD CONSTRAINT `fk_generation_startup_event_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`ancillary_service_offer` ADD CONSTRAINT `fk_generation_ancillary_service_offer_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`fuel_contract` ADD CONSTRAINT `fk_generation_fuel_contract_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`fuel_contract` ADD CONSTRAINT `fk_generation_fuel_contract_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= generation --> customer (1 constraint(s)) =========
-- Requires: generation schema, customer schema
ALTER TABLE `energy_utilities_ecm`.`generation`.`power_plant` ADD CONSTRAINT `fk_generation_power_plant_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);

-- ========= generation --> demand (6 constraint(s)) =========
-- Requires: generation schema, demand schema
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`output_telemetry` ADD CONSTRAINT `fk_generation_output_telemetry_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`startup_event` ADD CONSTRAINT `fk_generation_startup_event_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_dr_capacity_registration_id` FOREIGN KEY (`dr_capacity_registration_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_capacity_registration`(`dr_capacity_registration_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_dr_program_id` FOREIGN KEY (`dr_program_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_program`(`dr_program_id`);

-- ========= generation --> distribution (8 constraint(s)) =========
-- Requires: generation schema, distribution schema
ALTER TABLE `energy_utilities_ecm`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`power_plant` ADD CONSTRAINT `fk_generation_power_plant_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`output_telemetry` ADD CONSTRAINT `fk_generation_output_telemetry_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);

-- ========= generation --> forecast (12 constraint(s)) =========
-- Requires: generation schema, forecast schema
ALTER TABLE `energy_utilities_ecm`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`power_plant` ADD CONSTRAINT `fk_generation_power_plant_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`output_telemetry` ADD CONSTRAINT `fk_generation_output_telemetry_forecast_generation_id` FOREIGN KEY (`forecast_generation_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_generation`(`forecast_generation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_capacity_requirement_id` FOREIGN KEY (`capacity_requirement_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`capacity_requirement`(`capacity_requirement_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_irp_scenario_id` FOREIGN KEY (`irp_scenario_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`irp_scenario`(`irp_scenario_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_peak_demand_id` FOREIGN KEY (`peak_demand_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`peak_demand`(`peak_demand_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);

-- ========= generation --> grid (30 constraint(s)) =========
-- Requires: generation schema, grid schema
ALTER TABLE `energy_utilities_ecm`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_contingency_id` FOREIGN KEY (`contingency_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency`(`contingency_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`power_plant` ADD CONSTRAINT `fk_generation_power_plant_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_interchange_schedule_id` FOREIGN KEY (`interchange_schedule_id`) REFERENCES `energy_utilities_ecm`.`grid`.`interchange_schedule`(`interchange_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_state_estimation_run_id` FOREIGN KEY (`state_estimation_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`state_estimation_run`(`state_estimation_run_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_generation_dispatch_id` FOREIGN KEY (`generation_dispatch_id`) REFERENCES `energy_utilities_ecm`.`grid`.`generation_dispatch`(`generation_dispatch_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_operating_limit_id` FOREIGN KEY (`operating_limit_id`) REFERENCES `energy_utilities_ecm`.`grid`.`operating_limit`(`operating_limit_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_state_estimation_run_id` FOREIGN KEY (`state_estimation_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`state_estimation_run`(`state_estimation_run_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`output_telemetry` ADD CONSTRAINT `fk_generation_output_telemetry_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`output_telemetry` ADD CONSTRAINT `fk_generation_output_telemetry_generation_dispatch_id` FOREIGN KEY (`generation_dispatch_id`) REFERENCES `energy_utilities_ecm`.`grid`.`generation_dispatch`(`generation_dispatch_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`heat_rate_test` ADD CONSTRAINT `fk_generation_heat_rate_test_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`emissions_reading` ADD CONSTRAINT `fk_generation_emissions_reading_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_contingency_id` FOREIGN KEY (`contingency_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency`(`contingency_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_frequency_event_id` FOREIGN KEY (`frequency_event_id`) REFERENCES `energy_utilities_ecm`.`grid`.`frequency_event`(`frequency_event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_grid_reliability_event_id` FOREIGN KEY (`grid_reliability_event_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_reliability_event`(`grid_reliability_event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_grid_switching_order_id` FOREIGN KEY (`grid_switching_order_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_switching_order`(`grid_switching_order_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`startup_event` ADD CONSTRAINT `fk_generation_startup_event_contingency_analysis_run_id` FOREIGN KEY (`contingency_analysis_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency_analysis_run`(`contingency_analysis_run_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`startup_event` ADD CONSTRAINT `fk_generation_startup_event_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`startup_event` ADD CONSTRAINT `fk_generation_startup_event_grid_reliability_event_id` FOREIGN KEY (`grid_reliability_event_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_reliability_event`(`grid_reliability_event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`startup_event` ADD CONSTRAINT `fk_generation_startup_event_grid_switching_order_id` FOREIGN KEY (`grid_switching_order_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_switching_order`(`grid_switching_order_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`startup_event` ADD CONSTRAINT `fk_generation_startup_event_state_estimation_run_id` FOREIGN KEY (`state_estimation_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`state_estimation_run`(`state_estimation_run_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_load_forecast_id` FOREIGN KEY (`load_forecast_id`) REFERENCES `energy_utilities_ecm`.`grid`.`load_forecast`(`load_forecast_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`ancillary_service_offer` ADD CONSTRAINT `fk_generation_ancillary_service_offer_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`ancillary_service_offer` ADD CONSTRAINT `fk_generation_ancillary_service_offer_operating_limit_id` FOREIGN KEY (`operating_limit_id`) REFERENCES `energy_utilities_ecm`.`grid`.`operating_limit`(`operating_limit_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`ancillary_service_offer` ADD CONSTRAINT `fk_generation_ancillary_service_offer_state_estimation_run_id` FOREIGN KEY (`state_estimation_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`state_estimation_run`(`state_estimation_run_id`);

-- ========= generation --> interconnection (4 constraint(s)) =========
-- Requires: generation schema, interconnection schema
ALTER TABLE `energy_utilities_ecm`.`generation`.`output_telemetry` ADD CONSTRAINT `fk_generation_output_telemetry_poi_specification_id` FOREIGN KEY (`poi_specification_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`poi_specification`(`poi_specification_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_hosting_capacity_id` FOREIGN KEY (`hosting_capacity_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`hosting_capacity`(`hosting_capacity_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_network_upgrade_id` FOREIGN KEY (`network_upgrade_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`network_upgrade`(`network_upgrade_id`);

-- ========= generation --> outage (9 constraint(s)) =========
-- Requires: generation schema, outage schema
ALTER TABLE `energy_utilities_ecm`.`generation`.`power_plant` ADD CONSTRAINT `fk_generation_power_plant_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`output_telemetry` ADD CONSTRAINT `fk_generation_output_telemetry_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`emissions_reading` ADD CONSTRAINT `fk_generation_emissions_reading_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_cause_id` FOREIGN KEY (`cause_id`) REFERENCES `energy_utilities_ecm`.`outage`.`cause`(`cause_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`startup_event` ADD CONSTRAINT `fk_generation_startup_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`startup_event` ADD CONSTRAINT `fk_generation_startup_event_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);

-- ========= generation --> renewable (11 constraint(s)) =========
-- Requires: generation schema, renewable schema
ALTER TABLE `energy_utilities_ecm`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_interconnection_queue_id` FOREIGN KEY (`interconnection_queue_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`interconnection_queue`(`interconnection_queue_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_curtailment_event_id` FOREIGN KEY (`curtailment_event_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`curtailment_event`(`curtailment_event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`output_telemetry` ADD CONSTRAINT `fk_generation_output_telemetry_curtailment_event_id` FOREIGN KEY (`curtailment_event_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`curtailment_event`(`curtailment_event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_interconnection_queue_id` FOREIGN KEY (`interconnection_queue_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`interconnection_queue`(`interconnection_queue_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_rps_obligation_id` FOREIGN KEY (`rps_obligation_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`rps_obligation`(`rps_obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`ancillary_service_offer` ADD CONSTRAINT `fk_generation_ancillary_service_offer_battery_storage_asset_id` FOREIGN KEY (`battery_storage_asset_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`battery_storage_asset`(`battery_storage_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`ancillary_service_offer` ADD CONSTRAINT `fk_generation_ancillary_service_offer_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);

-- ========= generation --> trading (19 constraint(s)) =========
-- Requires: generation schema, trading schema
ALTER TABLE `energy_utilities_ecm`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_book_id` FOREIGN KEY (`book_id`) REFERENCES `energy_utilities_ecm`.`trading`.`book`(`book_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`power_plant` ADD CONSTRAINT `fk_generation_power_plant_book_id` FOREIGN KEY (`book_id`) REFERENCES `energy_utilities_ecm`.`trading`.`book`(`book_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`power_plant` ADD CONSTRAINT `fk_generation_power_plant_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `energy_utilities_ecm`.`trading`.`contract`(`contract_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_market_award_id` FOREIGN KEY (`market_award_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_award`(`market_award_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_market_bid_id` FOREIGN KEY (`market_bid_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_bid`(`market_bid_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `energy_utilities_ecm`.`trading`.`trade`(`trade_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_energy_schedule_id` FOREIGN KEY (`energy_schedule_id`) REFERENCES `energy_utilities_ecm`.`trading`.`energy_schedule`(`energy_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_lmp_price_id` FOREIGN KEY (`lmp_price_id`) REFERENCES `energy_utilities_ecm`.`trading`.`lmp_price`(`lmp_price_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_market_award_id` FOREIGN KEY (`market_award_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_award`(`market_award_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`output_telemetry` ADD CONSTRAINT `fk_generation_output_telemetry_energy_schedule_id` FOREIGN KEY (`energy_schedule_id`) REFERENCES `energy_utilities_ecm`.`trading`.`energy_schedule`(`energy_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`output_telemetry` ADD CONSTRAINT `fk_generation_output_telemetry_lmp_price_id` FOREIGN KEY (`lmp_price_id`) REFERENCES `energy_utilities_ecm`.`trading`.`lmp_price`(`lmp_price_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`heat_rate_test` ADD CONSTRAINT `fk_generation_heat_rate_test_market_bid_id` FOREIGN KEY (`market_bid_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_bid`(`market_bid_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`outage_event` ADD CONSTRAINT `fk_generation_outage_event_energy_schedule_id` FOREIGN KEY (`energy_schedule_id`) REFERENCES `energy_utilities_ecm`.`trading`.`energy_schedule`(`energy_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`startup_event` ADD CONSTRAINT `fk_generation_startup_event_market_bid_id` FOREIGN KEY (`market_bid_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_bid`(`market_bid_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`capacity_plan` ADD CONSTRAINT `fk_generation_capacity_plan_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `energy_utilities_ecm`.`trading`.`contract`(`contract_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`ancillary_service_offer` ADD CONSTRAINT `fk_generation_ancillary_service_offer_market_award_id` FOREIGN KEY (`market_award_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_award`(`market_award_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`ancillary_service_offer` ADD CONSTRAINT `fk_generation_ancillary_service_offer_market_bid_id` FOREIGN KEY (`market_bid_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_bid`(`market_bid_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`fuel_contract` ADD CONSTRAINT `fk_generation_fuel_contract_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `energy_utilities_ecm`.`trading`.`contract`(`contract_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`fuel_contract` ADD CONSTRAINT `fk_generation_fuel_contract_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);

-- ========= generation --> transmission (9 constraint(s)) =========
-- Requires: generation schema, transmission schema
ALTER TABLE `energy_utilities_ecm`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_constraint_id` FOREIGN KEY (`constraint_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`constraint`(`constraint_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`unit_commitment` ADD CONSTRAINT `fk_generation_unit_commitment_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_congestion_event_id` FOREIGN KEY (`congestion_event_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`congestion_event`(`congestion_event_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_flowgate_id` FOREIGN KEY (`flowgate_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`flowgate`(`flowgate_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`output_telemetry` ADD CONSTRAINT `fk_generation_output_telemetry_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`generation`.`ancillary_service_offer` ADD CONSTRAINT `fk_generation_ancillary_service_offer_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);

-- ========= grid --> asset (9 constraint(s)) =========
-- Requires: grid schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`grid`.`ems_node` ADD CONSTRAINT `fk_grid_ems_node_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_scada_measurement` ADD CONSTRAINT `fk_grid_grid_scada_measurement_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`generation_dispatch` ADD CONSTRAINT `fk_grid_generation_dispatch_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `energy_utilities_ecm`.`asset`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_switching_order` ADD CONSTRAINT `fk_grid_grid_switching_order_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `energy_utilities_ecm`.`asset`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_switching_order` ADD CONSTRAINT `fk_grid_grid_switching_order_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_switching_order` ADD CONSTRAINT `fk_grid_grid_switching_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`pmu_device` ADD CONSTRAINT `fk_grid_pmu_device_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`pmu_device` ADD CONSTRAINT `fk_grid_pmu_device_warranty_id` FOREIGN KEY (`warranty_id`) REFERENCES `energy_utilities_ecm`.`asset`.`warranty`(`warranty_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_reliability_event` ADD CONSTRAINT `fk_grid_grid_reliability_event_failure_event_id` FOREIGN KEY (`failure_event_id`) REFERENCES `energy_utilities_ecm`.`asset`.`failure_event`(`failure_event_id`);

-- ========= grid --> compliance (18 constraint(s)) =========
-- Requires: grid schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`grid`.`control_area` ADD CONSTRAINT `fk_grid_control_area_program_id` FOREIGN KEY (`program_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`program`(`program_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`ems_node` ADD CONSTRAINT `fk_grid_ems_node_bes_facility_id` FOREIGN KEY (`bes_facility_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`bes_facility`(`bes_facility_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`state_estimation_run` ADD CONSTRAINT `fk_grid_state_estimation_run_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`contingency` ADD CONSTRAINT `fk_grid_contingency_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`contingency_analysis_run` ADD CONSTRAINT `fk_grid_contingency_analysis_run_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`contingency_violation` ADD CONSTRAINT `fk_grid_contingency_violation_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`contingency_violation` ADD CONSTRAINT `fk_grid_contingency_violation_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`interchange_schedule` ADD CONSTRAINT `fk_grid_interchange_schedule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`interchange_schedule` ADD CONSTRAINT `fk_grid_interchange_schedule_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`load_forecast` ADD CONSTRAINT `fk_grid_load_forecast_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`generation_dispatch` ADD CONSTRAINT `fk_grid_generation_dispatch_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_switching_order` ADD CONSTRAINT `fk_grid_grid_switching_order_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_switching_order` ADD CONSTRAINT `fk_grid_grid_switching_order_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_switching_order` ADD CONSTRAINT `fk_grid_grid_switching_order_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`frequency_event` ADD CONSTRAINT `fk_grid_frequency_event_corrective_action_plan_id` FOREIGN KEY (`corrective_action_plan_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`corrective_action_plan`(`corrective_action_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`pmu_device` ADD CONSTRAINT `fk_grid_pmu_device_nerc_cip_asset_id` FOREIGN KEY (`nerc_cip_asset_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`nerc_cip_asset`(`nerc_cip_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`pmu_device` ADD CONSTRAINT `fk_grid_pmu_device_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`operating_limit` ADD CONSTRAINT `fk_grid_operating_limit_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= grid --> distribution (9 constraint(s)) =========
-- Requires: grid schema, distribution schema
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_scada_measurement` ADD CONSTRAINT `fk_grid_grid_scada_measurement_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_scada_measurement` ADD CONSTRAINT `fk_grid_grid_scada_measurement_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`contingency_violation` ADD CONSTRAINT `fk_grid_contingency_violation_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`agc_signal` ADD CONSTRAINT `fk_grid_agc_signal_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_switching_order` ADD CONSTRAINT `fk_grid_grid_switching_order_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_switching_order` ADD CONSTRAINT `fk_grid_grid_switching_order_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`frequency_event` ADD CONSTRAINT `fk_grid_frequency_event_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_reliability_event` ADD CONSTRAINT `fk_grid_grid_reliability_event_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`operating_limit` ADD CONSTRAINT `fk_grid_operating_limit_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`network_segment`(`network_segment_id`);

-- ========= grid --> forecast (10 constraint(s)) =========
-- Requires: grid schema, forecast schema
ALTER TABLE `energy_utilities_ecm`.`grid`.`ems_node` ADD CONSTRAINT `fk_grid_ems_node_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`state_estimation_run` ADD CONSTRAINT `fk_grid_state_estimation_run_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`contingency_analysis_run` ADD CONSTRAINT `fk_grid_contingency_analysis_run_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`load_forecast` ADD CONSTRAINT `fk_grid_load_forecast_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`load_forecast` ADD CONSTRAINT `fk_grid_load_forecast_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`load_forecast` ADD CONSTRAINT `fk_grid_load_forecast_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`load_forecast` ADD CONSTRAINT `fk_grid_load_forecast_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`generation_dispatch` ADD CONSTRAINT `fk_grid_generation_dispatch_forecast_generation_id` FOREIGN KEY (`forecast_generation_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_generation`(`forecast_generation_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`generation_dispatch` ADD CONSTRAINT `fk_grid_generation_dispatch_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`frequency_event` ADD CONSTRAINT `fk_grid_frequency_event_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);

-- ========= grid --> generation (2 constraint(s)) =========
-- Requires: grid schema, generation schema
ALTER TABLE `energy_utilities_ecm`.`grid`.`agc_signal` ADD CONSTRAINT `fk_grid_agc_signal_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`generation_dispatch` ADD CONSTRAINT `fk_grid_generation_dispatch_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);

-- ========= grid --> outage (5 constraint(s)) =========
-- Requires: grid schema, outage schema
ALTER TABLE `energy_utilities_ecm`.`grid`.`generation_dispatch` ADD CONSTRAINT `fk_grid_generation_dispatch_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_switching_order` ADD CONSTRAINT `fk_grid_grid_switching_order_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`frequency_event` ADD CONSTRAINT `fk_grid_frequency_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_reliability_event` ADD CONSTRAINT `fk_grid_grid_reliability_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_reliability_event` ADD CONSTRAINT `fk_grid_grid_reliability_event_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);

-- ========= grid --> renewable (9 constraint(s)) =========
-- Requires: grid schema, renewable schema
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_scada_measurement` ADD CONSTRAINT `fk_grid_grid_scada_measurement_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`state_estimation_result` ADD CONSTRAINT `fk_grid_state_estimation_result_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`contingency_violation` ADD CONSTRAINT `fk_grid_contingency_violation_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`interchange_schedule` ADD CONSTRAINT `fk_grid_interchange_schedule_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`generation_dispatch` ADD CONSTRAINT `fk_grid_generation_dispatch_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`generation_dispatch` ADD CONSTRAINT `fk_grid_generation_dispatch_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`generation_dispatch` ADD CONSTRAINT `fk_grid_generation_dispatch_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_switching_order` ADD CONSTRAINT `fk_grid_grid_switching_order_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`frequency_event` ADD CONSTRAINT `fk_grid_frequency_event_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);

-- ========= grid --> trading (10 constraint(s)) =========
-- Requires: grid schema, trading schema
ALTER TABLE `energy_utilities_ecm`.`grid`.`control_area` ADD CONSTRAINT `fk_grid_control_area_market_participant_id` FOREIGN KEY (`market_participant_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_participant`(`market_participant_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`contingency_analysis_run` ADD CONSTRAINT `fk_grid_contingency_analysis_run_market_run_id` FOREIGN KEY (`market_run_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_run`(`market_run_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`contingency_violation` ADD CONSTRAINT `fk_grid_contingency_violation_lmp_price_id` FOREIGN KEY (`lmp_price_id`) REFERENCES `energy_utilities_ecm`.`trading`.`lmp_price`(`lmp_price_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`interchange_schedule` ADD CONSTRAINT `fk_grid_interchange_schedule_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`interchange_schedule` ADD CONSTRAINT `fk_grid_interchange_schedule_energy_schedule_id` FOREIGN KEY (`energy_schedule_id`) REFERENCES `energy_utilities_ecm`.`trading`.`energy_schedule`(`energy_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`interchange_schedule` ADD CONSTRAINT `fk_grid_interchange_schedule_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `energy_utilities_ecm`.`trading`.`trade`(`trade_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`generation_dispatch` ADD CONSTRAINT `fk_grid_generation_dispatch_market_award_id` FOREIGN KEY (`market_award_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_award`(`market_award_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`generation_dispatch` ADD CONSTRAINT `fk_grid_generation_dispatch_ppa_id` FOREIGN KEY (`ppa_id`) REFERENCES `energy_utilities_ecm`.`trading`.`ppa`(`ppa_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`generation_dispatch` ADD CONSTRAINT `fk_grid_generation_dispatch_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `energy_utilities_ecm`.`trading`.`trade`(`trade_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_switching_order` ADD CONSTRAINT `fk_grid_grid_switching_order_energy_schedule_id` FOREIGN KEY (`energy_schedule_id`) REFERENCES `energy_utilities_ecm`.`trading`.`energy_schedule`(`energy_schedule_id`);

-- ========= grid --> transmission (9 constraint(s)) =========
-- Requires: grid schema, transmission schema
ALTER TABLE `energy_utilities_ecm`.`grid`.`contingency` ADD CONSTRAINT `fk_grid_contingency_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`contingency` ADD CONSTRAINT `fk_grid_contingency_power_transformer_id` FOREIGN KEY (`power_transformer_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`power_transformer`(`power_transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`contingency_violation` ADD CONSTRAINT `fk_grid_contingency_violation_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`contingency_violation` ADD CONSTRAINT `fk_grid_contingency_violation_power_transformer_id` FOREIGN KEY (`power_transformer_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`power_transformer`(`power_transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`interchange_schedule` ADD CONSTRAINT `fk_grid_interchange_schedule_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`pmu_device` ADD CONSTRAINT `fk_grid_pmu_device_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`grid_reliability_event` ADD CONSTRAINT `fk_grid_grid_reliability_event_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_outage`(`transmission_outage_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`operating_limit` ADD CONSTRAINT `fk_grid_operating_limit_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`grid`.`operating_limit` ADD CONSTRAINT `fk_grid_operating_limit_power_transformer_id` FOREIGN KEY (`power_transformer_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`power_transformer`(`power_transformer_id`);

-- ========= interconnection --> asset (7 constraint(s)) =========
-- Requires: interconnection schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`der_system` ADD CONSTRAINT `fk_interconnection_der_system_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`poi_specification` ADD CONSTRAINT `fk_interconnection_poi_specification_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `energy_utilities_ecm`.`asset`.`capital_project`(`capital_project_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `energy_utilities_ecm`.`asset`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`inspection_milestone` ADD CONSTRAINT `fk_interconnection_inspection_milestone_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `energy_utilities_ecm`.`asset`.`inspection`(`inspection_id`);

-- ========= interconnection --> billing (4 constraint(s)) =========
-- Requires: interconnection schema, billing schema
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`nem_agreement` ADD CONSTRAINT `fk_interconnection_nem_agreement_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`cost_responsibility` ADD CONSTRAINT `fk_interconnection_cost_responsibility_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`fee` ADD CONSTRAINT `fk_interconnection_fee_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= interconnection --> compliance (5 constraint(s)) =========
-- Requires: interconnection schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`der_system` ADD CONSTRAINT `fk_interconnection_der_system_nerc_cip_asset_id` FOREIGN KEY (`nerc_cip_asset_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`nerc_cip_asset`(`nerc_cip_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`technical_review` ADD CONSTRAINT `fk_interconnection_technical_review_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`agreement` ADD CONSTRAINT `fk_interconnection_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`nem_agreement` ADD CONSTRAINT `fk_interconnection_nem_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= interconnection --> customer (16 constraint(s)) =========
-- Requires: interconnection schema, customer schema
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_customer_service_agreement_id` FOREIGN KEY (`customer_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`customer`.`customer_service_agreement`(`customer_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `energy_utilities_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_address_id` FOREIGN KEY (`address_id`) REFERENCES `energy_utilities_ecm`.`customer`.`address`(`address_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`der_system` ADD CONSTRAINT `fk_interconnection_der_system_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`der_system` ADD CONSTRAINT `fk_interconnection_der_system_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`agreement` ADD CONSTRAINT `fk_interconnection_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`agreement` ADD CONSTRAINT `fk_interconnection_agreement_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`agreement` ADD CONSTRAINT `fk_interconnection_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `energy_utilities_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`nem_agreement` ADD CONSTRAINT `fk_interconnection_nem_agreement_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`nem_agreement` ADD CONSTRAINT `fk_interconnection_nem_agreement_customer_service_agreement_id` FOREIGN KEY (`customer_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`customer`.`customer_service_agreement`(`customer_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`nem_agreement` ADD CONSTRAINT `fk_interconnection_nem_agreement_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`nem_agreement` ADD CONSTRAINT `fk_interconnection_nem_agreement_profile_id` FOREIGN KEY (`profile_id`) REFERENCES `energy_utilities_ecm`.`customer`.`profile`(`profile_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`inspection_milestone` ADD CONSTRAINT `fk_interconnection_inspection_milestone_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`inspection_milestone` ADD CONSTRAINT `fk_interconnection_inspection_milestone_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`cost_responsibility` ADD CONSTRAINT `fk_interconnection_cost_responsibility_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);

-- ========= interconnection --> distribution (13 constraint(s)) =========
-- Requires: interconnection schema, distribution schema
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`der_system` ADD CONSTRAINT `fk_interconnection_der_system_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`poi_specification` ADD CONSTRAINT `fk_interconnection_poi_specification_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`poi_specification` ADD CONSTRAINT `fk_interconnection_poi_specification_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`transformer`(`transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`technical_review` ADD CONSTRAINT `fk_interconnection_technical_review_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`impact_study` ADD CONSTRAINT `fk_interconnection_impact_study_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`network_segment`(`network_segment_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`agreement` ADD CONSTRAINT `fk_interconnection_agreement_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`nem_agreement` ADD CONSTRAINT `fk_interconnection_nem_agreement_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`hosting_capacity` ADD CONSTRAINT `fk_interconnection_hosting_capacity_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`hosting_capacity` ADD CONSTRAINT `fk_interconnection_hosting_capacity_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`network_segment`(`network_segment_id`);

-- ========= interconnection --> forecast (17 constraint(s)) =========
-- Requires: interconnection schema, forecast schema
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`der_system` ADD CONSTRAINT `fk_interconnection_der_system_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`poi_specification` ADD CONSTRAINT `fk_interconnection_poi_specification_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`technical_review` ADD CONSTRAINT `fk_interconnection_technical_review_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`technical_review` ADD CONSTRAINT `fk_interconnection_technical_review_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`impact_study` ADD CONSTRAINT `fk_interconnection_impact_study_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`impact_study` ADD CONSTRAINT `fk_interconnection_impact_study_irp_scenario_id` FOREIGN KEY (`irp_scenario_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`irp_scenario`(`irp_scenario_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`impact_study` ADD CONSTRAINT `fk_interconnection_impact_study_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`impact_study` ADD CONSTRAINT `fk_interconnection_impact_study_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_capacity_requirement_id` FOREIGN KEY (`capacity_requirement_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`capacity_requirement`(`capacity_requirement_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`queue_position` ADD CONSTRAINT `fk_interconnection_queue_position_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`hosting_capacity` ADD CONSTRAINT `fk_interconnection_hosting_capacity_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`hosting_capacity` ADD CONSTRAINT `fk_interconnection_hosting_capacity_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`hosting_capacity` ADD CONSTRAINT `fk_interconnection_hosting_capacity_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`hosting_capacity` ADD CONSTRAINT `fk_interconnection_hosting_capacity_peak_demand_id` FOREIGN KEY (`peak_demand_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`peak_demand`(`peak_demand_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`cost_responsibility` ADD CONSTRAINT `fk_interconnection_cost_responsibility_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);

-- ========= interconnection --> generation (8 constraint(s)) =========
-- Requires: interconnection schema, generation schema
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_power_plant_id` FOREIGN KEY (`power_plant_id`) REFERENCES `energy_utilities_ecm`.`generation`.`power_plant`(`power_plant_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`poi_specification` ADD CONSTRAINT `fk_interconnection_poi_specification_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`technical_review` ADD CONSTRAINT `fk_interconnection_technical_review_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`impact_study` ADD CONSTRAINT `fk_interconnection_impact_study_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`queue_position` ADD CONSTRAINT `fk_interconnection_queue_position_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`inspection_milestone` ADD CONSTRAINT `fk_interconnection_inspection_milestone_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);

-- ========= interconnection --> grid (16 constraint(s)) =========
-- Requires: interconnection schema, grid schema
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`der_system` ADD CONSTRAINT `fk_interconnection_der_system_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`poi_specification` ADD CONSTRAINT `fk_interconnection_poi_specification_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`poi_specification` ADD CONSTRAINT `fk_interconnection_poi_specification_operating_limit_id` FOREIGN KEY (`operating_limit_id`) REFERENCES `energy_utilities_ecm`.`grid`.`operating_limit`(`operating_limit_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`technical_review` ADD CONSTRAINT `fk_interconnection_technical_review_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`technical_review` ADD CONSTRAINT `fk_interconnection_technical_review_operating_limit_id` FOREIGN KEY (`operating_limit_id`) REFERENCES `energy_utilities_ecm`.`grid`.`operating_limit`(`operating_limit_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`impact_study` ADD CONSTRAINT `fk_interconnection_impact_study_contingency_analysis_run_id` FOREIGN KEY (`contingency_analysis_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency_analysis_run`(`contingency_analysis_run_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`impact_study` ADD CONSTRAINT `fk_interconnection_impact_study_contingency_id` FOREIGN KEY (`contingency_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency`(`contingency_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_contingency_id` FOREIGN KEY (`contingency_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency`(`contingency_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_operating_limit_id` FOREIGN KEY (`operating_limit_id`) REFERENCES `energy_utilities_ecm`.`grid`.`operating_limit`(`operating_limit_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`agreement` ADD CONSTRAINT `fk_interconnection_agreement_operating_limit_id` FOREIGN KEY (`operating_limit_id`) REFERENCES `energy_utilities_ecm`.`grid`.`operating_limit`(`operating_limit_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`hosting_capacity` ADD CONSTRAINT `fk_interconnection_hosting_capacity_contingency_analysis_run_id` FOREIGN KEY (`contingency_analysis_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency_analysis_run`(`contingency_analysis_run_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`hosting_capacity` ADD CONSTRAINT `fk_interconnection_hosting_capacity_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`hosting_capacity` ADD CONSTRAINT `fk_interconnection_hosting_capacity_operating_limit_id` FOREIGN KEY (`operating_limit_id`) REFERENCES `energy_utilities_ecm`.`grid`.`operating_limit`(`operating_limit_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`inspection_milestone` ADD CONSTRAINT `fk_interconnection_inspection_milestone_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);

-- ========= interconnection --> metering (4 constraint(s)) =========
-- Requires: interconnection schema, metering schema
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`der_system` ADD CONSTRAINT `fk_interconnection_der_system_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`poi_specification` ADD CONSTRAINT `fk_interconnection_poi_specification_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`nem_agreement` ADD CONSTRAINT `fk_interconnection_nem_agreement_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);

-- ========= interconnection --> renewable (6 constraint(s)) =========
-- Requires: interconnection schema, renewable schema
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`der_system` ADD CONSTRAINT `fk_interconnection_der_system_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`der_system` ADD CONSTRAINT `fk_interconnection_der_system_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`impact_study` ADD CONSTRAINT `fk_interconnection_impact_study_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`agreement` ADD CONSTRAINT `fk_interconnection_agreement_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`nem_agreement` ADD CONSTRAINT `fk_interconnection_nem_agreement_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`nem_account`(`nem_account_id`);

-- ========= interconnection --> transmission (17 constraint(s)) =========
-- Requires: interconnection schema, transmission schema
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`application` ADD CONSTRAINT `fk_interconnection_application_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`poi_specification` ADD CONSTRAINT `fk_interconnection_poi_specification_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`poi_specification` ADD CONSTRAINT `fk_interconnection_poi_specification_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`technical_review` ADD CONSTRAINT `fk_interconnection_technical_review_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`technical_review` ADD CONSTRAINT `fk_interconnection_technical_review_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`impact_study` ADD CONSTRAINT `fk_interconnection_impact_study_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`impact_study` ADD CONSTRAINT `fk_interconnection_impact_study_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_power_transformer_id` FOREIGN KEY (`power_transformer_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`power_transformer`(`power_transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`network_upgrade` ADD CONSTRAINT `fk_interconnection_network_upgrade_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`agreement` ADD CONSTRAINT `fk_interconnection_agreement_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`agreement` ADD CONSTRAINT `fk_interconnection_agreement_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`agreement` ADD CONSTRAINT `fk_interconnection_agreement_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`hosting_capacity` ADD CONSTRAINT `fk_interconnection_hosting_capacity_line_id` FOREIGN KEY (`line_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`line`(`line_id`);
ALTER TABLE `energy_utilities_ecm`.`interconnection`.`hosting_capacity` ADD CONSTRAINT `fk_interconnection_hosting_capacity_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);

-- ========= metering --> asset (15 constraint(s)) =========
-- Requires: metering schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `energy_utilities_ecm`.`asset`.`capital_project`(`capital_project_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_class_id` FOREIGN KEY (`class_id`) REFERENCES `energy_utilities_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ADD CONSTRAINT `fk_metering_vee_rule_class_id` FOREIGN KEY (`class_id`) REFERENCES `energy_utilities_ecm`.`asset`.`class`(`class_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ADD CONSTRAINT `fk_metering_ami_head_end_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `energy_utilities_ecm`.`asset`.`capital_project`(`capital_project_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ADD CONSTRAINT `fk_metering_ami_head_end_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `energy_utilities_ecm`.`asset`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ADD CONSTRAINT `fk_metering_ami_head_end_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_failure_event_id` FOREIGN KEY (`failure_event_id`) REFERENCES `energy_utilities_ecm`.`asset`.`failure_event`(`failure_event_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_capital_project_id` FOREIGN KEY (`capital_project_id`) REFERENCES `energy_utilities_ecm`.`asset`.`capital_project`(`capital_project_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `energy_utilities_ecm`.`asset`.`inspection`(`inspection_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `energy_utilities_ecm`.`asset`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `energy_utilities_ecm`.`asset`.`work_order`(`work_order_id`);

-- ========= metering --> billing (21 constraint(s)) =========
-- Requires: metering schema, billing schema
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `energy_utilities_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ADD CONSTRAINT `fk_metering_interval_reading_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `energy_utilities_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ADD CONSTRAINT `fk_metering_interval_reading_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `energy_utilities_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ADD CONSTRAINT `fk_metering_vee_rule_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ADD CONSTRAINT `fk_metering_vee_exception_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ADD CONSTRAINT `fk_metering_tou_rate_program_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_collections_id` FOREIGN KEY (`collections_id`) REFERENCES `energy_utilities_ecm`.`billing`.`collections`(`collections_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `energy_utilities_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_dunning_notice_id` FOREIGN KEY (`dunning_notice_id`) REFERENCES `energy_utilities_ecm`.`billing`.`dunning_notice`(`dunning_notice_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `energy_utilities_ecm`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_reading_route` ADD CONSTRAINT `fk_metering_meter_reading_route_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `energy_utilities_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`register` ADD CONSTRAINT `fk_metering_register_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `energy_utilities_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`register` ADD CONSTRAINT `fk_metering_register_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `energy_utilities_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ADD CONSTRAINT `fk_metering_service_point_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `energy_utilities_ecm`.`billing`.`cycle`(`cycle_id`);

-- ========= metering --> compliance (23 constraint(s)) =========
-- Requires: metering schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_nerc_cip_asset_id` FOREIGN KEY (`nerc_cip_asset_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`nerc_cip_asset`(`nerc_cip_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter` ADD CONSTRAINT `fk_metering_meter_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ADD CONSTRAINT `fk_metering_vee_rule_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_rule` ADD CONSTRAINT `fk_metering_vee_rule_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ADD CONSTRAINT `fk_metering_vee_exception_audit_finding_id` FOREIGN KEY (`audit_finding_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit_finding`(`audit_finding_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ADD CONSTRAINT `fk_metering_ami_head_end_nerc_cip_asset_id` FOREIGN KEY (`nerc_cip_asset_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`nerc_cip_asset`(`nerc_cip_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ADD CONSTRAINT `fk_metering_ami_head_end_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_nerc_cip_asset_id` FOREIGN KEY (`nerc_cip_asset_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`nerc_cip_asset`(`nerc_cip_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ADD CONSTRAINT `fk_metering_tou_rate_program_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ADD CONSTRAINT `fk_metering_tou_rate_program_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_compliance_rec_certificate_id` FOREIGN KEY (`compliance_rec_certificate_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`compliance_rec_certificate`(`compliance_rec_certificate_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);

-- ========= metering --> customer (18 constraint(s)) =========
-- Requires: metering schema, customer schema
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_customer_service_agreement_id` FOREIGN KEY (`customer_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`customer`.`customer_service_agreement`(`customer_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ADD CONSTRAINT `fk_metering_vee_exception_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_customer_service_agreement_id` FOREIGN KEY (`customer_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`customer`.`customer_service_agreement`(`customer_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_enrollment_id` FOREIGN KEY (`enrollment_id`) REFERENCES `energy_utilities_ecm`.`customer`.`enrollment`(`enrollment_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_customer_service_agreement_id` FOREIGN KEY (`customer_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`customer`.`customer_service_agreement`(`customer_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_customer_service_request_id` FOREIGN KEY (`customer_service_request_id`) REFERENCES `energy_utilities_ecm`.`customer`.`customer_service_request`(`customer_service_request_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_customer_service_agreement_id` FOREIGN KEY (`customer_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`customer`.`customer_service_agreement`(`customer_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_customer_service_request_id` FOREIGN KEY (`customer_service_request_id`) REFERENCES `energy_utilities_ecm`.`customer`.`customer_service_request`(`customer_service_request_id`);

-- ========= metering --> demand (3 constraint(s)) =========
-- Requires: metering schema, demand schema
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ADD CONSTRAINT `fk_metering_interval_reading_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ADD CONSTRAINT `fk_metering_vee_exception_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);

-- ========= metering --> distribution (10 constraint(s)) =========
-- Requires: metering schema, distribution schema
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`transformer`(`transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`network_segment`(`network_segment_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`transformer`(`transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`tou_rate_program` ADD CONSTRAINT `fk_metering_tou_rate_program_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_der_interconnection_point_id` FOREIGN KEY (`der_interconnection_point_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`der_interconnection_point`(`der_interconnection_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ADD CONSTRAINT `fk_metering_service_point_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ADD CONSTRAINT `fk_metering_service_point_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);

-- ========= metering --> grid (11 constraint(s)) =========
-- Requires: metering schema, grid schema
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ADD CONSTRAINT `fk_metering_interval_reading_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_head_end` ADD CONSTRAINT `fk_metering_ami_head_end_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ADD CONSTRAINT `fk_metering_service_point_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);

-- ========= metering --> interconnection (8 constraint(s)) =========
-- Requires: metering schema, interconnection schema
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`agreement`(`agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`agreement`(`agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_inspection_milestone_id` FOREIGN KEY (`inspection_milestone_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`inspection_milestone`(`inspection_milestone_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_nem_agreement_id` FOREIGN KEY (`nem_agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`nem_agreement`(`nem_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`agreement`(`agreement_id`);

-- ========= metering --> outage (4 constraint(s)) =========
-- Requires: metering schema, outage schema
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ADD CONSTRAINT `fk_metering_interval_reading_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ADD CONSTRAINT `fk_metering_vee_exception_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);

-- ========= metering --> renewable (16 constraint(s)) =========
-- Requires: metering schema, renewable schema
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`nem_account`(`nem_account_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ADD CONSTRAINT `fk_metering_interval_reading_curtailment_event_id` FOREIGN KEY (`curtailment_event_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`curtailment_event`(`curtailment_event_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ADD CONSTRAINT `fk_metering_interval_reading_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ADD CONSTRAINT `fk_metering_interval_reading_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`nem_account`(`nem_account_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`nem_account`(`nem_account_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ADD CONSTRAINT `fk_metering_vee_exception_curtailment_event_id` FOREIGN KEY (`curtailment_event_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`curtailment_event`(`curtailment_event_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_curtailment_event_id` FOREIGN KEY (`curtailment_event_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`curtailment_event`(`curtailment_event_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`nem_account`(`nem_account_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_curtailment_event_id` FOREIGN KEY (`curtailment_event_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`curtailment_event`(`curtailment_event_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`remote_service_order` ADD CONSTRAINT `fk_metering_remote_service_order_vpp_configuration_id` FOREIGN KEY (`vpp_configuration_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`vpp_configuration`(`vpp_configuration_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);

-- ========= metering --> trading (7 constraint(s)) =========
-- Requires: metering schema, trading schema
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_delivery_point_id` FOREIGN KEY (`delivery_point_id`) REFERENCES `energy_utilities_ecm`.`trading`.`delivery_point`(`delivery_point_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_installation` ADD CONSTRAINT `fk_metering_meter_installation_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `energy_utilities_ecm`.`trading`.`trade`(`trade_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ADD CONSTRAINT `fk_metering_interval_reading_energy_schedule_id` FOREIGN KEY (`energy_schedule_id`) REFERENCES `energy_utilities_ecm`.`trading`.`energy_schedule`(`energy_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`interval_reading` ADD CONSTRAINT `fk_metering_interval_reading_lmp_price_id` FOREIGN KEY (`lmp_price_id`) REFERENCES `energy_utilities_ecm`.`trading`.`lmp_price`(`lmp_price_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_read` ADD CONSTRAINT `fk_metering_meter_read_lmp_price_id` FOREIGN KEY (`lmp_price_id`) REFERENCES `energy_utilities_ecm`.`trading`.`lmp_price`(`lmp_price_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`vee_exception` ADD CONSTRAINT `fk_metering_vee_exception_market_settlement_id` FOREIGN KEY (`market_settlement_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_settlement`(`market_settlement_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`net_energy_metering` ADD CONSTRAINT `fk_metering_net_energy_metering_ppa_id` FOREIGN KEY (`ppa_id`) REFERENCES `energy_utilities_ecm`.`trading`.`ppa`(`ppa_id`);

-- ========= metering --> transmission (3 constraint(s)) =========
-- Requires: metering schema, transmission schema
ALTER TABLE `energy_utilities_ecm`.`metering`.`meter_point` ADD CONSTRAINT `fk_metering_meter_point_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`ami_event` ADD CONSTRAINT `fk_metering_ami_event_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_outage`(`transmission_outage_id`);
ALTER TABLE `energy_utilities_ecm`.`metering`.`service_point` ADD CONSTRAINT `fk_metering_service_point_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);

-- ========= outage --> asset (4 constraint(s)) =========
-- Requires: outage schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`outage`.`outage_switching_order` ADD CONSTRAINT `fk_outage_outage_switching_order_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`crew_dispatch` ADD CONSTRAINT `fk_outage_crew_dispatch_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`restoration_action` ADD CONSTRAINT `fk_outage_restoration_action_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`planned_outage_window` ADD CONSTRAINT `fk_outage_planned_outage_window_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= outage --> billing (2 constraint(s)) =========
-- Requires: outage schema, billing schema
ALTER TABLE `energy_utilities_ecm`.`outage`.`interruption` ADD CONSTRAINT `fk_outage_interruption_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`affected_customer` ADD CONSTRAINT `fk_outage_affected_customer_billing_service_agreement_id` FOREIGN KEY (`billing_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`billing`.`billing_service_agreement`(`billing_service_agreement_id`);

-- ========= outage --> compliance (5 constraint(s)) =========
-- Requires: outage schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`outage`.`event` ADD CONSTRAINT `fk_outage_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`outage_switching_order` ADD CONSTRAINT `fk_outage_outage_switching_order_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`storm_event` ADD CONSTRAINT `fk_outage_storm_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`storm_event` ADD CONSTRAINT `fk_outage_storm_event_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`reliability_index_period` ADD CONSTRAINT `fk_outage_reliability_index_period_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= outage --> customer (7 constraint(s)) =========
-- Requires: outage schema, customer schema
ALTER TABLE `energy_utilities_ecm`.`outage`.`interruption` ADD CONSTRAINT `fk_outage_interruption_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`affected_customer` ADD CONSTRAINT `fk_outage_affected_customer_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`affected_customer` ADD CONSTRAINT `fk_outage_affected_customer_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`customer_notification` ADD CONSTRAINT `fk_outage_customer_notification_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`customer_notification` ADD CONSTRAINT `fk_outage_customer_notification_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`call` ADD CONSTRAINT `fk_outage_call_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`call` ADD CONSTRAINT `fk_outage_call_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);

-- ========= outage --> distribution (21 constraint(s)) =========
-- Requires: outage schema, distribution schema
ALTER TABLE `energy_utilities_ecm`.`outage`.`event` ADD CONSTRAINT `fk_outage_event_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`interruption` ADD CONSTRAINT `fk_outage_interruption_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`interruption` ADD CONSTRAINT `fk_outage_interruption_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`interruption` ADD CONSTRAINT `fk_outage_interruption_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`outage_switching_order` ADD CONSTRAINT `fk_outage_outage_switching_order_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`outage_switching_order` ADD CONSTRAINT `fk_outage_outage_switching_order_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`restoration_action` ADD CONSTRAINT `fk_outage_restoration_action_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`restoration_action` ADD CONSTRAINT `fk_outage_restoration_action_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`restoration_action` ADD CONSTRAINT `fk_outage_restoration_action_network_segment_id` FOREIGN KEY (`network_segment_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`network_segment`(`network_segment_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`restoration_action` ADD CONSTRAINT `fk_outage_restoration_action_sectionalizing_device_id` FOREIGN KEY (`sectionalizing_device_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`sectionalizing_device`(`sectionalizing_device_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`planned_outage_window` ADD CONSTRAINT `fk_outage_planned_outage_window_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`planned_outage_window` ADD CONSTRAINT `fk_outage_planned_outage_window_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`affected_customer` ADD CONSTRAINT `fk_outage_affected_customer_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`affected_customer` ADD CONSTRAINT `fk_outage_affected_customer_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`storm_event` ADD CONSTRAINT `fk_outage_storm_event_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`prediction` ADD CONSTRAINT `fk_outage_prediction_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`prediction` ADD CONSTRAINT `fk_outage_prediction_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`prediction` ADD CONSTRAINT `fk_outage_prediction_prediction_feeder_id` FOREIGN KEY (`prediction_feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`prediction` ADD CONSTRAINT `fk_outage_prediction_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`call` ADD CONSTRAINT `fk_outage_call_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`call` ADD CONSTRAINT `fk_outage_call_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);

-- ========= outage --> forecast (13 constraint(s)) =========
-- Requires: outage schema, forecast schema
ALTER TABLE `energy_utilities_ecm`.`outage`.`event` ADD CONSTRAINT `fk_outage_event_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`outage_switching_order` ADD CONSTRAINT `fk_outage_outage_switching_order_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`crew_dispatch` ADD CONSTRAINT `fk_outage_crew_dispatch_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`restoration_action` ADD CONSTRAINT `fk_outage_restoration_action_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`planned_outage_window` ADD CONSTRAINT `fk_outage_planned_outage_window_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`planned_outage_window` ADD CONSTRAINT `fk_outage_planned_outage_window_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`storm_event` ADD CONSTRAINT `fk_outage_storm_event_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`storm_event` ADD CONSTRAINT `fk_outage_storm_event_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`mutual_aid_request` ADD CONSTRAINT `fk_outage_mutual_aid_request_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`reliability_index_period` ADD CONSTRAINT `fk_outage_reliability_index_period_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`prediction` ADD CONSTRAINT `fk_outage_prediction_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`prediction` ADD CONSTRAINT `fk_outage_prediction_model_id` FOREIGN KEY (`model_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`model`(`model_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`prediction` ADD CONSTRAINT `fk_outage_prediction_weather_input_id` FOREIGN KEY (`weather_input_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`weather_input`(`weather_input_id`);

-- ========= outage --> grid (18 constraint(s)) =========
-- Requires: outage schema, grid schema
ALTER TABLE `energy_utilities_ecm`.`outage`.`event` ADD CONSTRAINT `fk_outage_event_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`event` ADD CONSTRAINT `fk_outage_event_control_center_id` FOREIGN KEY (`control_center_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_center`(`control_center_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`outage_switching_order` ADD CONSTRAINT `fk_outage_outage_switching_order_contingency_analysis_run_id` FOREIGN KEY (`contingency_analysis_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency_analysis_run`(`contingency_analysis_run_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`outage_switching_order` ADD CONSTRAINT `fk_outage_outage_switching_order_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`outage_switching_order` ADD CONSTRAINT `fk_outage_outage_switching_order_grid_switching_order_id` FOREIGN KEY (`grid_switching_order_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_switching_order`(`grid_switching_order_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`outage_switching_order` ADD CONSTRAINT `fk_outage_outage_switching_order_operating_limit_id` FOREIGN KEY (`operating_limit_id`) REFERENCES `energy_utilities_ecm`.`grid`.`operating_limit`(`operating_limit_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`outage_switching_order` ADD CONSTRAINT `fk_outage_outage_switching_order_state_estimation_run_id` FOREIGN KEY (`state_estimation_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`state_estimation_run`(`state_estimation_run_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`crew_dispatch` ADD CONSTRAINT `fk_outage_crew_dispatch_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`crew_dispatch` ADD CONSTRAINT `fk_outage_crew_dispatch_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`crew_dispatch` ADD CONSTRAINT `fk_outage_crew_dispatch_grid_switching_order_id` FOREIGN KEY (`grid_switching_order_id`) REFERENCES `energy_utilities_ecm`.`grid`.`grid_switching_order`(`grid_switching_order_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`restoration_action` ADD CONSTRAINT `fk_outage_restoration_action_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`restoration_action` ADD CONSTRAINT `fk_outage_restoration_action_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`restoration_action` ADD CONSTRAINT `fk_outage_restoration_action_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`planned_outage_window` ADD CONSTRAINT `fk_outage_planned_outage_window_contingency_analysis_run_id` FOREIGN KEY (`contingency_analysis_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency_analysis_run`(`contingency_analysis_run_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`storm_event` ADD CONSTRAINT `fk_outage_storm_event_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`mutual_aid_request` ADD CONSTRAINT `fk_outage_mutual_aid_request_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`reliability_index_period` ADD CONSTRAINT `fk_outage_reliability_index_period_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`prediction` ADD CONSTRAINT `fk_outage_prediction_state_estimation_run_id` FOREIGN KEY (`state_estimation_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`state_estimation_run`(`state_estimation_run_id`);

-- ========= outage --> interconnection (13 constraint(s)) =========
-- Requires: outage schema, interconnection schema
ALTER TABLE `energy_utilities_ecm`.`outage`.`event` ADD CONSTRAINT `fk_outage_event_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`interruption` ADD CONSTRAINT `fk_outage_interruption_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`outage_switching_order` ADD CONSTRAINT `fk_outage_outage_switching_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`agreement`(`agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`outage_switching_order` ADD CONSTRAINT `fk_outage_outage_switching_order_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`outage_switching_order` ADD CONSTRAINT `fk_outage_outage_switching_order_poi_specification_id` FOREIGN KEY (`poi_specification_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`poi_specification`(`poi_specification_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`crew_dispatch` ADD CONSTRAINT `fk_outage_crew_dispatch_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`restoration_action` ADD CONSTRAINT `fk_outage_restoration_action_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`restoration_action` ADD CONSTRAINT `fk_outage_restoration_action_poi_specification_id` FOREIGN KEY (`poi_specification_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`poi_specification`(`poi_specification_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`planned_outage_window` ADD CONSTRAINT `fk_outage_planned_outage_window_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`agreement`(`agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`affected_customer` ADD CONSTRAINT `fk_outage_affected_customer_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`agreement`(`agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`affected_customer` ADD CONSTRAINT `fk_outage_affected_customer_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`customer_notification` ADD CONSTRAINT `fk_outage_customer_notification_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`agreement`(`agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`call` ADD CONSTRAINT `fk_outage_call_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);

-- ========= outage --> metering (9 constraint(s)) =========
-- Requires: outage schema, metering schema
ALTER TABLE `energy_utilities_ecm`.`outage`.`event` ADD CONSTRAINT `fk_outage_event_ami_head_end_id` FOREIGN KEY (`ami_head_end_id`) REFERENCES `energy_utilities_ecm`.`metering`.`ami_head_end`(`ami_head_end_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`interruption` ADD CONSTRAINT `fk_outage_interruption_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`interruption` ADD CONSTRAINT `fk_outage_interruption_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`interruption` ADD CONSTRAINT `fk_outage_interruption_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`service_point`(`service_point_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`affected_customer` ADD CONSTRAINT `fk_outage_affected_customer_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`affected_customer` ADD CONSTRAINT `fk_outage_affected_customer_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`service_point`(`service_point_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`customer_notification` ADD CONSTRAINT `fk_outage_customer_notification_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`service_point`(`service_point_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`prediction` ADD CONSTRAINT `fk_outage_prediction_ami_head_end_id` FOREIGN KEY (`ami_head_end_id`) REFERENCES `energy_utilities_ecm`.`metering`.`ami_head_end`(`ami_head_end_id`);
ALTER TABLE `energy_utilities_ecm`.`outage`.`call` ADD CONSTRAINT `fk_outage_call_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);

-- ========= renewable --> asset (8 constraint(s)) =========
-- Requires: renewable schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ADD CONSTRAINT `fk_renewable_ppa_settlement_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ADD CONSTRAINT `fk_renewable_nem_account_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_depreciation_schedule_id` FOREIGN KEY (`depreciation_schedule_id`) REFERENCES `energy_utilities_ecm`.`asset`.`depreciation_schedule`(`depreciation_schedule_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `energy_utilities_ecm`.`asset`.`inspection`(`inspection_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `energy_utilities_ecm`.`asset`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_warranty_id` FOREIGN KEY (`warranty_id`) REFERENCES `energy_utilities_ecm`.`asset`.`warranty`(`warranty_id`);

-- ========= renewable --> compliance (10 constraint(s)) =========
-- Requires: renewable schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ADD CONSTRAINT `fk_renewable_renewable_rec_certificate_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ADD CONSTRAINT `fk_renewable_rps_obligation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ADD CONSTRAINT `fk_renewable_ppa_contract_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ADD CONSTRAINT `fk_renewable_ppa_settlement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_bes_facility_id` FOREIGN KEY (`bes_facility_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`bes_facility`(`bes_facility_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ADD CONSTRAINT `fk_renewable_der_enrollment_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ADD CONSTRAINT `fk_renewable_incentive_program_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= renewable --> customer (7 constraint(s)) =========
-- Requires: renewable schema, customer schema
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ADD CONSTRAINT `fk_renewable_nem_account_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ADD CONSTRAINT `fk_renewable_nem_account_customer_service_agreement_id` FOREIGN KEY (`customer_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`customer`.`customer_service_agreement`(`customer_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ADD CONSTRAINT `fk_renewable_der_enrollment_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ADD CONSTRAINT `fk_renewable_der_enrollment_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ADD CONSTRAINT `fk_renewable_incentive_application_account_id` FOREIGN KEY (`account_id`) REFERENCES `energy_utilities_ecm`.`customer`.`account`(`account_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ADD CONSTRAINT `fk_renewable_incentive_application_customer_service_agreement_id` FOREIGN KEY (`customer_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`customer`.`customer_service_agreement`(`customer_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ADD CONSTRAINT `fk_renewable_incentive_application_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `energy_utilities_ecm`.`customer`.`premise`(`premise_id`);

-- ========= renewable --> demand (3 constraint(s)) =========
-- Requires: renewable schema, demand schema
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_aggregator_id` FOREIGN KEY (`aggregator_id`) REFERENCES `energy_utilities_ecm`.`demand`.`aggregator`(`aggregator_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_dr_program_id` FOREIGN KEY (`dr_program_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_program`(`dr_program_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ADD CONSTRAINT `fk_renewable_der_enrollment_dr_program_id` FOREIGN KEY (`dr_program_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_program`(`dr_program_id`);

-- ========= renewable --> distribution (13 constraint(s)) =========
-- Requires: renewable schema, distribution schema
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ADD CONSTRAINT `fk_renewable_der_registry_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ADD CONSTRAINT `fk_renewable_der_registry_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`transformer`(`transformer_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ADD CONSTRAINT `fk_renewable_rps_obligation_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ADD CONSTRAINT `fk_renewable_ppa_contract_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ADD CONSTRAINT `fk_renewable_interconnection_queue_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_program` ADD CONSTRAINT `fk_renewable_incentive_program_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ADD CONSTRAINT `fk_renewable_incentive_application_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);

-- ========= renewable --> forecast (20 constraint(s)) =========
-- Requires: renewable schema, forecast schema
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ADD CONSTRAINT `fk_renewable_der_registry_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ADD CONSTRAINT `fk_renewable_renewable_rec_certificate_irp_scenario_id` FOREIGN KEY (`irp_scenario_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`irp_scenario`(`irp_scenario_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ADD CONSTRAINT `fk_renewable_renewable_rec_certificate_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`rps_obligation` ADD CONSTRAINT `fk_renewable_rps_obligation_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ADD CONSTRAINT `fk_renewable_ppa_contract_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ADD CONSTRAINT `fk_renewable_ppa_settlement_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ADD CONSTRAINT `fk_renewable_ppa_settlement_forecast_renewable_id` FOREIGN KEY (`forecast_renewable_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_renewable`(`forecast_renewable_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_forecast_renewable_id` FOREIGN KEY (`forecast_renewable_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_renewable`(`forecast_renewable_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ADD CONSTRAINT `fk_renewable_interconnection_queue_capacity_requirement_id` FOREIGN KEY (`capacity_requirement_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`capacity_requirement`(`capacity_requirement_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ADD CONSTRAINT `fk_renewable_interconnection_queue_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_capacity_requirement_id` FOREIGN KEY (`capacity_requirement_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`capacity_requirement`(`capacity_requirement_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_forecast_renewable_id` FOREIGN KEY (`forecast_renewable_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_renewable`(`forecast_renewable_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_capacity_requirement_id` FOREIGN KEY (`capacity_requirement_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`capacity_requirement`(`capacity_requirement_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ADD CONSTRAINT `fk_renewable_generation_meter_read_forecast_renewable_id` FOREIGN KEY (`forecast_renewable_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_renewable`(`forecast_renewable_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ADD CONSTRAINT `fk_renewable_generation_meter_read_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ADD CONSTRAINT `fk_renewable_der_enrollment_forecast_renewable_id` FOREIGN KEY (`forecast_renewable_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_renewable`(`forecast_renewable_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ADD CONSTRAINT `fk_renewable_incentive_application_irp_scenario_id` FOREIGN KEY (`irp_scenario_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`irp_scenario`(`irp_scenario_id`);

-- ========= renewable --> generation (5 constraint(s)) =========
-- Requires: renewable schema, generation schema
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ADD CONSTRAINT `fk_renewable_renewable_rec_certificate_power_plant_id` FOREIGN KEY (`power_plant_id`) REFERENCES `energy_utilities_ecm`.`generation`.`power_plant`(`power_plant_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ADD CONSTRAINT `fk_renewable_ppa_settlement_power_plant_id` FOREIGN KEY (`power_plant_id`) REFERENCES `energy_utilities_ecm`.`generation`.`power_plant`(`power_plant_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_power_plant_id` FOREIGN KEY (`power_plant_id`) REFERENCES `energy_utilities_ecm`.`generation`.`power_plant`(`power_plant_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ADD CONSTRAINT `fk_renewable_generation_meter_read_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ADD CONSTRAINT `fk_renewable_generation_meter_read_power_plant_id` FOREIGN KEY (`power_plant_id`) REFERENCES `energy_utilities_ecm`.`generation`.`power_plant`(`power_plant_id`);

-- ========= renewable --> grid (7 constraint(s)) =========
-- Requires: renewable schema, grid schema
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ADD CONSTRAINT `fk_renewable_der_registry_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_contingency_id` FOREIGN KEY (`contingency_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency`(`contingency_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);

-- ========= renewable --> interconnection (6 constraint(s)) =========
-- Requires: renewable schema, interconnection schema
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ADD CONSTRAINT `fk_renewable_nem_account_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ADD CONSTRAINT `fk_renewable_generation_meter_read_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ADD CONSTRAINT `fk_renewable_der_enrollment_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ADD CONSTRAINT `fk_renewable_incentive_application_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ADD CONSTRAINT `fk_renewable_incentive_application_application_id` FOREIGN KEY (`application_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`application`(`application_id`);

-- ========= renewable --> metering (16 constraint(s)) =========
-- Requires: renewable schema, metering schema
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ADD CONSTRAINT `fk_renewable_renewable_rec_certificate_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ADD CONSTRAINT `fk_renewable_ppa_settlement_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ADD CONSTRAINT `fk_renewable_ppa_settlement_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ADD CONSTRAINT `fk_renewable_nem_account_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ADD CONSTRAINT `fk_renewable_generation_meter_read_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ADD CONSTRAINT `fk_renewable_generation_meter_read_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ADD CONSTRAINT `fk_renewable_der_enrollment_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ADD CONSTRAINT `fk_renewable_der_enrollment_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ADD CONSTRAINT `fk_renewable_der_enrollment_tou_rate_program_id` FOREIGN KEY (`tou_rate_program_id`) REFERENCES `energy_utilities_ecm`.`metering`.`tou_rate_program`(`tou_rate_program_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`incentive_application` ADD CONSTRAINT `fk_renewable_incentive_application_meter_point_id` FOREIGN KEY (`meter_point_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter_point`(`meter_point_id`);

-- ========= renewable --> outage (9 constraint(s)) =========
-- Requires: renewable schema, outage schema
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ADD CONSTRAINT `fk_renewable_renewable_rec_certificate_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ADD CONSTRAINT `fk_renewable_ppa_settlement_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`nem_account` ADD CONSTRAINT `fk_renewable_nem_account_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ADD CONSTRAINT `fk_renewable_generation_meter_read_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_enrollment` ADD CONSTRAINT `fk_renewable_der_enrollment_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);

-- ========= renewable --> trading (3 constraint(s)) =========
-- Requires: renewable schema, trading schema
ALTER TABLE `energy_utilities_ecm`.`renewable`.`der_registry` ADD CONSTRAINT `fk_renewable_der_registry_scheduling_coordinator_id` FOREIGN KEY (`scheduling_coordinator_id`) REFERENCES `energy_utilities_ecm`.`trading`.`scheduling_coordinator`(`scheduling_coordinator_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ADD CONSTRAINT `fk_renewable_ppa_contract_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_settlement` ADD CONSTRAINT `fk_renewable_ppa_settlement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);

-- ========= renewable --> transmission (11 constraint(s)) =========
-- Requires: renewable schema, transmission schema
ALTER TABLE `energy_utilities_ecm`.`renewable`.`renewable_rec_certificate` ADD CONSTRAINT `fk_renewable_renewable_rec_certificate_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ADD CONSTRAINT `fk_renewable_ppa_contract_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`ppa_contract` ADD CONSTRAINT `fk_renewable_ppa_contract_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_outage`(`transmission_outage_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`curtailment_event` ADD CONSTRAINT `fk_renewable_curtailment_event_constraint_id` FOREIGN KEY (`constraint_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`constraint`(`constraint_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ADD CONSTRAINT `fk_renewable_interconnection_queue_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`interconnection_queue` ADD CONSTRAINT `fk_renewable_interconnection_queue_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`vpp_configuration` ADD CONSTRAINT `fk_renewable_vpp_configuration_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`battery_storage_asset` ADD CONSTRAINT `fk_renewable_battery_storage_asset_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`renewable`.`generation_meter_read` ADD CONSTRAINT `fk_renewable_generation_meter_read_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);

-- ========= trading --> asset (7 constraint(s)) =========
-- Requires: trading schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ADD CONSTRAINT `fk_trading_ppa_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ADD CONSTRAINT `fk_trading_scheduling_coordinator_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ADD CONSTRAINT `fk_trading_delivery_point_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= trading --> compliance (10 constraint(s)) =========
-- Requires: trading schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ADD CONSTRAINT `fk_trading_ppa_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ADD CONSTRAINT `fk_trading_scheduling_coordinator_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ADD CONSTRAINT `fk_trading_scheduling_coordinator_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ADD CONSTRAINT `fk_trading_credit_exposure_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ADD CONSTRAINT `fk_trading_book_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`contract` ADD CONSTRAINT `fk_trading_contract_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= trading --> demand (8 constraint(s)) =========
-- Requires: trading schema, demand schema
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_dr_program_id` FOREIGN KEY (`dr_program_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_program`(`dr_program_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_aggregator_id` FOREIGN KEY (`aggregator_id`) REFERENCES `energy_utilities_ecm`.`demand`.`aggregator`(`aggregator_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_aggregator_id` FOREIGN KEY (`aggregator_id`) REFERENCES `energy_utilities_ecm`.`demand`.`aggregator`(`aggregator_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_dr_event_id` FOREIGN KEY (`dr_event_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_event`(`dr_event_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`settlement_statement` ADD CONSTRAINT `fk_trading_settlement_statement_aggregator_id` FOREIGN KEY (`aggregator_id`) REFERENCES `energy_utilities_ecm`.`demand`.`aggregator`(`aggregator_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`settlement_statement` ADD CONSTRAINT `fk_trading_settlement_statement_dr_program_id` FOREIGN KEY (`dr_program_id`) REFERENCES `energy_utilities_ecm`.`demand`.`dr_program`(`dr_program_id`);

-- ========= trading --> distribution (12 constraint(s)) =========
-- Requires: trading schema, distribution schema
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ADD CONSTRAINT `fk_trading_ppa_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`contract` ADD CONSTRAINT `fk_trading_contract_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ADD CONSTRAINT `fk_trading_delivery_point_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ADD CONSTRAINT `fk_trading_delivery_point_load_zone_id` FOREIGN KEY (`load_zone_id`) REFERENCES `energy_utilities_ecm`.`distribution`.`load_zone`(`load_zone_id`);

-- ========= trading --> forecast (19 constraint(s)) =========
-- Requires: trading schema, forecast schema
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_forecast_generation_id` FOREIGN KEY (`forecast_generation_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_generation`(`forecast_generation_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_forecast_renewable_id` FOREIGN KEY (`forecast_renewable_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_renewable`(`forecast_renewable_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_forecast_renewable_id` FOREIGN KEY (`forecast_renewable_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_renewable`(`forecast_renewable_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ADD CONSTRAINT `fk_trading_lmp_price_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`scheduling_coordinator` ADD CONSTRAINT `fk_trading_scheduling_coordinator_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_forecast_generation_id` FOREIGN KEY (`forecast_generation_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_generation`(`forecast_generation_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ADD CONSTRAINT `fk_trading_credit_exposure_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`book` ADD CONSTRAINT `fk_trading_book_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`portfolio` ADD CONSTRAINT `fk_trading_portfolio_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_run` ADD CONSTRAINT `fk_trading_market_run_forecast_run_id` FOREIGN KEY (`forecast_run_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`forecast_run`(`forecast_run_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ADD CONSTRAINT `fk_trading_delivery_point_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);

-- ========= trading --> generation (2 constraint(s)) =========
-- Requires: trading schema, generation schema
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa` ADD CONSTRAINT `fk_trading_ppa_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `energy_utilities_ecm`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_output_telemetry_id` FOREIGN KEY (`output_telemetry_id`) REFERENCES `energy_utilities_ecm`.`generation`.`output_telemetry`(`output_telemetry_id`);

-- ========= trading --> interconnection (4 constraint(s)) =========
-- Requires: trading schema, interconnection schema
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_der_system_id` FOREIGN KEY (`der_system_id`) REFERENCES `energy_utilities_ecm`.`interconnection`.`der_system`(`der_system_id`);

-- ========= trading --> metering (1 constraint(s)) =========
-- Requires: trading schema, metering schema
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ADD CONSTRAINT `fk_trading_delivery_point_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `energy_utilities_ecm`.`metering`.`meter`(`meter_id`);

-- ========= trading --> outage (9 constraint(s)) =========
-- Requires: trading schema, outage schema
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);

-- ========= trading --> renewable (11 constraint(s)) =========
-- Requires: trading schema, renewable schema
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`ppa_delivery` ADD CONSTRAINT `fk_trading_ppa_delivery_ppa_settlement_id` FOREIGN KEY (`ppa_settlement_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_settlement`(`ppa_settlement_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_battery_storage_asset_id` FOREIGN KEY (`battery_storage_asset_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`battery_storage_asset`(`battery_storage_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_battery_storage_asset_id` FOREIGN KEY (`battery_storage_asset_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`battery_storage_asset`(`battery_storage_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_interconnection_queue_id` FOREIGN KEY (`interconnection_queue_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`interconnection_queue`(`interconnection_queue_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_der_registry_id` FOREIGN KEY (`der_registry_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`der_registry`(`der_registry_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`credit_exposure` ADD CONSTRAINT `fk_trading_credit_exposure_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);

-- ========= trading --> transmission (10 constraint(s)) =========
-- Requires: trading schema, transmission schema
ALTER TABLE `energy_utilities_ecm`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_award` ADD CONSTRAINT `fk_trading_market_award_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`lmp_price` ADD CONSTRAINT `fk_trading_lmp_price_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_path_id` FOREIGN KEY (`path_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`path`(`path_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`energy_schedule` ADD CONSTRAINT `fk_trading_energy_schedule_transmission_service_agreement_id` FOREIGN KEY (`transmission_service_agreement_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`transmission_service_agreement`(`transmission_service_agreement_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`market_settlement` ADD CONSTRAINT `fk_trading_market_settlement_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);
ALTER TABLE `energy_utilities_ecm`.`trading`.`delivery_point` ADD CONSTRAINT `fk_trading_delivery_point_pnode_id` FOREIGN KEY (`pnode_id`) REFERENCES `energy_utilities_ecm`.`transmission`.`pnode`(`pnode_id`);

-- ========= transmission --> asset (5 constraint(s)) =========
-- Requires: transmission schema, asset schema
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ADD CONSTRAINT `fk_transmission_power_transformer_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ADD CONSTRAINT `fk_transmission_protection_device_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `energy_utilities_ecm`.`asset`.`registry`(`registry_id`);

-- ========= transmission --> compliance (19 constraint(s)) =========
-- Requires: transmission schema, compliance schema
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_bes_facility_id` FOREIGN KEY (`bes_facility_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`bes_facility`(`bes_facility_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_bes_facility_id` FOREIGN KEY (`bes_facility_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`bes_facility`(`bes_facility_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ADD CONSTRAINT `fk_transmission_power_transformer_bes_facility_id` FOREIGN KEY (`bes_facility_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`bes_facility`(`bes_facility_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ADD CONSTRAINT `fk_transmission_power_transformer_nerc_cip_asset_id` FOREIGN KEY (`nerc_cip_asset_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`nerc_cip_asset`(`nerc_cip_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ADD CONSTRAINT `fk_transmission_power_transformer_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ADD CONSTRAINT `fk_transmission_path_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ADD CONSTRAINT `fk_transmission_atc_calculation_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ADD CONSTRAINT `fk_transmission_transmission_service_request_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ADD CONSTRAINT `fk_transmission_transmission_service_agreement_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ADD CONSTRAINT `fk_transmission_transmission_service_agreement_regulatory_filing_id` FOREIGN KEY (`regulatory_filing_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_regulatory_correspondence_id` FOREIGN KEY (`regulatory_correspondence_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`regulatory_correspondence`(`regulatory_correspondence_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_violation_id` FOREIGN KEY (`violation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`violation`(`violation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ADD CONSTRAINT `fk_transmission_protection_device_nerc_cip_asset_id` FOREIGN KEY (`nerc_cip_asset_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`nerc_cip_asset`(`nerc_cip_asset_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ADD CONSTRAINT `fk_transmission_protection_device_obligation_id` FOREIGN KEY (`obligation_id`) REFERENCES `energy_utilities_ecm`.`compliance`.`obligation`(`obligation_id`);

-- ========= transmission --> forecast (11 constraint(s)) =========
-- Requires: transmission schema, forecast schema
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ADD CONSTRAINT `fk_transmission_path_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ADD CONSTRAINT `fk_transmission_atc_calculation_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ADD CONSTRAINT `fk_transmission_atc_calculation_peak_demand_id` FOREIGN KEY (`peak_demand_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`peak_demand`(`peak_demand_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ADD CONSTRAINT `fk_transmission_transmission_service_request_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ADD CONSTRAINT `fk_transmission_transmission_service_agreement_planning_period_id` FOREIGN KEY (`planning_period_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`planning_period`(`planning_period_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ADD CONSTRAINT `fk_transmission_ftr_position_energy_price_id` FOREIGN KEY (`energy_price_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`energy_price`(`energy_price_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ADD CONSTRAINT `fk_transmission_ftr_position_load_id` FOREIGN KEY (`load_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`load`(`load_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`flowgate` ADD CONSTRAINT `fk_transmission_flowgate_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`pnode` ADD CONSTRAINT `fk_transmission_pnode_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `energy_utilities_ecm`.`forecast`.`zone`(`zone_id`);

-- ========= transmission --> grid (28 constraint(s)) =========
-- Requires: transmission schema, grid schema
ALTER TABLE `energy_utilities_ecm`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_control_center_id` FOREIGN KEY (`control_center_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_center`(`control_center_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`power_transformer` ADD CONSTRAINT `fk_transmission_power_transformer_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`path` ADD CONSTRAINT `fk_transmission_path_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ADD CONSTRAINT `fk_transmission_atc_calculation_contingency_analysis_run_id` FOREIGN KEY (`contingency_analysis_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency_analysis_run`(`contingency_analysis_run_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ADD CONSTRAINT `fk_transmission_atc_calculation_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ADD CONSTRAINT `fk_transmission_atc_calculation_state_estimation_run_id` FOREIGN KEY (`state_estimation_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`state_estimation_run`(`state_estimation_run_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ADD CONSTRAINT `fk_transmission_transmission_service_request_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ADD CONSTRAINT `fk_transmission_transmission_service_request_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ADD CONSTRAINT `fk_transmission_transmission_service_agreement_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ADD CONSTRAINT `fk_transmission_ftr_position_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_contingency_id` FOREIGN KEY (`contingency_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency`(`contingency_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_operating_limit_id` FOREIGN KEY (`operating_limit_id`) REFERENCES `energy_utilities_ecm`.`grid`.`operating_limit`(`operating_limit_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_contingency_id` FOREIGN KEY (`contingency_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency`(`contingency_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_contingency_analysis_run_id` FOREIGN KEY (`contingency_analysis_run_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency_analysis_run`(`contingency_analysis_run_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`protection_device` ADD CONSTRAINT `fk_transmission_protection_device_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_scada_measurement` ADD CONSTRAINT `fk_transmission_transmission_scada_measurement_scada_point_id` FOREIGN KEY (`scada_point_id`) REFERENCES `energy_utilities_ecm`.`grid`.`scada_point`(`scada_point_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`constraint` ADD CONSTRAINT `fk_transmission_constraint_contingency_id` FOREIGN KEY (`contingency_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency`(`contingency_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`constraint` ADD CONSTRAINT `fk_transmission_constraint_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`constraint` ADD CONSTRAINT `fk_transmission_constraint_operating_limit_id` FOREIGN KEY (`operating_limit_id`) REFERENCES `energy_utilities_ecm`.`grid`.`operating_limit`(`operating_limit_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`flowgate` ADD CONSTRAINT `fk_transmission_flowgate_contingency_id` FOREIGN KEY (`contingency_id`) REFERENCES `energy_utilities_ecm`.`grid`.`contingency`(`contingency_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`flowgate` ADD CONSTRAINT `fk_transmission_flowgate_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`pnode` ADD CONSTRAINT `fk_transmission_pnode_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `energy_utilities_ecm`.`grid`.`control_area`(`control_area_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`pnode` ADD CONSTRAINT `fk_transmission_pnode_ems_node_id` FOREIGN KEY (`ems_node_id`) REFERENCES `energy_utilities_ecm`.`grid`.`ems_node`(`ems_node_id`);

-- ========= transmission --> outage (8 constraint(s)) =========
-- Requires: transmission schema, outage schema
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ADD CONSTRAINT `fk_transmission_atc_calculation_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ADD CONSTRAINT `fk_transmission_atc_calculation_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_event_id` FOREIGN KEY (`event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`event`(`event_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_cause_id` FOREIGN KEY (`cause_id`) REFERENCES `energy_utilities_ecm`.`outage`.`cause`(`cause_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_outage_switching_order_id` FOREIGN KEY (`outage_switching_order_id`) REFERENCES `energy_utilities_ecm`.`outage`.`outage_switching_order`(`outage_switching_order_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_planned_outage_window_id` FOREIGN KEY (`planned_outage_window_id`) REFERENCES `energy_utilities_ecm`.`outage`.`planned_outage_window`(`planned_outage_window_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `energy_utilities_ecm`.`outage`.`storm_event`(`storm_event_id`);

-- ========= transmission --> renewable (2 constraint(s)) =========
-- Requires: transmission schema, renewable schema
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ADD CONSTRAINT `fk_transmission_transmission_service_agreement_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ADD CONSTRAINT `fk_transmission_ftr_position_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `energy_utilities_ecm`.`renewable`.`ppa_contract`(`ppa_contract_id`);

-- ========= transmission --> trading (7 constraint(s)) =========
-- Requires: transmission schema, trading schema
ALTER TABLE `energy_utilities_ecm`.`transmission`.`atc_calculation` ADD CONSTRAINT `fk_transmission_atc_calculation_position_id` FOREIGN KEY (`position_id`) REFERENCES `energy_utilities_ecm`.`trading`.`position`(`position_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ADD CONSTRAINT `fk_transmission_transmission_service_request_market_participant_id` FOREIGN KEY (`market_participant_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_participant`(`market_participant_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_request` ADD CONSTRAINT `fk_transmission_transmission_service_request_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`transmission_service_agreement` ADD CONSTRAINT `fk_transmission_transmission_service_agreement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ADD CONSTRAINT `fk_transmission_ftr_position_book_id` FOREIGN KEY (`book_id`) REFERENCES `energy_utilities_ecm`.`trading`.`book`(`book_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`ftr_position` ADD CONSTRAINT `fk_transmission_ftr_position_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `energy_utilities_ecm`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `energy_utilities_ecm`.`transmission`.`constraint` ADD CONSTRAINT `fk_transmission_constraint_market_participant_id` FOREIGN KEY (`market_participant_id`) REFERENCES `energy_utilities_ecm`.`trading`.`market_participant`(`market_participant_id`);

