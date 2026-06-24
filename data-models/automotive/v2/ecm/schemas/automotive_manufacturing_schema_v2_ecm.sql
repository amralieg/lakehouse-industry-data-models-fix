-- Schema for Domain: manufacturing | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 03:51:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`manufacturing` COMMENT 'Core production and assembly operations across all manufacturing plants. Manages shop floor execution via MES (Manufacturing Execution System), work order scheduling, production line sequencing (JIS - Just-in-Sequence), WIP (Work in Progress) tracking, and build traceability. Includes stamping, body shop, paint, and final assembly processes. Integrates with AGV (Automated Guided Vehicle), PLC (Programmable Logic Controller), and SCADA systems for real-time production control.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`plant` (
    `plant_id` BIGINT COMMENT 'Primary key',
    `jurisdiction_id` BIGINT COMMENT 'FK to compliance jurisdiction',
    `address_line1` STRING COMMENT 'Address line 1',
    `address_line2` STRING COMMENT 'Address line 2',
    `agv_enabled` BOOLEAN COMMENT 'AGV enabled flag',
    `annual_capacity_units` STRING COMMENT 'Annual capacity in units',
    `annual_co2_emissions_tonnes` DECIMAL(18,2) COMMENT 'Annual CO2 emissions in tonnes',
    `annual_water_consumption_m3` DECIMAL(18,2) COMMENT 'Annual water consumption in m3',
    `city` STRING COMMENT 'City',
    `plant_code` STRING COMMENT 'Unique plant code',
    `commissioning_date` DATE COMMENT 'Commissioning date',
    `company_code` STRING COMMENT 'Company code',
    `cost_center_code` STRING COMMENT 'Cost center code',
    `country_code` STRING COMMENT 'Country code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `daily_capacity_units` STRING COMMENT 'Daily capacity in units',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `eop_date` DATE COMMENT 'End of production date',
    `epa_facility_code` STRING COMMENT 'EPA facility code',
    `floor_area_sqm` DECIMAL(18,2) COMMENT 'Floor area in sqm',
    `iatf_16949_certified` BOOLEAN COMMENT 'IATF 16949 certified flag',
    `iso_14001_certified` BOOLEAN COMMENT 'ISO 14001 certified flag',
    `iso_9001_certified` BOOLEAN COMMENT 'ISO 9001 certified flag',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude',
    `manager` STRING COMMENT 'Plant manager name',
    `mes_plant_code` STRING COMMENT 'MES plant code',
    `model_year_current` STRING COMMENT 'Current model year',
    `plant_name` STRING COMMENT 'Plant name',
    `nhtsa_facility_code` STRING COMMENT 'NHTSA facility code',
    `number_of_assembly_lines` STRING COMMENT 'Number of assembly lines',
    `number_of_shifts` STRING COMMENT 'Number of shifts',
    `operational_status` STRING COMMENT 'Operational status',
    `ota_capable` BOOLEAN COMMENT 'OTA capable flag',
    `phone_number` STRING COMMENT 'Phone number',
    `plant_type` STRING COMMENT 'Type of plant',
    `postal_code` STRING COMMENT 'Postal code',
    `powertrain_types_produced` STRING COMMENT 'Powertrain types produced',
    `primary_vehicle_segment` STRING COMMENT 'Primary vehicle segment',
    `region` STRING COMMENT 'Region',
    `renewable_energy_pct` DECIMAL(18,2) COMMENT 'Renewable energy percentage',
    `scada_enabled` BOOLEAN COMMENT 'SCADA enabled flag',
    `short_name` STRING COMMENT 'Short name',
    `sop_date` DATE COMMENT 'Start of production date',
    `state_province` STRING COMMENT 'State or province',
    `takt_time_seconds` STRING COMMENT 'Takt time in seconds',
    `time_zone` STRING COMMENT 'Time zone',
    `union_represented` BOOLEAN COMMENT 'Union represented flag',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    `workforce_headcount` STRING COMMENT 'Workforce headcount',
    CONSTRAINT pk_plant PRIMARY KEY(`plant_id`)
) COMMENT 'Manufacturing plant/facility master data including location, capacity, certifications and operational parameters';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` (
    `production_line_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'FK to line manager',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `vehicle_program_id` BIGINT COMMENT 'FK to vehicle program',
    `agv_integration_enabled` BOOLEAN COMMENT 'AGV integration enabled',
    `andon_system_type` STRING COMMENT 'Type of andon system installed on this line.',
    `automation_level` STRING COMMENT 'Automation level',
    `conveyor_type` STRING COMMENT 'Conveyor type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `current_jph` DECIMAL(18,2) COMMENT 'Current jobs per hour',
    `cycle_time_tracking_enabled` BOOLEAN COMMENT 'Whether automated cycle time tracking is enabled.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `designed_jph` DECIMAL(18,2) COMMENT 'Designed jobs per hour',
    `energy_consumption_kwh_per_unit` DECIMAL(18,2) COMMENT 'Energy consumption per unit',
    `energy_source_type` STRING COMMENT 'Energy source type',
    `eop_date` DATE COMMENT 'End of production date',
    `floor_space_sqm` DECIMAL(18,2) COMMENT 'Floor space in sqm',
    `jis_enabled` BOOLEAN COMMENT 'JIS enabled flag',
    `last_maintenance_date` DATE COMMENT 'Last maintenance date',
    `line_code` STRING COMMENT 'Line code',
    `line_length_meters` DECIMAL(18,2) COMMENT 'Line length in meters',
    `line_name` STRING COMMENT 'Line name',
    `line_status` STRING COMMENT 'Line status',
    `line_type` STRING COMMENT 'Line type',
    `max_vehicle_weight_kg` DECIMAL(18,2) COMMENT 'Max vehicle weight',
    `mes_line_code` STRING COMMENT 'MES line code',
    `mixed_model_capable` BOOLEAN COMMENT 'Mixed model capable flag',
    `model_year_capability` STRING COMMENT 'Model year capability',
    `next_maintenance_date` DATE COMMENT 'Next maintenance date',
    `number_of_stations` STRING COMMENT 'Number of stations',
    `powertrain_type_capability` STRING COMMENT 'Powertrain type capability',
    `quality_gate_count` STRING COMMENT 'Quality gate count',
    `robot_count` STRING COMMENT 'Robot count',
    `safety_certification_expiry_date` DATE COMMENT 'Safety cert expiry date',
    `safety_certification_status` STRING COMMENT 'Safety certification status',
    `sop_date` DATE COMMENT 'Start of production date',
    `takt_time_seconds` DECIMAL(18,2) COMMENT 'Takt time in seconds',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `vehicle_platform_code` STRING COMMENT 'Vehicle platform code',
    `weld_gun_count` STRING COMMENT 'Weld gun count',
    `work_instruction_digital_flag` BOOLEAN COMMENT 'Whether digital work instructions are deployed on this line.',
    CONSTRAINT pk_production_line PRIMARY KEY(`production_line_id`)
) COMMENT 'Assembly/production line master data including capacity, automation level, and MES integration';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` (
    `work_center_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `functional_location_id` BIGINT COMMENT 'FK to functional location',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `work_responsible_supervisor_employee_id` BIGINT COMMENT 'FK to supervisor',
    `agv_integration_enabled` BOOLEAN COMMENT 'AGV integration enabled',
    `andon_enabled` BOOLEAN COMMENT 'Whether andon system is enabled at this work center.',
    `automation_level` STRING COMMENT 'Automation level',
    `available_capacity_hours_per_day` DECIMAL(18,2) COMMENT 'Available capacity hours per day',
    `capacity_category` STRING COMMENT 'Capacity category',
    `work_center_category` STRING COMMENT 'Category',
    `co2_emissions_per_cycle_kg` DECIMAL(18,2) COMMENT 'CO2 emissions per cycle',
    `work_center_code` STRING COMMENT 'Work center code',
    `commissioning_date` DATE COMMENT 'Commissioning date',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `cycle_time_seconds` DECIMAL(18,2) COMMENT 'Cycle time seconds',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `decommissioning_date` DATE COMMENT 'Decommissioning date',
    `work_center_description` STRING COMMENT 'Description',
    `energy_consumption_kw` DECIMAL(18,2) COMMENT 'Energy consumption kW',
    `floor_area_sqm` DECIMAL(18,2) COMMENT 'Floor area sqm',
    `is_bottleneck` BOOLEAN COMMENT 'Is bottleneck flag',
    `is_jis_enabled` BOOLEAN COMMENT 'JIS enabled flag',
    `is_quality_gate` BOOLEAN COMMENT 'Is quality gate flag',
    `labor_rate_per_hour` DECIMAL(18,2) COMMENT 'Labor rate per hour',
    `last_calibration_date` DATE COMMENT 'Last calibration date',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `location_description` STRING COMMENT 'Location description',
    `machine_rate_per_hour` DECIMAL(18,2) COMMENT 'Machine rate per hour',
    `maintenance_strategy_code` STRING COMMENT 'Maintenance strategy code',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'MTBF hours',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'MTTR hours',
    `mes_station_count` STRING COMMENT 'Number of MES-tracked stations within this work center.',
    `mes_work_center_code` STRING COMMENT 'MES work center code',
    `work_center_name` STRING COMMENT 'Work center name',
    `next_calibration_due_date` DATE COMMENT 'Next calibration due date',
    `number_of_shifts` STRING COMMENT 'Number of shifts',
    `number_of_workers` STRING COMMENT 'Number of workers',
    `overhead_rate_percent` DECIMAL(18,2) COMMENT 'Overhead rate percent',
    `plant_code` STRING COMMENT 'Plant code',
    `plc_node_code` STRING COMMENT 'PLC node code',
    `poka_yoke_count` STRING COMMENT 'Number of error-proofing devices at this work center.',
    `process_category` STRING COMMENT 'Process category',
    `production_line_code` STRING COMMENT 'Production line code',
    `sap_work_center_code` STRING COMMENT 'SAP work center code',
    `scada_node_code` STRING COMMENT 'SCADA node code',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Setup time minutes',
    `shift_model_code` STRING COMMENT 'Shift model code',
    `standard_value_key` STRING COMMENT 'Standard value key',
    `takt_time_seconds` DECIMAL(18,2) COMMENT 'Takt time seconds',
    `teardown_time_minutes` DECIMAL(18,2) COMMENT 'Teardown time minutes',
    `work_center_status` STRING COMMENT 'Status',
    `work_center_type` STRING COMMENT 'Type',
    CONSTRAINT pk_work_center PRIMARY KEY(`work_center_id`)
) COMMENT 'Work center master data representing individual manufacturing stations with capacity, cost rates, and equipment details';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` (
    `production_order_id` BIGINT COMMENT 'Primary key',
    `configuration_id` BIGINT COMMENT 'FK to vehicle configuration',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'FK to creator employee',
    `party_id` BIGINT COMMENT 'FK to customer party',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_bom_id` BIGINT COMMENT 'FK to production BOM',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `profit_center_id` BIGINT COMMENT 'FK to profit center',
    `routing_id` BIGINT COMMENT 'FK to routing',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `sku_master_id` BIGINT COMMENT 'FK to SKU master',
    `vehicle_program_id` BIGINT COMMENT 'FK to vehicle program',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual finish timestamp',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Actual labor hours',
    `actual_machine_hours` DECIMAL(18,2) COMMENT 'Actual machine hours',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual start timestamp',
    `carbon_footprint_kg_co2` DECIMAL(18,2) COMMENT 'Carbon footprint kg CO2',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Confirmed quantity',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `hazardous_material_flag` BOOLEAN COMMENT 'Hazardous material flag',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `mes_order_reference` STRING COMMENT 'MES order reference',
    `mes_sync_status` STRING COMMENT 'Synchronization status between ERP and MES for this order.',
    `model_year` STRING COMMENT 'Model year',
    `order_date` DATE COMMENT 'Order date',
    `order_description` STRING COMMENT 'Order description',
    `order_number` STRING COMMENT 'Order number',
    `order_status` STRING COMMENT 'Order status',
    `order_type` STRING COMMENT 'Order type',
    `planned_finish_date` DATE COMMENT 'Planned finish date',
    `planned_labor_hours` DECIMAL(18,2) COMMENT 'Planned labor hours',
    `planned_machine_hours` DECIMAL(18,2) COMMENT 'Planned machine hours',
    `planned_start_date` DATE COMMENT 'Planned start date',
    `ppap_required` BOOLEAN COMMENT 'PPAP required flag',
    `priority` STRING COMMENT 'Priority',
    `production_stage` STRING COMMENT 'Production stage',
    `release_timestamp` TIMESTAMP COMMENT 'Release timestamp',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Rework quantity',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Scrap quantity',
    `sop_indicator` BOOLEAN COMMENT 'SOP indicator',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard cost',
    `target_quantity` DECIMAL(18,2) COMMENT 'Target quantity',
    `technical_completion_timestamp` TIMESTAMP COMMENT 'Technical completion timestamp',
    `total_cycle_time_planned_seconds` DECIMAL(18,2) COMMENT 'Total planned cycle time for all operations in this order.',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `vin_range_end` STRING COMMENT 'VIN range end',
    `vin_range_start` STRING COMMENT 'VIN range start',
    `wip_posting_flag` BOOLEAN COMMENT 'WIP posting flag',
    CONSTRAINT pk_production_order PRIMARY KEY(`production_order_id`)
) COMMENT 'Production/manufacturing order for vehicle or component production with scheduling, costing, and status tracking';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` (
    `build_sequence_id` BIGINT COMMENT 'Primary key',
    `configuration_id` BIGINT COMMENT 'FK to configuration',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual end timestamp',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual start timestamp',
    `body_style_code` STRING COMMENT 'Body style code',
    `build_type` STRING COMMENT 'Build type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `customer_order_number` STRING COMMENT 'Customer order number',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `dealer_code` STRING COMMENT 'Dealer code',
    `destination_market_code` STRING COMMENT 'Destination market code',
    `exterior_color_code` STRING COMMENT 'Exterior color code',
    `freeze_timestamp` TIMESTAMP COMMENT 'Freeze timestamp',
    `interior_color_code` STRING COMMENT 'Interior color code',
    `is_frozen` BOOLEAN COMMENT 'Is frozen flag',
    `is_priority_build` BOOLEAN COMMENT 'Priority build flag',
    `jis_call_off_timestamp` TIMESTAMP COMMENT 'JIS call off timestamp',
    `low_emission_priority_flag` BOOLEAN COMMENT 'Low emission priority flag',
    `mes_sequence_reference` STRING COMMENT 'MES sequence reference',
    `model_year` STRING COMMENT 'Model year',
    `operator_assignment_confirmed` BOOLEAN COMMENT 'Whether all station operator assignments are confirmed for this sequence.',
    `option_package_code` STRING COMMENT 'Option package code',
    `planned_build_date` DATE COMMENT 'Planned build date',
    `planned_end_timestamp` TIMESTAMP COMMENT 'Planned end timestamp',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Planned start timestamp',
    `powertrain_type` STRING COMMENT 'Powertrain type',
    `quality_hold_flag` BOOLEAN COMMENT 'Quality hold flag',
    `sequence_number` STRING COMMENT 'Sequence number',
    `sequence_revision_number` STRING COMMENT 'Revision number',
    `sequence_set_number` STRING COMMENT 'Sequence set number',
    `sequence_status` STRING COMMENT 'Sequence status',
    `sequence_type` STRING COMMENT 'Sequence type',
    `takt_time_seconds` STRING COMMENT 'Takt time seconds',
    `transmission_type` STRING COMMENT 'Transmission type',
    `trim_level_code` STRING COMMENT 'Trim level code',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `vehicle_model_code` STRING COMMENT 'Vehicle model code',
    `vin` STRING COMMENT 'VIN',
    `work_instruction_version` STRING COMMENT 'Active work instruction version set for this sequence position.',
    CONSTRAINT pk_build_sequence PRIMARY KEY(`build_sequence_id`)
) COMMENT 'Vehicle build sequence defining the order of vehicles on the production line with configuration and scheduling details';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` (
    `vehicle_build_id` BIGINT COMMENT 'Primary key',
    `build_stage_id` BIGINT COMMENT 'FK to build stage',
    `homologation_record_id` BIGINT COMMENT 'FK to homologation record',
    `operator_team_id` BIGINT COMMENT 'FK to operator team',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `vin_registry_id` BIGINT COMMENT 'FK to VIN registry',
    `andon_call_count` STRING COMMENT 'Total andon calls during this vehicle build.',
    `battery_serial_number` STRING COMMENT 'Battery serial number',
    `body_shop_end_timestamp` TIMESTAMP COMMENT 'Body shop end',
    `body_shop_start_timestamp` TIMESTAMP COMMENT 'Body shop start',
    `body_style` STRING COMMENT 'Body style',
    `bom_version` STRING COMMENT 'BOM version',
    `build_carbon_footprint_kg` DECIMAL(18,2) COMMENT 'Build carbon footprint kg',
    `build_end_timestamp` TIMESTAMP COMMENT 'Build end timestamp',
    `build_sequence_number` STRING COMMENT 'Build sequence number',
    `build_start_timestamp` TIMESTAMP COMMENT 'Build start timestamp',
    `build_status` STRING COMMENT 'Build status',
    `build_type` STRING COMMENT 'Build type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `end_of_line_test_result` STRING COMMENT 'End of line test result',
    `engine_serial_number` STRING COMMENT 'Engine serial number',
    `final_assembly_end_timestamp` TIMESTAMP COMMENT 'Final assembly end',
    `final_assembly_start_timestamp` TIMESTAMP COMMENT 'Final assembly start',
    `hold_flag` BOOLEAN COMMENT 'Hold flag',
    `hold_reason_code` STRING COMMENT 'Hold reason code',
    `mes_build_ref` STRING COMMENT 'MES system reference for this vehicle build.',
    `model_year` STRING COMMENT 'Model year',
    `paint_color_code` STRING COMMENT 'Paint color code',
    `paint_end_timestamp` TIMESTAMP COMMENT 'Paint end',
    `paint_start_timestamp` TIMESTAMP COMMENT 'Paint start',
    `powertrain_type` STRING COMMENT 'Powertrain type',
    `quality_gate_status` STRING COMMENT 'Quality gate status',
    `rework_count` STRING COMMENT 'Rework count',
    `rework_flag` BOOLEAN COMMENT 'Rework flag',
    `scheduled_build_date` DATE COMMENT 'Scheduled build date',
    `total_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Total accumulated cycle time for this vehicle build.',
    `transmission_serial_number` STRING COMMENT 'Transmission serial number',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `vehicle_model_code` STRING COMMENT 'Vehicle model code',
    `vin` STRING COMMENT 'VIN',
    CONSTRAINT pk_vehicle_build PRIMARY KEY(`vehicle_build_id`)
) COMMENT 'Individual vehicle build record tracking the manufacturing lifecycle from body shop through final assembly';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` (
    `build_stage_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `employee_id` BIGINT COMMENT 'FK to supervisor',
    `agv_enabled` BOOLEAN COMMENT 'AGV enabled',
    `andon_call_count_daily` STRING COMMENT 'Daily count of andon calls at this stage.',
    `automation_level` STRING COMMENT 'Automation level',
    `avg_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Rolling average actual cycle time for this stage.',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `effective_from` DATE COMMENT 'Effective from',
    `effective_until` DATE COMMENT 'Effective until',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Energy consumption kWh',
    `is_quality_gate` BOOLEAN COMMENT 'Is quality gate',
    `is_rework_eligible` BOOLEAN COMMENT 'Is rework eligible',
    `labor_headcount_standard` STRING COMMENT 'Labor headcount standard',
    `mes_stage_code` STRING COMMENT 'MES stage code',
    `operator_headcount_actual` STRING COMMENT 'Actual operator headcount assigned to this stage.',
    `process_area` STRING COMMENT 'Process area',
    `sequence_order` STRING COMMENT 'Sequence order',
    `spc_enabled` BOOLEAN COMMENT 'SPC enabled',
    `stage_code` STRING COMMENT 'Stage code',
    `stage_description` STRING COMMENT 'Stage description',
    `stage_name` STRING COMMENT 'Stage name',
    `stage_status` STRING COMMENT 'Stage status',
    `stage_type` STRING COMMENT 'Stage type',
    `standard_cycle_time_sec` DECIMAL(18,2) COMMENT 'Standard cycle time sec',
    `takt_time_sec` DECIMAL(18,2) COMMENT 'Takt time sec',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `water_consumption_liters` DECIMAL(18,2) COMMENT 'Water consumption liters',
    `work_instruction_count` STRING COMMENT 'Number of active work instructions for this stage.',
    CONSTRAINT pk_build_stage PRIMARY KEY(`build_stage_id`)
) COMMENT 'Manufacturing build stage definitions (body shop, paint, trim, final assembly) with process parameters';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` (
    `shop_floor_event_id` BIGINT COMMENT 'Primary key',
    `equipment_registry_id` BIGINT COMMENT 'FK to equipment',
    `employee_id` BIGINT COMMENT 'FK to operator',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `vin_registry_id` BIGINT COMMENT 'FK to VIN registry',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `work_instruction_id` BIGINT COMMENT 'FK to the work instruction being executed during this event.',
    `andon_call_flag` BOOLEAN COMMENT 'Whether an andon call was triggered during this event.',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `cycle_time_actual_seconds` DECIMAL(18,2) COMMENT 'Actual cycle time recorded for this event.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `emissions_event_flag` BOOLEAN COMMENT 'Emissions event flag',
    `event_category` STRING COMMENT 'Event category',
    `event_duration_seconds` DECIMAL(18,2) COMMENT 'Event duration seconds',
    `event_source_system` STRING COMMENT 'Event source system',
    `event_status` STRING COMMENT 'Event status',
    `event_timestamp` TIMESTAMP COMMENT 'Event timestamp',
    `event_type` STRING COMMENT 'Event type',
    `fault_code` STRING COMMENT 'Fault code',
    `is_rework` BOOLEAN COMMENT 'Is rework',
    `is_within_spec` BOOLEAN COMMENT 'Is within spec',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Lower control limit',
    `measured_value` DECIMAL(18,2) COMMENT 'Measured value',
    `mes_event_number` STRING COMMENT 'MES event number',
    `oee_loss_category` STRING COMMENT 'OEE loss category',
    `process_step_code` STRING COMMENT 'Process step code',
    `quality_result` STRING COMMENT 'Quality result',
    `station_code` STRING COMMENT 'Station code',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Upper control limit',
    CONSTRAINT pk_shop_floor_event PRIMARY KEY(`shop_floor_event_id`)
) COMMENT 'Real-time shop floor events from MES/SCADA including quality checks, machine events, and operator actions';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` (
    `wip_inventory_id` BIGINT COMMENT 'Primary key',
    `part_master_id` BIGINT COMMENT 'FK to part master',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `sku_master_id` BIGINT COMMENT 'FK to SKU master',
    `storage_location_id` BIGINT COMMENT 'FK to storage location',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `assembly_stage` STRING COMMENT 'Assembly stage',
    `currency_code` STRING COMMENT 'Currency code',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `hazardous_material_flag` BOOLEAN COMMENT 'Hazardous material flag',
    `is_rework_item` BOOLEAN COMMENT 'Is rework item',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record created timestamp',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record updated timestamp',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Snapshot timestamp',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `vin` STRING COMMENT 'VIN',
    `wip_record_number` STRING COMMENT 'WIP record number',
    `wip_status` STRING COMMENT 'WIP status',
    `wip_valuation_amount` DECIMAL(18,2) COMMENT 'WIP valuation amount',
    CONSTRAINT pk_wip_inventory PRIMARY KEY(`wip_inventory_id`)
) COMMENT 'Work-in-progress inventory tracking parts and sub-assemblies on the production floor';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` (
    `production_schedule_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `model_id` BIGINT COMMENT 'FK to vehicle model',
    `vehicle_program_id` BIGINT COMMENT 'FK to vehicle program',
    `actual_quantity` STRING COMMENT 'Actual quantity',
    `capacity_utilization_pct` DECIMAL(18,2) COMMENT 'Capacity utilization pct',
    `confirmed_quantity` STRING COMMENT 'Confirmed quantity',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `energy_budget_kwh` DECIMAL(18,2) COMMENT 'Energy budget kWh',
    `freeze_horizon_date` DATE COMMENT 'Freeze horizon date',
    `is_frozen` BOOLEAN COMMENT 'Is frozen',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `mes_schedule_ref` STRING COMMENT 'MES system reference for this schedule.',
    `model_year` STRING COMMENT 'Model year',
    `operator_availability_count` STRING COMMENT 'Number of operators available for this schedule period.',
    `planned_quantity` STRING COMMENT 'Planned quantity',
    `powertrain_type` STRING COMMENT 'Powertrain type',
    `schedule_date` DATE COMMENT 'Schedule date',
    `schedule_end_date` DATE COMMENT 'Schedule end date',
    `schedule_number` STRING COMMENT 'Schedule number',
    `schedule_status` STRING COMMENT 'Schedule status',
    `schedule_type` STRING COMMENT 'Schedule type',
    `schedule_version` STRING COMMENT 'Schedule version',
    `shift_pattern` STRING COMMENT 'Shift pattern',
    `takt_time_seconds` STRING COMMENT 'Takt time seconds',
    CONSTRAINT pk_production_schedule PRIMARY KEY(`production_schedule_id`)
) COMMENT 'Production scheduling data including planned volumes, capacity utilization, and freeze horizons';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`shift` (
    `shift_id` BIGINT COMMENT 'Primary key',
    `factory_calendar_id` BIGINT COMMENT 'FK to factory calendar',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `break_duration_minutes` STRING COMMENT 'Break duration minutes',
    `shift_code` STRING COMMENT 'Shift code',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `effective_date` DATE COMMENT 'Effective date',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Energy consumption kWh',
    `expiry_date` DATE COMMENT 'Expiry date',
    `gross_shift_hours` DECIMAL(18,2) COMMENT 'Gross shift hours',
    `shift_name` STRING COMMENT 'Shift name',
    `number_of_breaks` STRING COMMENT 'Number of breaks',
    `oee_target_percent` DECIMAL(18,2) COMMENT 'OEE target percent',
    `overtime_eligible` BOOLEAN COMMENT 'Overtime eligible',
    `planned_end_time` TIMESTAMP COMMENT 'Planned end time',
    `planned_production_hours` DECIMAL(18,2) COMMENT 'Planned production hours',
    `planned_start_time` TIMESTAMP COMMENT 'Planned start time',
    `shift_status` STRING COMMENT 'Shift status',
    `shift_type` STRING COMMENT 'Shift type',
    `target_units_per_shift` STRING COMMENT 'Target units per shift',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `workforce_headcount_target` STRING COMMENT 'Workforce headcount target',
    CONSTRAINT pk_shift PRIMARY KEY(`shift_id`)
) COMMENT 'Shift definition and scheduling including break patterns, capacity targets, and OEE goals';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` (
    `downtime_event_id` BIGINT COMMENT 'Primary key',
    `equipment_registry_id` BIGINT COMMENT 'FK to equipment',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `employee_id` BIGINT COMMENT 'FK to reporter',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `cycle_time_impact_total_seconds` DECIMAL(18,2) COMMENT 'Total cycle time impact across downstream stations.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `downtime_category` STRING COMMENT 'Downtime category',
    `downtime_type` STRING COMMENT 'Downtime type',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Duration minutes',
    `end_timestamp` TIMESTAMP COMMENT 'End timestamp',
    `energy_waste_kwh` DECIMAL(18,2) COMMENT 'Energy waste kWh',
    `event_number` STRING COMMENT 'Event number',
    `event_status` STRING COMMENT 'Event status',
    `failure_mode_code` STRING COMMENT 'Failure mode code',
    `is_repeat_failure` BOOLEAN COMMENT 'Is repeat failure',
    `is_safety_related` BOOLEAN COMMENT 'Is safety related',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `maintenance_cost_local` DECIMAL(18,2) COMMENT 'Maintenance cost local',
    `mes_downtime_ref` STRING COMMENT 'MES system reference for this downtime event.',
    `oee_availability_loss_pct` DECIMAL(18,2) COMMENT 'OEE availability loss pct',
    `production_loss_units` STRING COMMENT 'Production loss units',
    `resolution_notes` STRING COMMENT 'Resolution notes',
    `root_cause_code` STRING COMMENT 'Root cause code',
    `start_timestamp` TIMESTAMP COMMENT 'Start timestamp',
    CONSTRAINT pk_downtime_event PRIMARY KEY(`downtime_event_id`)
) COMMENT 'Production line and equipment downtime events with root cause, duration, and OEE impact';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` (
    `production_bom_id` BIGINT COMMENT 'Primary key',
    `bom_id` BIGINT COMMENT 'FK to engineering BOM',
    `model_id` BIGINT COMMENT 'FK to vehicle model',
    `base_quantity` DECIMAL(18,2) COMMENT 'Base quantity',
    `base_unit_of_measure` STRING COMMENT 'Base unit of measure',
    `bom_description` STRING COMMENT 'BOM description',
    `bom_status` STRING COMMENT 'BOM status',
    `bom_type` STRING COMMENT 'BOM type',
    `bom_version` STRING COMMENT 'BOM version',
    `component_count` STRING COMMENT 'Component count',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `eco_number` STRING COMMENT 'ECO number',
    `effectivity_end_date` DATE COMMENT 'Effectivity end date',
    `effectivity_start_date` DATE COMMENT 'Effectivity start date',
    `is_configurable` BOOLEAN COMMENT 'Is configurable',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `material_number` STRING COMMENT 'Material number',
    `model_year` STRING COMMENT 'Model year',
    `plant_code` STRING COMMENT 'Plant code',
    `recyclability_pct` DECIMAL(18,2) COMMENT 'Recyclability percentage',
    CONSTRAINT pk_production_bom PRIMARY KEY(`production_bom_id`)
) COMMENT 'Production bill of materials (MBOM) derived from engineering BOM with plant-specific configurations';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` (
    `manufacturing_bom_component_id` BIGINT COMMENT 'Primary key',
    `part_master_id` BIGINT COMMENT 'FK to part master',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_bom_id` BIGINT COMMENT 'FK to production BOM',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `backflush_indicator` BOOLEAN COMMENT 'Backflush indicator',
    `bom_level` STRING COMMENT 'BOM level',
    `component_status` STRING COMMENT 'Component status',
    `component_type` STRING COMMENT 'Component type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `effectivity_end_date` DATE COMMENT 'Effectivity end date',
    `effectivity_start_date` DATE COMMENT 'Effectivity start date',
    `engineering_change_number` STRING COMMENT 'Engineering change number',
    `installation_sequence` STRING COMMENT 'Installation sequence',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `quantity_per_vehicle` DECIMAL(18,2) COMMENT 'Quantity per vehicle',
    `recycled_material_flag` BOOLEAN COMMENT 'Recycled material flag',
    `scrap_factor_pct` DECIMAL(18,2) COMMENT 'Scrap factor pct',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard cost',
    `supplier_part_number` STRING COMMENT 'Supplier part number',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `variant_condition` STRING COMMENT 'Variant condition',
    CONSTRAINT pk_manufacturing_bom_component PRIMARY KEY(`manufacturing_bom_component_id`)
) COMMENT 'Individual component line items within a production BOM with quantities, effectivity, and sourcing details';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` (
    `material_consumption_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to confirming employee',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `sku_master_id` BIGINT COMMENT 'FK to SKU master',
    `storage_location_id` BIGINT COMMENT 'FK to storage location',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `batch_number` STRING COMMENT 'Batch number',
    `consumption_status` STRING COMMENT 'Consumption status',
    `consumption_timestamp` TIMESTAMP COMMENT 'Consumption timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `goods_movement_type` STRING COMMENT 'Goods movement type',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last updated timestamp',
    `material_cost_amount` DECIMAL(18,2) COMMENT 'Material cost amount',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Planned quantity',
    `posting_date` DATE COMMENT 'Posting date',
    `quantity_consumed` DECIMAL(18,2) COMMENT 'Quantity consumed',
    `quantity_variance` DECIMAL(18,2) COMMENT 'Quantity variance',
    `recycled_content_pct` DECIMAL(18,2) COMMENT 'Recycled content pct',
    `reversal_indicator` BOOLEAN COMMENT 'Reversal indicator',
    `scrap_indicator` BOOLEAN COMMENT 'Scrap indicator',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    CONSTRAINT pk_material_consumption PRIMARY KEY(`material_consumption_id`)
) COMMENT 'Material consumption postings against production orders tracking actual vs planned usage';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` (
    `rework_order_id` BIGINT COMMENT 'Primary key',
    `defect_record_id` BIGINT COMMENT 'FK to defect record',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual end timestamp',
    `actual_rework_hours` DECIMAL(18,2) COMMENT 'Actual rework hours',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual start timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `defect_code` STRING COMMENT 'Defect code',
    `defect_description` STRING COMMENT 'Defect description',
    `is_safety_related` BOOLEAN COMMENT 'Is safety related',
    `planned_end_timestamp` TIMESTAMP COMMENT 'Planned end timestamp',
    `planned_rework_hours` DECIMAL(18,2) COMMENT 'Planned rework hours',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Planned start timestamp',
    `priority_level` STRING COMMENT 'Priority level',
    `re_inspection_required` BOOLEAN COMMENT 'Re-inspection required',
    `re_inspection_result` STRING COMMENT 'Re-inspection result',
    `rework_attempt_count` STRING COMMENT 'Rework attempt count',
    `rework_cost` DECIMAL(18,2) COMMENT 'Rework cost',
    `rework_order_number` STRING COMMENT 'Rework order number',
    `rework_status` STRING COMMENT 'Rework status',
    `rework_type` STRING COMMENT 'Rework type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `waste_generated_kg` DECIMAL(18,2) COMMENT 'Waste generated kg',
    CONSTRAINT pk_rework_order PRIMARY KEY(`rework_order_id`)
) COMMENT 'Rework orders for defective units requiring correction before proceeding in production';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` (
    `production_confirmation_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `confirmation_number` STRING COMMENT 'Confirmation number',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Confirmation timestamp',
    `confirmation_type` STRING COMMENT 'Confirmation type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `cycle_time_actual_seconds` DECIMAL(18,2) COMMENT 'Actual cycle time recorded at confirmation from MES',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `energy_actual_kwh` DECIMAL(18,2) COMMENT 'Energy actual kWh',
    `energy_consumed_kwh` DECIMAL(18,2) COMMENT 'Energy consumed during this confirmed operation for ESG tracking',
    `is_final_confirmation` BOOLEAN COMMENT 'Is final confirmation',
    `labor_hours` DECIMAL(18,2) COMMENT 'Labor hours',
    `machine_hours` DECIMAL(18,2) COMMENT 'Machine hours',
    `mes_confirmation_ref` STRING COMMENT 'MES system reference for this confirmation.',
    `oee_contribution_flag` BOOLEAN COMMENT 'Whether this confirmation contributes to OEE calculation',
    `operation_number` STRING COMMENT 'Operation number',
    `posting_date` DATE COMMENT 'Posting date',
    `rework_quantity` DECIMAL(18,2) COMMENT 'Rework quantity',
    `scrap_quantity` DECIMAL(18,2) COMMENT 'Scrap quantity',
    `station_code` STRING COMMENT 'Station code where confirmation was recorded.',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `yield_quantity` DECIMAL(18,2) COMMENT 'Yield quantity',
    CONSTRAINT pk_production_confirmation PRIMARY KEY(`production_confirmation_id`)
) COMMENT 'Production order confirmations recording completed operations, quantities, and labor/machine hours';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` (
    `manufacturing_tooling_usage_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to operator',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `shift_id` BIGINT COMMENT 'Reference to the shift during which tooling was used',
    `tooling_registry_id` BIGINT COMMENT 'FK to tooling registry',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `cumulative_cycle_count` STRING COMMENT 'Cumulative cycle count',
    `cycle_count` STRING COMMENT 'Cycle count',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `downtime_minutes` STRING COMMENT 'Unplanned downtime in minutes during usage',
    `energy_consumed_kwh` DECIMAL(18,2) COMMENT 'Energy consumed kWh',
    `maintenance_required_flag` BOOLEAN COMMENT 'Maintenance required flag',
    `max_cycle_life` STRING COMMENT 'Max cycle life',
    `next_maintenance_date` DATE COMMENT 'Scheduled next maintenance date',
    `oee_contribution_pct` DECIMAL(18,2) COMMENT 'OEE contribution percentage for this tooling usage',
    `parts_produced_count` STRING COMMENT 'Number of parts produced during this usage session',
    `process_type` STRING COMMENT 'Manufacturing process type (stamping, welding, machining, assembly)',
    `scrap_count` STRING COMMENT 'Number of scrapped parts during this usage',
    `tool_condition_rating` STRING COMMENT 'Condition rating after usage (good, fair, poor, critical)',
    `tool_number` STRING COMMENT 'Unique tool identification number',
    `tool_type` STRING COMMENT 'Type of tooling (die, mold, fixture, jig)',
    `tooling_reference` STRING COMMENT 'Tooling reference',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `usage_end_timestamp` TIMESTAMP COMMENT 'Usage end timestamp',
    `usage_start_timestamp` TIMESTAMP COMMENT 'Usage start timestamp',
    `usage_status` STRING COMMENT 'Usage status',
    `wear_percentage` DECIMAL(18,2) COMMENT 'Wear percentage',
    CONSTRAINT pk_manufacturing_tooling_usage PRIMARY KEY(`manufacturing_tooling_usage_id`)
) COMMENT 'Tooling usage records tracking tool deployment, cycle counts, and wear on the manufacturing floor This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` (
    `process_parameter_id` BIGINT COMMENT 'Primary key',
    `equipment_registry_id` BIGINT COMMENT 'FK to equipment',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `esg_parameter_flag` BOOLEAN COMMENT 'ESG parameter flag',
    `is_within_spec` BOOLEAN COMMENT 'Is within spec',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Lower spec limit',
    `measurement_timestamp` TIMESTAMP COMMENT 'Measurement timestamp',
    `mes_parameter_group` STRING COMMENT 'MES system parameter grouping for integration with shop-specific parameter products',
    `parameter_name` STRING COMMENT 'Parameter name',
    `parameter_type` STRING COMMENT 'Parameter type',
    `parameter_value` DECIMAL(18,2) COMMENT 'Parameter value',
    `process_step` STRING COMMENT 'Process step',
    `shop_area` STRING COMMENT 'Identifies which shop area this parameter belongs to: paint_shop, body_shop, assembly, trim',
    `station_code` STRING COMMENT 'Station code',
    `target_value` DECIMAL(18,2) COMMENT 'Target value',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper spec limit',
    `vin` STRING COMMENT 'VIN',
    CONSTRAINT pk_process_parameter PRIMARY KEY(`process_parameter_id`)
) COMMENT 'Manufacturing process parameters (torque, temperature, pressure, etc.) captured from PLC/SCADA systems';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` (
    `agv_movement_id` BIGINT COMMENT 'Primary key',
    `agv_route_id` BIGINT COMMENT 'FK to AGV route',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `agv_unit_code` STRING COMMENT 'AGV unit code',
    `arrival_timestamp` TIMESTAMP COMMENT 'Arrival timestamp',
    `battery_level_pct` DECIMAL(18,2) COMMENT 'Battery level pct',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `cycle_time_impact_seconds` DECIMAL(18,2) COMMENT 'Impact on station cycle time due to AGV delivery timing.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `departure_timestamp` TIMESTAMP COMMENT 'Departure timestamp',
    `destination_location` STRING COMMENT 'Destination location',
    `energy_consumed_kwh` DECIMAL(18,2) COMMENT 'Energy consumed kWh',
    `material_number` STRING COMMENT 'Material number',
    `mes_dispatch_ref` STRING COMMENT 'MES dispatch reference for this AGV movement.',
    `movement_status` STRING COMMENT 'Movement status',
    `movement_type` STRING COMMENT 'Movement type',
    `origin_location` STRING COMMENT 'Origin location',
    `payload_weight_kg` DECIMAL(18,2) COMMENT 'Payload weight kg',
    CONSTRAINT pk_agv_movement PRIMARY KEY(`agv_movement_id`)
) COMMENT 'Automated Guided Vehicle movement events tracking material transport on the shop floor';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` (
    `capacity_plan_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `available_capacity_hours` DECIMAL(18,2) COMMENT 'Available capacity hours',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `cycle_time_constraint_seconds` DECIMAL(18,2) COMMENT 'Bottleneck cycle time constraining capacity.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `energy_budget_kwh` DECIMAL(18,2) COMMENT 'Planned energy budget for the capacity plan period',
    `oee_target_pct` DECIMAL(18,2) COMMENT 'Target OEE percentage for capacity planning',
    `operator_requirement_count` STRING COMMENT 'Number of operators required for this capacity plan.',
    `plan_name` STRING COMMENT 'Plan name',
    `plan_period_end` DATE COMMENT 'Plan period end',
    `plan_period_start` DATE COMMENT 'Plan period start',
    `plan_status` STRING COMMENT 'Plan status',
    `plan_type` STRING COMMENT 'Plan type',
    `planned_units` STRING COMMENT 'Planned units',
    `required_capacity_hours` DECIMAL(18,2) COMMENT 'Required capacity hours',
    `shift_pattern` STRING COMMENT 'Shift pattern',
    `sustainability_constraint_flag` BOOLEAN COMMENT 'Sustainability constraint flag',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `utilization_pct` DECIMAL(18,2) COMMENT 'Utilization pct',
    CONSTRAINT pk_capacity_plan PRIMARY KEY(`capacity_plan_id`)
) COMMENT 'Production capacity planning records for lines and plants with demand vs available capacity';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` (
    `changeover_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `actual_duration_minutes` DECIMAL(18,2) COMMENT 'Actual duration minutes',
    `changeover_status` STRING COMMENT 'Changeover status',
    `changeover_type` STRING COMMENT 'Changeover type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `end_timestamp` TIMESTAMP COMMENT 'End timestamp',
    `energy_consumed_kwh` DECIMAL(18,2) COMMENT 'Energy consumed during changeover',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Energy consumption kWh',
    `from_variant_code` STRING COMMENT 'From variant code',
    `oee_loss_minutes` DECIMAL(18,2) COMMENT 'Minutes of OEE availability loss attributed to this changeover',
    `operator_retraining_required` BOOLEAN COMMENT 'Whether operator retraining is needed for the new variant.',
    `planned_duration_minutes` DECIMAL(18,2) COMMENT 'Planned duration minutes',
    `production_loss_units` STRING COMMENT 'Production loss units',
    `start_timestamp` TIMESTAMP COMMENT 'Start timestamp',
    `to_variant_code` STRING COMMENT 'To variant code',
    `work_instruction_changeover_ref` STRING COMMENT 'Reference to changeover work instructions.',
    CONSTRAINT pk_changeover PRIMARY KEY(`changeover_id`)
) COMMENT 'Production line changeover events when switching between vehicle models or variants';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`production_variant` (
    `production_variant_id` BIGINT COMMENT 'Primary key',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `vehicle_program_id` BIGINT COMMENT 'FK to vehicle program',
    `body_style` STRING COMMENT 'Body style',
    `carbon_intensity_kg_per_unit` DECIMAL(18,2) COMMENT 'Carbon intensity per unit',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `cycle_time_impact_seconds` DECIMAL(18,2) COMMENT 'Additional cycle time in seconds this variant adds vs base',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `effective_from` DATE COMMENT 'Effective from',
    `effective_until` DATE COMMENT 'Effective until',
    `model_year` STRING COMMENT 'Model year',
    `powertrain_type` STRING COMMENT 'Powertrain type',
    `takt_time_seconds` DECIMAL(18,2) COMMENT 'Takt time seconds',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `variant_code` STRING COMMENT 'Variant code',
    `variant_description` STRING COMMENT 'Variant description',
    `variant_name` STRING COMMENT 'Variant name',
    `variant_status` STRING COMMENT 'Variant status',
    CONSTRAINT pk_production_variant PRIMARY KEY(`production_variant_id`)
) COMMENT 'Production variant definitions representing buildable vehicle configurations on a production line';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` (
    `scrap_record_id` BIGINT COMMENT 'Primary key',
    `part_master_id` BIGINT COMMENT 'FK to part master',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `co2_waste_kg` DECIMAL(18,2) COMMENT 'CO2 waste kg',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `disposition_code` STRING COMMENT 'Disposition code',
    `energy_wasted_kwh` DECIMAL(18,2) COMMENT 'Energy wasted on scrapped unit for ESG reporting',
    `is_supplier_caused` BOOLEAN COMMENT 'Is supplier caused',
    `quantity_scrapped` DECIMAL(18,2) COMMENT 'Quantity scrapped',
    `scrap_cost` DECIMAL(18,2) COMMENT 'Scrap cost',
    `scrap_reason_code` STRING COMMENT 'Scrap reason code',
    `scrap_timestamp` TIMESTAMP COMMENT 'Scrap timestamp',
    `scrap_type` STRING COMMENT 'Scrap type',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    CONSTRAINT pk_scrap_record PRIMARY KEY(`scrap_record_id`)
) COMMENT 'Scrap records for materials and components scrapped during production with reason codes and costs';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` (
    `manufacturing_supply_agreement_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `agreement_number` STRING COMMENT 'Agreement number',
    `agreement_status` STRING COMMENT 'Agreement status',
    `agreement_type` STRING COMMENT 'Agreement type',
    `annual_volume_commitment` STRING COMMENT 'Annual volume commitment',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `delivery_frequency` STRING COMMENT 'Delivery frequency',
    `effective_date` DATE COMMENT 'Effective date',
    `energy_sustainability_clause` BOOLEAN COMMENT 'Whether agreement includes energy/sustainability requirements',
    `expiry_date` DATE COMMENT 'Expiry date',
    `lead_time_hours` DECIMAL(18,2) COMMENT 'Lead time hours',
    `sustainability_clause_flag` BOOLEAN COMMENT 'Sustainability clause flag',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    CONSTRAINT pk_manufacturing_supply_agreement PRIMARY KEY(`manufacturing_supply_agreement_id`)
) COMMENT 'Supply agreements between manufacturing plants and suppliers for JIT/JIS material delivery';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` (
    `vehicle_mobility_subscription_id` BIGINT COMMENT 'Primary key',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `service_subscription_id` BIGINT COMMENT 'FK to service subscription',
    `vin_registry_id` BIGINT COMMENT 'FK to VIN registry',
    `actual_delivery_date` DATE COMMENT 'Actual delivery date',
    `carbon_offset_included_flag` BOOLEAN COMMENT 'Carbon offset included flag',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `fleet_assignment_code` STRING COMMENT 'Fleet assignment code',
    `planned_delivery_date` DATE COMMENT 'Planned delivery date',
    `production_tracking_enabled` BOOLEAN COMMENT 'Whether production status tracking is enabled for subscription vehicle',
    `service_tier_code` STRING COMMENT 'Service tier code',
    `subscription_status` STRING COMMENT 'Subscription status',
    `subscription_type` STRING COMMENT 'Subscription type',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    CONSTRAINT pk_vehicle_mobility_subscription PRIMARY KEY(`vehicle_mobility_subscription_id`)
) COMMENT 'Subscription-based vehicle production orders linking mobility service subscriptions to manufacturing';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` (
    `compliance_certification_id` BIGINT COMMENT 'Primary key',
    `jurisdiction_id` BIGINT COMMENT 'FK to jurisdiction',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `certification_number` STRING COMMENT 'Certification number',
    `certification_status` STRING COMMENT 'Certification status',
    `certification_type` STRING COMMENT 'Certification type',
    `certifying_body` STRING COMMENT 'Certifying body',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `esg_certification_type` STRING COMMENT 'ESG certification type',
    `expiry_date` DATE COMMENT 'Expiry date',
    `is_active` BOOLEAN COMMENT 'Is active',
    `iso_50001_scope` STRING COMMENT 'Scope of ISO 50001 energy management certification',
    `issue_date` DATE COMMENT 'Issue date',
    `last_audit_date` DATE COMMENT 'Last audit date',
    `next_audit_date` DATE COMMENT 'Next audit date',
    `nonconformance_count` STRING COMMENT 'Nonconformance count',
    `scope_description` STRING COMMENT 'Scope description',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    CONSTRAINT pk_compliance_certification PRIMARY KEY(`compliance_certification_id`)
) COMMENT 'Manufacturing compliance certifications (ISO, IATF, environmental) for plants and production lines';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` (
    `production_order_allocation_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Allocated quantity',
    `allocation_date` DATE COMMENT 'Allocation date',
    `allocation_reason` STRING COMMENT 'Allocation reason',
    `allocation_status` STRING COMMENT 'Allocation status',
    `allocation_type` STRING COMMENT 'Allocation type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `energy_allocation_kwh` DECIMAL(18,2) COMMENT 'Allocated energy budget for this production order allocation',
    `priority_rank` STRING COMMENT 'Priority rank',
    `sustainability_priority_flag` BOOLEAN COMMENT 'Sustainability priority flag',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    CONSTRAINT pk_production_order_allocation PRIMARY KEY(`production_order_allocation_id`)
) COMMENT 'Allocation of production orders to specific lines, shifts, and time slots for scheduling optimization';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` (
    `agv_route_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `destination_zone` STRING COMMENT 'Destination zone',
    `distance_meters` DECIMAL(18,2) COMMENT 'Distance meters',
    `energy_efficiency_score` DECIMAL(18,2) COMMENT 'Energy efficiency score',
    `estimated_energy_kwh` DECIMAL(18,2) COMMENT 'Estimated energy consumption per route traversal',
    `estimated_travel_time_seconds` STRING COMMENT 'Estimated travel time seconds',
    `is_bidirectional` BOOLEAN COMMENT 'Is bidirectional',
    `max_speed_mps` DECIMAL(18,2) COMMENT 'Max speed mps',
    `mes_route_ref` STRING COMMENT 'MES system reference for this AGV route.',
    `origin_zone` STRING COMMENT 'Origin zone',
    `priority_level` STRING COMMENT 'Priority level',
    `route_code` STRING COMMENT 'Route code',
    `route_name` STRING COMMENT 'Route name',
    `route_status` STRING COMMENT 'Route status',
    `route_type` STRING COMMENT 'Route type',
    `takt_synchronized_flag` BOOLEAN COMMENT 'Whether this route is synchronized with line takt time.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    CONSTRAINT pk_agv_route PRIMARY KEY(`agv_route_id`)
) COMMENT 'AGV route definitions within a plant including waypoints, speed limits, and priority zones';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`routing` (
    `routing_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `vehicle_program_id` BIGINT COMMENT 'FK to vehicle program',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `routing_description` STRING COMMENT 'Routing description',
    `effective_from` DATE COMMENT 'Effective from',
    `effective_until` DATE COMMENT 'Effective until',
    `energy_per_operation_kwh` DECIMAL(18,2) COMMENT 'Energy per operation kWh',
    `mes_routing_code` STRING COMMENT 'MES system routing identifier for integration',
    `mes_routing_ref` STRING COMMENT 'Reference to the routing definition in MES.',
    `operation_count` STRING COMMENT 'Operation count',
    `routing_number` STRING COMMENT 'Routing number',
    `routing_status` STRING COMMENT 'Routing status',
    `routing_type` STRING COMMENT 'Routing type',
    `total_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Total cycle time seconds',
    `total_standard_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Sum of standard cycle times across all operations in routing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `version` STRING COMMENT 'Routing version',
    `work_instruction_count` STRING COMMENT 'Number of work instructions linked to this routing',
    `work_instruction_linked_flag` BOOLEAN COMMENT 'Whether all operations have linked digital work instructions.',
    CONSTRAINT pk_routing PRIMARY KEY(`routing_id`)
) COMMENT 'Manufacturing routing definitions specifying the sequence of operations for producing a product';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`factory_calendar` (
    `factory_calendar_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `available_hours` DECIMAL(18,2) COMMENT 'Available hours',
    `calendar_code` STRING COMMENT 'Calendar code',
    `calendar_date` DATE COMMENT 'Calendar date',
    `calendar_name` STRING COMMENT 'Calendar name',
    `calendar_year` STRING COMMENT 'Calendar year',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `day_type` STRING COMMENT 'Day type',
    `energy_budget_day_kwh` DECIMAL(18,2) COMMENT 'Planned daily energy budget for the calendar day',
    `holiday_name` STRING COMMENT 'Holiday name',
    `is_production_day` BOOLEAN COMMENT 'Is production day',
    `planned_shifts` STRING COMMENT 'Planned shifts',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    CONSTRAINT pk_factory_calendar PRIMARY KEY(`factory_calendar_id`)
) COMMENT 'Factory calendar defining working days, holidays, shutdown periods, and special production days';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` (
    `operator_team_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `employee_id` BIGINT COMMENT 'FK to team leader',
    `assigned_station_count` STRING COMMENT 'Number of stations this team is assigned to',
    `avg_cycle_time_efficiency_pct` DECIMAL(18,2) COMMENT 'Team average cycle time efficiency vs standard.',
    `avg_skill_level` STRING COMMENT 'Average skill level of team members',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `mes_team_code` STRING COMMENT 'Team code as registered in the MES system.',
    `multi_skill_coverage_pct` DECIMAL(18,2) COMMENT 'Percentage of stations the team can cover through multi-skilling.',
    `shift_pattern` STRING COMMENT 'Shift pattern',
    `team_code` STRING COMMENT 'Team code',
    `team_name` STRING COMMENT 'Team name',
    `team_size` STRING COMMENT 'Team size',
    `team_status` STRING COMMENT 'Team status',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    CONSTRAINT pk_operator_team PRIMARY KEY(`operator_team_id`)
) COMMENT 'Operator team definitions for production line staffing and shift assignments';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_packaging_specification` (
    `manufacturing_packaging_specification_id` BIGINT COMMENT 'Primary key',
    `part_master_id` BIGINT COMMENT 'FK to part master',
    `container_type` STRING COMMENT 'Container type',
    `container_weight_kg` DECIMAL(18,2) COMMENT 'Container weight kg',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `is_returnable` BOOLEAN COMMENT 'Is returnable',
    `parts_per_container` STRING COMMENT 'Parts per container',
    `recyclable_material_flag` BOOLEAN COMMENT 'Recyclable material flag',
    `specification_code` STRING COMMENT 'Specification code',
    `specification_name` STRING COMMENT 'Specification name',
    `specification_status` STRING COMMENT 'Specification status',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    CONSTRAINT pk_manufacturing_packaging_specification PRIMARY KEY(`manufacturing_packaging_specification_id`)
) COMMENT 'Packaging specifications for parts and components used in manufacturing logistics (container types, dimensions)';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` (
    `oee_metric_view_id` BIGINT COMMENT 'Surrogate key for the pre-aggregated OEE metric record.',
    `plant_id` BIGINT COMMENT 'Plant the OEE metrics are aggregated for.',
    `production_line_id` BIGINT COMMENT 'Production line the OEE metrics are aggregated for.',
    `shift_id` BIGINT COMMENT 'Shift the OEE metrics are aggregated for.',
    `work_center_id` BIGINT COMMENT 'Work center the OEE metrics are aggregated for.',
    `aggregation_period` STRING COMMENT 'Granularity of the aggregation (shift, day, week, month).',
    `availability_rate` DECIMAL(18,2) COMMENT 'OEE availability component (operating time / planned time).',
    `created_timestamp` TIMESTAMP COMMENT 'When this aggregated record was generated.',
    `downtime_minutes` DECIMAL(18,2) COMMENT 'Total downtime in minutes during the period.',
    `good_units_produced` BIGINT COMMENT 'Good (defect-free) units produced in the period.',
    `ideal_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Ideal cycle time per unit in seconds.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'When this aggregated record was last refreshed.',
    `metric_date` DATE COMMENT 'Calendar date the OEE metrics are aggregated over.',
    `oee_rate` DECIMAL(18,2) COMMENT 'Overall Equipment Effectiveness = availability x performance x quality.',
    `operating_time_minutes` DECIMAL(18,2) COMMENT 'Actual operating (run) time in minutes.',
    `performance_rate` DECIMAL(18,2) COMMENT 'OEE performance component.',
    `planned_production_time_minutes` DECIMAL(18,2) COMMENT 'Total planned production time in minutes.',
    `quality_rate` DECIMAL(18,2) COMMENT 'OEE quality component (good units / total units).',
    `scrap_units` BIGINT COMMENT 'Units scrapped during the period.',
    `teep_rate` DECIMAL(18,2) COMMENT 'Total Effective Equipment Performance rate.',
    `total_units_produced` BIGINT COMMENT 'Total units produced in the period.',
    CONSTRAINT pk_oee_metric_view PRIMARY KEY(`oee_metric_view_id`)
) COMMENT 'Pre-aggregated Overall Equipment Effectiveness (OEE) metrics per plant/line/work-center/shift for analytics readiness.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` (
    `paint_shop_parameter_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `vehicle_build_id` BIGINT COMMENT 'FK to vehicle build',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `atomization_pressure_bar` DECIMAL(18,2) COMMENT 'Spray atomization pressure',
    `batch_number` STRING COMMENT 'Paint batch/lot number',
    `booth_humidity_pct` DECIMAL(18,2) COMMENT 'Relative humidity percentage',
    `booth_temperature_celsius` DECIMAL(18,2) COMMENT 'Booth ambient temperature',
    `color_code` STRING COMMENT 'Paint color code applied',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cure_duration_seconds` STRING COMMENT 'Duration in cure oven',
    `cure_oven_temp_celsius` DECIMAL(18,2) COMMENT 'Oven curing temperature',
    `data_governance_ref` STRING COMMENT 'Data governance lineage reference',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Energy consumed during this process step',
    `film_thickness_microns` DECIMAL(18,2) COMMENT 'Measured paint film thickness',
    `flow_rate_ml_per_min` DECIMAL(18,2) COMMENT 'Paint flow rate',
    `is_within_spec` BOOLEAN COMMENT 'Whether reading is within spec',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Lower specification limit',
    `measurement_timestamp` TIMESTAMP COMMENT 'When the reading was taken',
    `mes_event_reference` STRING COMMENT 'MES system event ID',
    `parameter_name` STRING COMMENT 'Name of the measured parameter',
    `parameter_value` DECIMAL(18,2) COMMENT 'Measured numeric value',
    `process_step` STRING COMMENT 'E.g. e-coat, primer, base coat, clear coat, sealer',
    `robot_program_code` STRING COMMENT 'Paint robot program identifier',
    `station_code` STRING COMMENT 'Paint booth or station identifier',
    `target_value` DECIMAL(18,2) COMMENT 'Nominal target value',
    `unit_of_measure` STRING COMMENT 'UOM for the parameter value',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper specification limit',
    `voc_emissions_g` DECIMAL(18,2) COMMENT 'Volatile organic compound emissions in grams',
    CONSTRAINT pk_paint_shop_parameter PRIMARY KEY(`paint_shop_parameter_id`)
) COMMENT 'Paint shop specific process parameters including booth temperature, humidity, film thickness, color coat application settings, and cure oven profiles tracked per vehicle and station.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` (
    `body_shop_parameter_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `tooling_registry_id` BIGINT COMMENT 'Weld gun equipment identifier',
    `vehicle_build_id` BIGINT COMMENT 'FK to vehicle build',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `adhesive_bead_width_mm` DECIMAL(18,2) COMMENT 'Structural adhesive bead width',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_governance_ref` STRING COMMENT 'Data governance lineage reference',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Energy consumed during this process step',
    `flush_measurement_mm` DECIMAL(18,2) COMMENT 'Panel flush dimensional measurement',
    `gap_measurement_mm` DECIMAL(18,2) COMMENT 'Panel gap dimensional measurement',
    `hemming_force_kn` DECIMAL(18,2) COMMENT 'Hemming press force',
    `is_within_spec` BOOLEAN COMMENT 'Whether reading is within spec',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Lower specification limit',
    `measurement_timestamp` TIMESTAMP COMMENT 'When the reading was taken',
    `mes_event_reference` STRING COMMENT 'MES system event ID',
    `nugget_diameter_mm` DECIMAL(18,2) COMMENT 'Weld nugget diameter',
    `parameter_name` STRING COMMENT 'Name of the measured parameter',
    `parameter_value` DECIMAL(18,2) COMMENT 'Measured numeric value',
    `process_step` STRING COMMENT 'E.g. spot weld, MIG weld, laser weld, adhesive, hemming',
    `robot_program_code` STRING COMMENT 'Robot program identifier',
    `station_code` STRING COMMENT 'Body shop station identifier',
    `target_value` DECIMAL(18,2) COMMENT 'Nominal target value',
    `unit_of_measure` STRING COMMENT 'UOM for the parameter value',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper specification limit',
    `weld_current_amps` DECIMAL(18,2) COMMENT 'Welding current in amps',
    `weld_force_kn` DECIMAL(18,2) COMMENT 'Electrode force in kilonewtons',
    `weld_spot_number` STRING COMMENT 'Sequential weld spot number on body',
    `weld_time_ms` DECIMAL(18,2) COMMENT 'Weld duration in milliseconds',
    CONSTRAINT pk_body_shop_parameter PRIMARY KEY(`body_shop_parameter_id`)
) COMMENT 'Body shop specific process parameters including weld current, weld time, adhesive application, hemming force, and dimensional measurements per station and vehicle.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` (
    `assembly_parameter_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to operator who performed the operation',
    `part_master_id` BIGINT COMMENT 'Fastener/bolt identifier for traceability',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `vehicle_build_id` BIGINT COMMENT 'FK to vehicle build',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `alignment_offset_mm` DECIMAL(18,2) COMMENT 'Alignment measurement offset',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_governance_ref` STRING COMMENT 'Data governance lineage reference',
    `electrical_test_current_ma` DECIMAL(18,2) COMMENT 'Electrical test current in milliamps',
    `electrical_test_voltage` DECIMAL(18,2) COMMENT 'Electrical test voltage',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Energy consumed during this process step',
    `fill_volume_liters` DECIMAL(18,2) COMMENT 'Fluid fill volume in liters',
    `is_safety_critical` BOOLEAN COMMENT 'Whether this is a safety-critical fastening',
    `is_within_spec` BOOLEAN COMMENT 'Whether reading is within spec',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Lower specification limit',
    `measurement_timestamp` TIMESTAMP COMMENT 'When the reading was taken',
    `mes_event_reference` STRING COMMENT 'MES system event ID',
    `parameter_name` STRING COMMENT 'Name of the measured parameter',
    `parameter_value` DECIMAL(18,2) COMMENT 'Measured numeric value',
    `process_step` STRING COMMENT 'E.g. torque, fill, electrical test, alignment, marriage',
    `station_code` STRING COMMENT 'Assembly station identifier',
    `target_value` DECIMAL(18,2) COMMENT 'Nominal target value',
    `tool_serial_number` STRING COMMENT 'Torque tool or fixture serial number',
    `torque_angle_degrees` DECIMAL(18,2) COMMENT 'Torque angle in degrees',
    `torque_value_nm` DECIMAL(18,2) COMMENT 'Applied torque in Newton-meters',
    `unit_of_measure` STRING COMMENT 'UOM for the parameter value',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper specification limit',
    CONSTRAINT pk_assembly_parameter PRIMARY KEY(`assembly_parameter_id`)
) COMMENT 'Final assembly specific process parameters including torque values, fill volumes, electrical test results, and alignment measurements per station and vehicle.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` (
    `work_instruction_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `routing_id` BIGINT COMMENT 'FK to routing',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `approved_by` STRING COMMENT 'Name of approver',
    `approved_timestamp` TIMESTAMP COMMENT 'Approval timestamp',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_governance_ref` STRING COMMENT 'Data governance lineage reference',
    `effective_from_date` DATE COMMENT 'Effective start date',
    `effective_to_date` DATE COMMENT 'Effective end date',
    `instruction_description` STRING COMMENT 'Detailed description of the work instruction',
    `instruction_number` STRING COMMENT 'Unique instruction document number',
    `instruction_status` STRING COMMENT 'Status: draft, active, superseded, archived',
    `instruction_title` STRING COMMENT 'Title of the work instruction',
    `instruction_type` STRING COMMENT 'Type: standard, safety-critical, quality-check, rework',
    `is_safety_critical` BOOLEAN COMMENT 'Whether this is a safety-critical operation',
    `media_attachment_url` STRING COMMENT 'URL to visual/video instruction media',
    `model_applicability` STRING COMMENT 'Which vehicle models this applies to',
    `operation_sequence` STRING COMMENT 'Sequence order within the station',
    `ppe_required` STRING COMMENT 'Personal protective equipment required',
    `quality_check_type` STRING COMMENT 'Type of quality check: visual, torque, dimensional, electrical',
    `revision_date` DATE COMMENT 'Date of last revision',
    `skill_level_required` STRING COMMENT 'Minimum operator skill level',
    `standard_time_seconds` DECIMAL(18,2) COMMENT 'Standard time to complete in seconds',
    `station_code` STRING COMMENT 'Station where instruction applies',
    `tools_required` STRING COMMENT 'List of tools/fixtures required',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `variant_condition` STRING COMMENT 'Configuration variant conditions for applicability',
    `version_number` STRING COMMENT 'Document version number',
    CONSTRAINT pk_work_instruction PRIMARY KEY(`work_instruction_id`)
) COMMENT 'MES work instructions per station defining the step-by-step operations, tools required, quality checks, and safety precautions for each assembly or process station.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` (
    `station_operator_assignment_id` BIGINT COMMENT 'Primary key',
    `operator_team_id` BIGINT COMMENT 'FK to operator team',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `employee_id` BIGINT COMMENT 'FK to assigned operator',
    `station_trainee_employee_id` BIGINT COMMENT 'FK to trainee being supervised',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `assignment_date` DATE COMMENT 'Date of assignment',
    `assignment_end_timestamp` TIMESTAMP COMMENT 'End time of assignment',
    `assignment_start_timestamp` TIMESTAMP COMMENT 'Start time of assignment',
    `assignment_status` STRING COMMENT 'Status: planned, active, completed, cancelled',
    `assignment_type` STRING COMMENT 'Type: primary, backup, relief, training',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_governance_ref` STRING COMMENT 'Data governance lineage reference',
    `is_trainer` BOOLEAN COMMENT 'Whether operator is training others',
    `qualification_verified` BOOLEAN COMMENT 'Whether operator qualification was verified',
    `role_at_station` STRING COMMENT 'Operator role: lead, assembler, quality checker',
    `rotation_sequence` STRING COMMENT 'Position in rotation schedule',
    `skill_level` STRING COMMENT 'Operator skill level for this station',
    `station_code` STRING COMMENT 'Station identifier',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_station_operator_assignment PRIMARY KEY(`station_operator_assignment_id`)
) COMMENT 'Operator assignments per station tracking which operators are assigned to which work centers/stations per shift, including qualification verification and rotation schedules.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` (
    `cycle_time_tracking_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to operator',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `vehicle_build_id` BIGINT COMMENT 'FK to vehicle build',
    `work_center_id` BIGINT COMMENT 'FK to work center',
    `actual_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Actual cycle time in seconds',
    `andon_call_flag` BOOLEAN COMMENT 'Whether andon was pulled during cycle',
    `andon_duration_seconds` DECIMAL(18,2) COMMENT 'Duration of andon stop',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `cycle_end_timestamp` TIMESTAMP COMMENT 'Timestamp when cycle ended',
    `cycle_start_timestamp` TIMESTAMP COMMENT 'Timestamp when cycle started',
    `cycle_time_variance_seconds` DECIMAL(18,2) COMMENT 'Difference between actual and planned',
    `data_governance_ref` STRING COMMENT 'Data governance lineage reference',
    `delay_reason_code` STRING COMMENT 'Reason code if over takt',
    `is_over_takt` BOOLEAN COMMENT 'Whether cycle exceeded takt time',
    `mes_event_reference` STRING COMMENT 'MES system event ID',
    `model_variant_code` STRING COMMENT 'Vehicle variant affecting cycle time',
    `non_value_added_time_seconds` DECIMAL(18,2) COMMENT 'Non-value-added portion',
    `planned_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Planned/standard cycle time in seconds',
    `station_code` STRING COMMENT 'Station identifier',
    `takt_time_seconds` DECIMAL(18,2) COMMENT 'Current takt time for the line',
    `value_added_time_seconds` DECIMAL(18,2) COMMENT 'Value-added portion of cycle time',
    `variance_pct` DECIMAL(18,2) COMMENT 'Percentage variance from planned',
    `wait_time_seconds` DECIMAL(18,2) COMMENT 'Wait/idle time before cycle start',
    CONSTRAINT pk_cycle_time_tracking PRIMARY KEY(`cycle_time_tracking_id`)
) COMMENT 'Cycle time tracking per station recording actual vs planned cycle times for each vehicle passing through each work center, enabling bottleneck analysis and line balancing.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` (
    `oee_metric_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `work_center_id` BIGINT COMMENT 'FK to work center (nullable for line-level)',
    `actual_avg_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Actual average cycle time',
    `actual_run_time_minutes` DECIMAL(18,2) COMMENT 'Actual running time',
    `availability_pct` DECIMAL(18,2) COMMENT 'Availability component percentage',
    `changeover_count` STRING COMMENT 'Number of changeovers in period',
    `changeover_time_minutes` DECIMAL(18,2) COMMENT 'Total changeover time',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_governance_ref` STRING COMMENT 'Data governance lineage reference',
    `defective_units` STRING COMMENT 'Units requiring rework or scrapped',
    `energy_consumption_kwh` DECIMAL(18,2) COMMENT 'Total energy consumed in period',
    `energy_per_unit_kwh` DECIMAL(18,2) COMMENT 'Energy consumption per unit produced',
    `good_units_produced` STRING COMMENT 'Units passing quality first time',
    `ideal_cycle_time_seconds` DECIMAL(18,2) COMMENT 'Ideal/designed cycle time',
    `major_stop_count` STRING COMMENT 'Number of major stoppages',
    `metric_date` DATE COMMENT 'Date of the OEE measurement period',
    `metric_period_type` STRING COMMENT 'Granularity: shift, daily, weekly, monthly',
    `minor_stop_count` STRING COMMENT 'Number of minor stoppages',
    `oee_pct` DECIMAL(18,2) COMMENT 'Overall OEE = Availability x Performance x Quality',
    `oee_target_pct` DECIMAL(18,2) COMMENT 'Target OEE for the period',
    `performance_pct` DECIMAL(18,2) COMMENT 'Performance/speed component percentage',
    `period_end_timestamp` TIMESTAMP COMMENT 'End of measurement period',
    `period_start_timestamp` TIMESTAMP COMMENT 'Start of measurement period',
    `planned_downtime_minutes` DECIMAL(18,2) COMMENT 'Planned downtime (changeover, maintenance)',
    `planned_production_time_minutes` DECIMAL(18,2) COMMENT 'Total planned production time',
    `quality_pct` DECIMAL(18,2) COMMENT 'Quality/yield component percentage',
    `rework_units` STRING COMMENT 'Units sent to rework',
    `scrap_units` STRING COMMENT 'Units scrapped',
    `speed_loss_minutes` DECIMAL(18,2) COMMENT 'Time lost due to reduced speed',
    `top_loss_category` STRING COMMENT 'Biggest loss category in period',
    `total_units_produced` STRING COMMENT 'Total units produced in period',
    `unplanned_downtime_minutes` DECIMAL(18,2) COMMENT 'Unplanned downtime duration',
    CONSTRAINT pk_oee_metric PRIMARY KEY(`oee_metric_id`)
) COMMENT 'Pre-aggregated Overall Equipment Effectiveness (OEE) metrics per production line, work center, and shift, decomposed into availability, performance, and quality components.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` (
    `energy_consumption_id` BIGINT COMMENT 'Primary key',
    `measurement_point_id` BIGINT COMMENT 'Energy meter identifier',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line (nullable for plant-level)',
    `shift_id` BIGINT COMMENT 'FK to shift',
    `work_center_id` BIGINT COMMENT 'FK to work center (nullable for line-level)',
    `baseline_consumption` DECIMAL(18,2) COMMENT 'Baseline/target consumption for comparison',
    `co2_emission_factor` DECIMAL(18,2) COMMENT 'Emission factor used for calculation',
    `co2_emissions_kg` DECIMAL(18,2) COMMENT 'CO2 equivalent emissions in kg',
    `consumption_kwh_equivalent` DECIMAL(18,2) COMMENT 'Normalized to kWh equivalent',
    `consumption_per_unit` DECIMAL(18,2) COMMENT 'Energy per unit produced',
    `consumption_value` DECIMAL(18,2) COMMENT 'Measured consumption value',
    `cost_amount` DECIMAL(18,2) COMMENT 'Cost of energy consumed',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency of cost',
    `data_governance_ref` STRING COMMENT 'Data governance lineage reference',
    `energy_source` STRING COMMENT 'Source: grid, solar, wind, cogeneration, purchased',
    `energy_type` STRING COMMENT 'Type: electricity, natural_gas, compressed_air, steam, water',
    `is_estimated` BOOLEAN COMMENT 'Whether value is estimated vs metered',
    `measurement_date` DATE COMMENT 'Date of measurement',
    `peak_demand_kw` DECIMAL(18,2) COMMENT 'Peak power demand in kW',
    `period_end_timestamp` TIMESTAMP COMMENT 'End of measurement period',
    `period_start_timestamp` TIMESTAMP COMMENT 'Start of measurement period',
    `period_type` STRING COMMENT 'Granularity: hourly, shift, daily, weekly, monthly',
    `renewable_pct` DECIMAL(18,2) COMMENT 'Percentage from renewable sources',
    `reporting_standard` STRING COMMENT 'ESG reporting standard: GHG Protocol, ISO 14064, CSRD',
    `scope_category` STRING COMMENT 'GHG scope: scope_1, scope_2, scope_3',
    `unit_of_measure` STRING COMMENT 'UOM: kWh, m3, liters, kg',
    `units_produced` STRING COMMENT 'Vehicles/units produced in period',
    `variance_from_baseline_pct` DECIMAL(18,2) COMMENT 'Percentage variance from baseline',
    `water_consumption_m3` DECIMAL(18,2) COMMENT 'Water consumption in cubic meters',
    CONSTRAINT pk_energy_consumption PRIMARY KEY(`energy_consumption_id`)
) COMMENT 'Energy consumption tracking per production line and plant for ESG reporting, recording electricity, gas, water, and compressed air usage with CO2 equivalent calculations.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`iot_sensor_data` (
    `iot_sensor_data_id` BIGINT COMMENT '',
    `plant_id` BIGINT COMMENT '',
    `production_line_id` BIGINT COMMENT '',
    `sensor_tag` STRING COMMENT '',
    `sensor_type` STRING COMMENT '',
    `measurement_value` DOUBLE COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `captured_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_iot_sensor_data PRIMARY KEY(`iot_sensor_data_id`)
) COMMENT '';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`edge_computing_data_flow` (
    `edge_computing_data_flow_id` BIGINT COMMENT '',
    `plant_id` BIGINT COMMENT '',
    `edge_node_name` STRING COMMENT '',
    `source_sensor_tag` STRING COMMENT '',
    `flow_direction` STRING COMMENT '',
    `payload_format` STRING COMMENT '',
    `processed_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_edge_computing_data_flow PRIMARY KEY(`edge_computing_data_flow_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_production_bom_id` FOREIGN KEY (`production_bom_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_bom`(`production_bom_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_build_stage_id` FOREIGN KEY (`build_stage_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`build_stage`(`build_stage_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_operator_team_id` FOREIGN KEY (`operator_team_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`operator_team`(`operator_team_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` ADD CONSTRAINT `fk_manufacturing_build_stage_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` ADD CONSTRAINT `fk_manufacturing_shop_floor_event_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` ADD CONSTRAINT `fk_manufacturing_shop_floor_event_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` ADD CONSTRAINT `fk_manufacturing_shop_floor_event_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` ADD CONSTRAINT `fk_manufacturing_shop_floor_event_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` ADD CONSTRAINT `fk_manufacturing_shop_floor_event_work_instruction_id` FOREIGN KEY (`work_instruction_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_instruction`(`work_instruction_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` ADD CONSTRAINT `fk_manufacturing_wip_inventory_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` ADD CONSTRAINT `fk_manufacturing_wip_inventory_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` ADD CONSTRAINT `fk_manufacturing_wip_inventory_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` ADD CONSTRAINT `fk_manufacturing_wip_inventory_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` ADD CONSTRAINT `fk_manufacturing_wip_inventory_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shift` ADD CONSTRAINT `fk_manufacturing_shift_factory_calendar_id` FOREIGN KEY (`factory_calendar_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`factory_calendar`(`factory_calendar_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shift` ADD CONSTRAINT `fk_manufacturing_shift_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shift` ADD CONSTRAINT `fk_manufacturing_shift_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` ADD CONSTRAINT `fk_manufacturing_downtime_event_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_component_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_component_production_bom_id` FOREIGN KEY (`production_bom_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_bom`(`production_bom_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` ADD CONSTRAINT `fk_manufacturing_manufacturing_bom_component_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` ADD CONSTRAINT `fk_manufacturing_manufacturing_tooling_usage_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` ADD CONSTRAINT `fk_manufacturing_manufacturing_tooling_usage_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` ADD CONSTRAINT `fk_manufacturing_manufacturing_tooling_usage_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` ADD CONSTRAINT `fk_manufacturing_manufacturing_tooling_usage_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` ADD CONSTRAINT `fk_manufacturing_process_parameter_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` ADD CONSTRAINT `fk_manufacturing_agv_movement_agv_route_id` FOREIGN KEY (`agv_route_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`agv_route`(`agv_route_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` ADD CONSTRAINT `fk_manufacturing_agv_movement_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` ADD CONSTRAINT `fk_manufacturing_agv_movement_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` ADD CONSTRAINT `fk_manufacturing_changeover_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_variant` ADD CONSTRAINT `fk_manufacturing_production_variant_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` ADD CONSTRAINT `fk_manufacturing_scrap_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` ADD CONSTRAINT `fk_manufacturing_scrap_record_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` ADD CONSTRAINT `fk_manufacturing_scrap_record_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` ADD CONSTRAINT `fk_manufacturing_manufacturing_supply_agreement_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` ADD CONSTRAINT `fk_manufacturing_vehicle_mobility_subscription_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` ADD CONSTRAINT `fk_manufacturing_compliance_certification_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` ADD CONSTRAINT `fk_manufacturing_production_order_allocation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` ADD CONSTRAINT `fk_manufacturing_production_order_allocation_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` ADD CONSTRAINT `fk_manufacturing_production_order_allocation_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` ADD CONSTRAINT `fk_manufacturing_production_order_allocation_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` ADD CONSTRAINT `fk_manufacturing_agv_route_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`factory_calendar` ADD CONSTRAINT `fk_manufacturing_factory_calendar_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` ADD CONSTRAINT `fk_manufacturing_operator_team_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` ADD CONSTRAINT `fk_manufacturing_operator_team_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ADD CONSTRAINT `fk_manufacturing_oee_metric_view_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ADD CONSTRAINT `fk_manufacturing_oee_metric_view_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ADD CONSTRAINT `fk_manufacturing_oee_metric_view_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ADD CONSTRAINT `fk_manufacturing_oee_metric_view_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ADD CONSTRAINT `fk_manufacturing_paint_shop_parameter_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ADD CONSTRAINT `fk_manufacturing_paint_shop_parameter_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ADD CONSTRAINT `fk_manufacturing_paint_shop_parameter_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ADD CONSTRAINT `fk_manufacturing_paint_shop_parameter_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ADD CONSTRAINT `fk_manufacturing_paint_shop_parameter_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ADD CONSTRAINT `fk_manufacturing_body_shop_parameter_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ADD CONSTRAINT `fk_manufacturing_body_shop_parameter_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ADD CONSTRAINT `fk_manufacturing_body_shop_parameter_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ADD CONSTRAINT `fk_manufacturing_body_shop_parameter_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ADD CONSTRAINT `fk_manufacturing_body_shop_parameter_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ADD CONSTRAINT `fk_manufacturing_assembly_parameter_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ADD CONSTRAINT `fk_manufacturing_assembly_parameter_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ADD CONSTRAINT `fk_manufacturing_assembly_parameter_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ADD CONSTRAINT `fk_manufacturing_assembly_parameter_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ADD CONSTRAINT `fk_manufacturing_assembly_parameter_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ADD CONSTRAINT `fk_manufacturing_work_instruction_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ADD CONSTRAINT `fk_manufacturing_work_instruction_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ADD CONSTRAINT `fk_manufacturing_work_instruction_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ADD CONSTRAINT `fk_manufacturing_work_instruction_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ADD CONSTRAINT `fk_manufacturing_station_operator_assignment_operator_team_id` FOREIGN KEY (`operator_team_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`operator_team`(`operator_team_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ADD CONSTRAINT `fk_manufacturing_station_operator_assignment_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ADD CONSTRAINT `fk_manufacturing_station_operator_assignment_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ADD CONSTRAINT `fk_manufacturing_station_operator_assignment_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ADD CONSTRAINT `fk_manufacturing_station_operator_assignment_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ADD CONSTRAINT `fk_manufacturing_cycle_time_tracking_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ADD CONSTRAINT `fk_manufacturing_cycle_time_tracking_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ADD CONSTRAINT `fk_manufacturing_cycle_time_tracking_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ADD CONSTRAINT `fk_manufacturing_cycle_time_tracking_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ADD CONSTRAINT `fk_manufacturing_cycle_time_tracking_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ADD CONSTRAINT `fk_manufacturing_cycle_time_tracking_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ADD CONSTRAINT `fk_manufacturing_oee_metric_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ADD CONSTRAINT `fk_manufacturing_oee_metric_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ADD CONSTRAINT `fk_manufacturing_oee_metric_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ADD CONSTRAINT `fk_manufacturing_oee_metric_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ADD CONSTRAINT `fk_manufacturing_energy_consumption_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ADD CONSTRAINT `fk_manufacturing_energy_consumption_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ADD CONSTRAINT `fk_manufacturing_energy_consumption_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`shift`(`shift_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ADD CONSTRAINT `fk_manufacturing_energy_consumption_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`iot_sensor_data` ADD CONSTRAINT `fk_manufacturing_iot_sensor_data_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`iot_sensor_data` ADD CONSTRAINT `fk_manufacturing_iot_sensor_data_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`edge_computing_data_flow` ADD CONSTRAINT `fk_manufacturing_edge_computing_data_flow_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`manufacturing` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_automotive_v1`.`manufacturing` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ALTER COLUMN `andon_system_type` SET TAGS ('dbx_business_glossary_term' = 'Andon System Type');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ALTER COLUMN `cycle_time_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Tracking Enabled');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ALTER COLUMN `work_instruction_digital_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Instruction Digital Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `work_responsible_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `work_responsible_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `andon_enabled` SET TAGS ('dbx_business_glossary_term' = 'Andon Enabled');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `mes_station_count` SET TAGS ('dbx_business_glossary_term' = 'MES Station Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `poka_yoke_count` SET TAGS ('dbx_business_glossary_term' = 'Poka-Yoke Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_subdomain' = 'build_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `mes_sync_status` SET TAGS ('dbx_business_glossary_term' = 'MES Sync Status');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `total_cycle_time_planned_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Cycle Time Planned Seconds');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` SET TAGS ('dbx_subdomain' = 'build_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ALTER COLUMN `operator_assignment_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Operator Assignment Confirmed');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ALTER COLUMN `work_instruction_version` SET TAGS ('dbx_business_glossary_term' = 'Work Instruction Version');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` SET TAGS ('dbx_subdomain' = 'build_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `andon_call_count` SET TAGS ('dbx_business_glossary_term' = 'Andon Call Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `mes_build_ref` SET TAGS ('dbx_business_glossary_term' = 'MES Build Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `total_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Cycle Time Seconds');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` ALTER COLUMN `andon_call_count_daily` SET TAGS ('dbx_business_glossary_term' = 'Andon Call Count Daily');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` ALTER COLUMN `avg_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Cycle Time Seconds');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` ALTER COLUMN `operator_headcount_actual` SET TAGS ('dbx_business_glossary_term' = 'Operator Headcount Actual');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_stage` ALTER COLUMN `work_instruction_count` SET TAGS ('dbx_business_glossary_term' = 'Work Instruction Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` ALTER COLUMN `work_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Work Instruction ID');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` ALTER COLUMN `andon_call_flag` SET TAGS ('dbx_business_glossary_term' = 'Andon Call Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` ALTER COLUMN `cycle_time_actual_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Actual Seconds');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shop_floor_event` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` SET TAGS ('dbx_subdomain' = 'material_flow');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`wip_inventory` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ALTER COLUMN `mes_schedule_ref` SET TAGS ('dbx_business_glossary_term' = 'MES Schedule Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ALTER COLUMN `operator_availability_count` SET TAGS ('dbx_business_glossary_term' = 'Operator Availability Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shift` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shift` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shift` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shift` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shift` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shift` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shift` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shift` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shift` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`shift` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `cycle_time_impact_total_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Impact Total Seconds');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`downtime_event` ALTER COLUMN `mes_downtime_ref` SET TAGS ('dbx_business_glossary_term' = 'MES Downtime Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` SET TAGS ('dbx_subdomain' = 'material_flow');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` SET TAGS ('dbx_subdomain' = 'material_flow');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_bom_component` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` SET TAGS ('dbx_subdomain' = 'material_flow');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` SET TAGS ('dbx_subdomain' = 'build_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_subdomain' = 'build_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `cycle_time_actual_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Cycle Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `energy_consumed_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumed');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `mes_confirmation_ref` SET TAGS ('dbx_business_glossary_term' = 'MES Confirmation Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `oee_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'OEE Contribution Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` SET TAGS ('dbx_subdomain' = 'material_flow');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` SET TAGS ('dbx_ssot_owner' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` SET TAGS ('dbx_ssot_concept' = 'tooling_usage');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_tooling_usage` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `mes_parameter_group` SET TAGS ('dbx_business_glossary_term' = 'MES Parameter Group');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`process_parameter` ALTER COLUMN `shop_area` SET TAGS ('dbx_business_glossary_term' = 'Shop Area');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` ALTER COLUMN `cycle_time_impact_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Impact Seconds');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_movement` ALTER COLUMN `mes_dispatch_ref` SET TAGS ('dbx_business_glossary_term' = 'MES Dispatch Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `cycle_time_constraint_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Constraint Seconds');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `energy_budget_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Budget');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `oee_target_pct` SET TAGS ('dbx_business_glossary_term' = 'OEE Target');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `operator_requirement_count` SET TAGS ('dbx_business_glossary_term' = 'Operator Requirement Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` SET TAGS ('dbx_subdomain' = 'build_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` ALTER COLUMN `energy_consumed_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumed');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` ALTER COLUMN `oee_loss_minutes` SET TAGS ('dbx_business_glossary_term' = 'OEE Loss Minutes');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` ALTER COLUMN `operator_retraining_required` SET TAGS ('dbx_business_glossary_term' = 'Operator Retraining Required');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`changeover` ALTER COLUMN `work_instruction_changeover_ref` SET TAGS ('dbx_business_glossary_term' = 'Work Instruction Changeover Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_variant` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_variant` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_variant` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_variant` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_variant` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_variant` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_variant` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_variant` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_variant` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_variant` ALTER COLUMN `cycle_time_impact_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Impact');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_variant` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` SET TAGS ('dbx_subdomain' = 'material_flow');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`scrap_record` ALTER COLUMN `energy_wasted_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Wasted');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` SET TAGS ('dbx_subdomain' = 'build_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` SET TAGS ('dbx_association_edges' = 'manufacturing.plant,procurement.supplier');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_supply_agreement` ALTER COLUMN `energy_sustainability_clause` SET TAGS ('dbx_business_glossary_term' = 'Energy Sustainability Clause');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` SET TAGS ('dbx_subdomain' = 'build_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` SET TAGS ('dbx_association_edges' = 'manufacturing.vehicle_build,mobility.mobility_service');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_mobility_subscription` ALTER COLUMN `production_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Production Tracking Enabled');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` SET TAGS ('dbx_subdomain' = 'compliance_sustainability');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` SET TAGS ('dbx_association_edges' = 'manufacturing.production_order,compliance.regulatory_requirement');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`compliance_certification` ALTER COLUMN `iso_50001_scope` SET TAGS ('dbx_business_glossary_term' = 'ISO 50001 Scope');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` SET TAGS ('dbx_subdomain' = 'build_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` SET TAGS ('dbx_association_edges' = 'manufacturing.production_order,dealer.dealership');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order_allocation` ALTER COLUMN `energy_allocation_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Allocation');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` ALTER COLUMN `estimated_energy_kwh` SET TAGS ('dbx_business_glossary_term' = 'Estimated Energy');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` ALTER COLUMN `mes_route_ref` SET TAGS ('dbx_business_glossary_term' = 'MES Route Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`agv_route` ALTER COLUMN `takt_synchronized_flag` SET TAGS ('dbx_business_glossary_term' = 'Takt Synchronized Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `mes_routing_code` SET TAGS ('dbx_business_glossary_term' = 'MES Routing Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `mes_routing_ref` SET TAGS ('dbx_business_glossary_term' = 'MES Routing Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `total_standard_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Standard Cycle Time Seconds');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `work_instruction_count` SET TAGS ('dbx_business_glossary_term' = 'Work Instruction Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `work_instruction_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Instruction Linked Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`factory_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`factory_calendar` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`factory_calendar` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`factory_calendar` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`factory_calendar` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`factory_calendar` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`factory_calendar` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`factory_calendar` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`factory_calendar` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`factory_calendar` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`factory_calendar` ALTER COLUMN `energy_budget_day_kwh` SET TAGS ('dbx_business_glossary_term' = 'Daily Energy Budget');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` ALTER COLUMN `assigned_station_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned Station Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` ALTER COLUMN `avg_cycle_time_efficiency_pct` SET TAGS ('dbx_business_glossary_term' = 'Average Cycle Time Efficiency Percent');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` ALTER COLUMN `avg_skill_level` SET TAGS ('dbx_business_glossary_term' = 'Average Skill Level');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` ALTER COLUMN `mes_team_code` SET TAGS ('dbx_business_glossary_term' = 'MES Team Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`operator_team` ALTER COLUMN `multi_skill_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Multi-Skill Coverage Percent');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_packaging_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_packaging_specification` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_packaging_specification` SET TAGS ('dbx_system_of_record' = 'SAP_PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_packaging_specification` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_packaging_specification` SET TAGS ('dbx_value_chain_area' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_packaging_specification` SET TAGS ('dbx_user_vibe_authority' = 'supreme');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_packaging_specification` SET TAGS ('dbx_source_of_record' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_packaging_specification` SET TAGS ('dbx_source_system' = 'SAP PP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_packaging_specification` SET TAGS ('dbx_MES' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`manufacturing_packaging_specification` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` SET TAGS ('dbx_pre_aggregated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` SET TAGS ('dbx_oee' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` SET TAGS ('dbx_analytics' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` SET TAGS ('dbx_mes' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `oee_metric_view_id` SET TAGS ('dbx_business_glossary_term' = 'OEE Record');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `aggregation_period` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Period');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `availability_rate` SET TAGS ('dbx_business_glossary_term' = 'Availability');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `good_units_produced` SET TAGS ('dbx_business_glossary_term' = 'Good Units');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `ideal_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ideal Cycle Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `metric_date` SET TAGS ('dbx_business_glossary_term' = 'Metric Date');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `oee_rate` SET TAGS ('dbx_business_glossary_term' = 'OEE');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `operating_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Operating Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `performance_rate` SET TAGS ('dbx_business_glossary_term' = 'Performance');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `planned_production_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `quality_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `scrap_units` SET TAGS ('dbx_business_glossary_term' = 'Scrap Units');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `teep_rate` SET TAGS ('dbx_business_glossary_term' = 'TEEP');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric_view` ALTER COLUMN `total_units_produced` SET TAGS ('dbx_business_glossary_term' = 'Total Units');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` SET TAGS ('dbx_subdomain' = 'mes_integration');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` SET TAGS ('dbx_layer' = 'bronze');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `paint_shop_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Paint Shop Parameter ID');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `vehicle_build_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Build');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `atomization_pressure_bar` SET TAGS ('dbx_business_glossary_term' = 'Atomization Pressure');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `booth_humidity_pct` SET TAGS ('dbx_business_glossary_term' = 'Booth Humidity');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `booth_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Booth Temperature');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `color_code` SET TAGS ('dbx_business_glossary_term' = 'Color Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `cure_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cure Duration');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `cure_oven_temp_celsius` SET TAGS ('dbx_business_glossary_term' = 'Cure Oven Temperature');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `film_thickness_microns` SET TAGS ('dbx_business_glossary_term' = 'Film Thickness');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `flow_rate_ml_per_min` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `is_within_spec` SET TAGS ('dbx_business_glossary_term' = 'Within Spec Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Spec Limit');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `mes_event_reference` SET TAGS ('dbx_business_glossary_term' = 'MES Event Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `parameter_value` SET TAGS ('dbx_business_glossary_term' = 'Parameter Value');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `robot_program_code` SET TAGS ('dbx_business_glossary_term' = 'Robot Program');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Spec Limit');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`paint_shop_parameter` ALTER COLUMN `voc_emissions_g` SET TAGS ('dbx_business_glossary_term' = 'VOC Emissions');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` SET TAGS ('dbx_subdomain' = 'mes_integration');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` SET TAGS ('dbx_layer' = 'bronze');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `body_shop_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Body Shop Parameter ID');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `tooling_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Weld Gun ID');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `vehicle_build_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Build');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `adhesive_bead_width_mm` SET TAGS ('dbx_business_glossary_term' = 'Adhesive Bead Width');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `flush_measurement_mm` SET TAGS ('dbx_business_glossary_term' = 'Flush Measurement');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `gap_measurement_mm` SET TAGS ('dbx_business_glossary_term' = 'Gap Measurement');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `hemming_force_kn` SET TAGS ('dbx_business_glossary_term' = 'Hemming Force');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `is_within_spec` SET TAGS ('dbx_business_glossary_term' = 'Within Spec Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Spec Limit');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `mes_event_reference` SET TAGS ('dbx_business_glossary_term' = 'MES Event Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `nugget_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Nugget Diameter');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `parameter_value` SET TAGS ('dbx_business_glossary_term' = 'Parameter Value');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `robot_program_code` SET TAGS ('dbx_business_glossary_term' = 'Robot Program');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Spec Limit');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `weld_current_amps` SET TAGS ('dbx_business_glossary_term' = 'Weld Current');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `weld_force_kn` SET TAGS ('dbx_business_glossary_term' = 'Weld Force');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `weld_spot_number` SET TAGS ('dbx_business_glossary_term' = 'Weld Spot Number');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`body_shop_parameter` ALTER COLUMN `weld_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Weld Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` SET TAGS ('dbx_subdomain' = 'mes_integration');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` SET TAGS ('dbx_layer' = 'bronze');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `assembly_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Assembly Parameter ID');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Fastener ID');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `vehicle_build_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Build');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `alignment_offset_mm` SET TAGS ('dbx_business_glossary_term' = 'Alignment Offset');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `electrical_test_current_ma` SET TAGS ('dbx_business_glossary_term' = 'Test Current');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `electrical_test_voltage` SET TAGS ('dbx_business_glossary_term' = 'Test Voltage');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `fill_volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Fill Volume');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `is_safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `is_within_spec` SET TAGS ('dbx_business_glossary_term' = 'Within Spec Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Spec Limit');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `mes_event_reference` SET TAGS ('dbx_business_glossary_term' = 'MES Event Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `parameter_value` SET TAGS ('dbx_business_glossary_term' = 'Parameter Value');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Process Step');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `tool_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Tool Serial Number');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `torque_angle_degrees` SET TAGS ('dbx_business_glossary_term' = 'Torque Angle');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `torque_value_nm` SET TAGS ('dbx_business_glossary_term' = 'Torque Value');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`assembly_parameter` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Spec Limit');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` SET TAGS ('dbx_subdomain' = 'mes_integration');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` SET TAGS ('dbx_layer' = 'silver');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `work_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Work Instruction ID');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `instruction_description` SET TAGS ('dbx_business_glossary_term' = 'Instruction Description');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `instruction_number` SET TAGS ('dbx_business_glossary_term' = 'Instruction Number');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `instruction_status` SET TAGS ('dbx_business_glossary_term' = 'Instruction Status');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `instruction_title` SET TAGS ('dbx_business_glossary_term' = 'Instruction Title');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `instruction_type` SET TAGS ('dbx_business_glossary_term' = 'Instruction Type');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `is_safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `media_attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Media Attachment');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `model_applicability` SET TAGS ('dbx_business_glossary_term' = 'Model Applicability');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `operation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Operation Sequence');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'PPE Required');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `quality_check_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Type');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `skill_level_required` SET TAGS ('dbx_business_glossary_term' = 'Skill Level Required');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `standard_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Standard Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `tools_required` SET TAGS ('dbx_business_glossary_term' = 'Tools Required');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `variant_condition` SET TAGS ('dbx_business_glossary_term' = 'Variant Condition');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_instruction` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` SET TAGS ('dbx_subdomain' = 'plant_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` SET TAGS ('dbx_subdomain' = 'mes_integration');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` SET TAGS ('dbx_layer' = 'silver');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `station_operator_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Station Operator Assignment ID');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `operator_team_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Team');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `station_trainee_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainee');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `station_trainee_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `station_trainee_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment End');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `is_trainer` SET TAGS ('dbx_business_glossary_term' = 'Is Trainer');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `qualification_verified` SET TAGS ('dbx_business_glossary_term' = 'Qualification Verified');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `role_at_station` SET TAGS ('dbx_business_glossary_term' = 'Role at Station');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `rotation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Rotation Sequence');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`station_operator_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` SET TAGS ('dbx_subdomain' = 'mes_integration');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` SET TAGS ('dbx_layer' = 'bronze');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `cycle_time_tracking_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Tracking ID');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `vehicle_build_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Build');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `actual_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Cycle Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `andon_call_flag` SET TAGS ('dbx_business_glossary_term' = 'Andon Call Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `andon_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Andon Duration');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `cycle_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cycle End');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `cycle_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cycle Start');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `cycle_time_variance_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Variance');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `delay_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `is_over_takt` SET TAGS ('dbx_business_glossary_term' = 'Over Takt Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `mes_event_reference` SET TAGS ('dbx_business_glossary_term' = 'MES Event Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `model_variant_code` SET TAGS ('dbx_business_glossary_term' = 'Model Variant Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `non_value_added_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Non-Value Added Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `planned_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Planned Cycle Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `takt_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Takt Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `value_added_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Value Added Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`cycle_time_tracking` ALTER COLUMN `wait_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Wait Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` SET TAGS ('dbx_subdomain' = 'mes_integration');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` SET TAGS ('dbx_layer' = 'gold');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` SET TAGS ('dbx_pre_aggregated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `oee_metric_id` SET TAGS ('dbx_business_glossary_term' = 'OEE Metric ID');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `actual_avg_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Avg Cycle Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `actual_run_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Run Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `availability_pct` SET TAGS ('dbx_business_glossary_term' = 'Availability');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `changeover_count` SET TAGS ('dbx_business_glossary_term' = 'Changeover Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `changeover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Changeover Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `defective_units` SET TAGS ('dbx_business_glossary_term' = 'Defective Units');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `energy_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `energy_per_unit_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Per Unit');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `good_units_produced` SET TAGS ('dbx_business_glossary_term' = 'Good Units');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `ideal_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Ideal Cycle Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `major_stop_count` SET TAGS ('dbx_business_glossary_term' = 'Major Stop Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `metric_date` SET TAGS ('dbx_business_glossary_term' = 'Metric Date');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `metric_period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `minor_stop_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Stop Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `oee_pct` SET TAGS ('dbx_business_glossary_term' = 'OEE Percentage');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `oee_target_pct` SET TAGS ('dbx_business_glossary_term' = 'OEE Target');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `performance_pct` SET TAGS ('dbx_business_glossary_term' = 'Performance');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `period_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period End');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `period_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Start');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `planned_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Downtime');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `planned_production_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Planned Production Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `quality_pct` SET TAGS ('dbx_business_glossary_term' = 'Quality');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `rework_units` SET TAGS ('dbx_business_glossary_term' = 'Rework Units');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `scrap_units` SET TAGS ('dbx_business_glossary_term' = 'Scrap Units');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `speed_loss_minutes` SET TAGS ('dbx_business_glossary_term' = 'Speed Loss');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `top_loss_category` SET TAGS ('dbx_business_glossary_term' = 'Top Loss Category');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `total_units_produced` SET TAGS ('dbx_business_glossary_term' = 'Total Units Produced');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`oee_metric` ALTER COLUMN `unplanned_downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Unplanned Downtime');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` SET TAGS ('dbx_subdomain' = 'compliance_sustainability');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` SET TAGS ('dbx_subdomain' = 'mes_integration');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` SET TAGS ('dbx_layer' = 'silver');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` SET TAGS ('dbx_esg' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `energy_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption ID');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `measurement_point_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `baseline_consumption` SET TAGS ('dbx_business_glossary_term' = 'Baseline Consumption');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `co2_emission_factor` SET TAGS ('dbx_business_glossary_term' = 'CO2 Emission Factor');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `co2_emissions_kg` SET TAGS ('dbx_business_glossary_term' = 'CO2 Emissions');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `consumption_kwh_equivalent` SET TAGS ('dbx_business_glossary_term' = 'kWh Equivalent');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `consumption_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Consumption Per Unit');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `consumption_value` SET TAGS ('dbx_business_glossary_term' = 'Consumption Value');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `energy_source` SET TAGS ('dbx_business_glossary_term' = 'Energy Source');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `energy_type` SET TAGS ('dbx_business_glossary_term' = 'Energy Type');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `measurement_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Date');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `peak_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `period_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period End');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `period_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Period Start');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `renewable_pct` SET TAGS ('dbx_business_glossary_term' = 'Renewable Percentage');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Reporting Standard');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `scope_category` SET TAGS ('dbx_business_glossary_term' = 'Scope Category');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `units_produced` SET TAGS ('dbx_business_glossary_term' = 'Units Produced');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `variance_from_baseline_pct` SET TAGS ('dbx_business_glossary_term' = 'Variance from Baseline');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`energy_consumption` ALTER COLUMN `water_consumption_m3` SET TAGS ('dbx_business_glossary_term' = 'Water Consumption');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`iot_sensor_data` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`iot_sensor_data` ALTER COLUMN `iot_sensor_data_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`iot_sensor_data` ALTER COLUMN `plant_id` SET TAGS ('dbx_subdomain' = 'iot_sensor');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`iot_sensor_data` ALTER COLUMN `production_line_id` SET TAGS ('dbx_subdomain' = 'iot_sensor');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`iot_sensor_data` ALTER COLUMN `sensor_tag` SET TAGS ('dbx_subdomain' = 'iot_sensor');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`iot_sensor_data` ALTER COLUMN `sensor_type` SET TAGS ('dbx_subdomain' = 'iot_sensor');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`iot_sensor_data` ALTER COLUMN `measurement_value` SET TAGS ('dbx_subdomain' = 'iot_sensor');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`iot_sensor_data` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_subdomain' = 'iot_sensor');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`iot_sensor_data` ALTER COLUMN `captured_at` SET TAGS ('dbx_subdomain' = 'iot_sensor');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`edge_computing_data_flow` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`edge_computing_data_flow` ALTER COLUMN `edge_computing_data_flow_id` SET TAGS ('dbx_role' = 'primary_key');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`edge_computing_data_flow` ALTER COLUMN `plant_id` SET TAGS ('dbx_subdomain' = 'edge_computing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`edge_computing_data_flow` ALTER COLUMN `edge_node_name` SET TAGS ('dbx_subdomain' = 'edge_computing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`edge_computing_data_flow` ALTER COLUMN `source_sensor_tag` SET TAGS ('dbx_subdomain' = 'edge_computing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`edge_computing_data_flow` ALTER COLUMN `flow_direction` SET TAGS ('dbx_subdomain' = 'edge_computing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`edge_computing_data_flow` ALTER COLUMN `payload_format` SET TAGS ('dbx_subdomain' = 'edge_computing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`edge_computing_data_flow` ALTER COLUMN `processed_at` SET TAGS ('dbx_subdomain' = 'edge_computing');
