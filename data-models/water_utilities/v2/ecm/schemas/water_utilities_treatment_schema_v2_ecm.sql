-- Schema for Domain: treatment | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 18:57:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`treatment` COMMENT 'Authoritative domain for all water treatment and purification operations at WTPs and WWTPs. Owns process data for coagulation, filtration, disinfection (UV, chlorination, RO, UF, MF, GAC), CT compliance, chemical dosing, and finished water production. Integrates with SCADA/OSIsoft PI Historian for real-time process control and MOR regulatory submissions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`facility` (
    `facility_id` BIGINT COMMENT 'Primary key',
    `cost_center_id` BIGINT COMMENT 'Finance cost center',
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
    `pwsid` STRING COMMENT 'Public Water System ID',
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
    `cip_project_id` BIGINT COMMENT 'Related CIP project',
    `cost_center_id` BIGINT COMMENT 'Cost center',
    `facility_id` BIGINT COMMENT 'Parent facility',
    `material_master_id` BIGINT COMMENT 'Material master record',
    `asset_tag` STRING COMMENT 'Asset tag',
    `bed_volumes_to_breakthrough` STRING COMMENT 'Bed volumes to breakthrough',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `design_capacity_gpm` DECIMAL(18,2) COMMENT 'Design capacity in GPM',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Design capacity in MGD',
    `empty_bed_contact_time_min` DECIMAL(18,2) COMMENT 'Empty bed contact time in minutes',
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
    `technology_class` STRING COMMENT 'Technology class',
    `unit_name` STRING COMMENT 'Process unit name',
    `unit_number` STRING COMMENT 'Unit number',
    `updated_timestamp` TIMESTAMP COMMENT 'Record update timestamp',
    CONSTRAINT pk_process_unit PRIMARY KEY(`process_unit_id`)
) COMMENT 'Individual treatment process unit (filter, clarifier, GAC contactor, membrane train) with design parameters, PFAS removal capability, media specifications, and operational status.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` (
    `process_reading_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `employee_id` BIGINT COMMENT 'Operator employee',
    `process_unit_id` BIGINT COMMENT 'Process unit',
    `scada_tag_id` BIGINT COMMENT 'SCADA tag',
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
    `employee_id` BIGINT COMMENT 'Operator employee',
    `process_unit_id` BIGINT COMMENT 'Process unit',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` (
    `ct_compliance_record_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `process_unit_id` BIGINT COMMENT 'Process unit',
    `treatment_violation_id` BIGINT COMMENT 'Treatment violation',
    `calculation_timestamp` TIMESTAMP COMMENT 'Calculation timestamp',
    `compliance_status` STRING COMMENT 'Compliance status',
    `contact_time_min` DECIMAL(18,2) COMMENT 'Contact time in minutes',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `ct_calculated` DECIMAL(18,2) COMMENT 'CT calculated',
    `ct_ratio` DECIMAL(18,2) COMMENT 'CT ratio',
    `ct_required` DECIMAL(18,2) COMMENT 'CT required',
    `disinfectant_concentration` DECIMAL(18,2) COMMENT 'Disinfectant concentration',
    `disinfectant_type` STRING COMMENT 'Disinfectant type',
    `log_inactivation_achieved` DECIMAL(18,2) COMMENT 'Log inactivation achieved',
    `log_inactivation_required` DECIMAL(18,2) COMMENT 'Log inactivation required',
    `ph_value` DECIMAL(18,2) COMMENT 'pH value',
    `reporting_period_end` DATE COMMENT 'Reporting period end',
    `reporting_period_start` DATE COMMENT 'Reporting period start',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature in Celsius',
    CONSTRAINT pk_ct_compliance_record PRIMARY KEY(`ct_compliance_record_id`)
) COMMENT 'CT (concentration × time) compliance record for disinfection, capturing calculated CT, required CT, log inactivation achieved, and compliance status per EPA SWTR/LT2ESWTR.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` (
    `filter_run_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `filter_unit_id` BIGINT COMMENT 'Filter unit',
    `backwash_trigger_reason` STRING COMMENT 'Backwash trigger reason',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `influent_turbidity_ntu` DECIMAL(18,2) COMMENT 'Influent turbidity NTU',
    `peak_effluent_turbidity_ntu` DECIMAL(18,2) COMMENT 'Peak effluent turbidity NTU',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Regulatory compliance flag',
    `run_duration_hours` DECIMAL(18,2) COMMENT 'Run duration in hours',
    `run_end_timestamp` TIMESTAMP COMMENT 'Run end timestamp',
    `run_number` STRING COMMENT 'Run number',
    `run_start_timestamp` TIMESTAMP COMMENT 'Run start timestamp',
    `run_status` STRING COMMENT 'Run status',
    `terminal_effluent_turbidity_ntu` DECIMAL(18,2) COMMENT 'Terminal effluent turbidity NTU',
    `terminal_head_loss_ft` DECIMAL(18,2) COMMENT 'Terminal head loss in feet',
    `turbidity_mcl_exceedance` BOOLEAN COMMENT 'Turbidity MCL exceedance flag',
    `volume_filtered_mg` DECIMAL(18,2) COMMENT 'Volume filtered in MG',
    CONSTRAINT pk_filter_run PRIMARY KEY(`filter_run_id`)
) COMMENT 'Filter run record capturing run duration, volume filtered, influent/effluent turbidity, terminal head loss, backwash trigger reason, and turbidity MCL exceedance status.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` (
    `backwash_event_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `filter_unit_id` BIGINT COMMENT 'Filter unit',
    `air_scour_duration_minutes` DECIMAL(18,2) COMMENT 'Air scour duration minutes',
    `air_scour_used` BOOLEAN COMMENT 'Air scour used flag',
    `backwash_end_timestamp` TIMESTAMP COMMENT 'Backwash end timestamp',
    `backwash_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Backwash flow rate GPM',
    `backwash_start_timestamp` TIMESTAMP COMMENT 'Backwash start timestamp',
    `backwash_water_volume_gal` DECIMAL(18,2) COMMENT 'Backwash water volume gallons',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `duration_minutes` DECIMAL(18,2) COMMENT 'Duration in minutes',
    `event_status` STRING COMMENT 'Event status',
    `filter_to_waste_used` BOOLEAN COMMENT 'Filter to waste used flag',
    `filter_to_waste_volume_gal` DECIMAL(18,2) COMMENT 'Filter to waste volume gallons',
    `post_backwash_turbidity_ntu` DECIMAL(18,2) COMMENT 'Post-backwash turbidity NTU',
    `pre_backwash_turbidity_ntu` DECIMAL(18,2) COMMENT 'Pre-backwash turbidity NTU',
    `trigger_reason` STRING COMMENT 'Trigger reason',
    CONSTRAINT pk_backwash_event PRIMARY KEY(`backwash_event_id`)
) COMMENT 'Filter backwash event capturing duration, flow rate, water volume used, air scour usage, filter-to-waste volume, and pre/post turbidity readings.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` (
    `finished_water_production_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Approved by employee',
    `facility_id` BIGINT COMMENT 'Facility',
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
    `water_source_id` BIGINT COMMENT 'Water source',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` (
    `membrane_performance_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `feed_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Feed flow rate GPM',
    `feed_turbidity_ntu` DECIMAL(18,2) COMMENT 'Feed turbidity NTU',
    `fouling_index` DECIMAL(18,2) COMMENT 'Fouling index',
    `integrity_test_result` STRING COMMENT 'Integrity test result',
    `log_removal_value` DECIMAL(18,2) COMMENT 'Log removal value',
    `membrane_technology_type` STRING COMMENT 'Membrane technology type',
    `observation_timestamp` TIMESTAMP COMMENT 'Observation timestamp',
    `permeate_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Permeate flow rate GPM',
    `permeate_turbidity_ntu` DECIMAL(18,2) COMMENT 'Permeate turbidity NTU',
    `recovery_rate_pct` DECIMAL(18,2) COMMENT 'Recovery rate percent',
    `transmembrane_pressure_psi` DECIMAL(18,2) COMMENT 'Transmembrane pressure PSI',
    CONSTRAINT pk_membrane_performance PRIMARY KEY(`membrane_performance_id`)
) COMMENT 'Membrane system performance record capturing feed/permeate flow, transmembrane pressure, recovery rate, turbidity removal, fouling index, integrity test result, and log removal value.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` (
    `uv_disinfection_event_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `data_quality_flag` BOOLEAN COMMENT 'Data quality flag',
    `dose_compliance_flag` BOOLEAN COMMENT 'Dose compliance flag',
    `event_timestamp` TIMESTAMP COMMENT 'Event timestamp',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Flow rate GPM',
    `lamp_hours_elapsed` DECIMAL(18,2) COMMENT 'Lamp hours elapsed',
    `lamp_status` STRING COMMENT 'Lamp status',
    `log_inactivation_target` DECIMAL(18,2) COMMENT 'Log inactivation target',
    `uv_dose_delivered_mj_cm2` DECIMAL(18,2) COMMENT 'UV dose delivered mJ/cm²',
    `uv_dose_required_mj_cm2` DECIMAL(18,2) COMMENT 'UV dose required mJ/cm²',
    `uv_intensity_mw_cm2` DECIMAL(18,2) COMMENT 'UV intensity mW/cm²',
    `uv_transmittance_pct` DECIMAL(18,2) COMMENT 'UV transmittance percent',
    CONSTRAINT pk_uv_disinfection_event PRIMARY KEY(`uv_disinfection_event_id`)
) COMMENT 'UV disinfection event capturing UV dose delivered/required, intensity, transmittance, flow rate, lamp status, lamp hours, log inactivation target, and dose compliance flag.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` (
    `sludge_production_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `biosolids_class` STRING COMMENT 'Biosolids class',
    `disposal_cost_usd` DECIMAL(18,2) COMMENT 'Disposal cost USD',
    `disposal_method` STRING COMMENT 'Disposal method',
    `disposal_site_name` STRING COMMENT 'Disposal site name',
    `dry_weight_tons` DECIMAL(18,2) COMMENT 'Dry weight in tons',
    `pathogen_reduction_method` STRING COMMENT 'Pathogen reduction method',
    `production_date` DATE COMMENT 'Production date',
    `total_solids_pct` DECIMAL(18,2) COMMENT 'Total solids percent',
    `volatile_solids_pct` DECIMAL(18,2) COMMENT 'Volatile solids percent',
    `volume_gallons` DECIMAL(18,2) COMMENT 'Volume in gallons',
    CONSTRAINT pk_sludge_production PRIMARY KEY(`sludge_production_id`)
) COMMENT 'Sludge/biosolids production record capturing volume, dry weight, total/volatile solids, biosolids class, disposal method, disposal site, disposal cost, and pathogen reduction method.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` (
    `chemical_inventory_id` BIGINT COMMENT 'Primary key',
    `chemical_id` BIGINT COMMENT 'Chemical',
    `facility_id` BIGINT COMMENT 'Facility',
    `vendor_id` BIGINT COMMENT 'Vendor',
    `expiration_date` DATE COMMENT 'Expiration date',
    `inventory_status` STRING COMMENT 'Inventory status',
    `is_epcra_reportable` BOOLEAN COMMENT 'EPCRA reportable flag',
    `is_rmp_regulated` BOOLEAN COMMENT 'RMP regulated flag',
    `last_physical_count_date` DATE COMMENT 'Last physical count date',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Quantity on hand',
    `record_created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `reorder_point` DECIMAL(18,2) COMMENT 'Reorder point',
    `sds_reference_number` STRING COMMENT 'SDS reference number',
    `storage_container_type` STRING COMMENT 'Storage container type',
    `unit_cost` DECIMAL(18,2) COMMENT 'Unit cost',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    CONSTRAINT pk_chemical_inventory PRIMARY KEY(`chemical_inventory_id`)
) COMMENT 'Chemical inventory record capturing quantity on hand, unit of measure, reorder point, storage container type, SDS reference, EPCRA/RMP reportability, expiration date, and vendor.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` (
    `process_control_setpoint_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `process_unit_id` BIGINT COMMENT 'Process unit',
    `scada_tag_id` BIGINT COMMENT 'SCADA tag',
    `effective_date` DATE COMMENT 'Effective date',
    `engineering_unit` STRING COMMENT 'Engineering unit',
    `expiry_date` DATE COMMENT 'Expiry date',
    `high_alarm_limit` DECIMAL(18,2) COMMENT 'High alarm limit',
    `is_mcl_related` BOOLEAN COMMENT 'MCL related flag',
    `low_alarm_limit` DECIMAL(18,2) COMMENT 'Low alarm limit',
    `setpoint_name` STRING COMMENT 'Setpoint name',
    `setpoint_value` DECIMAL(18,2) COMMENT 'Setpoint value',
    CONSTRAINT pk_process_control_setpoint PRIMARY KEY(`process_control_setpoint_id`)
) COMMENT 'Process control setpoint record capturing setpoint name, value, engineering unit, high/low alarm limits, effective/expiry dates, MCL relation flag, and SCADA tag linkage.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` (
    `treatment_permit_id` BIGINT COMMENT 'Primary key',
    `discharge_point_id` BIGINT COMMENT 'Discharge point',
    `facility_id` BIGINT COMMENT 'Facility',
    `regulatory_agency_id` BIGINT COMMENT 'Regulatory agency',
    `project_permit_id` BIGINT COMMENT '',
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
    `material_master_id` BIGINT COMMENT 'Material master',
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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` (
    `treatment_violation_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `treatment_permit_id` BIGINT COMMENT 'Treatment permit',
    `contaminant_name` STRING COMMENT 'Contaminant name',
    `enforcement_action_required` BOOLEAN COMMENT 'Enforcement action required flag',
    `mcl_value` DECIMAL(18,2) COMMENT 'MCL value',
    `measured_value` DECIMAL(18,2) COMMENT 'Measured value',
    `violation_date` DATE COMMENT 'Violation date',
    `violation_status` STRING COMMENT 'Violation status',
    `violation_type` STRING COMMENT 'Violation type',
    CONSTRAINT pk_treatment_violation PRIMARY KEY(`treatment_violation_id`)
) COMMENT 'Treatment violation record capturing violation type, date, contaminant name, MCL value, measured value, violation status, enforcement action requirement, and public notification tier.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` (
    `mor_submission_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `compliance_status` STRING COMMENT 'Compliance status',
    `reporting_period_end` DATE COMMENT 'Reporting period end',
    `reporting_period_start` DATE COMMENT 'Reporting period start',
    `submission_date` DATE COMMENT 'Submission date',
    `submission_status` STRING COMMENT 'Submission status',
    `total_production_mg` DECIMAL(18,2) COMMENT 'Total production MG',
    CONSTRAINT pk_mor_submission PRIMARY KEY(`mor_submission_id`)
) COMMENT 'Monthly Operating Report (MOR) submission record capturing reporting period, submission date, submission status, total production, compliance status, average daily flow, turbidity, chlorine residual, CT compliance, and MCL exceedance count.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` (
    `scada_tag_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `online_instrument_id` BIGINT COMMENT 'Instrument',
    `process_unit_id` BIGINT COMMENT 'Process unit',
    `data_quality_flag` BOOLEAN COMMENT 'Data quality flag indicating the validation status of the scada tag record (data quality flag).',
    `data_type` STRING COMMENT 'Data type',
    `engineering_unit` STRING COMMENT 'Engineering unit',
    `historian_server` STRING COMMENT 'Historian server',
    `scan_rate_seconds` STRING COMMENT 'Scan rate in seconds',
    `tag_description` STRING COMMENT 'Tag description',
    `tag_name` STRING COMMENT 'Tag name',
    `tag_category` STRING COMMENT 'Basic SCADA tag taxonomy category (e.g. analog, digital, calculated)',
    `tag_data_type` STRING COMMENT 'SCADA tag data type within the basic tag taxonomy',
    `tag_quality_class` STRING COMMENT 'SCADA tag quality classification within the basic tag taxonomy',
    `engineering_units` STRING COMMENT 'Engineering units for the SCADA tag taxonomy',
    CONSTRAINT pk_scada_tag PRIMARY KEY(`scada_tag_id`)
) COMMENT 'SCADA tag master record capturing tag name, description, engineering unit, data type, scan rate, historian server, instrument linkage, and PI point ID.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` (
    `facility_service_allocation_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `territory_id` BIGINT COMMENT 'Service territory',
    `allocated_capacity_mgd` DECIMAL(18,2) COMMENT 'Allocated capacity MGD',
    `allocation_end_date` DATE COMMENT 'Allocation end date',
    `allocation_start_date` DATE COMMENT 'Allocation start date',
    `allocation_status` STRING COMMENT 'Allocation status',
    CONSTRAINT pk_facility_service_allocation PRIMARY KEY(`facility_service_allocation_id`)
) COMMENT 'Facility service allocation record capturing allocation of treatment capacity to service territories or wholesale customers.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` (
    `chemical_supply_agreement_id` BIGINT COMMENT 'Primary key',
    `chemical_id` BIGINT COMMENT 'Chemical',
    `vendor_id` BIGINT COMMENT 'Vendor',
    `agreement_end_date` DATE COMMENT 'Agreement end date',
    `agreement_number` STRING COMMENT 'Agreement number',
    `agreement_start_date` DATE COMMENT 'Agreement start date',
    `agreement_status` STRING COMMENT 'Agreement status',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price',
    CONSTRAINT pk_chemical_supply_agreement PRIMARY KEY(`chemical_supply_agreement_id`)
) COMMENT 'Chemical supply agreement record capturing vendor, chemical, contract terms, pricing, delivery schedule, and agreement status.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` (
    `facility_project_id` BIGINT COMMENT 'Primary key',
    `cip_project_id` BIGINT COMMENT 'CIP project',
    `facility_id` BIGINT COMMENT 'Facility',
    `project_end_date` DATE COMMENT 'Project end date',
    `project_role` STRING COMMENT 'Project role',
    `project_start_date` DATE COMMENT 'Project start date',
    CONSTRAINT pk_facility_project PRIMARY KEY(`facility_project_id`)
) COMMENT 'Facility project record linking treatment facilities to CIP projects for upgrades, expansions, or new construction.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` (
    `operator_qualification_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'Employee',
    `facility_id` BIGINT COMMENT 'Facility',
    `operator_license_id` BIGINT COMMENT 'Operator license',
    `certification_class` STRING COMMENT 'Certification class',
    `expiration_date` DATE COMMENT 'Expiration date',
    `qualification_date` DATE COMMENT 'Qualification date',
    `qualification_status` STRING COMMENT 'Qualification status',
    `operator_qualification_status` STRING COMMENT '',
    `operator_qualification_notes` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `created_at` TIMESTAMP COMMENT '',
    CONSTRAINT pk_operator_qualification PRIMARY KEY(`operator_qualification_id`)
) COMMENT 'Operator qualification record capturing operator license, certification class, facility assignment, and qualification status.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` (
    `process_maintenance_plan_id` BIGINT COMMENT 'Primary key',
    `pm_schedule_id` BIGINT COMMENT 'PM schedule',
    `process_unit_id` BIGINT COMMENT 'Process unit',
    `crew_id` BIGINT COMMENT 'Responsible crew',
    `maintenance_frequency` STRING COMMENT 'Maintenance frequency',
    `next_maintenance_date` DATE COMMENT 'Next maintenance date',
    `plan_status` STRING COMMENT 'Plan status',
    CONSTRAINT pk_process_maintenance_plan PRIMARY KEY(`process_maintenance_plan_id`)
) COMMENT 'Process maintenance plan record capturing maintenance schedule, frequency, responsible crew, and plan status for treatment process units.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` (
    `process_compliance_monitoring_id` BIGINT COMMENT 'Primary key',
    `process_unit_id` BIGINT COMMENT 'Process unit',
    `regulatory_requirement_id` BIGINT COMMENT 'Regulatory requirement',
    `last_monitoring_date` DATE COMMENT 'Last monitoring date',
    `monitoring_frequency` STRING COMMENT 'Monitoring frequency',
    `monitoring_parameter` STRING COMMENT 'Monitoring parameter',
    `monitoring_status` STRING COMMENT 'Monitoring status',
    `next_monitoring_date` DATE COMMENT 'Next monitoring date',
    `process_compliance_monitoring_status` STRING COMMENT '',
    `process_compliance_monitoring_notes` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiration_date` DATE COMMENT '',
    CONSTRAINT pk_process_compliance_monitoring PRIMARY KEY(`process_compliance_monitoring_id`)
) COMMENT 'Process compliance monitoring record capturing monitoring schedule, parameter, frequency, regulatory requirement, and monitoring status.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` (
    `permit_compliance_obligation_id` BIGINT COMMENT 'Primary key',
    `treatment_permit_id` BIGINT COMMENT 'Treatment permit',
    `completion_date` DATE COMMENT 'Completion date',
    `compliance_status` STRING COMMENT 'Compliance status',
    `due_date` DATE COMMENT 'Due date',
    `obligation_description` STRING COMMENT 'Obligation description',
    `obligation_type` STRING COMMENT 'Obligation type',
    CONSTRAINT pk_permit_compliance_obligation PRIMARY KEY(`permit_compliance_obligation_id`)
) COMMENT 'Permit compliance obligation record capturing specific permit conditions, obligations, due dates, and compliance status.';

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

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` (
    `discharge_point_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `discharge_status` STRING COMMENT 'Discharge status',
    `discharge_type` STRING COMMENT 'Discharge type',
    `latitude` DECIMAL(18,2) COMMENT 'GIS latitude',
    `longitude` DECIMAL(18,2) COMMENT 'GIS longitude',
    `outfall_number` STRING COMMENT 'Outfall number',
    `receiving_water_body` STRING COMMENT 'Receiving water body',
    CONSTRAINT pk_discharge_point PRIMARY KEY(`discharge_point_id`)
) COMMENT 'Discharge point master record capturing outfall location, receiving water body, permit limits, and discharge monitoring requirements.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` (
    `filter_unit_id` BIGINT COMMENT 'Primary key',
    `facility_id` BIGINT COMMENT 'Facility',
    `design_flow_rate_gpm` DECIMAL(18,2) COMMENT 'Design flow rate GPM',
    `filter_number` STRING COMMENT 'Filter number',
    `filter_type` STRING COMMENT 'Filter type',
    `installation_date` DATE COMMENT 'Installation date',
    `media_type` STRING COMMENT 'Media type',
    `operational_status` STRING COMMENT 'Operational status',
    `surface_area_sqft` DECIMAL(18,2) COMMENT 'Surface area sqft',
    CONSTRAINT pk_filter_unit PRIMARY KEY(`filter_unit_id`)
) COMMENT 'Filter unit master record capturing filter number, type, media specifications, design flow rate, and operational status.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` (
    `treatment_prediction_event_id` BIGINT COMMENT 'Unique identifier for the prediction event record.',
    `employee_id` BIGINT COMMENT 'Foreign key to the employee who reviewed or acted on this prediction.',
    `facility_id` BIGINT COMMENT 'Foreign key to the treatment facility associated with this prediction.',
    `actual_class` STRING COMMENT 'For classification models, the actual observed class label.',
    `actual_label` STRING COMMENT 'Observed/realized categorical label used for accuracy evaluation.',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual observed value after the prediction window, used for model evaluation.',
    `alert_severity` STRING COMMENT 'Severity level of triggered alert (e.g., LOW, MEDIUM, HIGH, CRITICAL).',
    `alert_triggered` BOOLEAN COMMENT 'Indicates if this prediction triggered an operational alert.',
    `confidence` DOUBLE COMMENT 'Confidence score or certainty measure of the prediction (0.0 to 1.0).',
    `confidence_lower_bound` DOUBLE COMMENT 'Lower bound of the confidence interval for the prediction.',
    `confidence_upper_bound` DOUBLE COMMENT 'Upper bound of the confidence interval for the prediction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was created.',
    `error_type` STRING COMMENT 'Type of error metric (e.g., MAE, RMSE, MAPE).',
    `error_value` DECIMAL(18,2) COMMENT 'Difference between predicted and actual value once actual is known.',
    `evaluated_at` TIMESTAMP COMMENT 'Timestamp when the prediction was evaluated against the actual outcome.',
    `feature_set_version` STRING COMMENT 'Version of the feature set/inputs used to produce the prediction.',
    `feature_vector_json` STRING COMMENT 'JSON representation of input features used for this prediction.',
    `is_actual_recorded` BOOLEAN COMMENT 'Flag indicating whether the actual outcome has been recorded for evaluation.',
    `is_anomaly` BOOLEAN COMMENT 'Flag indicating whether the prediction represents a detected anomaly.',
    `is_validated` BOOLEAN COMMENT 'Indicates if the prediction has been validated against actual outcomes.',
    `lower_bound` DOUBLE COMMENT 'Lower bound of the prediction interval.',
    `model_algorithm` STRING COMMENT 'Algorithm type used (e.g., XGBoost, LSTM, RandomForest, Prophet).',
    `model_name` STRING COMMENT 'Human-readable name of the predictive model.',
    `model_ontology_class` STRING COMMENT 'Ontology: ML, statistical, mechanistic, hybrid',
    `model_type` STRING COMMENT 'Algorithm/family of the model (e.g. regression, classification, time-series, neural-network).',
    `model_version` STRING COMMENT 'Version identifier of the ML model used for this prediction.',
    `model_version_code` STRING COMMENT 'Unique identifier for the ML model that generated this prediction.',
    `pfas_breakthrough_prediction_flag` BOOLEAN COMMENT 'Prediction for PFAS breakthrough in GAC/IX',
    `predicted_class` STRING COMMENT 'For classification models, the predicted category or class label.',
    `predicted_label` STRING COMMENT 'Categorical/class label predicted by the model when applicable.',
    `predicted_probability` DOUBLE COMMENT 'For classification models, the probability of the predicted class.',
    `predicted_value` DECIMAL(18,2) COMMENT 'The numeric value predicted by the ML model.',
    `prediction_error` DOUBLE COMMENT 'Calculated error between predicted and actual values.',
    `prediction_horizon` STRING COMMENT 'Forecast horizon for the prediction (e.g. 1h, 24h, 7d, 30d).',
    `prediction_horizon_hours` STRING COMMENT 'Number of hours into the future the prediction applies to.',
    `prediction_ontology_class` STRING COMMENT 'Ontology: breakthrough, demand_forecast, leak_detection, water_quality',
    `prediction_timestamp` TIMESTAMP COMMENT 'Timestamp when the prediction was generated.',
    `prediction_type` STRING COMMENT 'Category of prediction (e.g., PFAS_BREAKTHROUGH, DEMAND_FORECAST, LEAK_DETECTION, ASSET_FAILURE, WATER_QUALITY).',
    `prediction_unit` STRING COMMENT 'Unit of measure for the predicted value (e.g., MGD, ppt, PSI, count).',
    `prediction_window_end` TIMESTAMP COMMENT 'End of the time window for which the prediction is valid.',
    `prediction_window_start` TIMESTAMP COMMENT 'Start of the time window for which the prediction is valid.',
    `scored_at` TIMESTAMP COMMENT 'Timestamp when the prediction was generated/scored.',
    `target_domain` STRING COMMENT 'Logical domain this prediction serves (e.g. treatment, distribution, quality, metering).',
    `target_entity` STRING COMMENT 'Name of the entity/table the prediction pertains to (generic linkage usable across domains).',
    `target_entity_key` BIGINT COMMENT 'Identifier of the specific record the prediction pertains to within the target entity.',
    `target_entity_ref` BIGINT COMMENT 'Foreign key to the entity being predicted, interpreted based on target_entity_type.',
    `target_entity_type` STRING COMMENT 'Type of entity being predicted (e.g., facility, pipe_main, meter, customer_account).',
    `threshold_value` DECIMAL(18,2) COMMENT 'Decision threshold used for classification or alerting.',
    `training_dataset_code` STRING COMMENT 'Identifier of the dataset used to train the model.',
    `training_date` DATE COMMENT 'Date when the model was last trained.',
    `training_run_code` STRING COMMENT 'Identifier of the training run that produced the model version.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the predicted/actual value.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last updated.',
    `upper_bound` DOUBLE COMMENT 'Upper bound of the prediction interval.',
    `validation_timestamp` TIMESTAMP COMMENT 'Timestamp when the prediction was validated against actuals.',
    CONSTRAINT pk_treatment_prediction_event PRIMARY KEY(`treatment_prediction_event_id`)
) COMMENT 'Generic ML/AI prediction storage entity capturing predicted values, actual outcomes, confidence scores, and model metadata for water utility predictive analytics including PFAS breakthrough, demand forecasting, leak detection, and asset failure prediction.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ADD CONSTRAINT `fk_treatment_process_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ADD CONSTRAINT `fk_treatment_process_reading_scada_tag_id` FOREIGN KEY (`scada_tag_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`scada_tag`(`scada_tag_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_chemical_id` FOREIGN KEY (`chemical_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`chemical`(`chemical_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ADD CONSTRAINT `fk_treatment_chemical_dose_event_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ADD CONSTRAINT `fk_treatment_ct_compliance_record_treatment_violation_id` FOREIGN KEY (`treatment_violation_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_violation`(`treatment_violation_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ADD CONSTRAINT `fk_treatment_filter_run_filter_unit_id` FOREIGN KEY (`filter_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`filter_unit`(`filter_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ADD CONSTRAINT `fk_treatment_backwash_event_filter_unit_id` FOREIGN KEY (`filter_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`filter_unit`(`filter_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ADD CONSTRAINT `fk_treatment_finished_water_production_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ADD CONSTRAINT `fk_treatment_source_water_intake_water_source_id` FOREIGN KEY (`water_source_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`water_source`(`water_source_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ADD CONSTRAINT `fk_treatment_membrane_performance_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ADD CONSTRAINT `fk_treatment_uv_disinfection_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ADD CONSTRAINT `fk_treatment_sludge_production_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_chemical_id` FOREIGN KEY (`chemical_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`chemical`(`chemical_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ADD CONSTRAINT `fk_treatment_chemical_inventory_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ADD CONSTRAINT `fk_treatment_process_control_setpoint_scada_tag_id` FOREIGN KEY (`scada_tag_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`scada_tag`(`scada_tag_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_discharge_point_id` FOREIGN KEY (`discharge_point_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`discharge_point`(`discharge_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ADD CONSTRAINT `fk_treatment_treatment_permit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ADD CONSTRAINT `fk_treatment_treatment_violation_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ADD CONSTRAINT `fk_treatment_mor_submission_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ADD CONSTRAINT `fk_treatment_scada_tag_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ADD CONSTRAINT `fk_treatment_scada_tag_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ADD CONSTRAINT `fk_treatment_facility_service_allocation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ADD CONSTRAINT `fk_treatment_chemical_supply_agreement_chemical_id` FOREIGN KEY (`chemical_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`chemical`(`chemical_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ADD CONSTRAINT `fk_treatment_facility_project_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ADD CONSTRAINT `fk_treatment_operator_qualification_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ADD CONSTRAINT `fk_treatment_process_maintenance_plan_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ADD CONSTRAINT `fk_treatment_process_compliance_monitoring_process_unit_id` FOREIGN KEY (`process_unit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`process_unit`(`process_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ADD CONSTRAINT `fk_treatment_permit_compliance_obligation_treatment_permit_id` FOREIGN KEY (`treatment_permit_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`treatment_permit`(`treatment_permit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ADD CONSTRAINT `fk_treatment_discharge_point_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ADD CONSTRAINT `fk_treatment_filter_unit_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ADD CONSTRAINT `fk_treatment_treatment_prediction_event_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `vibe_water_utilities_v1`.`treatment`.`facility`(`facility_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`treatment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`treatment` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` SET TAGS ('dbx_entity_type' = 'master');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_reconciled_depth' = '32');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_depth_tier' = 'canonical');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_fk' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility` ALTER COLUMN `pwsid` SET TAGS ('dbx_business_glossary_term' = 'PWSID');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `material_master_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `bed_volumes_to_breakthrough` SET TAGS ('dbx_business_glossary_term' = 'Bed Volumes to Breakthrough');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `design_capacity_gpm` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity GPM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity MGD');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `empty_bed_contact_time_min` SET TAGS ('dbx_business_glossary_term' = 'EBCT');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `technology_class` SET TAGS ('dbx_business_glossary_term' = 'Technology Class');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Unit Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `unit_number` SET TAGS ('dbx_business_glossary_term' = 'Unit Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` SET TAGS ('dbx_entity_type' = 'transactional');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Process Reading ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_reading_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `is_manual_entry` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `is_regulatory_exceedance` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exceedance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `parameter_type` SET TAGS ('dbx_business_glossary_term' = 'Parameter Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `reading_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reading Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_reading` ALTER COLUMN `regulatory_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` SET TAGS ('dbx_entity_type' = 'transactional');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_dose_event_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Dose Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_dose_event_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `chemical_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_dose_event` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_fk' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` SET TAGS ('dbx_entity_type' = 'compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ct_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'CT Compliance Record ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ct_compliance_record_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Violation');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `contact_time_min` SET TAGS ('dbx_business_glossary_term' = 'Contact Time');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ct_calculated` SET TAGS ('dbx_business_glossary_term' = 'CT Calculated');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ct_ratio` SET TAGS ('dbx_business_glossary_term' = 'CT Ratio');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ct_required` SET TAGS ('dbx_business_glossary_term' = 'CT Required');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `disinfectant_concentration` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Concentration');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `disinfectant_type` SET TAGS ('dbx_business_glossary_term' = 'Disinfectant Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `log_inactivation_achieved` SET TAGS ('dbx_business_glossary_term' = 'Log Inactivation Achieved');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `log_inactivation_required` SET TAGS ('dbx_business_glossary_term' = 'Log Inactivation Required');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`ct_compliance_record` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `filter_run_id` SET TAGS ('dbx_business_glossary_term' = 'Filter Run ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `filter_run_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `filter_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Filter Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `filter_unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `backwash_trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Backwash Trigger Reason');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `influent_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Influent Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `peak_effluent_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Peak Effluent Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `run_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Run Duration');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `run_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `run_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `terminal_effluent_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Terminal Effluent Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `terminal_head_loss_ft` SET TAGS ('dbx_business_glossary_term' = 'Terminal Head Loss');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `turbidity_mcl_exceedance` SET TAGS ('dbx_business_glossary_term' = 'Turbidity MCL Exceedance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_run` ALTER COLUMN `volume_filtered_mg` SET TAGS ('dbx_business_glossary_term' = 'Volume Filtered');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_event_id` SET TAGS ('dbx_business_glossary_term' = 'Backwash Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_event_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `filter_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Filter Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `filter_unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `air_scour_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Air Scour Duration');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `air_scour_used` SET TAGS ('dbx_business_glossary_term' = 'Air Scour Used');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Backwash End');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Backwash Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Backwash Start');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `backwash_water_volume_gal` SET TAGS ('dbx_business_glossary_term' = 'Backwash Water Volume');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `filter_to_waste_used` SET TAGS ('dbx_business_glossary_term' = 'Filter to Waste Used');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `filter_to_waste_volume_gal` SET TAGS ('dbx_business_glossary_term' = 'Filter to Waste Volume');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `post_backwash_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Post-Backwash Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `pre_backwash_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Pre-Backwash Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`backwash_event` ALTER COLUMN `trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Trigger Reason');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `finished_water_production_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Water Production ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `finished_water_production_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`finished_water_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `source_water_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Source Water Intake ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `source_water_intake_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`source_water_intake` ALTER COLUMN `water_source_id` SET TAGS ('dbx_fk' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `membrane_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Membrane Performance ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `membrane_performance_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `feed_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Feed Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `feed_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Feed Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `fouling_index` SET TAGS ('dbx_business_glossary_term' = 'Fouling Index');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `integrity_test_result` SET TAGS ('dbx_business_glossary_term' = 'Integrity Test Result');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `log_removal_value` SET TAGS ('dbx_business_glossary_term' = 'Log Removal Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `membrane_technology_type` SET TAGS ('dbx_business_glossary_term' = 'Membrane Technology Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `permeate_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Permeate Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `permeate_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Permeate Turbidity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `recovery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Recovery Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`membrane_performance` ALTER COLUMN `transmembrane_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Transmembrane Pressure');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_disinfection_event_id` SET TAGS ('dbx_business_glossary_term' = 'UV Disinfection Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_disinfection_event_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `dose_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Dose Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `lamp_hours_elapsed` SET TAGS ('dbx_business_glossary_term' = 'Lamp Hours Elapsed');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `lamp_status` SET TAGS ('dbx_business_glossary_term' = 'Lamp Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `log_inactivation_target` SET TAGS ('dbx_business_glossary_term' = 'Log Inactivation Target');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_dose_delivered_mj_cm2` SET TAGS ('dbx_business_glossary_term' = 'UV Dose Delivered');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_dose_required_mj_cm2` SET TAGS ('dbx_business_glossary_term' = 'UV Dose Required');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_intensity_mw_cm2` SET TAGS ('dbx_business_glossary_term' = 'UV Intensity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`uv_disinfection_event` ALTER COLUMN `uv_transmittance_pct` SET TAGS ('dbx_business_glossary_term' = 'UV Transmittance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `sludge_production_id` SET TAGS ('dbx_business_glossary_term' = 'Sludge Production ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `sludge_production_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `biosolids_class` SET TAGS ('dbx_business_glossary_term' = 'Biosolids Class');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `disposal_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Disposal Cost');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `disposal_site_name` SET TAGS ('dbx_business_glossary_term' = 'Disposal Site');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `dry_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Dry Weight');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `pathogen_reduction_method` SET TAGS ('dbx_business_glossary_term' = 'Pathogen Reduction Method');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `total_solids_pct` SET TAGS ('dbx_business_glossary_term' = 'Total Solids');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `volatile_solids_pct` SET TAGS ('dbx_business_glossary_term' = 'Volatile Solids');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`sludge_production` ALTER COLUMN `volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` SET TAGS ('dbx_subdomain' = 'chemical_management');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `chemical_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Inventory ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `chemical_inventory_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `chemical_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `vendor_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `is_epcra_reportable` SET TAGS ('dbx_business_glossary_term' = 'EPCRA Reportable');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `is_rmp_regulated` SET TAGS ('dbx_business_glossary_term' = 'RMP Regulated');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `sds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'SDS Reference');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `storage_container_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Container Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `process_control_setpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Process Control Setpoint ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `process_control_setpoint_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `high_alarm_limit` SET TAGS ('dbx_business_glossary_term' = 'High Alarm Limit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `is_mcl_related` SET TAGS ('dbx_business_glossary_term' = 'MCL Related');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `low_alarm_limit` SET TAGS ('dbx_business_glossary_term' = 'Low Alarm Limit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `setpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_control_setpoint` ALTER COLUMN `setpoint_value` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` SET TAGS ('dbx_entity_type' = 'compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `discharge_point_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `discharge_point_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `project_permit_id` SET TAGS ('dbx_references_ssot' = 'project.project_permit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `permitted_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_permit` ALTER COLUMN `pfas_monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'PFAS Monitoring Required');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_subdomain' = 'chemical_management');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` SET TAGS ('dbx_entity_type' = 'master');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `chemical_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical` ALTER COLUMN `material_master_id` SET TAGS ('dbx_fk' = 'true');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` SET TAGS ('dbx_entity_type' = 'compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Violation ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `treatment_violation_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `contaminant_name` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `enforcement_action_required` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Required');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `mcl_value` SET TAGS ('dbx_business_glossary_term' = 'MCL Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `violation_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `violation_status` SET TAGS ('dbx_business_glossary_term' = 'Violation Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` SET TAGS ('dbx_entity_type' = 'compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `mor_submission_id` SET TAGS ('dbx_business_glossary_term' = 'MOR Submission ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `mor_submission_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`mor_submission` ALTER COLUMN `total_production_mg` SET TAGS ('dbx_business_glossary_term' = 'Total Production');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` SET TAGS ('dbx_ECM' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_business_glossary_term' = 'SCADA Tag ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `scada_tag_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `online_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `online_instrument_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `engineering_unit` SET TAGS ('dbx_business_glossary_term' = 'Engineering Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `historian_server` SET TAGS ('dbx_business_glossary_term' = 'Historian Server');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `scan_rate_seconds` SET TAGS ('dbx_business_glossary_term' = 'Scan Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `tag_description` SET TAGS ('dbx_business_glossary_term' = 'Tag Description');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `tag_name` SET TAGS ('dbx_business_glossary_term' = 'Tag Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `tag_category` SET TAGS ('dbx_taxonomy' = 'scada_tag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `tag_category` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `tag_data_type` SET TAGS ('dbx_taxonomy' = 'scada_tag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `tag_data_type` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `tag_quality_class` SET TAGS ('dbx_taxonomy' = 'scada_tag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `tag_quality_class` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `engineering_units` SET TAGS ('dbx_taxonomy' = 'scada_tag');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`scada_tag` ALTER COLUMN `engineering_units` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` SET TAGS ('dbx_association_edges' = 'treatment.facility,service.service_territory');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `facility_service_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Service Allocation ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `facility_service_allocation_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `territory_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `allocated_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `allocation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_service_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` SET TAGS ('dbx_subdomain' = 'chemical_management');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` SET TAGS ('dbx_association_edges' = 'treatment.chemical,supply.vendor');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `chemical_supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Supply Agreement ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `chemical_supply_agreement_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `chemical_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`chemical_supply_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` SET TAGS ('dbx_association_edges' = 'treatment.facility,project.cip_project');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `facility_project_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `facility_project_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Project');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Project End Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `project_role` SET TAGS ('dbx_business_glossary_term' = 'Project Role');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`facility_project` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` SET TAGS ('dbx_association_edges' = 'treatment.process_unit,workforce.employee');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` SET TAGS ('dbx_entity_type' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `operator_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Qualification ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `operator_qualification_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `operator_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operator License');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `operator_license_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `certification_class` SET TAGS ('dbx_business_glossary_term' = 'Certification Class');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `operator_qualification_status` SET TAGS ('dbx_REQ' = 'VREQ-029');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `operator_qualification_status` SET TAGS ('dbx_added' = 'expansion');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `operator_qualification_notes` SET TAGS ('dbx_REQ' = 'VREQ-029');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `operator_qualification_notes` SET TAGS ('dbx_added' = 'expansion');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `effective_date` SET TAGS ('dbx_REQ' = 'VREQ-029');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `effective_date` SET TAGS ('dbx_added' = 'expansion');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `created_at` SET TAGS ('dbx_REQ' = 'VREQ-029');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`operator_qualification` ALTER COLUMN `created_at` SET TAGS ('dbx_added' = 'expansion');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` SET TAGS ('dbx_association_edges' = 'treatment.process_unit,asset.job_plan');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `process_maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Process Maintenance Plan ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `process_maintenance_plan_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Crew');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `crew_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `maintenance_frequency` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_maintenance_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` SET TAGS ('dbx_association_edges' = 'treatment.process_unit,compliance.permit_condition');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` SET TAGS ('dbx_entity_type' = 'compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `process_compliance_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Process Compliance Monitoring ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `process_compliance_monitoring_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `last_monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Last Monitoring Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `monitoring_parameter` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Parameter');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `next_monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Next Monitoring Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `process_compliance_monitoring_status` SET TAGS ('dbx_REQ' = 'VREQ-029');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `process_compliance_monitoring_status` SET TAGS ('dbx_added' = 'expansion');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `process_compliance_monitoring_notes` SET TAGS ('dbx_REQ' = 'VREQ-029');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `process_compliance_monitoring_notes` SET TAGS ('dbx_added' = 'expansion');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `effective_date` SET TAGS ('dbx_REQ' = 'VREQ-029');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `effective_date` SET TAGS ('dbx_added' = 'expansion');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `expiration_date` SET TAGS ('dbx_REQ' = 'VREQ-029');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`process_compliance_monitoring` ALTER COLUMN `expiration_date` SET TAGS ('dbx_added' = 'expansion');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` SET TAGS ('dbx_association_edges' = 'treatment.treatment_permit,compliance.regulatory_requirement');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` SET TAGS ('dbx_entity_type' = 'compliance');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `permit_compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Compliance Obligation ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `permit_compliance_obligation_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`permit_compliance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`water_source` SET TAGS ('dbx_entity_type' = 'master');
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
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` SET TAGS ('dbx_entity_type' = 'master');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `discharge_point_id` SET TAGS ('dbx_business_glossary_term' = 'Discharge Point ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `discharge_point_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `discharge_status` SET TAGS ('dbx_business_glossary_term' = 'Discharge Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `discharge_type` SET TAGS ('dbx_business_glossary_term' = 'Discharge Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `latitude` SET TAGS ('dbx_gis' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `longitude` SET TAGS ('dbx_gis' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `outfall_number` SET TAGS ('dbx_business_glossary_term' = 'Outfall Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`discharge_point` ALTER COLUMN `receiving_water_body` SET TAGS ('dbx_business_glossary_term' = 'Receiving Water Body');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` SET TAGS ('dbx_subdomain' = 'facility_operations');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` SET TAGS ('dbx_tier' = 'ECM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` SET TAGS ('dbx_domain' = 'treatment');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` SET TAGS ('dbx_entity_type' = 'operational');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `filter_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Filter Unit ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `filter_unit_id` SET TAGS ('dbx_pk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `facility_id` SET TAGS ('dbx_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `design_flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Design Flow Rate');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `filter_number` SET TAGS ('dbx_business_glossary_term' = 'Filter Number');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `filter_type` SET TAGS ('dbx_business_glossary_term' = 'Filter Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `media_type` SET TAGS ('dbx_business_glossary_term' = 'Media Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`filter_unit` ALTER COLUMN `surface_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Surface Area');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` SET TAGS ('dbx_subdomain' = 'process_control');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` SET TAGS ('dbx_tier' = 'MVM');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` SET TAGS ('dbx_domain' = 'analytics');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` SET TAGS ('dbx_ml' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `treatment_prediction_event_id` SET TAGS ('dbx_business_glossary_term' = 'Prediction Event ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `actual_class` SET TAGS ('dbx_business_glossary_term' = 'Actual Class');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `actual_label` SET TAGS ('dbx_business_glossary_term' = 'Actual Label');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `alert_triggered` SET TAGS ('dbx_business_glossary_term' = 'Alert Triggered');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `confidence` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `confidence_lower_bound` SET TAGS ('dbx_business_glossary_term' = 'Confidence Lower Bound');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `confidence_upper_bound` SET TAGS ('dbx_business_glossary_term' = 'Confidence Upper Bound');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `error_type` SET TAGS ('dbx_business_glossary_term' = 'Error Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `error_value` SET TAGS ('dbx_business_glossary_term' = 'Prediction Error');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `evaluated_at` SET TAGS ('dbx_business_glossary_term' = 'Evaluated At');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `feature_set_version` SET TAGS ('dbx_business_glossary_term' = 'Feature Set Version');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `feature_vector_json` SET TAGS ('dbx_business_glossary_term' = 'Feature Vector');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `is_actual_recorded` SET TAGS ('dbx_business_glossary_term' = 'Is Actual Recorded');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `is_anomaly` SET TAGS ('dbx_business_glossary_term' = 'Is Anomaly');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `is_validated` SET TAGS ('dbx_business_glossary_term' = 'Is Validated');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `lower_bound` SET TAGS ('dbx_business_glossary_term' = 'Prediction Lower Bound');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `model_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Model Algorithm');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `model_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `model_version_code` SET TAGS ('dbx_business_glossary_term' = 'Model ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `predicted_class` SET TAGS ('dbx_business_glossary_term' = 'Predicted Class');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `predicted_label` SET TAGS ('dbx_business_glossary_term' = 'Predicted Label');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `predicted_probability` SET TAGS ('dbx_business_glossary_term' = 'Predicted Probability');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `predicted_value` SET TAGS ('dbx_business_glossary_term' = 'Predicted Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `prediction_error` SET TAGS ('dbx_business_glossary_term' = 'Prediction Error');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `prediction_horizon` SET TAGS ('dbx_business_glossary_term' = 'Prediction Horizon');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `prediction_horizon_hours` SET TAGS ('dbx_business_glossary_term' = 'Prediction Horizon');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `prediction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prediction Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `prediction_type` SET TAGS ('dbx_business_glossary_term' = 'Prediction Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `prediction_unit` SET TAGS ('dbx_business_glossary_term' = 'Prediction Unit');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `prediction_window_end` SET TAGS ('dbx_business_glossary_term' = 'Prediction Window End');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `prediction_window_start` SET TAGS ('dbx_business_glossary_term' = 'Prediction Window Start');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `scored_at` SET TAGS ('dbx_business_glossary_term' = 'Scored At');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `target_domain` SET TAGS ('dbx_business_glossary_term' = 'Target Domain');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `target_entity` SET TAGS ('dbx_business_glossary_term' = 'Target Entity');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `target_entity_key` SET TAGS ('dbx_business_glossary_term' = 'Target Entity Key');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `target_entity_ref` SET TAGS ('dbx_business_glossary_term' = 'Target Entity ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `target_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Target Entity Type');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `training_dataset_code` SET TAGS ('dbx_business_glossary_term' = 'Training Dataset ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `training_date` SET TAGS ('dbx_business_glossary_term' = 'Training Date');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `training_run_code` SET TAGS ('dbx_business_glossary_term' = 'Training Run ID');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `upper_bound` SET TAGS ('dbx_business_glossary_term' = 'Prediction Upper Bound');
ALTER TABLE `vibe_water_utilities_v1`.`treatment`.`treatment_prediction_event` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
