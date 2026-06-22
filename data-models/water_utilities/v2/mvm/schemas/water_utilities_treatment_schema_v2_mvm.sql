-- Schema for Domain: treatment | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-06-22 20:12:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`treatment` COMMENT 'Authoritative domain for all water treatment and purification operations at WTPs and WWTPs. Owns process data for coagulation, filtration, disinfection (UV, chlorination, RO, UF, MF, GAC), CT compliance, chemical dosing, and finished water production. Integrates with SCADA/OSIsoft PI Historian for real-time process control and MOR regulatory submissions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`facility` (
    `facility_id` BIGINT COMMENT 'Primary key',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: Treatment facilities operate under a water system (PWSID) for SDWA regulatory reporting, CCR publication, and primacy agency oversight. facility.pwsid is a denormalized water_system identifier; formal',
    `address_line_1` STRING COMMENT 'Address line 1',
    `average_daily_flow_mgd` DECIMAL(18,2) COMMENT 'Average daily flow in MGD',
    `city` STRING COMMENT 'City',
    `commissioning_date` DATE COMMENT 'Facility commissioning date',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Design capacity in MGD',
    `disinfection_type` STRING COMMENT 'Disinfection method',
    `energy_intensity_kwh_per_mg` DECIMAL(18,2) COMMENT 'Energy intensity kWh per MG',
    `facility_status` STRING COMMENT 'Operational status',
    `facility_type` STRING COMMENT 'Type of facility (WTP, WWTP, etc.)',
    `last_major_upgrade_date` DATE COMMENT 'Last major upgrade date',
    `latitude` DECIMAL(18,2) COMMENT 'GIS latitude coordinate',
    `longitude` DECIMAL(18,2) COMMENT 'GIS longitude coordinate',
    `facility_name` STRING COMMENT 'Name of the treatment facility',
    `operator_certification_class_required` STRING COMMENT 'Required operator certification class',
    `permit_number` STRING COMMENT 'Regulatory permit number',
    `permitted_capacity_mgd` DECIMAL(18,2) COMMENT 'Permitted capacity in MGD',
    `pfas_treatment_capable_flag` BOOLEAN COMMENT 'PFAS treatment capability flag',
    `pfas_treatment_technology` STRING COMMENT 'PFAS treatment technology type',
    `population_served` STRING COMMENT 'Population served',
    `postal_code` STRING COMMENT 'Postal code',
    `regulatory_agency_code` STRING COMMENT 'Regulatory agency code',
    `scada_system_type` STRING COMMENT 'SCADA system type',
    `service_connections_count` STRING COMMENT 'Number of service connections',
    `source_water_type` STRING COMMENT 'Source water type',
    `state_code` STRING COMMENT 'State code',
    `treatment_technology_primary` STRING COMMENT 'Primary treatment technology',
    `treatment_technology_secondary` STRING COMMENT 'Secondary treatment technology',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Water treatment facility master record capturing design capacity, treatment technology, PFAS capability, regulatory classification, and operational status.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` (
    `process_unit_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Parent facility',
    `asset_tag` STRING COMMENT 'Asset tag',
    `bed_volumes_to_breakthrough` STRING COMMENT 'Bed volumes to breakthrough',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `design_capacity_gpm` DECIMAL(18,2) COMMENT 'Design capacity in GPM',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Design capacity in MGD',
    `design_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Design flow rate GPM',
    `empty_bed_contact_time_min` DECIMAL(18,2) COMMENT 'Empty bed contact time in minutes',
    `filter_number` STRING COMMENT 'Filter number',
    `filter_type` STRING COMMENT 'Filter type',
    `installation_date` DATE COMMENT 'Installation date',
    `last_maintenance_date` DATE COMMENT 'Last maintenance date',
    `manufacturer` STRING COMMENT 'Manufacturer',
    `media_type` STRING COMMENT 'Filter media type',
    `media_volume_cubic_ft` DECIMAL(18,2) COMMENT 'Media volume in cubic feet',
    `model_number` STRING COMMENT 'Model number',
    `next_media_replacement_date` DATE COMMENT 'Next media replacement date',
    `notes` STRING COMMENT 'Notes',
    `operational_status` STRING COMMENT 'Operational status',
    `pfas_removal_capable_flag` BOOLEAN COMMENT 'PFAS removal capability',
    `pfas_target_compounds` STRING COMMENT 'Target PFAS compounds',
    `process_stage` STRING COMMENT 'Process stage',
    `process_type` STRING COMMENT 'Process type',
    `redundancy_group` STRING COMMENT 'Redundancy group',
    `scada_tag_prefix` STRING COMMENT 'SCADA tag prefix',
    `sequence_order` STRING COMMENT 'Sequence order in treatment train',
    `serial_number` STRING COMMENT 'Serial number',
    `surface_area_sqft` DECIMAL(18,2) COMMENT 'Surface area sqft',
    `technology_class` STRING COMMENT 'Technology class',
    `unit_name` STRING COMMENT 'Process unit name',
    `unit_number` STRING COMMENT 'Unit number',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_process_unit PRIMARY KEY(`process_unit_id`)
) COMMENT 'Individual treatment process unit (filter, clarifier, GAC contactor, membrane train) with design parameters, PFAS removal capability, media specifications, and operational status.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` (
    `process_reading_id` BIGINT COMMENT 'Primary key',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Real-time treatment process readings (turbidity, chlorine residual, pH, PFAS surrogates) monitor the same parameters regulated as contaminants. Linking process_reading to contaminant enables automated',
    `facility_id` BIGINT COMMENT 'Facility',
    `process_unit_id` BIGINT COMMENT 'Process unit',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each monitored parameter in process_reading maps to a specific regulatory requirement (turbidity→LT2ESWTR, CT→SWTR, residual→SDWA). Linking readings to the requirement they monitor enables automated c',
    `engineering_unit` STRING COMMENT 'Engineering unit',
    `is_manual_entry` BOOLEAN COMMENT 'Manual entry flag',
    `is_regulatory_exceedance` BOOLEAN COMMENT 'Regulatory exceedance flag',
    `measured_value` DECIMAL(18,2) COMMENT 'Measured value',
    `parameter_type` STRING COMMENT 'Parameter type',
    `quality_flag` BOOLEAN COMMENT 'Data quality flag',
    `reading_timestamp` TIMESTAMP COMMENT 'Reading timestamp',
    `regulatory_limit_value` DECIMAL(18,2) COMMENT 'Regulatory limit value',
    CONSTRAINT pk_process_reading PRIMARY KEY(`process_reading_id`)
) COMMENT 'Time-series process reading from SCADA or manual entry capturing flow, pressure, chemical dose, turbidity, chlorine residual, CT value, and regulatory compliance flags.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` (
    `chemical_dose_event_id` BIGINT COMMENT 'Primary key',
    `chemical_id` BIGINT COMMENT 'Chemical',
    `facility_id` BIGINT COMMENT 'Facility',
    `process_unit_id` BIGINT COMMENT 'Process unit',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Chemical dosing events (disinfection CT compliance, coagulation for turbidity) are performed to satisfy specific regulatory requirements. chemical_dose_event.ct_compliance_flag confirms regulatory con',
    `chemical_mass_applied_kg` DECIMAL(18,2) COMMENT 'Chemical mass applied in kg',
    `chemical_type` STRING COMMENT 'Chemical type',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `ct_compliance_flag` BOOLEAN COMMENT 'CT compliance flag',
    `ct_required_mg_min_per_l` DECIMAL(18,2) COMMENT 'CT required mg·min/L',
    `ct_value_mg_min_per_l` DECIMAL(18,2) COMMENT 'CT value mg·min/L',
    `dose_end_timestamp` TIMESTAMP COMMENT 'Dose end timestamp',
    `dose_event_status` STRING COMMENT 'Dose event status',
    `dose_rate_mg_per_l` DECIMAL(18,2) COMMENT 'Dose rate mg/L',
    `dose_start_timestamp` TIMESTAMP COMMENT 'Dose start timestamp',
    `event_dose_cost_usd` DECIMAL(18,2) COMMENT 'Event dose cost USD',
    `target_dose_rate_mg_per_l` DECIMAL(18,2) COMMENT 'Target dose rate mg/L',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_chemical_dose_event PRIMARY KEY(`chemical_dose_event_id`)
) COMMENT 'Chemical dosing event capturing dose rate, mass applied, CT value achieved, compliance status, and cost for chlorine, coagulant, or other treatment chemicals.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` (
    `finished_water_production_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: AWWA M36 water audit requires plant effluent bulk meter data to calculate system input volume for non-revenue water analysis. Linking finished water production records to the registered bulk discharge',
    `avg_production_rate_gpm` DECIMAL(18,2) COMMENT 'Average production rate GPM',
    `cl2_residual_avg_mg_l` DECIMAL(18,2) COMMENT 'Cl2 residual average mg/L',
    `cl2_residual_min_mg_l` DECIMAL(18,2) COMMENT 'Cl2 residual minimum mg/L',
    `ct_achieved_mg_min_l` DECIMAL(18,2) COMMENT 'CT achieved mg·min/L',
    `ct_required_mg_min_l` DECIMAL(18,2) COMMENT 'CT required mg·min/L',
    `data_quality_flag` BOOLEAN COMMENT 'Data quality flag',
    `finished_water_volume_mg` DECIMAL(18,2) COMMENT 'Finished water volume MG',
    `peak_production_rate_gpm` DECIMAL(18,2) COMMENT 'Peak production rate GPM',
    `ph_avg` DECIMAL(18,2) COMMENT 'pH average',
    `plant_efficiency_ratio` DECIMAL(18,2) COMMENT 'Plant efficiency ratio',
    `production_date` DATE COMMENT 'Production date',
    `regulatory_exceedance` BOOLEAN COMMENT 'Regulatory exceedance flag',
    `turbidity_avg_ntu` DECIMAL(18,2) COMMENT 'Turbidity average NTU',
    `turbidity_max_ntu` DECIMAL(18,2) COMMENT 'Turbidity maximum NTU',
    CONSTRAINT pk_finished_water_production PRIMARY KEY(`finished_water_production_id`)
) COMMENT 'Daily finished water production record capturing volume produced, average/peak production rate, chlorine residual, CT achieved, turbidity, pH, and regulatory exceedance flags.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` (
    `source_water_intake_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.metering_meter. Business justification: Source water withdrawal permit compliance requires traceability to the specific bulk flow meter measuring intake volumes. Water utilities must report metered withdrawals to regulators; linking intake ',
    `sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.quality_sampling_point. Business justification: Source water intakes have co-located quality sampling points for intake monitoring programs. Linking source_water_intake to quality_sampling_point enables correlation of intake operational data (flow,',
    `water_source_id` BIGINT COMMENT 'Water source',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: Indirect potable reuse (IPR) and water recycling programs: a WWTPs treated effluent becomes a source water input for a drinking water treatment facility. Regulators require tracking which WWTP suppli',
    `data_quality_flag` BOOLEAN COMMENT 'Data quality flag',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Flow rate GPM',
    `gis_latitude` DECIMAL(18,2) COMMENT 'GIS latitude',
    `gis_longitude` DECIMAL(18,2) COMMENT 'GIS longitude',
    `intake_timestamp` TIMESTAMP COMMENT 'Intake timestamp',
    `permit_compliance_status` STRING COMMENT 'Permit compliance status',
    `ph_level` DECIMAL(18,2) COMMENT 'pH level',
    `source_type` STRING COMMENT 'Source type',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature Celsius',
    `toc_mg_per_l` DECIMAL(18,2) COMMENT 'TOC mg/L',
    `turbidity_ntu` DECIMAL(18,2) COMMENT 'Turbidity NTU',
    `volume_withdrawn_mg` DECIMAL(18,2) COMMENT 'Volume withdrawn MG',
    CONSTRAINT pk_source_water_intake PRIMARY KEY(`source_water_intake_id`)
) COMMENT 'Source water intake event capturing volume withdrawn, flow rate, turbidity, TOC, pH, temperature, source type, permit compliance status, and GIS coordinates.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` (
    `treatment_permit_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `regulatory_agency_id` BIGINT COMMENT 'Regulatory agency',
    `water_source_id` BIGINT COMMENT 'Foreign key linking to treatment.water_source. Business justification: Treatment permits in water utilities are frequently issued for specific water sources — a surface water permit differs from a groundwater permit, and regulatory agencies issue permits tied to the sour',
    `effective_date` DATE COMMENT 'Effective date',
    `expiration_date` DATE COMMENT 'Expiration date',
    `monitoring_frequency` STRING COMMENT 'Monitoring frequency',
    `permit_number` STRING COMMENT 'Permit number',
    `permit_status` STRING COMMENT 'Permit status',
    `permit_type` STRING COMMENT 'Permit type',
    `permitted_capacity_mgd` DECIMAL(18,2) COMMENT 'Permitted capacity MGD',
    `pfas_monitoring_required` BOOLEAN COMMENT 'PFAS monitoring required flag',
    CONSTRAINT pk_treatment_permit PRIMARY KEY(`treatment_permit_id`)
) COMMENT 'Treatment facility permit record capturing permit number, type, status, effective/expiration dates, permitted capacity, PFAS monitoring requirement, monitoring frequency, and discharge point.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` (
    `chemical_id` BIGINT COMMENT 'Primary key',
    `cas_number` STRING COMMENT 'CAS number',
    `chemical_category` STRING COMMENT 'Chemical category',
    `eu_dwd_sum_of_20_included` BOOLEAN COMMENT 'EU DWD sum of 20 included flag',
    `eu_dwd_total_pfas_included` BOOLEAN COMMENT 'EU DWD total PFAS included flag',
    `exposure_pathway` STRING COMMENT 'Exposure pathway',
    `formula` STRING COMMENT 'Chemical formula',
    `gac_removal_efficiency_pct` DECIMAL(18,2) COMMENT 'GAC removal efficiency percent',
    `is_pfas_compound` BOOLEAN COMMENT 'PFAS compound flag',
    `ix_removal_efficiency_pct` DECIMAL(18,2) COMMENT 'IX removal efficiency percent',
    `chemical_name` STRING COMMENT 'Chemical name',
    `pfas_chain_length_class` STRING COMMENT 'PFAS chain length class',
    `pfas_functional_group` STRING COMMENT 'PFAS functional group',
    `reach_registered_flag` BOOLEAN COMMENT 'REACH registered flag',
    `receptor_type` STRING COMMENT 'Receptor type',
    `treatment_removal_technology` STRING COMMENT 'Treatment removal technology',
    `us_epa_hazard_index_group` STRING COMMENT 'US EPA hazard index group',
    `us_epa_mcl_ppt` DECIMAL(18,2) COMMENT 'US EPA MCL in ppt',
    `us_epa_mclg_ppt` DECIMAL(18,2) COMMENT 'US EPA MCLG in ppt',
    CONSTRAINT pk_chemical PRIMARY KEY(`chemical_id`)
) COMMENT 'Chemical master record capturing chemical name, formula, CAS number, category, PFAS compound flag, PFAS chain length/functional group, US EPA MCL/MCLG, EU DWD inclusion, REACH registration, treatment removal technology, GAC/IX removal efficiency, exposure pathway, and receptor type.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` (
    `water_source_id` BIGINT COMMENT 'Primary key',
    `latitude` DECIMAL(18,2) COMMENT 'GIS latitude',
    `longitude` DECIMAL(18,2) COMMENT 'GIS longitude',
    `regulatory_classification` STRING COMMENT 'Regulatory classification',
    `source_capacity_mgd` DECIMAL(18,2) COMMENT 'Source capacity MGD',
    `source_location` STRING COMMENT 'Source location',
    `source_name` STRING COMMENT 'Source name',
    `source_status` STRING COMMENT 'Source status',
    `source_type` STRING COMMENT 'Source type',
    CONSTRAINT pk_water_source PRIMARY KEY(`water_source_id`)
) COMMENT 'Water source master record capturing source name, type, location, capacity, quality characteristics, and regulatory classification.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_chemical_id` FOREIGN KEY (`chemical_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`chemical`(`chemical_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`water_source`(`water_source_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`water_source`(`water_source_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`treatment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`treatment` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_reconciled_depth' = '32');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_depth_tier' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `average_daily_flow_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Flow');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `disinfection_type` SET TAGS ('dbx_business_glossary_term' = 'Disinfection Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `energy_intensity_kwh_per_mg` SET TAGS ('dbx_business_glossary_term' = 'Energy Intensity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Facility Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `last_major_upgrade_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Upgrade');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_gis' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_gis' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `operator_certification_class_required` SET TAGS ('dbx_business_glossary_term' = 'Operator Certification Class');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `permitted_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `pfas_treatment_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'PFAS Treatment Capable');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `pfas_treatment_capable_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `pfas_treatment_capable_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `pfas_treatment_technology` SET TAGS ('dbx_business_glossary_term' = 'PFAS Treatment Technology');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `pfas_treatment_technology` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `pfas_treatment_technology` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `population_served` SET TAGS ('dbx_business_glossary_term' = 'Population Served');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `regulatory_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `scada_system_type` SET TAGS ('dbx_business_glossary_term' = 'SCADA System');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `service_connections_count` SET TAGS ('dbx_business_glossary_term' = 'Service Connections');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `source_water_type` SET TAGS ('dbx_business_glossary_term' = 'Source Water Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Treatment Technology');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology_primary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology_primary` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Treatment Technology');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology_secondary` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `treatment_technology_secondary` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `bed_volumes_to_breakthrough` SET TAGS ('dbx_business_glossary_term' = 'Bed Volumes to Breakthrough');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `design_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity GPM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity MGD');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `design_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Design Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `empty_bed_contact_time_min` SET TAGS ('dbx_business_glossary_term' = 'EBCT');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `filter_number` SET TAGS ('dbx_business_glossary_term' = 'Filter Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `filter_type` SET TAGS ('dbx_business_glossary_term' = 'Filter Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `media_volume_cubic_ft` SET TAGS ('dbx_business_glossary_term' = 'Media Volume');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `next_media_replacement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Media Replacement');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `pfas_removal_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'PFAS Removal Capable');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `pfas_target_compounds` SET TAGS ('dbx_business_glossary_term' = 'PFAS Target Compounds');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `process_stage` SET TAGS ('dbx_business_glossary_term' = 'Process Stage');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `process_type` SET TAGS ('dbx_business_glossary_term' = 'Process Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `redundancy_group` SET TAGS ('dbx_business_glossary_term' = 'Redundancy Group');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `scada_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag Prefix');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Sequence Order');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `surface_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Surface Area');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `technology_class` SET TAGS ('dbx_business_glossary_term' = 'Technology Class');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Unit Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `unit_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_subdomain' = 'process_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Process Reading ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_reading_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `is_manual_entry` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `is_regulatory_exceedance` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exceedance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `parameter_type` SET TAGS ('dbx_business_glossary_term' = 'Parameter Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `regulatory_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_subdomain' = 'process_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_dose_event_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Dose Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_dose_event_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_mass_applied_kg` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mass Applied');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_type` SET TAGS ('dbx_business_glossary_term' = 'Chemical Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `ct_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'CT Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `ct_required_mg_min_per_l` SET TAGS ('dbx_business_glossary_term' = 'CT Required');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `ct_value_mg_min_per_l` SET TAGS ('dbx_business_glossary_term' = 'CT Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `dose_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dose End');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `dose_event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `dose_rate_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Dose Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `dose_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dose Start');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `event_dose_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Dose Cost');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `target_dose_rate_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'Target Dose Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_subdomain' = 'process_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `finished_water_production_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Water Production ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `finished_water_production_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `avg_production_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Average Production Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `cl2_residual_avg_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Cl2 Residual Average');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `cl2_residual_min_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Cl2 Residual Minimum');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `ct_achieved_mg_min_l` SET TAGS ('dbx_business_glossary_term' = 'CT Achieved');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `ct_required_mg_min_l` SET TAGS ('dbx_business_glossary_term' = 'CT Required');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `finished_water_volume_mg` SET TAGS ('dbx_business_glossary_term' = 'Finished Water Volume');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `peak_production_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Peak Production Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `ph_avg` SET TAGS ('dbx_business_glossary_term' = 'pH Average');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `plant_efficiency_ratio` SET TAGS ('dbx_business_glossary_term' = 'Plant Efficiency Ratio');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `regulatory_exceedance` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exceedance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `turbidity_avg_ntu` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Average');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `turbidity_max_ntu` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Maximum');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` SET TAGS ('dbx_subdomain' = 'process_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `source_water_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Source Water Intake ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `source_water_intake_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Meter Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Sampling Point Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `water_source_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_gis' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_gis' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `intake_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Intake Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `permit_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `ph_level` SET TAGS ('dbx_business_glossary_term' = 'pH Level');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `toc_mg_per_l` SET TAGS ('dbx_business_glossary_term' = 'TOC');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `volume_withdrawn_mg` SET TAGS ('dbx_business_glossary_term' = 'Volume Withdrawn');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permitted_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `pfas_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'PFAS Monitoring Required');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_subdomain' = 'process_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `chemical_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `chemical_category` SET TAGS ('dbx_business_glossary_term' = 'Chemical Category');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `eu_dwd_sum_of_20_included` SET TAGS ('dbx_business_glossary_term' = 'EU DWD Sum of 20');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `eu_dwd_total_pfas_included` SET TAGS ('dbx_business_glossary_term' = 'EU DWD Total PFAS');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `exposure_pathway` SET TAGS ('dbx_business_glossary_term' = 'Exposure Pathway');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `formula` SET TAGS ('dbx_business_glossary_term' = 'Chemical Formula');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `gac_removal_efficiency_pct` SET TAGS ('dbx_business_glossary_term' = 'GAC Removal Efficiency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `is_pfas_compound` SET TAGS ('dbx_business_glossary_term' = 'PFAS Compound');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `ix_removal_efficiency_pct` SET TAGS ('dbx_business_glossary_term' = 'IX Removal Efficiency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `pfas_chain_length_class` SET TAGS ('dbx_business_glossary_term' = 'PFAS Chain Length');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `pfas_functional_group` SET TAGS ('dbx_business_glossary_term' = 'PFAS Functional Group');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `reach_registered_flag` SET TAGS ('dbx_business_glossary_term' = 'REACH Registered');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `receptor_type` SET TAGS ('dbx_business_glossary_term' = 'Receptor Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `treatment_removal_technology` SET TAGS ('dbx_business_glossary_term' = 'Treatment Removal Technology');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `treatment_removal_technology` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `treatment_removal_technology` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `us_epa_hazard_index_group` SET TAGS ('dbx_business_glossary_term' = 'EPA Hazard Index Group');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `us_epa_mcl_ppt` SET TAGS ('dbx_business_glossary_term' = 'US EPA MCL');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `us_epa_mclg_ppt` SET TAGS ('dbx_business_glossary_term' = 'US EPA MCLG');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `water_source_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `latitude` SET TAGS ('dbx_gis' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `longitude` SET TAGS ('dbx_gis' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `source_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Source Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `source_location` SET TAGS ('dbx_business_glossary_term' = 'Source Location');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `source_name` SET TAGS ('dbx_business_glossary_term' = 'Source Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `source_status` SET TAGS ('dbx_business_glossary_term' = 'Source Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
