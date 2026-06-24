-- Schema for Domain: manufacturing | Business: Automotive | Version: v2_mvm
-- Generated on: 2026-06-23 06:00:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`manufacturing` COMMENT 'Core production and assembly operations across all manufacturing plants. Manages shop floor execution via MES (Manufacturing Execution System), work order scheduling, production line sequencing (JIS - Just-in-Sequence), WIP (Work in Progress) tracking, and build traceability. Includes stamping, body shop, paint, and final assembly processes. Integrates with AGV (Automated Guided Vehicle), PLC (Programmable Logic Controller), and SCADA systems for real-time production control.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`plant` (
    `plant_id` BIGINT COMMENT 'Primary key',
    `jurisdiction_id` BIGINT COMMENT 'FK to compliance jurisdiction',
    `segment_id` BIGINT COMMENT 'Foreign key linking to product.product_segment. Business justification: Each plant has a primary vehicle segment it produces (e.g., truck plant, EV plant). The plain attr primary_vehicle_segment is a denormalized reference to product_segment. This FK enables segment-level',
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
    `plant_id` BIGINT COMMENT 'FK to plant',
    `platform_id` BIGINT COMMENT 'Foreign key linking to vehicle.platform. Business justification: Production lines are physically certified and tooled for specific vehicle platforms (fixture geometry, weld schedules, conveyor dimensions). Platform assignment drives capital investment decisions, SO',
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
    `weld_gun_count` STRING COMMENT 'Weld gun count',
    `work_instruction_digital_flag` BOOLEAN COMMENT 'Whether digital work instructions are deployed on this line.',
    CONSTRAINT pk_production_line PRIMARY KEY(`production_line_id`)
) COMMENT 'Assembly/production line master data including capacity, automation level, and MES integration';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` (
    `work_center_id` BIGINT COMMENT 'Primary key',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Work centers are physically located within a manufacturing plant. work_center currently stores plant_code as a STRING denormalized reference. Adding plant_id FK to manufacturing.plant normalizes this ',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Each work center has a designated point-of-use (POU) storage location for JIT/JIS parts staging — a standard SAP/MES configuration in automotive assembly. This link enables AGV routing, material stagi',
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
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: Production orders must reference the specific engineering BOM version used for costing and change control. Direct FK enables ECO impact on open orders and standard cost roll-up. bom_version is a denor',
    `configuration_id` BIGINT COMMENT 'FK to vehicle configuration',
    `party_id` BIGINT COMMENT 'FK to customer party',
    `dealership_id` BIGINT COMMENT 'Foreign key linking to dealer.dealership. Business justification: Customer-order-driven production orders are placed by specific dealers. OEM scheduling priority, dealer-specific build confirmations, and order-to-delivery tracking all require dealer identity directl',
    `fleet_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_fleet_account. Business justification: Fleet production orders must reference the fleet account for volume tracking, contract billing, and discount tier application. Automotive OEM fleet operations require linking each production order to ',
    `homologation_record_id` BIGINT COMMENT 'Foreign key linking to compliance.homologation_record. Business justification: Before releasing a production order, manufacturing must verify the target vehicle configuration holds valid homologation approval for its destination market. Production planners and market-launch team',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: Production orders are issued for a specific powertrain variant to drive BOM selection, routing assignment, and standard cost rollup. powertrain_type is a denormalized string; FK to powertrain_variant ',
    `production_bom_id` BIGINT COMMENT 'FK to production BOM',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_schedule. Business justification: Production orders are created to fulfill a production schedule. The production_schedule defines planned quantities, dates, and capacity for a line/plant; production_orders are the execution artifacts ',
    `routing_id` BIGINT COMMENT 'FK to routing',
    `sku_master_id` BIGINT COMMENT 'FK to SKU master',
    `vehicle_order_id` BIGINT COMMENT 'Foreign key linking to sales.vehicle_order. Business justification: Order-to-production traceability: when a customer vehicle_order is confirmed, a production_order is created to fulfill it. This link drives ATP/CTP delivery promising, order status reporting to dealer',
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
    `dealership_id` BIGINT COMMENT 'Foreign key linking to dealer.dealership. Business justification: Build sequences in automotive manufacturing are dealer-order-driven. JIS call-off timing, sequence priority flags, and destination routing all require the destination dealership identity. dealer_code',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: Build sequences are model-specific for mixed-model line management and JIS call-off. vehicle_model_code is a denormalized plain string. FK to vehicle.model enables model-level sequence analysis, mixed',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: JIS (Just-In-Sequence) call-off requires the exact powertrain variant to trigger supplier deliveries and line-side sequencing. powertrain_type is a denormalized string; FK to powertrain_variant enable',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual end timestamp',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual start timestamp',
    `body_style_code` STRING COMMENT 'Body style code',
    `build_type` STRING COMMENT 'Build type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
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
    `vin` STRING COMMENT 'VIN',
    `work_instruction_version` STRING COMMENT 'Active work instruction version set for this sequence position.',
    CONSTRAINT pk_build_sequence PRIMARY KEY(`build_sequence_id`)
) COMMENT 'Vehicle build sequence defining the order of vehicles on the production line with configuration and scheduling details';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` (
    `vehicle_build_id` BIGINT COMMENT 'Primary key',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Each vehicle build is executed against a specific BOM header/version. This link is critical for recall investigations (identify all vehicles built with a specific BOM revision), warranty traceability,',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: As-built BOM traceability per VIN is a regulatory and warranty requirement in automotive. Linking vehicle_build to the exact engineering BOM version used enables recall investigations, warranty claims',
    `build_sequence_id` BIGINT COMMENT 'Foreign key linking to manufacturing.build_sequence. Business justification: A vehicle_build record represents the actual manufacturing execution of a vehicle that was planned in a build_sequence slot. The build_sequence defines the planned order and configuration; vehicle_bui',
    `build_spec_id` BIGINT COMMENT 'Foreign key linking to vehicle.build_spec. Business justification: End-of-line conformance checking compares actual build outcome (vehicle_build) against the planned build specification (build_spec). This link is required for regulatory build conformance reporting, N',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to vehicle.configuration. Business justification: vehicle_build must reference the specific configuration being built for end-of-line configuration conformance verification and recall traceability by configuration. vehicle_model_code is a denormalize',
    `finished_vehicle_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.finished_vehicle_stock. Business justification: When final assembly completes, a finished_vehicle_stock record is created from the vehicle_build. Recall investigations, IATF 16949 traceability audits, and warranty registration all require linking t',
    `homologation_record_id` BIGINT COMMENT 'FK to homologation record',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `recall_campaign_id` BIGINT COMMENT 'Foreign key linking to compliance.recall_campaign. Business justification: Recall campaigns must identify and track specific vehicle builds (by VIN) within scope. Linking vehicle_build to recall_campaign enables recall scope determination, remedy completion tracking per buil',
    `vehicle_compound_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle_compound. Business justification: Post-build compound staging: every finished vehicle is staged at a vehicle compound before outbound transport. Build-to-compound assignment drives PDI scheduling, yard management, and outbound logisti',
    `vin_registry_id` BIGINT COMMENT 'FK to VIN registry',
    `andon_call_count` STRING COMMENT 'Total andon calls during this vehicle build.',
    `battery_serial_number` STRING COMMENT 'Battery serial number',
    `body_shop_end_timestamp` TIMESTAMP COMMENT 'Body shop end',
    `body_shop_start_timestamp` TIMESTAMP COMMENT 'Body shop start',
    `body_style` STRING COMMENT 'Body style',
    `build_carbon_footprint_kg` DECIMAL(18,2) COMMENT 'Build carbon footprint kg',
    `build_end_timestamp` TIMESTAMP COMMENT 'Build end timestamp',
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
    `vin` STRING COMMENT 'VIN',
    CONSTRAINT pk_vehicle_build PRIMARY KEY(`vehicle_build_id`)
) COMMENT 'Individual vehicle build record tracking the manufacturing lifecycle from body shop through final assembly';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` (
    `production_schedule_id` BIGINT COMMENT 'Primary key',
    `fleet_contract_id` BIGINT COMMENT 'Foreign key linking to sales.fleet_contract. Business justification: Fleet contracts commit to specific delivery volumes by period. Production schedules must be aligned to fleet contract commitments for volume fulfillment tracking and capacity allocation. This link ena',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to engineering.milestone. Business justification: Production schedules in automotive are gated by engineering program milestones — production cannot be scheduled before SOP milestone approval. This FK enables milestone-gated scheduling and program ma',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `platform_id` BIGINT COMMENT 'Foreign key linking to vehicle.platform. Business justification: Production schedules are platform-specific — a platform determines which models can be built on which lines and constrains mixed-model scheduling. Platform-level scheduling enables capacity planning a',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: Production scheduling requires the exact powertrain variant to allocate correct tooling, energy budgets, and takt time. powertrain_type is a denormalized string; a proper FK enables MES-driven variant',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` (
    `production_bom_id` BIGINT COMMENT 'Primary key',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: The production BOM is derived from the product/engineering BOM header during manufacturing release. Tracing production_bom back to bom_header is essential for BOM change impact analysis, ECO (Engineer',
    `bom_id` BIGINT COMMENT 'FK to engineering BOM',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Each production BOM version is created or revised in response to an Engineering Change Order (ECO). Linking production_bom to the triggering change enables ECO implementation traceability in manufactu',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to vehicle.configuration. Business justification: Production BOMs are configuration-specific — market variant, trim level, and option packages determine which components are included. Linking production_bom to configuration enables configurable manuf',
    `model_id` BIGINT COMMENT 'FK to vehicle model',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: The production BOM header references the output finished-good SKU it produces — fundamental for MRP explosion, material cost rollups, and BOM-to-inventory availability checks. Role-prefix output_ us',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Production BOM is built around a specific engineering part/material. Linking to part_master enables ECO impact analysis — when an engineering change affects a part, all production BOMs referencing it ',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Production BOMs (MBOM) are plant-specific configurations derived from the engineering BOM. production_bom currently stores plant_code as a STRING denormalized reference. Adding plant_id FK to manufact',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: Production BOMs are powertrain-variant-specific — EV and ICE BOMs differ significantly in components, assembly operations, and material costs. Linking production_bom to powertrain_variant enables vari',
    `base_quantity` DECIMAL(18,2) COMMENT 'Base quantity',
    `base_unit_of_measure` STRING COMMENT 'Base unit of measure',
    `bom_description` STRING COMMENT 'BOM description',
    `bom_status` STRING COMMENT 'BOM status',
    `bom_type` STRING COMMENT 'BOM type',
    `bom_version` STRING COMMENT 'BOM version',
    `component_count` STRING COMMENT 'Component count',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `effectivity_end_date` DATE COMMENT 'Effectivity end date',
    `effectivity_start_date` DATE COMMENT 'Effectivity start date',
    `is_configurable` BOOLEAN COMMENT 'Is configurable',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `model_year` STRING COMMENT 'Model year',
    `recyclability_pct` DECIMAL(18,2) COMMENT 'Recyclability percentage',
    CONSTRAINT pk_production_bom PRIMARY KEY(`production_bom_id`)
) COMMENT 'Production bill of materials (MBOM) derived from engineering BOM with plant-specific configurations';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` (
    `material_consumption_id` BIGINT COMMENT 'Primary key',
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
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Rework orders are raised for defects on specific parts. Linking to part_master enables engineering to track manufacturing defect rates by part — directly feeds FMEA RPN updates, design improvement dec',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_order_id` BIGINT COMMENT 'FK to production order',
    `recall_campaign_id` BIGINT COMMENT 'Foreign key linking to compliance.recall_campaign. Business justification: Recall campaigns directly trigger rework orders for affected vehicles. Linking rework_order to recall_campaign enables recall-driven rework cost attribution, completion rate reporting to regulatory bo',
    `vehicle_build_id` BIGINT COMMENT 'Foreign key linking to manufacturing.vehicle_build. Business justification: A rework_order is raised for a specific defective vehicle build unit. vehicle_build has rework_flag and rework_count attributes confirming that rework is tracked at the vehicle build level. Linking re',
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
    `goods_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.goods_movement. Business justification: Production confirmations trigger automatic goods movements (goods receipt for finished output, goods issue for components) in SAP. Linking confirmation to goods_movement enables confirmation-to-invent',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: In automotive SAP/MES integration, production confirmations trigger or reference inspection lots for quality verification at operation completion. This link enables confirmation-to-inspection traceabi',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` (
    `capacity_plan_id` BIGINT COMMENT 'Primary key',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to engineering.milestone. Business justification: Automotive capacity plans are structured around program milestones (SOP, Job1, ramp-up gates). Linking capacity_plan to milestone enables milestone-driven capacity planning — a standard automotive pro',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: Capacity plans are built around specific vehicle model volumes in S&OP (Sales & Operations Planning). Model-level demand drives required capacity hours, operator counts, and energy budgets. This link ',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `production_line_id` BIGINT COMMENT 'FK to production line',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Capacity planning in automotive is always executed per vehicle program — capacity is allocated to support a specific programs launch volume and ramp-up. Without this FK, capacity plans cannot be aggr',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: Capacity planning in automotive manufacturing operates at the work center level, not just at the production line level. Work centers are the granular capacity units (individual stations with defined a',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`routing` (
    `routing_id` BIGINT COMMENT 'Primary key',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: In automotive SAP PP, a routing is directly associated with a BOM header — the routing defines the manufacturing operations to produce what the BOM specifies. This link enables standard cost calculati',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Engineering changes (ECOs) that affect part geometry or process parameters require routing updates. Linking routing to the implementing change enables manufacturing process change control traceability',
    `control_plan_id` BIGINT COMMENT 'Foreign key linking to quality.control_plan. Business justification: In automotive APQP/PPAP, each routing (process flow) must reference its corresponding control plan — this is a mandatory PPAP Package element. Linking routing to control_plan enables PPAP documentatio',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Routing operations must conform to engineering design specifications (torque specs, weld parameters, surface finish). Linking routing to design_specification enables process validation traceability — ',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: Routings define the model-specific sequence of manufacturing operations (body shop, paint, final assembly). Different models require different operation sequences and cycle times. Linking routing to m',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Routings define manufacturing operations for a specific part or assembly. Linking routing to part_master enables process planning traceability — when an ECO changes a part, manufacturing identifies wh',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `platform_id` BIGINT COMMENT 'Foreign key linking to vehicle.platform. Business justification: Routings are platform-specific — the sequence of manufacturing operations (body shop geometry, weld schedules, paint process) is determined by the vehicle platform architecture. Platform-level routing',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` (
    `routing_operation_id` BIGINT COMMENT 'Primary key for the routing_operation association',
    `routing_id` BIGINT COMMENT 'Foreign key linking to the routing header that this operation step belongs to',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to the work center that executes this operation step',
    `operation_description` STRING COMMENT 'Human-readable description of the manufacturing operation performed at this step (e.g., Robotic MIG weld door hinge bracket). Specific to this routing-work center combination.',
    `operation_number` STRING COMMENT 'Sequence number of this operation within the routing (e.g., 0010, 0020, 0030 in SAP PP convention). Determines the execution order of work centers within the routing.',
    `setup_time_minutes` DECIMAL(18,2) COMMENT 'Time in minutes required to set up the work center before executing this operation for this routing. Varies by routing-work center combination.',
    `standard_time_seconds` DECIMAL(18,2) COMMENT 'Standard cycle time in seconds for this specific operation at this specific work center within this routing. Belongs to the operation step, not to the routing header or work center master.',
    `teardown_time_minutes` DECIMAL(18,2) COMMENT 'Time in minutes required to tear down or reset the work center after completing this operation for this routing.',
    `work_instruction_reference` STRING COMMENT 'Reference to the digital work instruction document governing this specific operation step. Links to the MES work instruction system for operator guidance at this work center for this routing.',
    CONSTRAINT pk_routing_operation PRIMARY KEY(`routing_operation_id`)
) COMMENT 'This association product represents the Operation Step between routing and work_center. It captures each discrete manufacturing operation within a routing sequence, specifying which work center executes it, in what order, and with what time standards. Each record links one routing to one work center for a specific operation step, carrying attributes (operation number, standard times, work instructions) that exist only in the context of this routing-to-work-center assignment. Corresponds to SAP PP PLPO table and IATF 16949 process flow traceability requirements.. Existence Justification: In automotive manufacturing, a routing defines the sequence of operations to produce a part, and each operation step is executed at a specific work center. A single routing visits multiple work centers (e.g., stamping → welding → painting → assembly), and a single work center executes operations for many different routings across different vehicle programs. This is the canonical routing operation concept in SAP PP (PLPO table) and every automotive MES — it is an actively managed operational record, not an analytical correlation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ADD CONSTRAINT `fk_manufacturing_production_line_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ADD CONSTRAINT `fk_manufacturing_work_center_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_production_bom_id` FOREIGN KEY (`production_bom_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_bom`(`production_bom_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_production_schedule_id` FOREIGN KEY (`production_schedule_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_schedule`(`production_schedule_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ADD CONSTRAINT `fk_manufacturing_production_order_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ADD CONSTRAINT `fk_manufacturing_build_sequence_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_build_sequence_id` FOREIGN KEY (`build_sequence_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`build_sequence`(`build_sequence_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ADD CONSTRAINT `fk_manufacturing_vehicle_build_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ADD CONSTRAINT `fk_manufacturing_production_schedule_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ADD CONSTRAINT `fk_manufacturing_production_bom_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` ADD CONSTRAINT `fk_manufacturing_material_consumption_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_vehicle_build_id` FOREIGN KEY (`vehicle_build_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`vehicle_build`(`vehicle_build_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ADD CONSTRAINT `fk_manufacturing_rework_order_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_production_order_id` FOREIGN KEY (`production_order_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_order`(`production_order_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ADD CONSTRAINT `fk_manufacturing_production_confirmation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_production_line_id` FOREIGN KEY (`production_line_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`production_line`(`production_line_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ADD CONSTRAINT `fk_manufacturing_capacity_plan_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ADD CONSTRAINT `fk_manufacturing_routing_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`plant`(`plant_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` ADD CONSTRAINT `fk_manufacturing_routing_operation_routing_id` FOREIGN KEY (`routing_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`routing`(`routing_id`);
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` ADD CONSTRAINT `fk_manufacturing_routing_operation_work_center_id` FOREIGN KEY (`work_center_id`) REFERENCES `vibe_automotive_v1`.`manufacturing`.`work_center`(`work_center_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`manufacturing` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_automotive_v1`.`manufacturing` SET TAGS ('dbx_domain' = 'manufacturing');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`plant` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Segment Product Segment Id (Foreign Key)');
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
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ALTER COLUMN `andon_system_type` SET TAGS ('dbx_business_glossary_term' = 'Andon System Type');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ALTER COLUMN `cycle_time_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Tracking Enabled');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_line` ALTER COLUMN `work_instruction_digital_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Instruction Digital Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `andon_enabled` SET TAGS ('dbx_business_glossary_term' = 'Andon Enabled');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `mes_station_count` SET TAGS ('dbx_business_glossary_term' = 'MES Station Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`work_center` ALTER COLUMN `poka_yoke_count` SET TAGS ('dbx_business_glossary_term' = 'Poka-Yoke Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` SET TAGS ('dbx_subdomain' = 'assembly_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealership Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `fleet_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Fleet Account Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `homologation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `vehicle_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `mes_sync_status` SET TAGS ('dbx_business_glossary_term' = 'MES Sync Status');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_order` ALTER COLUMN `total_cycle_time_planned_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Cycle Time Planned Seconds');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` SET TAGS ('dbx_subdomain' = 'assembly_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealership Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ALTER COLUMN `operator_assignment_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Operator Assignment Confirmed');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`build_sequence` ALTER COLUMN `work_instruction_version` SET TAGS ('dbx_business_glossary_term' = 'Work Instruction Version');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` SET TAGS ('dbx_subdomain' = 'assembly_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `build_sequence_id` SET TAGS ('dbx_business_glossary_term' = 'Build Sequence Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `build_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Build Spec Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `finished_vehicle_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Vehicle Stock Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Campaign Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `vehicle_compound_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Compound Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `andon_call_count` SET TAGS ('dbx_business_glossary_term' = 'Andon Call Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `mes_build_ref` SET TAGS ('dbx_business_glossary_term' = 'MES Build Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`vehicle_build` ALTER COLUMN `total_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Cycle Time Seconds');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` SET TAGS ('dbx_subdomain' = 'assembly_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ALTER COLUMN `fleet_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Contract Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ALTER COLUMN `mes_schedule_ref` SET TAGS ('dbx_business_glossary_term' = 'MES Schedule Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_schedule` ALTER COLUMN `operator_availability_count` SET TAGS ('dbx_business_glossary_term' = 'Operator Availability Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` SET TAGS ('dbx_subdomain' = 'assembly_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Output Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_bom` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` SET TAGS ('dbx_subdomain' = 'assembly_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`material_consumption` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` SET TAGS ('dbx_subdomain' = 'assembly_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Campaign Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ALTER COLUMN `vehicle_build_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Build Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`rework_order` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` SET TAGS ('dbx_subdomain' = 'assembly_execution');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `cycle_time_actual_seconds` SET TAGS ('dbx_business_glossary_term' = 'Actual Cycle Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `energy_consumed_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumed');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `mes_confirmation_ref` SET TAGS ('dbx_business_glossary_term' = 'MES Confirmation Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `oee_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'OEE Contribution Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`production_confirmation` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `cycle_time_constraint_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Constraint Seconds');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `energy_budget_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Budget');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `oee_target_pct` SET TAGS ('dbx_business_glossary_term' = 'OEE Target');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`capacity_plan` ALTER COLUMN `operator_requirement_count` SET TAGS ('dbx_business_glossary_term' = 'Operator Requirement Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `mes_routing_code` SET TAGS ('dbx_business_glossary_term' = 'MES Routing Code');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `mes_routing_ref` SET TAGS ('dbx_business_glossary_term' = 'MES Routing Reference');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `total_standard_cycle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Standard Cycle Time Seconds');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `work_instruction_count` SET TAGS ('dbx_business_glossary_term' = 'Work Instruction Count');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing` ALTER COLUMN `work_instruction_linked_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Instruction Linked Flag');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` SET TAGS ('dbx_association_edges' = 'manufacturing.routing,manufacturing.work_center');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` ALTER COLUMN `routing_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Operation - Routing Operation Id');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` ALTER COLUMN `routing_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Operation - Routing Id');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Operation - Work Center Id');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` ALTER COLUMN `operation_description` SET TAGS ('dbx_business_glossary_term' = 'Operation Description');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` ALTER COLUMN `operation_number` SET TAGS ('dbx_business_glossary_term' = 'Operation Number');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` ALTER COLUMN `setup_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Setup Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` ALTER COLUMN `standard_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Standard Operation Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` ALTER COLUMN `teardown_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Teardown Time');
ALTER TABLE `vibe_automotive_v1`.`manufacturing`.`routing_operation` ALTER COLUMN `work_instruction_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Instruction Reference');
