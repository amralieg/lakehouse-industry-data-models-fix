-- Schema for Domain: quality | Business: Water_Utilities | Version: v2_mvm
-- Generated on: 2026-06-22 20:12:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`quality` COMMENT 'Water quality monitoring and compliance including sampling schedules, MCL/MCLG tracking, DBP monitoring (THM, HAA5), PFAS testing, turbidity (NTU), pH, BOD, COD, TSS, TDS, TOC analysis, bacteriological testing, CCR preparation, and regulatory compliance reporting. Manages water quality from source through distribution system and wastewater effluent discharge.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` (
    `sampling_point_id` BIGINT COMMENT 'Primary key',
    `compliance_permit_id` BIGINT COMMENT 'FK to compliance permit',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: DMAs are the primary operational unit for water quality monitoring and NRW/leakage correlation. Linking sampling points to DMAs supports DMA-level bacteriological and chemical compliance reports. The ',
    `facility_id` BIGINT COMMENT 'FK to facility',
    `manhole_id` BIGINT COMMENT 'Foreign key linking to wastewater.manhole. Business justification: Manholes serve as physical sampling locations for SSO monitoring, I/I characterization, and industrial pretreatment compliance sampling. Linking quality_sampling_point to the specific manhole enables ',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Pressure-zone-level water quality monitoring (TCR, LCRR, DBP compliance) requires linking sampling points to pressure zones. The existing plain-text pressure_zone column is a denormalized reference;',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: Pump stations with chlorine booster systems require dedicated post-pump sampling points for residual chlorine compliance monitoring. Linking sampling points to pump stations supports booster-station-s',
    `registry_id` BIGINT COMMENT 'FK to asset registry',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Regulatory monitoring location mandate: sampling points are established to satisfy specific regulatory_requirements (SDWA SWTR, LCR, TCR monitoring location requirements). This FK enables compliance m',
    `service_address_id` BIGINT COMMENT 'FK to service address',
    `sewershed_basin_id` BIGINT COMMENT 'Foreign key linking to wastewater.sewershed_basin. Business justification: Receiving water quality sampling points are organized by sewershed basin for watershed-level SSO impact assessment and MS4/NPDES stormwater reporting. Linking quality_sampling_point to sewershed_basin',
    `storage_tank_id` BIGINT COMMENT 'Foreign key linking to distribution.storage_tank. Business justification: Storage tanks are mandatory regulatory sampling locations for DBP monitoring, chlorine residual, bacteriological testing, and water age compliance. A water quality domain expert would expect sampling ',
    `water_source_id` BIGINT COMMENT 'Foreign key linking to treatment.water_source. Business justification: Source water sampling points must reference the water source for source water assessment and intake monitoring programs. quality_sampling_point has water_source_type as a plain text field but no FK; f',
    `water_system_id` BIGINT COMMENT 'FK to water system',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: NPDES compliance requires effluent sampling points to be formally associated with the WWTP they monitor. quality_sampling_point already has facility_id (wastewater.facility) but no direct FK to wastewa',
    `access_type` STRING COMMENT 'Access type',
    `ccr_reporting_flag` BOOLEAN COMMENT 'CCR reporting flag',
    `sampling_point_code` STRING COMMENT 'Sampling point code',
    `comments` STRING COMMENT 'Comments',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `decommission_date` DATE COMMENT 'Decommission date',
    `dmr_reporting_flag` BOOLEAN COMMENT 'DMR reporting flag',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation in feet',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Flow rate in GPM',
    `gis_feature_code` STRING COMMENT 'GIS feature code',
    `installation_date` DATE COMMENT 'Installation date',
    `last_sample_date` DATE COMMENT 'Last sample date',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude',
    `location_type` STRING COMMENT 'Location type',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude',
    `modified_by` STRING COMMENT 'Modified by',
    `modified_timestamp` TIMESTAMP COMMENT 'Modified timestamp',
    `sampling_point_name` STRING COMMENT 'Sampling point name',
    `next_scheduled_sample_date` DATE COMMENT 'Next scheduled sample date',
    `primary_contaminant_group` STRING COMMENT 'Primary contaminant group',
    `regulatory_zone` STRING COMMENT 'Regulatory zone',
    `residence_time_hours` DECIMAL(18,2) COMMENT 'Residence time in hours',
    `responsible_department` STRING COMMENT 'Responsible department',
    `safety_notes` STRING COMMENT 'Safety notes',
    `sample_collection_method` STRING COMMENT 'Sample collection method',
    `sampler_name` STRING COMMENT 'Sampler name',
    `sampling_frequency` STRING COMMENT 'Sampling frequency',
    `sampling_instructions` STRING COMMENT 'Sampling instructions',
    `sampling_point_status` STRING COMMENT 'Sampling point status',
    `scada_tag` STRING COMMENT 'SCADA tag',
    `treatment_stage` STRING COMMENT 'Treatment stage',
    `water_source_type` STRING COMMENT 'Water source type',
    `created_by` STRING COMMENT 'Created by',
    CONSTRAINT pk_sampling_point PRIMARY KEY(`sampling_point_id`)
) COMMENT 'Sampling point for water quality monitoring SSOT: Physical sampling point infrastructure is managed in asset.asset_sampling_point; this entity extends it with water quality monitoring context.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` (
    `sampling_schedule_id` BIGINT COMMENT 'Primary key',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Permit-driven monitoring: sampling schedules are mandated by specific compliance_permits (NPDES, operating permits with monitoring conditions). This FK enables permit compliance tracking, permit renew',
    `location_id` BIGINT COMMENT 'FK to monitoring location',
    `obligation_id` BIGINT COMMENT 'FK to obligation',
    `regulatory_requirement_id` BIGINT COMMENT 'FK to regulatory requirement',
    `sampling_point_id` BIGINT COMMENT 'FK to quality sampling point',
    `annual_budget_allocation` DECIMAL(18,2) COMMENT 'Annual budget allocation',
    `approved_by` STRING COMMENT 'Approved by',
    `approved_date` DATE COMMENT 'Approved date',
    `compliance_deadline_date` DATE COMMENT 'Compliance deadline date',
    `compliance_status` STRING COMMENT 'Compliance status',
    `cost_per_sample` DECIMAL(18,2) COMMENT 'Cost per sample',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `holding_time_hours` STRING COMMENT 'Holding time in hours',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `last_sample_collected_date` DATE COMMENT 'Last sample collected date',
    `modified_by` STRING COMMENT 'Modified by',
    `monitoring_period_end_date` DATE COMMENT 'Monitoring period end date',
    `monitoring_period_start_date` DATE COMMENT 'Monitoring period start date',
    `next_scheduled_sample_date` DATE COMMENT 'Next scheduled sample date',
    `notes` STRING COMMENT 'Notes',
    `notification_lead_time_days` STRING COMMENT 'Notification lead time in days',
    `preservation_method` STRING COMMENT 'Preservation method',
    `priority_level` STRING COMMENT 'Priority level',
    `regulatory_rule` STRING COMMENT 'Regulatory rule',
    `reporting_requirement` STRING COMMENT 'Reporting requirement',
    `sample_type` STRING COMMENT 'Sample type',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Sample volume in mL',
    `samples_collected_ytd` STRING COMMENT 'Samples collected YTD',
    `samples_per_period` STRING COMMENT 'Samples per period',
    `samples_required_ytd` STRING COMMENT 'Samples required YTD',
    `sampling_frequency` STRING COMMENT 'Sampling frequency',
    `sampling_method` STRING COMMENT 'Sampling method',
    `schedule_name` STRING COMMENT 'Schedule name',
    `schedule_status` STRING COMMENT 'Schedule status',
    `schedule_type` STRING COMMENT 'Schedule type',
    `seasonal_adjustment_flag` BOOLEAN COMMENT 'Seasonal adjustment flag',
    `violation_flag` BOOLEAN COMMENT 'Violation flag',
    CONSTRAINT pk_sampling_schedule PRIMARY KEY(`sampling_schedule_id`)
) COMMENT 'Schedule for water quality sampling activities';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` (
    `water_sample_id` BIGINT COMMENT 'Primary key',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Lead/copper first-draw sampling under LCR requires knowing the active meter installation at the sample site to record stagnation time, service line material, and site tier. water_sample has service_ad',
    `parent_sample_water_sample_id` BIGINT COMMENT 'FK to parent water sample',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: Process-stage sampling (filter effluent, post-GAC, post-disinfection) requires linking water samples to the specific process unit sampled. Operators use this for filter performance reporting, breakthr',
    `registry_id` BIGINT COMMENT 'FK to asset registry',
    `sampling_point_id` BIGINT COMMENT 'FK to quality sampling point',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Water samples are collected according to sampling schedules. This is a standard 1:N relationship where one schedule generates many samples over time. The FK allows tracking which regulatory or operati',
    `service_address_id` BIGINT COMMENT 'FK to service address',
    `water_source_id` BIGINT COMMENT 'Foreign key linking to treatment.water_source. Business justification: Source water quality monitoring requires linking water samples to the originating water source for source water assessment reporting (SDWA Section 1453). Operators and regulators track contaminant tre',
    `analysis_due_timestamp` TIMESTAMP COMMENT 'Analysis due timestamp',
    `collection_notes` STRING COMMENT 'Collection notes',
    `collection_timestamp` TIMESTAMP COMMENT 'Collection timestamp',
    `composite_duration_hours` DECIMAL(18,2) COMMENT 'Composite duration in hours',
    `composite_interval_minutes` STRING COMMENT 'Composite interval in minutes',
    `container_type` STRING COMMENT 'Container type',
    `container_volume_ml` STRING COMMENT 'Container volume in mL',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `field_chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'Field chlorine residual in mg/L',
    `field_conductivity_us_cm` DECIMAL(18,2) COMMENT 'Field conductivity in uS/cm',
    `field_dissolved_oxygen_mg_l` DECIMAL(18,2) COMMENT 'Field dissolved oxygen in mg/L',
    `field_ph` DECIMAL(18,2) COMMENT 'Field pH',
    `field_temperature_c` DECIMAL(18,2) COMMENT 'Field temperature in Celsius',
    `field_turbidity_ntu` DECIMAL(18,2) COMMENT 'Field turbidity in NTU',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Flow rate in GPM',
    `gis_latitude` DECIMAL(18,2) COMMENT 'GIS latitude',
    `gis_longitude` DECIMAL(18,2) COMMENT 'GIS longitude',
    `hold_time_hours` STRING COMMENT 'Hold time in hours',
    `lims_submission_code` STRING COMMENT 'LIMS submission code',
    `modified_timestamp` TIMESTAMP COMMENT 'Modified timestamp',
    `preservation_method` STRING COMMENT 'Preservation method',
    `quality_control_flag` BOOLEAN COMMENT 'Quality control flag',
    `regulatory_program` STRING COMMENT 'Regulatory program',
    `requested_analysis_group` STRING COMMENT 'Requested analysis group',
    `sample_location_description` STRING COMMENT 'Sample location description',
    `sample_matrix` STRING COMMENT 'Sample matrix',
    `sample_number` STRING COMMENT 'Sample number',
    `sample_purpose` STRING COMMENT 'Sample purpose',
    `sample_status` STRING COMMENT 'Sample status',
    `sampler_equipment_code` BIGINT COMMENT 'Sampler equipment code',
    `weather_conditions` STRING COMMENT 'Weather conditions',
    CONSTRAINT pk_water_sample PRIMARY KEY(`water_sample_id`)
) COMMENT 'Water sample collected for quality testing SSOT: This is the canonical source for water sample collection events; laboratory.lab_sample extends this with LIMS-specific workflow context.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` (
    `analytical_result_id` BIGINT COMMENT 'Primary key',
    `chemical_id` BIGINT COMMENT 'Foreign key linking to treatment.chemical. Business justification: PFAS source attribution and treatment efficacy reporting require linking analytical results to the specific treatment chemical detected or formed as a byproduct. Regulators and operators use this to d',
    `contaminant_id` BIGINT COMMENT 'FK to contaminant',
    `contaminant_limit_id` BIGINT COMMENT 'FK to contaminant limit',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Regulatory reporting audit trail: utilities must document which regulatory_submission (DMR, SDWA report) included each analytical_result. Required for agency dispute resolution, resubmission workflows',
    `water_sample_id` BIGINT COMMENT 'FK to water sample',
    `analysis_date` DATE COMMENT 'Analysis date',
    `analysis_timestamp` TIMESTAMP COMMENT 'Analysis timestamp',
    `analytical_method` STRING COMMENT 'Analytical method',
    `calibration_date` DATE COMMENT 'Calibration date',
    `compliance_exceeded` BOOLEAN COMMENT 'Compliance exceeded flag',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `data_validation_level` STRING COMMENT 'Data validation level',
    `detection_limit` DECIMAL(18,2) COMMENT 'Detection limit',
    `dilution_factor` DECIMAL(18,2) COMMENT 'Dilution factor',
    `eu_sum20_contribution_ng_l` DECIMAL(18,2) COMMENT 'EU sum-of-20 contribution in ng/L',
    `hazard_index_contribution` DECIMAL(18,2) COMMENT 'Hazard index contribution',
    `hazard_quotient` DECIMAL(18,2) COMMENT 'Hazard quotient',
    `hold_time_compliant` BOOLEAN COMMENT 'Hold time compliant flag',
    `hold_time_hours` STRING COMMENT 'Hold time in hours',
    `is_pfas_result` BOOLEAN COMMENT 'Is PFAS result flag',
    `jurisdiction_code` STRING COMMENT 'Jurisdiction code (US/EU/other)',
    `laboratory_accreditation_number` STRING COMMENT 'Laboratory accreditation number',
    `lims_result_code` STRING COMMENT 'LIMS result code',
    `mcl_value` DECIMAL(18,2) COMMENT 'MCL value',
    `mclg_value` DECIMAL(18,2) COMMENT 'MCLG value',
    `modified_timestamp` TIMESTAMP COMMENT 'Modified timestamp',
    `percent_recovery` DECIMAL(18,2) COMMENT 'Percent recovery',
    `pfas_compound_class` STRING COMMENT 'PFAS compound class (long-chain/short-chain)',
    `qualifier_code` STRING COMMENT 'Qualifier code',
    `quantitation_limit` DECIMAL(18,2) COMMENT 'Quantitation limit',
    `regulatory_framework` STRING COMMENT 'Regulatory framework (US/EU/WHO)',
    `relative_percent_difference` DECIMAL(18,2) COMMENT 'Relative percent difference',
    `reporting_required` BOOLEAN COMMENT 'Reporting required flag',
    `result_comment` STRING COMMENT 'Result comment',
    `result_status` STRING COMMENT 'Result status',
    `result_value` DECIMAL(18,2) COMMENT 'Result value',
    `sample_matrix` STRING COMMENT 'Sample matrix',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `validated_by` STRING COMMENT 'Validated by',
    `validation_timestamp` TIMESTAMP COMMENT 'Validation timestamp',
    CONSTRAINT pk_analytical_result PRIMARY KEY(`analytical_result_id`)
) COMMENT 'Analytical result from water quality testing SSOT: This is the canonical source for all water quality analytical results across drinking water, wastewater, and source water monitoring.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` (
    `contaminant_id` BIGINT COMMENT 'Primary key',
    `chemical_id` BIGINT COMMENT 'Foreign key linking to treatment.chemical. Business justification: Treatment efficacy analysis requires linking regulated contaminants to treatment chemicals — e.g., confirming GAC or IX removal efficiency for a specific PFAS compound. Both tables share CAS numbers; ',
    `regulatory_requirement_id` BIGINT COMMENT 'FK to regulatory requirement',
    `action_level_unit` STRING COMMENT 'Action level unit',
    `action_level_value` DECIMAL(18,2) COMMENT 'Action level value',
    `analytical_method_code` STRING COMMENT 'Analytical method code',
    `cas_number` STRING COMMENT 'CAS number',
    `ccr_language_template` STRING COMMENT 'CCR language template',
    `ccr_reporting_required` BOOLEAN COMMENT 'CCR reporting required flag',
    `chain_class` STRING COMMENT 'Chain class',
    `contaminant_code` STRING COMMENT 'Contaminant code',
    `contaminant_status` STRING COMMENT 'Contaminant status',
    `contaminant_type` STRING COMMENT 'Contaminant type',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `detection_limit_unit` STRING COMMENT 'Detection limit unit',
    `detection_limit_value` DECIMAL(18,2) COMMENT 'Detection limit value',
    `effective_date` DATE COMMENT 'Effective date',
    `eu_class_restriction_flag` BOOLEAN COMMENT 'EU class restriction flag',
    `eu_dwd_parametric_value_ng_l` DECIMAL(18,2) COMMENT 'EU DWD parametric value in ng/L',
    `eu_parametric_value_ng_l` DECIMAL(18,2) COMMENT 'EU parametric value in ng/L',
    `eu_regulatory_framework` STRING COMMENT 'EU regulatory framework',
    `eu_sum20_member` BOOLEAN COMMENT 'EU sum-of-20 member flag',
    `eu_sum_of_20_limit_ng_l` DECIMAL(18,2) COMMENT 'EU sum-of-20 limit in ng/L',
    `eu_sum_of_20_member` BOOLEAN COMMENT 'EU sum-of-20 member flag',
    `eu_total_pfas_class_member` BOOLEAN COMMENT 'EU total PFAS class member flag',
    `eu_total_pfas_included` BOOLEAN COMMENT 'EU total PFAS included flag',
    `eu_total_pfas_limit_ng_l` DECIMAL(18,2) COMMENT 'EU total PFAS limit in ng/L',
    `eu_total_pfas_member` BOOLEAN COMMENT 'True if part of EU total PFAS class',
    `hazard_based_water_concentration_ng_l` DECIMAL(18,2) COMMENT 'Hazard-based water concentration in ng/L',
    `hazard_index_member` BOOLEAN COMMENT 'Hazard index member flag',
    `health_effect_category` STRING COMMENT 'Health effect category',
    `health_effect_description` STRING COMMENT 'Health effect description',
    `is_pfas` BOOLEAN COMMENT 'Is PFAS flag',
    `is_pfas_compound` BOOLEAN COMMENT 'Is PFAS compound flag',
    `jurisdiction_code` STRING COMMENT 'Jurisdiction code (US/EU/other)',
    `mcl_unit` STRING COMMENT 'MCL unit',
    `mcl_value` DECIMAL(18,2) COMMENT 'MCL value',
    `mclg_unit` STRING COMMENT 'MCLG unit',
    `mclg_value` DECIMAL(18,2) COMMENT 'MCLG value',
    `modified_timestamp` TIMESTAMP COMMENT 'Modified timestamp',
    `monitoring_frequency_code` STRING COMMENT 'Monitoring frequency code',
    `monitoring_location_type` STRING COMMENT 'Monitoring location type',
    `contaminant_name` STRING COMMENT 'Contaminant name',
    `notes` STRING COMMENT 'Notes',
    `npdes_effluent_limit_unit` STRING COMMENT 'NPDES effluent limit unit',
    `npdes_effluent_limit_value` DECIMAL(18,2) COMMENT 'NPDES effluent limit value',
    `pfas_chain_class` STRING COMMENT 'PFAS chain class (long-chain, short-chain)',
    `pfas_chain_length` STRING COMMENT 'PFAS chain length',
    `pfas_chain_length_class` STRING COMMENT 'PFAS chain length class (long/short)',
    `pfas_chain_type` STRING COMMENT 'PFAS chain type',
    `pfas_class` STRING COMMENT 'PFAS class',
    `pfas_regulatory_framework` STRING COMMENT 'PFAS regulatory framework',
    `pfas_regulatory_framework_note` STRING COMMENT 'PFAS regulatory framework note',
    `public_notification_tier` STRING COMMENT 'Public notification tier',
    `regulatory_framework` STRING COMMENT 'Regulatory framework (EPA, EU DWD, etc.)',
    `regulatory_program` STRING COMMENT 'Regulatory program',
    `reporting_threshold_unit` STRING COMMENT 'Reporting threshold unit',
    `reporting_threshold_value` DECIMAL(18,2) COMMENT 'Reporting threshold value',
    `revision_date` DATE COMMENT 'Revision date',
    `source_category` STRING COMMENT 'Source category',
    `source_description` STRING COMMENT 'Source description',
    `subgroup` STRING COMMENT 'Subgroup',
    `treatment_technique_description` STRING COMMENT 'Treatment technique description',
    `treatment_technique_required` BOOLEAN COMMENT 'Treatment technique required flag',
    `treatment_technology_options` STRING COMMENT 'Treatment technology options (GAC, ion exchange, etc.)',
    `us_hazard_index_member` BOOLEAN COMMENT 'US hazard index member flag',
    `us_hbwc_ng_l` DECIMAL(18,2) COMMENT 'US hazard-based water concentration in ng/L',
    `us_mcl_ng_l` DECIMAL(18,2) COMMENT 'US MCL in ng/L',
    `us_mclg_ng_l` DECIMAL(18,2) COMMENT 'US MCLG in ng/L',
    `violation_trigger_logic` STRING COMMENT 'Violation trigger logic',
    `wastewater_parameter` BOOLEAN COMMENT 'Wastewater parameter flag',
    `who_guideline_unit` STRING COMMENT 'WHO guideline unit',
    `who_guideline_value` DECIMAL(18,2) COMMENT 'WHO guideline value',
    CONSTRAINT pk_contaminant PRIMARY KEY(`contaminant_id`)
) COMMENT 'Contaminant master list for water quality monitoring SSOT: This is the canonical master for all contaminant definitions, regulatory limits, and monitoring requirements across all water quality programs.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` (
    `contaminant_limit_id` BIGINT COMMENT 'Primary key',
    `contaminant_id` BIGINT COMMENT 'FK to contaminant',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: MCL/limit regulatory traceability: contaminant_limit records operationalize specific regulatory_requirements (SDWA MCLs, EU DWD parametric values). This FK normalizes the denormalized applicable_regul',
    `treatment_permit_id` BIGINT COMMENT 'FK to treatment permit',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: NPDES permits specify effluent contaminant limits per WWTP. contaminant_limit has treatment_permit_id but no direct FK to wastewater.wwtp; this link enables direct retrieval of all NPDES effluent limi',
    `analytical_method_required` STRING COMMENT 'Analytical method required',
    `averaging_period` STRING COMMENT 'Averaging period',
    `ccr_reporting_required` BOOLEAN COMMENT 'CCR reporting required flag',
    `compliance_status` STRING COMMENT 'Compliance status',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `detection_limit_required` DECIMAL(18,2) COMMENT 'Detection limit required',
    `effective_date` DATE COMMENT 'Effective date',
    `exceedance_action_required` STRING COMMENT 'Exceedance action required',
    `health_effect_category` STRING COMMENT 'Health effect category',
    `jurisdiction` STRING COMMENT 'Jurisdiction (US/EU/other)',
    `jurisdiction_authority` STRING COMMENT 'Jurisdiction authority',
    `limit_type` STRING COMMENT 'Limit type',
    `limit_value` DECIMAL(18,2) COMMENT 'Limit value',
    `monitoring_frequency_required` STRING COMMENT 'Monitoring frequency required',
    `notes` STRING COMMENT 'Notes',
    `public_notification_tier` STRING COMMENT 'Public notification tier',
    `sample_location_type` STRING COMMENT 'Sample location type',
    `superseded_date` DATE COMMENT 'Superseded date',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `updated_timestamp` TIMESTAMP COMMENT 'Updated timestamp',
    `variance_expiration_date` DATE COMMENT 'Variance expiration date',
    `variance_waiver_flag` BOOLEAN COMMENT 'Variance waiver flag',
    CONSTRAINT pk_contaminant_limit PRIMARY KEY(`contaminant_limit_id`)
) COMMENT 'Regulatory and operational limits for each contaminant at each applicable monitoring context (drinking water, effluent discharge, source water). Captures MCL, MCLG, action level, treatment technique standard, permit-specific effluent limit (daily max, monthly average), applicable regulation citation, effective date, superseded date, and jurisdiction (federal, state primacy agency). Enables automated compliance comparison against analytical_result values.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` (
    `exceedance_id` BIGINT COMMENT 'Primary key',
    `analytical_result_id` BIGINT COMMENT 'FK to analytical result',
    `ccr_period_id` BIGINT COMMENT 'Foreign key linking to quality.ccr_period. Business justification: An exceedance event is reported within a specific annual CCR reporting period. ccr_period tracks mcl_violation_count, monitoring_violation_count, and treatment_technique_violation_count as aggregates,',
    `contaminant_id` BIGINT COMMENT 'FK to contaminant',
    `contaminant_limit_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant_limit. Business justification: Exceedances are violations of specific regulatory or operational limits. Currently exceedance links to contaminant (the substance) but not to the specific limit record that was exceeded. Adding contam',
    `facility_id` BIGINT COMMENT 'FK to facility',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: Corrective action workflows require identifying which process unit failed when an exceedance occurs (e.g., filter breakthrough, disinfection failure). Linking exceedance to process_unit enables target',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Exceedance reporting traceability: SDWA requires utilities to document which regulatory_submission formally reported each exceedance to the primacy agency. Enables audit trail for agency follow-up, re',
    `sampling_point_id` BIGINT COMMENT 'FK to sampling point',
    `violation_id` BIGINT COMMENT 'FK to compliance violation',
    `water_sample_id` BIGINT COMMENT 'FK to water sample',
    `wwtp_id` BIGINT COMMENT 'Foreign key linking to wastewater.wwtp. Business justification: NPDES permit exceedances must be attributed to the specific WWTP that caused them for regulatory enforcement, corrective action tracking, and DMR reporting. exceedance has facility_id (wastewater.facil',
    `corrective_action_required` BOOLEAN COMMENT 'Corrective action required flag',
    `created_timestamp` TIMESTAMP COMMENT 'Created timestamp',
    `exceedance_date` DATE COMMENT 'Exceedance date',
    `exceedance_type` STRING COMMENT 'Exceedance type',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Last modified timestamp',
    `measured_value` DECIMAL(18,2) COMMENT 'Measured value',
    `notes` STRING COMMENT 'Notes',
    `parameter_name` STRING COMMENT 'Parameter name',
    `public_notification_required` BOOLEAN COMMENT 'Public notification required flag',
    `resolution_date` DATE COMMENT 'Resolution date',
    `resolution_status` STRING COMMENT 'Resolution status',
    `severity` STRING COMMENT 'Exceedance severity',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    CONSTRAINT pk_exceedance PRIMARY KEY(`exceedance_id`)
) COMMENT 'Transactional record of each confirmed MCL, action level, or permit limit exceedance detected from analytical results. Captures exceedance date, contaminant, sampling point, measured value, applicable limit, exceedance magnitude, regulatory notification deadline, public notification requirement flag, corrective action required, and resolution status. This is the primary operational record driving regulatory response workflows and violation tracking. SSOT: References quality.analytical_result as the canonical source for measured values; this entity captures regulatory exceedance events and response actions.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` (
    `lead_copper_result_id` BIGINT COMMENT 'Unique identifier for the lead and copper sampling result record.',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Lead and copper results are for specific contaminants (lead or copper). This FK identifies which contaminant the result applies to, enabling proper linkage to contaminant limits and regulatory require',
    `contaminant_limit_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant_limit. Business justification: Each Lead and Copper Rule (LCR/LCRR) result is evaluated against a specific regulatory action level defined in contaminant_limit. lead_copper_result already captures lead_action_level_exceeded and cop',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with the sampling site premises.',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Lead and Copper Rule explicitly requires sampling at customer taps with documented service line materials. Meter installation is the sampling location for tier classification, 90th percentile calculat',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Premise characteristics (service line material, building age, plumbing configuration) are mandatory for lead/copper site selection, tier classification, and LCRR compliance. Business process: site inv',
    `sampling_point_id` BIGINT COMMENT 'Reference to the customer tap location selected for Lead and Copper Rule monitoring.',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Lead/copper monitoring follows LCR sampling rounds with specific site selection and frequency requirements. Links result to regulatory schedule for 90th percentile calculation, action level exceedance',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Lead/copper sampling requires precise service address tracking for tier site selection, customer notification within 30 days of result, and LCRR compliance documentation. Already has customer_account_',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: LCR violation traceability: when lead_action_level_exceeded or copper_action_level_exceeded is true, the result directly triggers a compliance_violation under the Lead and Copper Rule. This FK enables',
    `water_sample_id` BIGINT COMMENT 'Laboratory-assigned unique identifier for the physical water sample collected at the tap.',
    `analysis_date` DATE COMMENT 'Date when the laboratory completed the lead and copper analysis.',
    `analysis_method` STRING COMMENT 'EPA-approved analytical method used for lead and copper determination (e.g., EPA 200.8 ICP-MS, EPA 200.9 ICP-AES).. Valid values are `EPA_200.8|EPA_200.9|ASTM_D3559`',
    `copper_action_level_exceeded` BOOLEAN COMMENT 'Indicates whether the copper result exceeds the EPA action level of 1300 ppb (1.3 mg/L), triggering potential corrosion control treatment requirements.',
    `copper_result_ppb` DECIMAL(18,2) COMMENT 'Measured concentration of copper in the water sample expressed in parts per billion (ppb or µg/L). Used for 90th percentile calculation and action level comparison.',
    `corrosion_control_treatment_status` STRING COMMENT 'Status of corrosion control treatment optimization at the time of sampling, indicating whether the water system has optimized corrosion control per LCRR requirements.. Valid values are `optimal|suboptimal|not_optimized|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lead and copper result record was first created in the system.',
    `customer_notification_date` DATE COMMENT 'Date when the customer was notified of their individual lead and copper sample result.',
    `customer_notification_sent` BOOLEAN COMMENT 'Indicates whether the customer was notified of their individual sample result as required by LCRR within 30 days of receiving results.',
    `detection_limit_copper_ppb` DECIMAL(18,2) COMMENT 'Minimum concentration of copper that the analytical method can reliably detect and quantify for this sample.',
    `detection_limit_lead_ppb` DECIMAL(18,2) COMMENT 'Minimum concentration of lead that the analytical method can reliably detect and quantify for this sample.',
    `holding_time_compliant` BOOLEAN COMMENT 'Indicates whether the sample was analyzed within the EPA-required holding time (6 months for metals) from collection to analysis.',
    `included_in_90th_percentile` DECIMAL(18,2) COMMENT 'Indicates whether this result was included in the 90th percentile calculation for LCRR compliance determination. Invalid or QC-failed samples are excluded.',
    `lead_action_level_exceeded` BOOLEAN COMMENT 'Indicates whether the lead result exceeds the EPA action level of 15 ppb, triggering potential corrosion control treatment requirements.',
    `lead_result_ppb` DECIMAL(18,2) COMMENT 'Measured concentration of lead in the water sample expressed in parts per billion (ppb or µg/L). Used for 90th percentile calculation and action level comparison.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lead and copper result record was last updated in the system.',
    `quality_control_status` STRING COMMENT 'Laboratory quality control status indicating whether the sample result passed all QC checks including blanks, duplicates, and spike recoveries.. Valid values are `passed|failed|pending`',
    `regulatory_reporting_status` STRING COMMENT 'Status of this result in the regulatory reporting workflow to state primacy agency and EPA.. Valid values are `pending|submitted|accepted|rejected`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, observations, or special circumstances related to the sample collection or analysis.',
    `sample_collection_date` DATE COMMENT 'Date when the first-draw water sample was collected at the customer tap.',
    `sample_collection_time` TIMESTAMP COMMENT 'Precise timestamp when the first-draw water sample was collected, including time of day to verify minimum stagnation period compliance.',
    `sample_ph` DECIMAL(18,2) COMMENT 'pH measurement of the water sample at collection, relevant for corrosion control assessment.',
    `sample_preservation_method` STRING COMMENT 'Method used to preserve the sample for metals analysis, typically acidification with nitric acid to pH < 2.. Valid values are `nitric_acid|unpreserved`',
    `sample_temperature_c` DECIMAL(18,2) COMMENT 'Water temperature at the time of sample collection, recorded to document field conditions.',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Volume of the first-draw water sample collected, typically 1 liter (1000 mL) per LCRR protocol.',
    `service_line_material` STRING COMMENT 'Material composition of the customer service line as classified under LCRR for site selection and tiering. [ENUM-REF-CANDIDATE: lead|galvanized_requiring_replacement|lead_status_unknown|non_lead|copper|plastic|steel|iron|unknown — promote to reference product]',
    `site_tier` STRING COMMENT 'LCRR-mandated tier classification of the sampling site based on service line material and building construction date (Tier 1: lead service lines, Tier 2: lead status unknown, Tier 3: non-lead).. Valid values are `tier_1|tier_2|tier_3`',
    `stagnation_time_hours` DECIMAL(18,2) COMMENT 'Duration in hours that water remained stagnant in the service line prior to sample collection. LCRR requires minimum 6-hour stagnation for first-draw samples.',
    CONSTRAINT pk_lead_copper_result PRIMARY KEY(`lead_copper_result_id`)
) COMMENT 'Specialized transactional record for Lead and Copper Rule (LCR/LCRR) monitoring at customer tap sampling sites. Captures sampling round (6-month period), customer service line material classification (lead, galvanized, copper, unknown), first-draw sample result (lead ppb, copper ppb), 90th percentile calculation inputs, action level exceedance flag (lead >15 ppb, copper >1300 ppb), tier classification of sampling site, and corrosion control treatment optimization status. Distinct from general analytical_result due to LCRR-specific site selection, tiering, and 90th percentile compliance methodology.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` (
    `ccr_period_id` BIGINT COMMENT 'Unique identifier for the Consumer Confidence Report period. Primary key.',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: CCR submission routing: each annual CCR is submitted to a specific regulatory_agency (primacy agency). This FK normalizes the denormalized primacy_agency text field on ccr_period, enabling automated s',
    `regulatory_requirement_id` BIGINT COMMENT 'FK to the governing regulatory requirement, providing the parallel US/EU/other reference path.',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: CCR regulatory filing: each ccr_period results in a formal regulatory_submission filed with the primacy agency. This FK enables tracking submission status, acknowledgment receipt, and agency response ',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: A Consumer Confidence Report (CCR) period is produced for a specific water system. ccr_period currently stores water_system_name as a denormalized STRING, but water_system is the authoritative master ',
    `certification_method` STRING COMMENT 'Method used to submit the CCR certification to the primacy agency. Many states now require electronic submission through online portals.. Valid values are `electronic|mail|fax|online_portal`',
    `certification_submission_date` DATE COMMENT 'Date when the CCR certification was submitted to the primacy agency. Systems must certify delivery of the CCR to customers by October 1.',
    `certified_by_name` STRING COMMENT 'Name of the authorized water system official who certified the CCR. Typically the system manager, superintendent, or designated compliance officer.',
    `certified_by_title` STRING COMMENT 'Job title of the authorized official who certified the CCR.',
    `comments` STRING COMMENT 'Additional notes, observations, or context about this CCR period, preparation process, or special circumstances.',
    `contact_email` STRING COMMENT 'Email address for customer inquiries about the CCR. Increasingly included as an additional contact method.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the water system contact person for customer questions about the CCR. Required to be included in the published report.',
    `contact_phone` STRING COMMENT 'Phone number for customer inquiries about the CCR. Required to be included in the published report.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CCR period record was first created in the system.',
    `customers_served_count` STRING COMMENT 'Total number of customer accounts or service connections served by the water system during the report year. Used to determine CCR distribution requirements.',
    `detected_contaminant_count` STRING COMMENT 'Total number of regulated contaminants detected in the water system during the report year. Includes contaminants above and below Maximum Contaminant Levels (MCL).',
    `distribution_method` STRING COMMENT 'Primary method used to deliver the Consumer Confidence Report to customers. EPA allows mail, electronic delivery, or posting with notification.. Valid values are `mailed|posted_online|electronic_delivery|newspaper|combination`',
    `document_file_path` STRING COMMENT 'File system path or cloud storage location of the final published CCR document (typically PDF format).',
    `eu_article_17_compliance_flag` BOOLEAN COMMENT 'Whether this reporting period meets EU DWD 2020/2184 Article 17 requirements for consumer information and online access to water quality data.',
    `eu_information_access_method` STRING COMMENT 'Method by which consumer water quality information is made accessible per EU DWD 2020/2184 Art 14 (e.g. online portal, annual mailing, on-request). NULL for US jurisdiction.',
    `eu_reference_path` STRING COMMENT 'EU reference path: Drinking Water Directive 2020/2184; REACH; WFD; UWWTD citation chain.',
    `health_effects_language_included_flag` BOOLEAN COMMENT 'Indicates whether mandatory EPA health effects language was included for all detected contaminants. Required for CCR compliance.',
    `jurisdiction` STRING COMMENT 'Jurisdiction flavor for this record. Allowed: US,EU,OTHER.',
    `jurisdiction_code` STRING COMMENT 'Regulatory jurisdiction for this CCR/consumer information report (US_EPA, US_STATE, EU_MEMBER_STATE, OTHER). EU equivalent is DWD 2020/2184 Article 17 consumer information provision.',
    `jurisdiction_region` STRING COMMENT 'Regulatory region code (US, EU, OTHER) for this consumer confidence report period. US requires annual CCR per SDWA; EU requires equivalent consumer information under Drinking Water Directive 2020/2184 Article 17.',
    `language_accessibility_provided_flag` BOOLEAN COMMENT 'Indicates whether the CCR was made available in languages other than English to serve non-English speaking populations. Required for systems serving significant non-English speaking populations.',
    `lead_copper_educational_information_flag` BOOLEAN COMMENT 'Indicates whether mandatory lead and copper educational information was included in the CCR. Required under Lead and Copper Rule Revisions (LCRR).',
    `mcl_violation_count` STRING COMMENT 'Number of Maximum Contaminant Level violations that occurred during the report year. Must be prominently disclosed in the CCR.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this CCR period record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CCR period record was last modified.',
    `monitoring_violation_count` STRING COMMENT 'Number of monitoring and reporting violations that occurred during the report year. Includes failures to test or report as required.',
    `online_ccr_url` STRING COMMENT 'Web address where the CCR is posted online. Required if using electronic delivery method.',
    `population_served_count` STRING COMMENT 'Estimated total population receiving water from the system during the report year. Used for regulatory classification and reporting.',
    `preparation_start_date` DATE COMMENT 'Date when preparation of the Consumer Confidence Report began. Typically starts in January following the report year.',
    `publication_date` DATE COMMENT 'Date when the Consumer Confidence Report was published and made available to customers. Must be by July 1 following the report year per EPA regulations.',
    `pwsid` STRING COMMENT 'EPA-assigned unique identifier for the public water system. Format: two-letter state code followed by seven digits (e.g., CA1234567).. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory framework for the region (US=EPA/AWWA/NPDWR/UCMR/NPDES; EU=Drinking Water Directive 2020/2184; REACH; Water Framework Directive; Urban Wastewater Treatment Directive; OTHER=Other national/regional frameworks).',
    `regulatory_region` STRING COMMENT 'Top-level regulatory region (US, EU, OTHER). US requires annual CCR per SDWA; EU requires real-time online access to water quality data per DWD 2020/2184 Article 17. Allowed regions: US,EU,OTHER.',
    `regulatory_region_code` STRING COMMENT 'ISO region code identifying the jurisdiction for this consumer confidence / water quality report period (US, EU, OTHER). US uses CCR per SDWA; EU uses DWD 2020/2184 Art 14 consumer information.',
    `report_status` STRING COMMENT 'Current lifecycle status of the Consumer Confidence Report. Tracks progression from draft through publication and certification to primacy agency.. Valid values are `draft|in_review|approved|published|certified|archived`',
    `report_year` STRING COMMENT 'Calendar year for which this Consumer Confidence Report is prepared. CCRs are annual reports covering the previous calendar years water quality data.',
    `source_water_assessment_summary` STRING COMMENT 'Summary of the source water assessment including susceptibility to contamination and availability information. Required CCR content element.',
    `special_notices_included` STRING COMMENT 'Description of any special notices included in the CCR such as boil water advisories, vulnerable population warnings, or emerging contaminant information.',
    `treatment_technique_violation_count` STRING COMMENT 'Number of treatment technique violations that occurred during the report year. Treatment techniques are required processes for contaminants without MCLs.',
    `us_reference_path` STRING COMMENT 'US reference path: EPA/AWWA/NPDWR/UCMR/NPDES citation chain.',
    `violation_summary` STRING COMMENT 'Narrative summary of all violations that occurred during the report year, including health effects language and corrective actions taken. Required CCR content element.',
    `water_source_summary` STRING COMMENT 'Narrative description of the water systems sources including surface water, groundwater, purchased water, and source water protection information. Required CCR content element.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this CCR period record.',
    CONSTRAINT pk_ccr_period PRIMARY KEY(`ccr_period_id`)
) COMMENT 'Master record for each annual Consumer Confidence Report (CCR) reporting period. Captures report year, water system name, PWSID (Public Water System ID), primacy agency, report preparation status, publication date, distribution method (mailed, posted, electronic), number of customers served, water source summary, detected contaminant summary count, violation summary, and certification submission date to primacy agency. Serves as the organizing entity for all CCR-related quality data aggregation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`quality`.`water_system` (
    `water_system_id` BIGINT COMMENT 'Primary key for water_system',
    `parent_water_system_id` BIGINT COMMENT 'Self-referencing FK on water_system (parent_water_system_id)',
    `regulatory_agency_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_agency. Business justification: Primacy agency assignment: every water system is regulated by a specific regulatory_agency (primacy agency under SDWA). This FK normalizes the denormalized primacy_agency text field, enabling inspecti',
    `active_flag` BOOLEAN COMMENT '',
    `average_daily_consumption_mgd` DECIMAL(18,2) COMMENT 'Average daily water consumption served by the system.',
    `average_daily_production_mgd` DECIMAL(18,2) COMMENT 'Average daily water production volume.',
    `capacity_mgd` DECIMAL(18,2) COMMENT 'Maximum designed water flow capacity.',
    `chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'Typical residual chlorine concentration.',
    `classification` STRING COMMENT 'Ownership and governance classification of the water system.',
    `commissioning_date` DATE COMMENT 'Date when the water system entered service.',
    `compliance_status` STRING COMMENT 'Current compliance status with water quality regulations.',
    `construction_date` DATE COMMENT 'Date when construction of the water system was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the water system record was created.',
    `decommission_date` DATE COMMENT 'Date when the water system was retired, if applicable.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the water system is currently active in the system.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate.',
    `location_city` STRING COMMENT 'City where the water system is located.',
    `location_state` STRING COMMENT 'State or province of the water system location.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate.',
    `maintenance_schedule` STRING COMMENT 'Textual description of routine maintenance schedule (e.g., quarterly, annual).',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'Average operational hours between failures.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Average time to repair a failure.',
    `water_system_name` STRING COMMENT 'Human readable name of the water system.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next inspection.',
    `number_of_units` STRING COMMENT 'Count of major equipment units within the system (e.g., pumps, filters).',
    `owner_organization` STRING COMMENT 'Name of the organization that owns the water system.',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the regulatory permit.',
    `permit_number` STRING COMMENT 'Identifier of the regulatory permit governing the water system.',
    `ph_range` STRING COMMENT 'Typical pH range of output water (e.g., 6.5-8.5).',
    `population_served` STRING COMMENT '',
    `primary_source_type` STRING COMMENT '',
    `pwsid` STRING COMMENT '',
    `source_type` STRING COMMENT 'Primary source of raw water for the system.',
    `system_code` STRING COMMENT 'Unique alphanumeric code assigned to the water system.',
    `system_name` STRING COMMENT '',
    `system_type` STRING COMMENT 'Category of the water system based on function.',
    `total_coliforms_cfu_100ml` DECIMAL(18,2) COMMENT 'Typical total coliform count.',
    `treatment_processes` STRING COMMENT 'Comma-separated list of treatment processes applied (e.g., coagulation, filtration, disinfection).',
    `turbidity_ntu` DECIMAL(18,2) COMMENT 'Typical turbidity measurement in Nephelometric Turbidity Units.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `water_quality_category` STRING COMMENT 'Classification of water quality produced.',
    `water_system_status` STRING COMMENT 'Current operational status of the water system.',
    CONSTRAINT pk_water_system PRIMARY KEY(`water_system_id`)
) COMMENT 'Master reference table for water_system. Referenced by water_system_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_parent_sample_water_sample_id` FOREIGN KEY (`parent_sample_water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_ccr_period_id` FOREIGN KEY (`ccr_period_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`ccr_period`(`ccr_period_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ADD CONSTRAINT `fk_quality_exceedance_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ADD CONSTRAINT `fk_quality_lead_copper_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ADD CONSTRAINT `fk_quality_ccr_period_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ADD CONSTRAINT `fk_quality_water_system_parent_water_system_id` FOREIGN KEY (`parent_water_system_id`) REFERENCES `vibe_water_utilities_v1`.`quality`.`water_system`(`water_system_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_water_utilities_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` SET TAGS ('dbx_subdomain' = 'sampling_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `manhole_id` SET TAGS ('dbx_business_glossary_term' = 'Manhole Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `sewershed_basin_id` SET TAGS ('dbx_business_glossary_term' = 'Sewershed Basin Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` SET TAGS ('dbx_subdomain' = 'sampling_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`sampling_schedule` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` SET TAGS ('dbx_subdomain' = 'sampling_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `water_source_id` SET TAGS ('dbx_business_glossary_term' = 'Water Source Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_sample` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`analytical_result` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `chemical_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `health_effect_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technology_options` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant` ALTER COLUMN `treatment_technology_options` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`contaminant_limit` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` SET TAGS ('dbx_subdomain' = 'compliance_monitoring');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `ccr_period_id` SET TAGS ('dbx_business_glossary_term' = 'Ccr Period Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`exceedance` ALTER COLUMN `wwtp_id` SET TAGS ('dbx_business_glossary_term' = 'Wwtp Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` SET TAGS ('dbx_subdomain' = 'sampling_infrastructure');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `lead_copper_result_id` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Result ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Site ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identification Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `analysis_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `analysis_method` SET TAGS ('dbx_value_regex' = 'EPA_200.8|EPA_200.9|ASTM_D3559');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `copper_action_level_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Copper Action Level Exceeded Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `copper_result_ppb` SET TAGS ('dbx_business_glossary_term' = 'Copper Concentration Result (Parts Per Billion)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `corrosion_control_treatment_status` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Control Treatment Optimization Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `corrosion_control_treatment_status` SET TAGS ('dbx_value_regex' = 'optimal|suboptimal|not_optimized|not_applicable');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `corrosion_control_treatment_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `corrosion_control_treatment_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `customer_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `detection_limit_copper_ppb` SET TAGS ('dbx_business_glossary_term' = 'Copper Method Detection Limit (Parts Per Billion)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `detection_limit_lead_ppb` SET TAGS ('dbx_business_glossary_term' = 'Lead Method Detection Limit (Parts Per Billion)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `holding_time_compliant` SET TAGS ('dbx_business_glossary_term' = 'Holding Time Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `included_in_90th_percentile` SET TAGS ('dbx_business_glossary_term' = 'Included in 90th Percentile Calculation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `lead_action_level_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Lead Action Level Exceeded Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `lead_result_ppb` SET TAGS ('dbx_business_glossary_term' = 'Lead Concentration Result (Parts Per Billion)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|accepted|rejected');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Sample Result Remarks');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_collection_time` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_ph` SET TAGS ('dbx_business_glossary_term' = 'Sample pH (Potential of Hydrogen)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_preservation_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Preservation Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_preservation_method` SET TAGS ('dbx_value_regex' = 'nitric_acid|unpreserved');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Sample Temperature (Celsius)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `sample_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume (Milliliters)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `service_line_material` SET TAGS ('dbx_business_glossary_term' = 'Service Line Material Classification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `site_tier` SET TAGS ('dbx_business_glossary_term' = 'Sampling Site Tier Classification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `site_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`lead_copper_result` ALTER COLUMN `stagnation_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Water Stagnation Time (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `ccr_period_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Period ID');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certification_method` SET TAGS ('dbx_business_glossary_term' = 'Certification Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certification_method` SET TAGS ('dbx_value_regex' = 'electronic|mail|fax|online_portal');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certification_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Certified By Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certified_by_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `certified_by_title` SET TAGS ('dbx_business_glossary_term' = 'Certified By Title');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `customers_served_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Served Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `detected_contaminant_count` SET TAGS ('dbx_business_glossary_term' = 'Detected Contaminant Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `distribution_method` SET TAGS ('dbx_business_glossary_term' = 'Distribution Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `distribution_method` SET TAGS ('dbx_value_regex' = 'mailed|posted_online|electronic_delivery|newspaper|combination');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `document_file_path` SET TAGS ('dbx_business_glossary_term' = 'Document File Path');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `eu_article_17_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'EU Article 17 Compliance');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `eu_information_access_method` SET TAGS ('dbx_business_glossary_term' = 'EU Information Access Method');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `eu_reference_path` SET TAGS ('dbx_dimension' = 'jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `health_effects_language_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Effects Language Included Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `health_effects_language_included_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `health_effects_language_included_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `jurisdiction_region` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Region');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `language_accessibility_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Language Accessibility Provided Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `lead_copper_educational_information_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Educational Information Flag');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `mcl_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Violation Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `monitoring_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Monitoring and Reporting Violation Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `online_ccr_url` SET TAGS ('dbx_business_glossary_term' = 'Online Consumer Confidence Report (CCR) URL');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `population_served_count` SET TAGS ('dbx_business_glossary_term' = 'Population Served Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `preparation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `pwsid` SET TAGS ('dbx_business_glossary_term' = 'Public Water System Identification (PWSID)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `pwsid` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_dimension' = 'jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `regulatory_region_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|published|certified|archived');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `report_year` SET TAGS ('dbx_business_glossary_term' = 'Report Year');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `source_water_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Source Water Assessment Summary');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `special_notices_included` SET TAGS ('dbx_business_glossary_term' = 'Special Notices Included');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `treatment_technique_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technique (TT) Violation Count');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `treatment_technique_violation_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `treatment_technique_violation_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `us_reference_path` SET TAGS ('dbx_dimension' = 'jurisdiction');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `violation_summary` SET TAGS ('dbx_business_glossary_term' = 'Violation Summary');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `water_source_summary` SET TAGS ('dbx_business_glossary_term' = 'Water Source Summary');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`ccr_period` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` SET TAGS ('dbx_subdomain' = 'regulatory_reporting');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `parent_water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Water System Id');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `parent_water_system_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `regulatory_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `average_daily_consumption_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Consumption Mgd');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `average_daily_production_mgd` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Production Mgd');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Capacity Mgd');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `chlorine_residual_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Chlorine Residual Mg L');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `construction_date` SET TAGS ('dbx_business_glossary_term' = 'Construction Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `location_state` SET TAGS ('dbx_business_glossary_term' = 'Location State');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `mean_time_between_failures_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures Hours');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair Hours');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `water_system_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `number_of_units` SET TAGS ('dbx_business_glossary_term' = 'Number Of Units');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiry Date');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `ph_range` SET TAGS ('dbx_business_glossary_term' = 'Ph Range');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `system_code` SET TAGS ('dbx_business_glossary_term' = 'System Code');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `system_type` SET TAGS ('dbx_business_glossary_term' = 'System Type');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `total_coliforms_cfu_100ml` SET TAGS ('dbx_business_glossary_term' = 'Total Coliforms Cfu 100ml');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `treatment_processes` SET TAGS ('dbx_business_glossary_term' = 'Treatment Processes');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `treatment_processes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `treatment_processes` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Ntu');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `water_quality_category` SET TAGS ('dbx_business_glossary_term' = 'Water Quality Category');
ALTER TABLE `vibe_water_utilities_v1`.`quality`.`water_system` ALTER COLUMN `water_system_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
