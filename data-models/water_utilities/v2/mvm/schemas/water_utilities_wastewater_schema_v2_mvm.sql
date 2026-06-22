-- Schema for Domain: wastewater | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-06-22 20:12:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`wastewater` COMMENT 'Manages wastewater collection, conveyance, and treatment operations including sewer network topology, gravity sewers, force mains, lift stations, manholes, CSO/SSO management, I&I monitoring, FOG program management, industrial user permits (IUP), and NPDES compliance tracking. Supports DMR submissions and biosolids management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` (
    `sewer_network_id` BIGINT COMMENT 'Primary key',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Sewer network segments must be classified by asset class (gravity sewer, force main, interceptor) to drive inspection frequency, maintenance strategy, and useful life calculations per ISO 55001 asset ',
    `compliance_permit_id` BIGINT COMMENT 'FK to permit',
    `manhole_id` BIGINT COMMENT 'FK to upstream manhole',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Sewer network segments are physical infrastructure assets requiring lifecycle management, condition assessments, work orders, and capital planning via the asset registry. A domain expert expects every',
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
    `registry_id` BIGINT COMMENT 'FK to asset registry',
    `sewershed_basin_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewershed_basin. Business justification: A manhole is a physical access point located within a specific sewershed basin. One sewershed basin contains many manholes (1:N). The manhole table currently carries a denormalized basin_code (STRING)',
    `asset_class_code` STRING COMMENT 'Asset class code',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` (
    `wwtp_id` BIGINT COMMENT 'Primary key',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Every WWTP operates under an NPDES discharge permit. wwtp.npdes_permit_number is a denormalized text field; replacing it with a proper FK to compliance_permit enables permit status queries, renewal tr',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: WWTPs are registered under a public water system (PWSID) for NPDES and regulatory reporting. wwtp already stores npdes_permit_number and pwsid fields; linking to water_system enables CCR, compliance, ',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` (
    `sewershed_basin_id` BIGINT COMMENT 'Primary key',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: A sewershed basin is a defined drainage area whose collected wastewater flows to a designated wastewater treatment plant (WWTP). This is a fundamental operational relationship in wastewater systems — ',
    `address_line` STRING COMMENT 'Address line text.',
    `amount` STRING COMMENT 'Monetary or numeric amount.',
    `sewershed_basin_category` STRING COMMENT 'Classification category.',
    `sewershed_basin_code` STRING COMMENT 'Short code identifier.',
    `completed_date` DATE COMMENT 'Completion date.',
    `created_at` TIMESTAMP COMMENT 'Creation timestamp.',
    `sewershed_basin_description` STRING COMMENT 'Free-text description.',
    `due_date` DATE COMMENT 'Due date.',
    `effective_date` DATE COMMENT 'Effective date.',
    `end_timestamp` TIMESTAMP COMMENT 'End timestamp.',
    `expiration_date` DATE COMMENT 'Expiration date.',
    `external_reference` STRING COMMENT 'External reference identifier.',
    `extra_info` STRING COMMENT 'Added to avoid stub',
    `is_active` BOOLEAN COMMENT 'Active flag.',
    `is_verified` BOOLEAN COMMENT 'Verification flag.',
    `latitude` STRING COMMENT 'Geographic latitude.',
    `longitude` STRING COMMENT 'Geographic longitude.',
    `max_value` STRING COMMENT 'Maximum threshold value.',
    `measured_unit` STRING COMMENT 'Unit of the measured value.',
    `measured_value` STRING COMMENT 'Measured numeric value.',
    `min_value` STRING COMMENT 'Minimum threshold value.',
    `sewershed_basin_name` STRING COMMENT 'Human readable name.',
    `notes` STRING COMMENT 'Additional notes.',
    `percent_value` STRING COMMENT 'Percentage value.',
    `priority` STRING COMMENT 'Priority level.',
    `quantity` STRING COMMENT 'Quantity value.',
    `recorded_at` TIMESTAMP COMMENT 'When the record was captured.',
    `region` STRING COMMENT 'Region designation.',
    `sequence_number` BIGINT COMMENT 'Ordering sequence number.',
    `sewershed_basin_status` STRING COMMENT 'Current lifecycle status.',
    `start_timestamp` TIMESTAMP COMMENT 'Start timestamp.',
    `status_reason` STRING COMMENT 'Reason for the current status.',
    `subcategory` STRING COMMENT 'Secondary classification.',
    `target_value` STRING COMMENT 'Target value.',
    `type_code` STRING COMMENT 'Type classification code.',
    `unit_of_measure` STRING COMMENT 'Unit of measure.',
    `updated_at` TIMESTAMP COMMENT 'Last update timestamp.',
    `updated_by` STRING COMMENT 'Last updater identity.',
    `version_number` BIGINT COMMENT 'Record version number.',
    `created_by` STRING COMMENT 'Creator identity.',
    CONSTRAINT pk_sewershed_basin PRIMARY KEY(`sewershed_basin_id`)
) COMMENT 'Sewershed Basin entity';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_manhole_id` FOREIGN KEY (`manhole_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`manhole`(`manhole_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_sewershed_basin_id` FOREIGN KEY (`sewershed_basin_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin`(`sewershed_basin_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ADD CONSTRAINT `fk_wastewater_sewer_network_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ADD CONSTRAINT `fk_wastewater_manhole_sewershed_basin_id` FOREIGN KEY (`sewershed_basin_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin`(`sewershed_basin_id`);
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ADD CONSTRAINT `fk_wastewater_sewershed_basin_wwtp_id` FOREIGN KEY (`wwtp_id`) REFERENCES `vibe_water_utilities_v1`.`wastewater`.`wwtp`(`wwtp_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`wastewater` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`wastewater` SET TAGS ('dbx_domain' = 'wastewater');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` SET TAGS ('dbx_subdomain' = 'collection_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `sewer_network_id` SET TAGS ('dbx_business_glossary_term' = 'Sewer Network ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Manhole ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewer_network` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `sewershed_basin_id` SET TAGS ('dbx_business_glossary_term' = 'Sewershed Basin Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`manhole` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'WWTP ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`wwtp` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
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
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` SET TAGS ('dbx_subdomain' = 'treatment_operations');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_id` SET TAGS ('dbx_business_glossary_term' = 'Sewershed Basin ID');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `address_line` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `address_line` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `address_line` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `address_line` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `amount` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `amount` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_category` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_category` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `completed_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `completed_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `created_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `created_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_description` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_description` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `due_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `due_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `effective_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `effective_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `expiration_date` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `expiration_date` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `external_reference` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `external_reference` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `is_active` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `is_active` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `is_verified` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `is_verified` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `latitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `latitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `longitude` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `longitude` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `max_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `max_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `measured_unit` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `measured_unit` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `measured_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `measured_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `min_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `min_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_name` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_name` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `notes` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `notes` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `percent_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `percent_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `priority` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `priority` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `quantity` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `quantity` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `recorded_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `recorded_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `region` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `region` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sequence_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sequence_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_status` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `sewershed_basin_status` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `status_reason` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `status_reason` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `subcategory` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `subcategory` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `target_value` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `target_value` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `type_code` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `type_code` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `updated_at` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `updated_at` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `updated_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `updated_by` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `version_number` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `version_number` SET TAGS ('dbx_from' = 'description');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `created_by` SET TAGS ('dbx_synthesized' = 'vreq018');
ALTER TABLE `vibe_water_utilities_v1`.`wastewater`.`sewershed_basin` ALTER COLUMN `created_by` SET TAGS ('dbx_from' = 'description');
