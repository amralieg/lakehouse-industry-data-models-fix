-- Schema for Domain: wastewater | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 18:57:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`wastewater` COMMENT 'Manages wastewater collection, conveyance, and treatment operations including sewer network topology, gravity sewers, force mains, lift stations, manholes, CSO/SSO management, I&I monitoring, FOG program management, industrial user permits (IUP), and NPDES compliance tracking. Supports DMR submissions and biosolids management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` (
    `sewer_network_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'FK to capital project',
    `compliance_permit_id` BIGINT COMMENT 'FK to permit',
    `fixed_asset_id` BIGINT COMMENT 'FK to fixed asset',
    `material_master_id` BIGINT COMMENT 'FK to material master',
    `manhole_id` BIGINT COMMENT 'FK to upstream manhole',
    `sewershed_basin_id` BIGINT COMMENT 'FK to sewershed basin',
    `wwtp_id` BIGINT COMMENT 'FK to wastewater treatment plant',
    `asset_tag` STRING COMMENT 'Asset tag',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'Average daily flow in MGD',
    `condition_grade` STRING COMMENT 'Condition grade',
    `coordinate_system` STRING COMMENT 'Coordinate system',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `criticality_score` STRING COMMENT 'Criticality score',
    `data_source` STRING COMMENT 'Data source',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Design capacity in MGD',
    `diameter_inches` DECIMAL(18,2) COMMENT 'Diameter in inches',
    `downstream_invert_elevation_feet` DECIMAL(18,2) COMMENT 'Downstream invert elevation in feet',
    `easement_required_flag` BOOLEAN COMMENT 'Easement required flag',
    `fog_risk_flag` BOOLEAN COMMENT 'FOG risk flag',
    `gis_geometry_wkt` STRING COMMENT 'GIS geometry WKT',
    `hydrogen_sulfide_risk_flag` BOOLEAN COMMENT 'Hydrogen sulfide risk flag',
    `installation_year` STRING COMMENT 'Installation year',
    `last_inspection_date` DATE COMMENT 'Last inspection date',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `length_feet` DECIMAL(18,2) COMMENT 'Length in feet',
    `lining_installation_date` DATE COMMENT 'Lining installation date',
    `lining_type` STRING COMMENT 'Lining type',
    `next_inspection_due_date` DATE COMMENT 'Next inspection due date',
    `notes` STRING COMMENT 'Notes',
    `operational_status` DECIMAL(18,2) COMMENT 'Operational status',
    `ownership_type` STRING COMMENT 'Ownership type',
    `peak_flow_gpm` DECIMAL(18,2) COMMENT 'Peak flow in GPM',
    `replacement_cost_usd` DECIMAL(18,2) COMMENT 'Replacement cost in USD',
    `root_intrusion_flag` BOOLEAN COMMENT 'Root intrusion flag',
    `segment_identifier` STRING COMMENT 'Segment identifier',
    `segment_type` STRING COMMENT 'Segment type',
    `slope_percent` DECIMAL(18,2) COMMENT 'Slope in percent',
    `sso_history_count` STRING COMMENT 'SSO history count',
    `traffic_impact_level` STRING COMMENT 'Traffic impact level',
    `upstream_invert_elevation_feet` DECIMAL(18,2) COMMENT 'Upstream invert elevation in feet',
    CONSTRAINT pk_sewer_network PRIMARY KEY(`sewer_network_id`)
) COMMENT 'Sewer pipe segments in the collection system with hydraulic, condition, and GIS attributes';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` (
    `manhole_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'FK to capital project',
    `fixed_asset_id` BIGINT COMMENT 'FK to fixed asset',
    `material_master_id` BIGINT COMMENT 'FK to material master',
    `registry_id` BIGINT COMMENT 'FK to asset registry',
    `asset_class_code` STRING COMMENT 'Asset class code',
    `basin_code` STRING COMMENT 'Basin code',
    `city` STRING COMMENT 'City',
    `confined_space_flag` BOOLEAN COMMENT 'Confined space flag',
    `cover_type` STRING COMMENT 'Cover type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `depth_feet` DECIMAL(18,2) COMMENT 'Depth in feet',
    `diameter_inches` DECIMAL(18,2) COMMENT 'Diameter in inches',
    `dma_code` STRING COMMENT 'DMA code',
    `gis_feature_reference` STRING COMMENT 'GIS feature reference',
    `inflow_infiltration_flag` BOOLEAN COMMENT 'Inflow infiltration flag',
    `invert_elevation_feet` DECIMAL(18,2) COMMENT 'Invert elevation in feet',
    `last_inspection_date` DATE COMMENT 'Last inspection date',
    `last_maintenance_date` DATE COMMENT 'Last maintenance date',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude',
    `macp_score` STRING COMMENT 'MACP score',
    `manhole_number` STRING COMMENT 'Manhole number',
    `manhole_status` STRING COMMENT 'Manhole status',
    `manhole_type` STRING COMMENT 'Manhole type',
    `next_inspection_date` DATE COMMENT 'Next inspection date',
    `notes` STRING COMMENT 'Notes',
    `ownership` STRING COMMENT 'Ownership',
    `postal_code` STRING COMMENT 'Postal code',
    `rim_elevation_feet` DECIMAL(18,2) COMMENT 'Rim elevation in feet',
    `scada_monitored_flag` BOOLEAN COMMENT 'SCADA monitored flag',
    `sso_history_flag` BOOLEAN COMMENT 'SSO history flag',
    `state_province` STRING COMMENT 'State province',
    `street_address` STRING COMMENT 'Street address',
    `traffic_load_rating` STRING COMMENT 'Traffic load rating',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    CONSTRAINT pk_manhole PRIMARY KEY(`manhole_id`)
) COMMENT 'Manholes providing access to sewer network with condition and GIS attributes';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` (
    `lift_station_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'FK to capital project',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `fixed_asset_id` BIGINT COMMENT 'FK to fixed asset',
    `sampling_location_id` BIGINT COMMENT 'FK to sampling location',
    `scada_tag_id` BIGINT COMMENT 'FK to SCADA tag',
    `annual_operating_cost_usd` DECIMAL(18,2) COMMENT 'Annual operating cost in USD',
    `asset_condition_score` DECIMAL(18,2) COMMENT 'Asset condition score',
    `backup_power_capacity_kw` DECIMAL(18,2) COMMENT 'Backup power capacity in kW',
    `backup_power_type` STRING COMMENT 'Backup power type',
    `city` STRING COMMENT 'City',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `criticality_rating` STRING COMMENT 'Criticality rating',
    `design_capacity_gpm` DECIMAL(18,2) COMMENT 'Design capacity in GPM',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Design capacity in MGD',
    `expected_useful_life_years` STRING COMMENT 'Expected useful life in years',
    `force_main_diameter_inches` DECIMAL(18,2) COMMENT 'Force main diameter in inches',
    `force_main_length_feet` DECIMAL(18,2) COMMENT 'Force main length in feet',
    `force_main_material` STRING COMMENT 'Force main material',
    `installation_date` DATE COMMENT 'Installation date',
    `last_inspection_date` DATE COMMENT 'Last inspection date',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `last_rehabilitation_date` DATE COMMENT 'Last rehabilitation date',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude',
    `next_scheduled_maintenance_date` DATE COMMENT 'Next scheduled maintenance date',
    `notes` STRING COMMENT 'Notes',
    `number_of_pumps` STRING COMMENT 'Number of pumps',
    `operational_status` DECIMAL(18,2) COMMENT 'Operational status',
    `ownership_type` STRING COMMENT 'Ownership type',
    `postal_code` STRING COMMENT 'Postal code',
    `pump_configuration` DECIMAL(18,2) COMMENT 'Pump configuration',
    `pump_horsepower` DECIMAL(18,2) COMMENT 'Pump horsepower',
    `replacement_cost_usd` DECIMAL(18,2) COMMENT 'Replacement cost in USD',
    `scada_integration_flag` BOOLEAN COMMENT 'SCADA integration flag',
    `service_area_name` STRING COMMENT 'Service area name',
    `service_area_population` STRING COMMENT 'Service area population',
    `sso_risk_flag` BOOLEAN COMMENT 'SSO risk flag',
    `state_province` STRING COMMENT 'State province',
    `station_code` STRING COMMENT 'Station code',
    `station_name` STRING COMMENT 'Station name',
    `station_type` STRING COMMENT 'Station type',
    `street_address` STRING COMMENT 'Street address',
    `telemetry_status` STRING COMMENT 'Telemetry status',
    `total_dynamic_head_feet` DECIMAL(18,2) COMMENT 'Total dynamic head in feet',
    `wet_well_volume_gallons` DECIMAL(18,2) COMMENT 'Wet well volume in gallons',
    CONSTRAINT pk_lift_station PRIMARY KEY(`lift_station_id`)
) COMMENT 'Lift stations pumping wastewater with capacity, condition, and operational attributes';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` (
    `wwtp_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'FK to capital project',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `fixed_asset_id` BIGINT COMMENT 'FK to fixed asset',
    `sampling_location_id` BIGINT COMMENT 'FK to sampling location',
    `warehouse_location_id` BIGINT COMMENT 'FK to warehouse location',
    `registry_id` BIGINT COMMENT 'FK to asset registry',
    `wwtp_registry_id` BIGINT COMMENT 'FK to asset registry',
    `address_line_1` STRING COMMENT 'Address line 1',
    `address_line_2` STRING COMMENT 'Address line 2',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'Average daily flow in MGD',
    `biosolids_class` STRING COMMENT 'Biosolids class',
    `biosolids_management_method` STRING COMMENT 'Biosolids management method',
    `city` STRING COMMENT 'City',
    `commissioning_date` DATE COMMENT 'Commissioning date',
    `compliance_status` STRING COMMENT 'Compliance status',
    `country_code` STRING COMMENT 'Country code',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Design capacity in MGD',
    `disinfection_method` STRING COMMENT 'Disinfection method',
    `effluent_discharge_point` DECIMAL(18,2) COMMENT 'Effluent discharge point',
    `energy_consumption_kwh_per_mg` DECIMAL(18,2) COMMENT 'Energy consumption in kWh per MG',
    `facility_code` STRING COMMENT 'Facility code',
    `facility_email` STRING COMMENT 'Facility email',
    `facility_name` STRING COMMENT 'Facility name',
    `facility_phone` STRING COMMENT 'Facility phone',
    `facility_type` STRING COMMENT 'Facility type',
    `gis_feature_reference` STRING COMMENT 'GIS feature reference',
    `last_inspection_date` DATE COMMENT 'Last inspection date',
    `last_major_upgrade_date` DATE COMMENT 'Last major upgrade date',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude',
    `notes` STRING COMMENT 'Notes',
    `npdes_permit_number` STRING COMMENT 'NPDES permit number',
    `operational_status` DECIMAL(18,2) COMMENT 'Operational status',
    `operator_certification_level` STRING COMMENT 'Operator certification level',
    `operator_certification_required` BOOLEAN COMMENT 'Operator certification required',
    `peak_flow_mgd` DECIMAL(18,2) COMMENT 'Peak flow in MGD',
    `permit_effective_date` DATE COMMENT 'Permit effective date',
    `permit_expiration_date` DATE COMMENT 'Permit expiration date',
    `postal_code` STRING COMMENT 'Postal code',
    `receiving_water_body` STRING COMMENT 'Receiving water body',
    `receiving_water_classification` STRING COMMENT 'Receiving water classification',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record created timestamp',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Record updated timestamp',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory jurisdiction',
    `scada_system_reference` STRING COMMENT 'SCADA system reference',
    `state_province` STRING COMMENT 'State province',
    `treatment_level` STRING COMMENT 'Treatment level',
    `treatment_process_description` STRING COMMENT 'Treatment process description',
    CONSTRAINT pk_wwtp PRIMARY KEY(`wwtp_id`)
) COMMENT 'Wastewater treatment plants with capacity, permit, and operational attributes';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` (
    `industrial_user_permit_id` BIGINT COMMENT 'Primary key',
    `extra_info` STRING COMMENT 'Added to avoid stub',
    `industrial_user_permit_name` STRING COMMENT 'Human readable name.',
    `industrial_user_permit_description` STRING COMMENT 'Free-text description.',
    `industrial_user_permit_code` STRING COMMENT 'Short code identifier.',
    `industrial_user_permit_status` STRING COMMENT 'Current lifecycle status.',
    `status_reason` STRING COMMENT 'Reason for the current status.',
    `industrial_user_permit_category` STRING COMMENT 'Classification category.',
    `subcategory` STRING COMMENT 'Secondary classification.',
    `type_code` STRING COMMENT 'Type classification code.',
    `priority` STRING COMMENT 'Priority level.',
    `quantity` STRING COMMENT 'Quantity value.',
    `amount` STRING COMMENT 'Monetary or numeric amount.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `measured_value` STRING COMMENT 'Measured numeric value.',
    `measured_unit` STRING COMMENT 'Unit of the measured value.',
    `min_value` STRING COMMENT 'Minimum threshold value.',
    `max_value` STRING COMMENT 'Maximum threshold value.',
    `target_value` STRING COMMENT 'Target value.',
    `percent_value` STRING COMMENT 'Percentage value.',
    `latitude` STRING COMMENT 'Geographic latitude.',
    `longitude` STRING COMMENT 'Geographic longitude.',
    `address_line` STRING COMMENT 'Address line text.',
    `region` STRING COMMENT 'Region designation.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `start_timestamp` TIMESTAMP COMMENT 'Start timestamp.',
    `end_timestamp` TIMESTAMP COMMENT 'End timestamp.',
    `recorded_at` TIMESTAMP COMMENT 'When the record was captured.',
    `due_date` DATE COMMENT 'Due date.',
    `completed_date` DATE COMMENT 'Completion date.',
    `is_active` BOOLEAN COMMENT 'Active flag.',
    `is_verified` BOOLEAN COMMENT 'Verification flag.',
    `sequence_number` BIGINT COMMENT 'Ordering sequence number.',
    `version_number` BIGINT COMMENT 'Record version number.',
    `source_system` STRING COMMENT 'Originating source system.',
    `external_reference` STRING COMMENT 'External reference identifier.',
    `notes` STRING COMMENT 'Additional notes.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `updated_at` TIMESTAMP COMMENT 'Last update timestamp.',
    `updated_by` STRING COMMENT 'Last updater identity.',
    `created_by` STRING COMMENT 'Creator identity.',
    CONSTRAINT pk_industrial_user_permit PRIMARY KEY(`industrial_user_permit_id`)
) COMMENT 'Industrial User Permit entity';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` (
    `fog_source_id` BIGINT COMMENT 'Primary key',
    `extra_info` STRING COMMENT 'Added to avoid stub',
    `fog_source_name` STRING COMMENT 'Human readable name.',
    `fog_source_description` STRING COMMENT 'Free-text description.',
    `fog_source_code` STRING COMMENT 'Short code identifier.',
    `fog_source_status` STRING COMMENT 'Current lifecycle status.',
    `status_reason` STRING COMMENT 'Reason for the current status.',
    `fog_source_category` STRING COMMENT 'Classification category.',
    `subcategory` STRING COMMENT 'Secondary classification.',
    `type_code` STRING COMMENT 'Type classification code.',
    `priority` STRING COMMENT 'Priority level.',
    `quantity` STRING COMMENT 'Quantity value.',
    `amount` STRING COMMENT 'Monetary or numeric amount.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `measured_value` STRING COMMENT 'Measured numeric value.',
    `measured_unit` STRING COMMENT 'Unit of the measured value.',
    `min_value` STRING COMMENT 'Minimum threshold value.',
    `max_value` STRING COMMENT 'Maximum threshold value.',
    `target_value` STRING COMMENT 'Target value.',
    `percent_value` STRING COMMENT 'Percentage value.',
    `latitude` STRING COMMENT 'Geographic latitude.',
    `longitude` STRING COMMENT 'Geographic longitude.',
    `address_line` STRING COMMENT 'Address line text.',
    `region` STRING COMMENT 'Region designation.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `start_timestamp` TIMESTAMP COMMENT 'Start timestamp.',
    `end_timestamp` TIMESTAMP COMMENT 'End timestamp.',
    `recorded_at` TIMESTAMP COMMENT 'When the record was captured.',
    `due_date` DATE COMMENT 'Due date.',
    `completed_date` DATE COMMENT 'Completion date.',
    `is_active` BOOLEAN COMMENT 'Active flag.',
    `is_verified` BOOLEAN COMMENT 'Verification flag.',
    `sequence_number` BIGINT COMMENT 'Ordering sequence number.',
    `version_number` BIGINT COMMENT 'Record version number.',
    `source_system` STRING COMMENT 'Originating source system.',
    `external_reference` STRING COMMENT 'External reference identifier.',
    `notes` STRING COMMENT 'Additional notes.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `updated_at` TIMESTAMP COMMENT 'Last update timestamp.',
    `updated_by` STRING COMMENT 'Last updater identity.',
    `created_by` STRING COMMENT 'Creator identity.',
    CONSTRAINT pk_fog_source PRIMARY KEY(`fog_source_id`)
) COMMENT 'Fog Source entity';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` (
    `dmr_submission_id` BIGINT COMMENT 'Primary key',
    `extra_info` STRING COMMENT 'Added to avoid stub',
    `dmr_submission_name` STRING COMMENT 'Human readable name.',
    `dmr_submission_description` STRING COMMENT 'Free-text description.',
    `dmr_submission_code` STRING COMMENT 'Short code identifier.',
    `dmr_submission_status` STRING COMMENT 'Current lifecycle status.',
    `status_reason` STRING COMMENT 'Reason for the current status.',
    `dmr_submission_category` STRING COMMENT 'Classification category.',
    `subcategory` STRING COMMENT 'Secondary classification.',
    `type_code` STRING COMMENT 'Type classification code.',
    `priority` STRING COMMENT 'Priority level.',
    `quantity` STRING COMMENT 'Quantity value.',
    `amount` STRING COMMENT 'Monetary or numeric amount.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `measured_value` STRING COMMENT 'Measured numeric value.',
    `measured_unit` STRING COMMENT 'Unit of the measured value.',
    `min_value` STRING COMMENT 'Minimum threshold value.',
    `max_value` STRING COMMENT 'Maximum threshold value.',
    `target_value` STRING COMMENT 'Target value.',
    `percent_value` STRING COMMENT 'Percentage value.',
    `latitude` STRING COMMENT 'Geographic latitude.',
    `longitude` STRING COMMENT 'Geographic longitude.',
    `address_line` STRING COMMENT 'Address line text.',
    `region` STRING COMMENT 'Region designation.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `start_timestamp` TIMESTAMP COMMENT 'Start timestamp.',
    `end_timestamp` TIMESTAMP COMMENT 'End timestamp.',
    `recorded_at` TIMESTAMP COMMENT 'When the record was captured.',
    `due_date` DATE COMMENT 'Due date.',
    `completed_date` DATE COMMENT 'Completion date.',
    `is_active` BOOLEAN COMMENT 'Active flag.',
    `is_verified` BOOLEAN COMMENT 'Verification flag.',
    `sequence_number` BIGINT COMMENT 'Ordering sequence number.',
    `version_number` BIGINT COMMENT 'Record version number.',
    `source_system` STRING COMMENT 'Originating source system.',
    `external_reference` STRING COMMENT 'External reference identifier.',
    `notes` STRING COMMENT 'Additional notes.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `updated_at` TIMESTAMP COMMENT 'Last update timestamp.',
    `updated_by` STRING COMMENT 'Last updater identity.',
    `created_by` STRING COMMENT 'Creator identity.',
    CONSTRAINT pk_dmr_submission PRIMARY KEY(`dmr_submission_id`)
) COMMENT 'Dmr Submission entity';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` (
    `outfall_id` BIGINT COMMENT 'Primary key',
    `extra_info` STRING COMMENT 'Added to avoid stub',
    `outfall_name` STRING COMMENT 'Human readable name.',
    `outfall_description` STRING COMMENT 'Free-text description.',
    `outfall_code` STRING COMMENT 'Short code identifier.',
    `outfall_status` STRING COMMENT 'Current lifecycle status.',
    `status_reason` STRING COMMENT 'Reason for the current status.',
    `outfall_category` STRING COMMENT 'Classification category.',
    `subcategory` STRING COMMENT 'Secondary classification.',
    `type_code` STRING COMMENT 'Type classification code.',
    `priority` STRING COMMENT 'Priority level.',
    `quantity` STRING COMMENT 'Quantity value.',
    `amount` STRING COMMENT 'Monetary or numeric amount.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `measured_value` STRING COMMENT 'Measured numeric value.',
    `measured_unit` STRING COMMENT 'Unit of the measured value.',
    `min_value` STRING COMMENT 'Minimum threshold value.',
    `max_value` STRING COMMENT 'Maximum threshold value.',
    `target_value` STRING COMMENT 'Target value.',
    `percent_value` STRING COMMENT 'Percentage value.',
    `latitude` STRING COMMENT 'Geographic latitude.',
    `longitude` STRING COMMENT 'Geographic longitude.',
    `address_line` STRING COMMENT 'Address line text.',
    `region` STRING COMMENT 'Region designation.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `start_timestamp` TIMESTAMP COMMENT 'Start timestamp.',
    `end_timestamp` TIMESTAMP COMMENT 'End timestamp.',
    `recorded_at` TIMESTAMP COMMENT 'When the record was captured.',
    `due_date` DATE COMMENT 'Due date.',
    `completed_date` DATE COMMENT 'Completion date.',
    `is_active` BOOLEAN COMMENT 'Active flag.',
    `is_verified` BOOLEAN COMMENT 'Verification flag.',
    `sequence_number` BIGINT COMMENT 'Ordering sequence number.',
    `version_number` BIGINT COMMENT 'Record version number.',
    `source_system` STRING COMMENT 'Originating source system.',
    `external_reference` STRING COMMENT 'External reference identifier.',
    `notes` STRING COMMENT 'Additional notes.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `updated_at` TIMESTAMP COMMENT 'Last update timestamp.',
    `updated_by` STRING COMMENT 'Last updater identity.',
    `created_by` STRING COMMENT 'Creator identity.',
    CONSTRAINT pk_outfall PRIMARY KEY(`outfall_id`)
) COMMENT 'Outfall entity';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` (
    `grease_interceptor_id` BIGINT COMMENT 'Primary key',
    `extra_info` STRING COMMENT 'Added to avoid stub',
    `grease_interceptor_name` STRING COMMENT 'Human readable name.',
    `grease_interceptor_description` STRING COMMENT 'Free-text description.',
    `grease_interceptor_code` STRING COMMENT 'Short code identifier.',
    `grease_interceptor_status` STRING COMMENT 'Current lifecycle status.',
    `status_reason` STRING COMMENT 'Reason for the current status.',
    `grease_interceptor_category` STRING COMMENT 'Classification category.',
    `subcategory` STRING COMMENT 'Secondary classification.',
    `type_code` STRING COMMENT 'Type classification code.',
    `priority` STRING COMMENT 'Priority level.',
    `quantity` STRING COMMENT 'Quantity value.',
    `amount` STRING COMMENT 'Monetary or numeric amount.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `measured_value` STRING COMMENT 'Measured numeric value.',
    `measured_unit` STRING COMMENT 'Unit of the measured value.',
    `min_value` STRING COMMENT 'Minimum threshold value.',
    `max_value` STRING COMMENT 'Maximum threshold value.',
    `target_value` STRING COMMENT 'Target value.',
    `percent_value` STRING COMMENT 'Percentage value.',
    `latitude` STRING COMMENT 'Geographic latitude.',
    `longitude` STRING COMMENT 'Geographic longitude.',
    `address_line` STRING COMMENT 'Address line text.',
    `region` STRING COMMENT 'Region designation.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `start_timestamp` TIMESTAMP COMMENT 'Start timestamp.',
    `end_timestamp` TIMESTAMP COMMENT 'End timestamp.',
    `recorded_at` TIMESTAMP COMMENT 'When the record was captured.',
    `due_date` DATE COMMENT 'Due date.',
    `completed_date` DATE COMMENT 'Completion date.',
    `is_active` BOOLEAN COMMENT 'Active flag.',
    `is_verified` BOOLEAN COMMENT 'Verification flag.',
    `sequence_number` BIGINT COMMENT 'Ordering sequence number.',
    `version_number` BIGINT COMMENT 'Record version number.',
    `source_system` STRING COMMENT 'Originating source system.',
    `external_reference` STRING COMMENT 'External reference identifier.',
    `notes` STRING COMMENT 'Additional notes.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `updated_at` TIMESTAMP COMMENT 'Last update timestamp.',
    `updated_by` STRING COMMENT 'Last updater identity.',
    `created_by` STRING COMMENT 'Creator identity.',
    CONSTRAINT pk_grease_interceptor PRIMARY KEY(`grease_interceptor_id`)
) COMMENT 'Grease Interceptor entity';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` (
    `sewershed_basin_id` BIGINT COMMENT 'Primary key',
    `extra_info` STRING COMMENT 'Added to avoid stub',
    `sewershed_basin_name` STRING COMMENT 'Human readable name.',
    `sewershed_basin_description` STRING COMMENT 'Free-text description.',
    `sewershed_basin_code` STRING COMMENT 'Short code identifier.',
    `sewershed_basin_status` STRING COMMENT 'Current lifecycle status.',
    `status_reason` STRING COMMENT 'Reason for the current status.',
    `sewershed_basin_category` STRING COMMENT 'Classification category.',
    `subcategory` STRING COMMENT 'Secondary classification.',
    `type_code` STRING COMMENT 'Type classification code.',
    `priority` STRING COMMENT 'Priority level.',
    `quantity` STRING COMMENT 'Quantity value.',
    `amount` STRING COMMENT 'Monetary or numeric amount.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `measured_value` STRING COMMENT 'Measured numeric value.',
    `measured_unit` STRING COMMENT 'Unit of the measured value.',
    `min_value` STRING COMMENT 'Minimum threshold value.',
    `max_value` STRING COMMENT 'Maximum threshold value.',
    `target_value` STRING COMMENT 'Target value.',
    `percent_value` STRING COMMENT 'Percentage value.',
    `latitude` STRING COMMENT 'Geographic latitude.',
    `longitude` STRING COMMENT 'Geographic longitude.',
    `address_line` STRING COMMENT 'Address line text.',
    `region` STRING COMMENT 'Region designation.',
    `effective_date` DATE COMMENT 'Effective date.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `start_timestamp` TIMESTAMP COMMENT 'Start timestamp.',
    `end_timestamp` TIMESTAMP COMMENT 'End timestamp.',
    `recorded_at` TIMESTAMP COMMENT 'When the record was captured.',
    `due_date` DATE COMMENT 'Due date.',
    `completed_date` DATE COMMENT 'Completion date.',
    `is_active` BOOLEAN COMMENT 'Active flag.',
    `is_verified` BOOLEAN COMMENT 'Verification flag.',
    `sequence_number` BIGINT COMMENT 'Ordering sequence number.',
    `version_number` BIGINT COMMENT 'Record version number.',
    `source_system` STRING COMMENT 'Originating source system.',
    `external_reference` STRING COMMENT 'External reference identifier.',
    `notes` STRING COMMENT 'Additional notes.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `updated_at` TIMESTAMP COMMENT 'Last update timestamp.',
    `updated_by` STRING COMMENT 'Last updater identity.',
    `created_by` STRING COMMENT 'Creator identity.',
    CONSTRAINT pk_sewershed_basin PRIMARY KEY(`sewershed_basin_id`)
) COMMENT 'Sewershed Basin entity';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_sewershed_basin_id` FOREIGN KEY (`sewershed_basin_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin`(`sewershed_basin_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`wastewater` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`wastewater` SET TAGS ('dbx_domain' = 'wastewater');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_infrastructure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_collection_system' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Manhole ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `sewershed_basin_id` SET TAGS ('dbx_business_glossary_term' = 'Basin ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'WWTP ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `average_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `coordinate_system` SET TAGS ('dbx_business_glossary_term' = 'Coordinate System');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `criticality_score` SET TAGS ('dbx_business_glossary_term' = 'Criticality Score');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Diameter');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `downstream_invert_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Downstream Invert Elevation');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `easement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Easement Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `fog_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'FOG Risk Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `gis_geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'GIS Geometry WKT');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `hydrogen_sulfide_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Hydrogen Sulfide Risk Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `length_feet` SET TAGS ('dbx_business_glossary_term' = 'Length');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `lining_installation_date` SET TAGS ('dbx_business_glossary_term' = 'Lining Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `lining_type` SET TAGS ('dbx_business_glossary_term' = 'Lining Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `peak_flow_gpm` SET TAGS ('dbx_business_glossary_term' = 'Peak Flow');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `root_intrusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Intrusion Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `segment_identifier` SET TAGS ('dbx_business_glossary_term' = 'Segment Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `segment_type` SET TAGS ('dbx_business_glossary_term' = 'Segment Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `slope_percent` SET TAGS ('dbx_business_glossary_term' = 'Slope');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `sso_history_count` SET TAGS ('dbx_business_glossary_term' = 'SSO History Count');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `traffic_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Traffic Impact Level');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `upstream_invert_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Upstream Invert Elevation');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` SET TAGS ('dbx_infrastructure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` SET TAGS ('dbx_access_point' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `basin_code` SET TAGS ('dbx_business_glossary_term' = 'Basin Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `confined_space_flag` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `cover_type` SET TAGS ('dbx_business_glossary_term' = 'Cover Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `depth_feet` SET TAGS ('dbx_business_glossary_term' = 'Depth');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Diameter');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'DMA Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `gis_feature_reference` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature Reference');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `inflow_infiltration_flag` SET TAGS ('dbx_business_glossary_term' = 'Inflow Infiltration Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `invert_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Invert Elevation');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `macp_score` SET TAGS ('dbx_business_glossary_term' = 'MACP Score');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `manhole_number` SET TAGS ('dbx_business_glossary_term' = 'Manhole Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `manhole_status` SET TAGS ('dbx_business_glossary_term' = 'Manhole Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `manhole_type` SET TAGS ('dbx_business_glossary_term' = 'Manhole Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `ownership` SET TAGS ('dbx_business_glossary_term' = 'Ownership');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `rim_elevation_feet` SET TAGS ('dbx_business_glossary_term' = 'Rim Elevation');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `scada_monitored_flag` SET TAGS ('dbx_business_glossary_term' = 'SCADA Monitored Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `sso_history_flag` SET TAGS ('dbx_business_glossary_term' = 'SSO History Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `street_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `traffic_load_rating` SET TAGS ('dbx_business_glossary_term' = 'Traffic Load Rating');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` SET TAGS ('dbx_asset' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` SET TAGS ('dbx_infrastructure' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` SET TAGS ('dbx_pumping' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `lift_station_id` SET TAGS ('dbx_business_glossary_term' = 'Lift Station ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `sampling_location_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `annual_operating_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Cost');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `asset_condition_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Score');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `backup_power_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Backup Power Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `backup_power_type` SET TAGS ('dbx_business_glossary_term' = 'Backup Power Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `design_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity GPM');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity MGD');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `force_main_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Force Main Diameter');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `force_main_length_feet` SET TAGS ('dbx_business_glossary_term' = 'Force Main Length');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `force_main_material` SET TAGS ('dbx_business_glossary_term' = 'Force Main Material');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `last_rehabilitation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Rehabilitation Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `next_scheduled_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `number_of_pumps` SET TAGS ('dbx_business_glossary_term' = 'Number of Pumps');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `pump_configuration` SET TAGS ('dbx_business_glossary_term' = 'Pump Configuration');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `pump_horsepower` SET TAGS ('dbx_business_glossary_term' = 'Pump Horsepower');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'SCADA Integration Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `service_area_name` SET TAGS ('dbx_business_glossary_term' = 'Service Area Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `service_area_population` SET TAGS ('dbx_business_glossary_term' = 'Service Area Population');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `sso_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'SSO Risk Flag');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `station_name` SET TAGS ('dbx_business_glossary_term' = 'Station Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `station_type` SET TAGS ('dbx_business_glossary_term' = 'Station Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `street_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `telemetry_status` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `total_dynamic_head_feet` SET TAGS ('dbx_business_glossary_term' = 'Total Dynamic Head');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`lift_station` ALTER COLUMN `wet_well_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Wet Well Volume');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_facility' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_treatment' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_npdes' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'WWTP ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `sampling_location_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `wwtp_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `average_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `biosolids_class` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Class');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `biosolids_management_method` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Management Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `disinfection_method` SET TAGS ('dbx_business_glossary_term' = 'Disinfection Method');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `effluent_discharge_point` SET TAGS ('dbx_business_glossary_term' = 'Effluent Discharge Point');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `energy_consumption_kwh_per_mg` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_business_glossary_term' = 'Facility Email');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_phone` SET TAGS ('dbx_business_glossary_term' = 'Facility Phone');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `gis_feature_reference` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature Reference');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `last_major_upgrade_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Upgrade Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `npdes_permit_number` SET TAGS ('dbx_business_glossary_term' = 'NPDES Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `operator_certification_level` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Level');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `operator_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Required');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `peak_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Peak Flow');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `permit_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `permit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `receiving_water_body` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `receiving_water_classification` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Classification');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `scada_system_reference` SET TAGS ('dbx_business_glossary_term' = 'SCADA System Reference');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_business_glossary_term' = 'Treatment Level');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_level` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_process_description` SET TAGS ('dbx_business_glossary_term' = 'Treatment Process Description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_process_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `treatment_process_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_wastewater' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Industrial User Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_name` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_name` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_description` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_description` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_status` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_status` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `status_reason` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `status_reason` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_category` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `industrial_user_permit_category` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `subcategory` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `subcategory` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `type_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `type_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `priority` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `priority` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `quantity` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `quantity` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `amount` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `amount` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `measured_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `measured_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `measured_unit` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `measured_unit` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `min_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `min_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `max_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `max_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `target_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `target_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `percent_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `percent_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `latitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `latitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `longitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `longitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `address_line` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `address_line` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `region` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `region` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `recorded_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `recorded_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `due_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `due_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `completed_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `completed_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `is_active` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `is_active` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `is_verified` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `is_verified` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `sequence_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `sequence_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `version_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `version_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `source_system` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `source_system` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `external_reference` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `external_reference` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `notes` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `notes` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `created_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `created_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `updated_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `updated_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `updated_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `updated_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `created_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`industrial_user_permit` ALTER COLUMN `created_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` SET TAGS ('dbx_wastewater' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `fog_source_id` SET TAGS ('dbx_business_glossary_term' = 'Fog Source ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `fog_source_name` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `fog_source_name` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `fog_source_description` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `fog_source_description` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `fog_source_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `fog_source_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `fog_source_status` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `fog_source_status` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `status_reason` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `status_reason` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `fog_source_category` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `fog_source_category` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `subcategory` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `subcategory` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `type_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `type_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `priority` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `priority` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `quantity` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `quantity` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `amount` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `amount` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `measured_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `measured_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `measured_unit` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `measured_unit` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `min_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `min_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `max_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `max_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `target_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `target_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `percent_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `percent_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `latitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `latitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `longitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `longitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `address_line` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `address_line` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `region` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `region` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `effective_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `effective_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `expiration_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `expiration_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `recorded_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `recorded_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `due_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `due_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `completed_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `completed_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `is_active` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `is_active` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `is_verified` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `is_verified` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `sequence_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `sequence_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `version_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `version_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `source_system` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `source_system` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `external_reference` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `external_reference` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `notes` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `notes` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `created_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `created_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `updated_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `updated_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `updated_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `updated_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `created_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`fog_source` ALTER COLUMN `created_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` SET TAGS ('dbx_wastewater' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Dmr Submission ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submission_name` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submission_name` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submission_description` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submission_description` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submission_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submission_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submission_status` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submission_status` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `status_reason` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `status_reason` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submission_category` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `dmr_submission_category` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `subcategory` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `subcategory` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `type_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `type_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `priority` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `priority` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `quantity` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `quantity` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `amount` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `amount` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `measured_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `measured_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `measured_unit` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `measured_unit` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `min_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `min_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `max_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `max_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `target_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `target_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `percent_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `percent_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `latitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `latitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `longitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `longitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `address_line` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `address_line` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `region` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `region` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `effective_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `effective_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `expiration_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `expiration_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `recorded_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `recorded_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `due_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `due_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `completed_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `completed_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `is_active` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `is_active` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `is_verified` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `is_verified` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `sequence_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `sequence_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `version_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `version_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `source_system` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `source_system` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `external_reference` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `external_reference` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `notes` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `notes` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `created_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `created_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `updated_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `updated_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `updated_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `updated_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `created_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`dmr_submission` ALTER COLUMN `created_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` SET TAGS ('dbx_wastewater' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_id` SET TAGS ('dbx_business_glossary_term' = 'Outfall ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_name` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_name` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_description` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_description` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_status` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_status` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `status_reason` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `status_reason` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_category` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `outfall_category` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `subcategory` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `subcategory` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `type_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `type_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `priority` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `priority` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `quantity` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `quantity` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `amount` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `amount` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `measured_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `measured_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `measured_unit` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `measured_unit` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `min_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `min_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `max_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `max_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `target_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `target_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `percent_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `percent_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `latitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `latitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `longitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `longitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `address_line` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `address_line` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `region` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `region` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `effective_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `effective_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `expiration_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `expiration_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `recorded_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `recorded_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `due_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `due_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `completed_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `completed_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `is_active` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `is_active` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `is_verified` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `is_verified` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `sequence_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `sequence_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `version_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `version_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `source_system` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `source_system` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `external_reference` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `external_reference` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `notes` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `notes` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `created_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `created_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `updated_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `updated_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `updated_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `updated_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `created_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`outfall` ALTER COLUMN `created_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` SET TAGS ('dbx_wastewater' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_id` SET TAGS ('dbx_business_glossary_term' = 'Grease Interceptor ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_name` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_name` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_description` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_description` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_status` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_status` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `status_reason` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `status_reason` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_category` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `grease_interceptor_category` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `subcategory` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `subcategory` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `type_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `type_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `priority` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `priority` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `quantity` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `quantity` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `amount` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `amount` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `measured_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `measured_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `measured_unit` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `measured_unit` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `min_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `min_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `max_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `max_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `target_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `target_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `percent_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `percent_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `latitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `latitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `longitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `longitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `address_line` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `address_line` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `region` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `region` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `effective_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `effective_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `expiration_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `expiration_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `recorded_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `recorded_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `due_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `due_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `completed_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `completed_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `is_active` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `is_active` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `is_verified` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `is_verified` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `sequence_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `sequence_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `version_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `version_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `source_system` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `source_system` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `external_reference` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `external_reference` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `notes` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `notes` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `created_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `created_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `updated_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `updated_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `updated_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `updated_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `created_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`grease_interceptor` ALTER COLUMN `created_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` SET TAGS ('dbx_wastewater' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` SET TAGS ('dbx_operational' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_id` SET TAGS ('dbx_business_glossary_term' = 'Sewershed Basin ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_name` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_name` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_description` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_description` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_status` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_status` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `status_reason` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `status_reason` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_category` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_category` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `subcategory` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `subcategory` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `type_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `type_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `priority` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `priority` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `quantity` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `quantity` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `amount` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `amount` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `measured_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `measured_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `measured_unit` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `measured_unit` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `min_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `min_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `max_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `max_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `target_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `target_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `percent_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `percent_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `latitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `latitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `longitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `longitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `address_line` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `address_line` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `region` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `region` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `effective_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `effective_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `expiration_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `expiration_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `recorded_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `recorded_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `due_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `due_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `completed_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `completed_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `is_active` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `is_active` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `is_verified` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `is_verified` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sequence_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sequence_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `version_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `version_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `source_system` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `source_system` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `external_reference` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `external_reference` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `notes` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `notes` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `created_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `created_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `updated_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `updated_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `updated_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `updated_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `created_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `created_by` SET TAGS ('dbx_from' = 'description');
