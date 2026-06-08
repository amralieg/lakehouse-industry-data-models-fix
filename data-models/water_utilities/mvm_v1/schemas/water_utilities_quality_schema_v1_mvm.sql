-- Schema for Domain: quality | Business: Water Utilities | Version: v1_mvm
-- Generated on: 2026-05-06 01:37:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `water_utilities_ecm`.`quality` COMMENT 'Water quality monitoring and compliance including sampling schedules, MCL/MCLG tracking, DBP monitoring (THM, HAA5), PFAS testing, turbidity (NTU), pH, BOD, COD, TSS, TDS, TOC analysis, bacteriological testing, CCR preparation, and regulatory compliance reporting. Manages water quality from source through distribution system and wastewater effluent discharge.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `water_utilities_ecm`.`quality`.`sampling_point` (
    `sampling_point_id` BIGINT COMMENT 'Unique identifier for the water quality sampling location. Primary key for the sampling point registry.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: AMI-integrated water quality monitoring programs co-locate sampling points with AMI endpoints to correlate continuous consumption/flow data with discrete quality samples. Distribution system hydraulic',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Sampling points are established or modified during CIP projects (new treatment plants, distribution expansions). Project closeout requires documenting new sampling points per regulatory permit conditi',
    `compliance_permit_id` BIGINT COMMENT 'The NPDES permit number, SDWA public water system ID, or Industrial User Permit (IUP) number associated with this sampling point for regulatory compliance tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sampling points are maintained and operated under specific cost centers for O&M cost allocation and departmental budgeting. Water utilities track field sampling operations by cost center for financial',
    `facility_id` BIGINT COMMENT 'Reference to the parent facility (WTP, WWTP, pump station, reservoir) where this sampling point is located, if applicable.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Permanent sampling points (stations, buildings, infrastructure) are capital assets requiring depreciation and inclusion in utility rate base for rate case proceedings—essential for capital asset track',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Regulatory sampling programs (LCR, LCRR) define Tier 1 sampling sites at specific customer meter installations. Sampling point-to-meter traceability is required for regulatory site selection documenta',
    `point_id` BIGINT COMMENT 'Foreign key linking to service.point. Business justification: Water utilities map sampling points to service connection points for compliance monitoring and customer notification. When a sampling point detects a violation, the associated service point identifies',
    `registry_id` BIGINT COMMENT 'Reference to the specific physical asset (pipe segment, valve, tank, treatment unit) at which sampling occurs, if applicable. Links to asset registry for maintenance correlation.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Sampling points are physically located at customer service addresses for distribution system monitoring, lead/copper compliance sampling, and RTCR investigations. SDWA regulatory requirement for site-',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Sampling points are geographically located within service territories for regulatory zone compliance reporting, CCR preparation, and operational monitoring jurisdiction. Water utilities organize sampl',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: A sampling point belongs to a single water system; linking provides hierarchy for reporting and compliance tracking.',
    `access_type` STRING COMMENT 'Classification of physical access requirements for sampling personnel. Public = open access; restricted = requires authorization; private property = requires owner permission; confined space = requires confined space entry procedures; remote = difficult to reach, may require special equipment.. Valid values are `public|restricted|private_property|confined_space|remote`',
    `ccr_reporting_flag` BOOLEAN COMMENT 'Indicates whether water quality results from this sampling point must be included in the annual Consumer Confidence Report (CCR) to customers. True = included in CCR; False = not included.',
    `comments` STRING COMMENT 'Additional notes, historical context, or operational observations about this sampling point that do not fit other structured fields.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this sampling point record was first created in the system.',
    `decommission_date` DATE COMMENT 'The date when this sampling point was permanently retired from service. Null if still active or temporarily suspended.',
    `dma_code` STRING COMMENT 'The District Metered Area (DMA) code to which this sampling point belongs, used for Non-Revenue Water (NRW) analysis and pressure zone management.',
    `dmr_reporting_flag` BOOLEAN COMMENT 'Indicates whether effluent quality results from this sampling point must be included in monthly Discharge Monitoring Reports (DMR) submitted to EPA or state agencies. True = included in DMR; False = not included.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation of the sampling point above sea level in feet. Used for hydraulic gradient analysis and pressure zone validation.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'The typical or design flow rate in gallons per minute (GPM) at this sampling location. Used for composite sampling calculations and hydraulic modeling correlation.',
    `gis_feature_code` STRING COMMENT 'The unique feature identifier in the Esri ArcGIS or other GIS system that represents this sampling point. Used for spatial analysis, network tracing, and map visualization.',
    `installation_date` DATE COMMENT 'The date when this sampling point was first established and became operational for water quality monitoring.',
    `last_sample_date` DATE COMMENT 'The most recent date on which a sample was collected from this sampling point. Used to track compliance with sampling schedules and identify overdue sampling locations.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the sampling point location for GIS mapping and spatial analysis.',
    `location_type` STRING COMMENT 'Classification of the sampling point by its position in the water system lifecycle. Entry point = water entering distribution; distribution system = points within the network; source water = raw intake; WTP/WWTP process = treatment plant intermediate stages; effluent discharge = final discharge point; customer tap = end-user location. [ENUM-REF-CANDIDATE: entry_point|distribution_system|source_water|wtp_process|wwtp_process|effluent_discharge|customer_tap — 7 candidates stripped; promote to reference product]',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the sampling point location for GIS mapping and spatial analysis.',
    `modified_by` STRING COMMENT 'The username or identifier of the person who last modified this sampling point record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this sampling point record was last updated or modified.',
    `next_scheduled_sample_date` DATE COMMENT 'The next planned date for sample collection at this location based on the regulatory or operational sampling schedule.',
    `pressure_zone` STRING COMMENT 'The hydraulic pressure zone within the distribution network where this sampling point is located. Used for hydraulic modeling and water quality correlation analysis.',
    `primary_contaminant_group` STRING COMMENT 'The primary category of contaminants monitored at this sampling point (e.g., Microbiological, Disinfection Byproducts, Inorganic Chemicals, Organic Chemicals, Radionuclides, Nutrients, Metals). Used to organize sampling schedules and laboratory workflows.',
    `regulatory_zone` STRING COMMENT 'The regulatory monitoring zone or district to which this sampling point is assigned for compliance reporting purposes. Used to aggregate results for Consumer Confidence Report (CCR) and Discharge Monitoring Report (DMR).',
    `residence_time_hours` DECIMAL(18,2) COMMENT 'The estimated water residence time in hours from the treatment plant to this sampling point in the distribution system. Critical for disinfection Contact Time (CT) calculations and Disinfection Byproduct (DBP) formation analysis.',
    `responsible_department` STRING COMMENT 'The internal department or division responsible for sampling at this location (e.g., Water Quality Lab, Distribution Operations, Wastewater Operations, Compliance).',
    `safety_notes` STRING COMMENT 'Safety considerations and hazards specific to this sampling location (e.g., confined space, traffic hazards, chemical exposure, biological hazards, electrical equipment).',
    `sample_collection_method` STRING COMMENT 'The method by which samples are collected at this point. Grab = single point-in-time sample; composite = time- or flow-weighted composite over a period; continuous monitor = automated real-time sensor; passive sampler = diffusion-based accumulation.. Valid values are `grab|composite|continuous_monitor|passive_sampler`',
    `sampler_name` STRING COMMENT 'The name of the primary field technician or automated sampler equipment responsible for routine sample collection at this location. Used for quality assurance and chain-of-custody tracking.',
    `sampling_frequency` STRING COMMENT 'The regulatory or operational frequency at which samples must be collected from this location. Continuous = real-time monitoring (e.g., SCADA); event-based = triggered by specific conditions (e.g., storm events, process upsets). [ENUM-REF-CANDIDATE: continuous|hourly|daily|weekly|monthly|quarterly|annual|event_based — 8 candidates stripped; promote to reference product]',
    `sampling_instructions` STRING COMMENT 'Detailed field instructions for sample collection at this location, including access directions, safety precautions, flushing procedures, bottle types, preservation requirements, and any site-specific protocols.',
    `sampling_point_code` STRING COMMENT 'Externally-known unique business identifier for the sampling location, used in regulatory reporting and laboratory requisitions. Typically follows EPA or state-specific coding conventions.. Valid values are `^[A-Z0-9]{6,20}$`',
    `sampling_point_name` STRING COMMENT 'Human-readable name or label for the sampling location (e.g., Main Street Entry Point, WTP Clearwell Outlet, WWTP Final Effluent).',
    `sampling_point_status` STRING COMMENT 'Current operational status of the sampling point. Active = in regular use; inactive = not currently sampled but may be reactivated; temporarily suspended = short-term pause (e.g., construction); decommissioned = permanently retired.. Valid values are `active|inactive|temporarily_suspended|decommissioned`',
    `scada_tag` STRING COMMENT 'The SCADA system tag or point identifier for continuous monitoring instruments at this sampling location. Used to link laboratory results with real-time process data from OSIsoft PI Historian or similar systems.',
    `treatment_stage` STRING COMMENT 'For WTP or WWTP process sampling points, the specific treatment stage being monitored (e.g., Raw Intake, Coagulation, Sedimentation, Filtration, Disinfection, Clearwell, Primary Treatment, Secondary Treatment, Tertiary Treatment, UV Disinfection, Reverse Osmosis). Null for distribution or source sampling points.',
    `water_source_type` STRING COMMENT 'The type of water source from which this sampling point draws or monitors. Surface water = rivers, lakes, reservoirs; groundwater = wells, aquifers; groundwater under influence = groundwater influenced by surface water; blended = mix of sources; purchased = water bought from another utility; recycled = reclaimed wastewater.. Valid values are `surface_water|groundwater|groundwater_under_influence|blended|purchased|recycled`',
    `created_by` STRING COMMENT 'The username or identifier of the person who created this sampling point record.',
    CONSTRAINT pk_sampling_point PRIMARY KEY(`sampling_point_id`)
) COMMENT 'Master registry of all approved water quality sampling locations across the utilitys infrastructure including distribution system sites, source water intakes, WTP/WWTP process points, and wastewater effluent discharge outfalls. Captures location type (entry point, distribution, source, effluent, customer tap), GIS coordinates, regulatory monitoring zone classification, DMA assignment, pressure zone, LCRR tier classification for tap sites, associated permit or CCR reporting requirements, and activation/deactivation status. Serves as the authoritative SSOT for where samples are collected and links to sampling_schedule for monitoring requirements.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` (
    `sampling_schedule_id` BIGINT COMMENT 'Unique identifier for the sampling schedule record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: CIP projects for new treatment facilities or distribution upgrades directly trigger new regulatory sampling schedules. Project managers need to verify all required monitoring programs are established ',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: A sampling schedule is defined to monitor a specific contaminant or contaminant group (e.g., THM, nitrate, lead, turbidity). Linking sampling_schedule directly to contaminant normalizes the regulatory',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sampling schedules track annual_budget_allocation and cost_per_sample; linking to cost_center enables budget variance analysis and cost allocation for regulatory monitoring programs—essential for comp',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: sampling_schedule.annual_budget_allocation is a denormalized budget reference. Linking to finance_budget enables proper budget tracking, variance analysis, and encumbrance management for monitoring pr',
    `grant_id` BIGINT COMMENT 'Foreign key linking to finance.grant. Business justification: Monitoring programs such as UCMR (Unregulated Contaminant Monitoring Rule) and source water assessments are frequently grant-funded by EPA or state agencies. Linking sampling_schedule to grant enables',
    `location_id` BIGINT COMMENT 'Reference to the physical location where samples are collected (e.g., treatment plant, distribution point, discharge point).',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Sampling schedules operationalize compliance obligations (permit monitoring requirements, consent order milestones). This link connects operational monitoring plans to formal compliance commitments, e',
    `project_permit_id` BIGINT COMMENT 'Foreign key linking to project.project_permit. Business justification: Project permits (construction, environmental) routinely impose post-construction water quality monitoring conditions. A sampling schedule is established to satisfy specific project permit requirements',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Sampling schedules are driven by specific regulatory requirements (SDWA monitoring frequencies, RTCR rules, LCR sampling). This link documents the regulatory basis for each monitoring schedule, essent',
    `sampling_point_id` BIGINT COMMENT 'Reference to the physical location where samples are collected (e.g., treatment plant, distribution point, discharge point).',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Sampling schedules are organized by service territory because regulatory primacy agencies and monitoring requirements differ by jurisdiction. Territory-scoped scheduling drives compliance reporting, D',
    `vendor_id` BIGINT COMMENT 'Reference to the laboratory responsible for analyzing samples collected under this schedule (internal lab or contracted external lab).',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this sampling schedule (e.g., Compliance Manager, Lab Director).',
    `approved_date` DATE COMMENT 'Date when this sampling schedule was formally approved for execution.',
    `compliance_deadline_date` DATE COMMENT 'Regulatory deadline by which all samples for this schedule must be collected and analyzed to avoid violation.',
    `compliance_status` STRING COMMENT 'Current compliance status of this schedule: compliant (all samples collected on time), at risk (approaching deadline or missed samples), non-compliant (violation occurred), pending review (awaiting regulatory determination).. Valid values are `compliant|at_risk|non_compliant|pending_review`',
    `cost_per_sample` DECIMAL(18,2) COMMENT 'Estimated or contracted cost in USD for each sample collection and analysis event under this schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sampling schedule record was first created in the system.',
    `holding_time_hours` STRING COMMENT 'Maximum allowable time in hours between sample collection and analysis, per regulatory or method requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sampling schedule record was last updated.',
    `last_sample_collected_date` DATE COMMENT 'Date when the most recent sample was collected under this schedule. Used to track compliance gaps.',
    `modified_by` STRING COMMENT 'Identifier of the user or system process that last modified this record.',
    `monitoring_period_end_date` DATE COMMENT 'End date of the monitoring period covered by this schedule. Null for ongoing/perpetual schedules.',
    `monitoring_period_start_date` DATE COMMENT 'Start date of the monitoring period covered by this schedule.',
    `next_scheduled_sample_date` DATE COMMENT 'Date when the next sample is scheduled to be collected under this schedule.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or operational notes related to this sampling schedule.',
    `notification_lead_time_days` STRING COMMENT 'Number of days in advance that field crews and labs should be notified before scheduled sampling events.',
    `preservation_method` STRING COMMENT 'Required preservation technique for samples (e.g., refrigerate to 4°C, acidify to pH<2 with HNO3, add sodium thiosulfate, no preservation required).',
    `priority_level` STRING COMMENT 'Business priority of this schedule: critical (regulatory mandate with enforcement risk), high (compliance-sensitive), medium (operational importance), low (discretionary monitoring).. Valid values are `critical|high|medium|low`',
    `regulatory_rule` STRING COMMENT 'The specific regulatory rule or permit condition driving this schedule (e.g., LCRR, DBP Stage 2 Rule, NPDES Permit CA0012345, PFAS Monitoring Advisory, SDWA Coliform Rule).',
    `reporting_requirement` STRING COMMENT 'Description of the reporting obligation associated with this schedule (e.g., Monthly Operating Report (MOR), Discharge Monitoring Report (DMR), Consumer Confidence Report (CCR), quarterly summary to state primacy agency).',
    `sample_type` STRING COMMENT 'Type of sample to be collected: grab (single point-in-time), composite (time- or flow-weighted over period), continuous (automated real-time), or integrated (multiple grabs combined).. Valid values are `grab|composite|continuous|integrated`',
    `sample_volume_ml` DECIMAL(18,2) COMMENT 'Required sample volume in milliliters for each collection event.',
    `samples_collected_ytd` STRING COMMENT 'Count of samples collected under this schedule in the current calendar or fiscal year.',
    `samples_per_period` STRING COMMENT 'Number of samples required per monitoring period (e.g., 4 samples per month for DBP monitoring in a large system).',
    `samples_required_ytd` STRING COMMENT 'Count of samples required to be collected under this schedule by this point in the calendar or fiscal year.',
    `sampling_frequency` STRING COMMENT 'Required frequency of sample collection: daily, weekly, biweekly, monthly, quarterly, semiannual, annual, on-demand (event-driven), or continuous (automated monitoring). [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|semiannual|annual|on_demand|continuous — 9 candidates stripped; promote to reference product]',
    `sampling_method` STRING COMMENT 'Standard method or protocol for sample collection (e.g., EPA Method 1694, Standard Methods 9060A, grab sample, composite 24-hour).',
    `schedule_name` STRING COMMENT 'Business-friendly name or identifier for the sampling schedule (e.g., Q1 2024 DBP Monitoring - Plant A).',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the sampling schedule: active (in effect), suspended (temporarily paused), completed (monitoring period ended), cancelled (no longer required), pending approval (awaiting regulatory or management sign-off), or expired (past end date).. Valid values are `active|suspended|completed|cancelled|pending_approval|expired`',
    `schedule_type` STRING COMMENT 'Classification of the sampling schedule purpose: regulatory (mandated by permit/rule), operational (internal monitoring), investigational (response to incident), special study (research/optimization), compliance verification, or routine.. Valid values are `regulatory|operational|investigational|special_study|compliance_verification|routine`',
    `seasonal_adjustment_flag` BOOLEAN COMMENT 'Indicates whether this schedule has seasonal variations in frequency or parameters (e.g., increased DBP monitoring in summer months).',
    `violation_flag` BOOLEAN COMMENT 'Indicates whether this schedule has triggered a monitoring or reporting violation.',
    CONSTRAINT pk_sampling_schedule PRIMARY KEY(`sampling_schedule_id`)
) COMMENT 'Defines the regulatory and operational sampling schedules for each monitoring location and contaminant group. Captures required sampling frequency (daily, weekly, monthly, quarterly, annual), applicable rule (LCRR, DBP Stage 2, PFAS, NPDES), monitoring period start/end dates, responsible lab or field crew, and schedule status. Drives compliance calendar and ensures no monitoring gaps that could trigger violations.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`quality`.`water_sample` (
    `water_sample_id` BIGINT COMMENT 'Unique identifier for each water or wastewater sample collected. Primary key for the water sample transactional record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to service.service_agreement. Business justification: Water samples collected at customer service points for lead/copper compliance, customer complaint investigations, or service quality verification require linkage to the active service agreement for cu',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Commissioning and construction acceptance require project-specific water sampling (disinfection validation, bacteriological clearance before placing new mains in service). Project managers must track ',
    `point_id` BIGINT COMMENT 'Reference to the regulatory compliance monitoring point associated with this sample, if applicable. Links sample to specific permit or regulatory obligation.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Sample containers and preservation chemicals are procured materials tracked in material_master. Water utilities link samples to their container material for inventory consumption tracking, procurement',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sample collection incurs labor, materials, and equipment costs that utilities allocate to departmental cost centers for budgeting, variance reporting, and rate case cost-of-service documentation—stand',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Lead and Copper Rule and distribution system sampling require traceability from water sample to the specific meter installation where it was collected. Regulatory compliance reporting (LCR Tier 1 site',
    `parent_sample_water_sample_id` BIGINT COMMENT 'For duplicate or split samples, reference to the original parent sample from which this sample was derived. Null for primary samples.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: LCRR tap sampling programs require water samples to be linked to the specific premise (unit, floor, building type) beyond just the service address, enabling Tier 1 site tracking, lead service line inv',
    `registry_id` BIGINT COMMENT 'Reference to the automatic sampler or field equipment used to collect the sample, if applicable. Supports equipment calibration tracking and quality assurance.',
    `sampling_point_id` BIGINT COMMENT 'Reference to the physical location or monitoring point where the sample was collected (e.g., treatment plant inlet, distribution system tap, wastewater effluent discharge point).',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: A water sample is collected pursuant to a specific sampling schedule. This FK links each transactional sample record back to the regulatory or operational schedule that triggered its collection, enabl',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Water samples collected at customer premises for compliance monitoring (lead/copper rule, bacteriological sampling, customer complaint investigations). Required for customer notification and site-spec',
    `vendor_id` BIGINT COMMENT 'Reference to the laboratory facility that will perform or has performed the analysis. May be internal lab or external contract lab.',
    `analysis_due_timestamp` TIMESTAMP COMMENT 'Calculated deadline by which analysis must be completed to meet hold-time requirements. Derived from collection timestamp plus hold time hours.',
    `collection_notes` STRING COMMENT 'Free-text field for collector to record observations, anomalies, or special conditions at the time of collection (e.g., visible discoloration, odor, nearby construction activity, equipment malfunction).',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the sample was physically collected, recorded in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Critical for regulatory compliance and hold-time calculations.',
    `composite_duration_hours` STRING COMMENT 'For composite samples, the total time period over which the sample was collected (e.g., 24-hour composite). Null for grab samples.',
    `composite_interval_minutes` STRING COMMENT 'For composite samples, the time interval between individual aliquot collections (e.g., every 15 minutes, every 60 minutes). Null for grab samples.',
    `container_volume_ml` STRING COMMENT 'Volume capacity of the sample container in milliliters (e.g., 125 mL, 500 mL, 1000 mL).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this sample record was first created in the database. Audit trail for data governance.',
    `field_chlorine_residual_mg_l` DECIMAL(18,2) COMMENT 'Free or total chlorine residual measured at the time of sample collection in mg/L. Critical for disinfection monitoring and compliance with Safe Drinking Water Act (SDWA) requirements.',
    `field_conductivity_us_cm` DECIMAL(18,2) COMMENT 'Electrical conductivity measured at the time of sample collection in microsiemens per centimeter (µS/cm). Indicates total dissolved solids (TDS) and ionic content.',
    `field_dissolved_oxygen_mg_l` DECIMAL(18,2) COMMENT 'Dissolved oxygen concentration measured at the time of sample collection in mg/L. Important for wastewater treatment process control and aquatic life support.',
    `field_ph` DECIMAL(18,2) COMMENT 'pH level measured at the time of sample collection using a calibrated field meter. Indicates acidity or alkalinity on a scale of 0-14.',
    `field_temperature_c` DECIMAL(18,2) COMMENT 'Water temperature measured at the time of sample collection in degrees Celsius. Field measurement recorded on-site.',
    `field_turbidity_ntu` DECIMAL(18,2) COMMENT 'Turbidity measured at the time of sample collection in Nephelometric Turbidity Units (NTU) using a field turbidimeter. Indicates water clarity and particulate matter.',
    `flow_rate_gpm` DECIMAL(18,2) COMMENT 'Flow rate at the sampling point at the time of collection, measured in gallons per minute (GPM). Important for composite sampling and process control samples.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the sample collection point in decimal degrees. Enables spatial analysis and mapping of water quality data.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the sample collection point in decimal degrees. Enables spatial analysis and mapping of water quality data.',
    `hold_time_hours` STRING COMMENT 'Maximum allowable time in hours between sample collection and analysis completion, as specified by EPA methods. Critical for ensuring analytical validity and regulatory compliance.',
    `lims_submission_code` STRING COMMENT 'Reference identifier assigned by the LIMS when the sample is logged into the laboratory system for analysis. Links field sample to laboratory test results.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this sample record was last updated. Audit trail for data governance and change tracking.',
    `quality_control_flag` BOOLEAN COMMENT 'Indicates whether this sample is a quality control sample (field blank, duplicate, split, trip blank) rather than a routine environmental sample. True for QC samples, false for routine samples.',
    `regulatory_program` STRING COMMENT 'The regulatory program or permit under which the sample is collected (e.g., SDWA compliance, NPDES discharge monitoring, Lead and Copper Rule Revisions (LCRR), Disinfection Byproduct (DBP) monitoring, Per- and Polyfluoroalkyl Substances (PFAS) testing).',
    `requested_analysis_group` STRING COMMENT 'The suite or panel of tests requested for this sample (e.g., bacteriological, inorganic chemicals, volatile organic compounds (VOCs), Disinfection Byproducts (DBPs), metals, nutrients). May reference a predefined test package.',
    `sample_location_description` STRING COMMENT 'Free-text description of the sample collection location, including address, facility name, or geographic reference. Supplements the sampling point reference with human-readable context.',
    `sample_matrix` STRING COMMENT 'The type of water or wastewater being sampled: drinking water (finished), raw water (source), treated water (post-treatment), distribution water (in-network), wastewater influent (incoming), or wastewater effluent (discharge).. Valid values are `drinking_water|raw_water|treated_water|distribution_water|wastewater_influent|wastewater_effluent`',
    `sample_number` STRING COMMENT 'Business-facing unique sample identifier or barcode assigned at collection time, used for tracking and chain-of-custody documentation.',
    `sample_purpose` STRING COMMENT 'Business reason for collecting the sample (e.g., routine compliance monitoring, customer complaint investigation, process control, special study, Consumer Confidence Report (CCR) preparation, National Pollutant Discharge Elimination System (NPDES) permit monitoring).',
    `sample_status` STRING COMMENT 'Current lifecycle status of the sample: collected (in field), in transit (being transported), received by lab (logged into LIMS), in analysis (testing underway), analysis complete (results available), results reported (delivered to stakeholders), or voided (invalidated). [ENUM-REF-CANDIDATE: collected|in_transit|received_by_lab|in_analysis|analysis_complete|results_reported|voided — 7 candidates stripped; promote to reference product]',
    `sample_type` STRING COMMENT 'Classification of the sample collection method: grab (single point-in-time), composite (time- or flow-weighted composite), field blank (quality control), duplicate (replicate for precision), split (divided for multiple labs), or trip blank (contamination control).. Valid values are `grab|composite|field_blank|duplicate|split|trip_blank`',
    `sampler_equipment_code` BIGINT COMMENT 'Reference to the automatic sampler or field equipment used to collect the sample, if applicable. Supports equipment calibration tracking and quality assurance.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of sample collection (e.g., clear, rain, snow, storm). Relevant for source water and stormwater-influenced samples.',
    CONSTRAINT pk_water_sample PRIMARY KEY(`water_sample_id`)
) COMMENT 'Transactional record of each individual water or wastewater sample collected in the field or at a process point. Captures sample collection date/time, collector identity, sampling point, sample type (grab, composite, field blank, duplicate), preservation method, container type, chain-of-custody number, field measurements (temperature, pH, residual chlorine, turbidity in NTU), and LIMS submission reference. This is the primary event record for all quality monitoring activity.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`quality`.`analytical_result` (
    `analytical_result_id` BIGINT COMMENT 'Unique identifier for the laboratory analytical result record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Foreign key linking to project.cip_project. Business justification: Lab results from commissioning samples must be traceable to the project for asset handover and regulatory approval. Operations cannot accept new treatment facilities or distribution mains without docu',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: analytical_result currently has analyte_name and cas_number as free-text attributes. These should reference the contaminant master table for standardization, regulatory alignment, and to enable proper',
    `contaminant_limit_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant_limit. Business justification: Lab analytical results are compared against applicable regulatory limits for compliance determination. Links result to specific limit used for MCL/AL exceedance evaluation, public notification trigger',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Laboratory analysis represents significant operating expense; utilities track lab costs by cost center for budget management, rate case justification, and regulatory cost recovery—critical for O&M exp',
    `installation_id` BIGINT COMMENT 'Foreign key linking to metering.installation. Business justification: Lab analytical results for customer tap samples (lead, copper, bacteriological) must link to meter installation for customer notification, compliance reporting, and corrosion control program effective',
    `vendor_id` BIGINT COMMENT 'Identifier of the laboratory facility that performed the analysis. May be internal lab or external contract lab.',
    `water_sample_id` BIGINT COMMENT 'Reference to the water sample that was analyzed to produce this result. Links to the sample collection event.',
    `analysis_date` DATE COMMENT 'Date on which the laboratory analysis was performed. Used to verify compliance with method-specific hold-time requirements.',
    `analysis_timestamp` TIMESTAMP COMMENT 'Precise date and time when the laboratory analysis was completed. Provides full temporal resolution for hold-time verification and audit trails.',
    `analytical_method` STRING COMMENT 'EPA or standard method number used for the analysis (e.g., EPA 200.8, EPA 300.0, SM 2320B, ASTM D1067). Defines the laboratory procedure and instrumentation.',
    `calibration_date` DATE COMMENT 'Date of the most recent calibration of the instrument used for this analysis. Ensures measurement accuracy and traceability.',
    `compliance_exceeded` BOOLEAN COMMENT 'Indicates whether the result value exceeds the applicable MCL or permit limit. Triggers regulatory notification and corrective action workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this analytical result record was first created in the system. Audit trail field.',
    `data_validation_level` STRING COMMENT 'Level of data validation review applied to this result. Higher levels indicate more rigorous QA/QC review, typically required for regulatory or litigation purposes.. Valid values are `level_1|level_2|level_3|level_4`',
    `detection_limit` DECIMAL(18,2) COMMENT 'Minimum concentration of a substance that can be measured and reported with 99% confidence that the analyte concentration is greater than zero. Also known as MDL or MRL (Method Reporting Limit).',
    `dilution_factor` DECIMAL(18,2) COMMENT 'Factor by which the sample was diluted prior to analysis. Result value is typically reported after applying the dilution factor. A value of 1.0 indicates no dilution.',
    `hold_time_compliant` BOOLEAN COMMENT 'Indicates whether the sample was analyzed within the method-specified hold time from collection to analysis. Non-compliance may affect result validity.',
    `hold_time_hours` STRING COMMENT 'Elapsed time in hours between sample collection and analysis. Used to verify compliance with method-specific hold-time requirements.',
    `laboratory_accreditation_number` STRING COMMENT 'State or EPA certification number for the laboratory. Required for regulatory compliance reporting under SDWA and CWA.',
    `lims_result_code` STRING COMMENT 'Original result identifier from the source LIMS system (LabWare or similar). Used for traceability and reconciliation with source system.',
    `mcl_value` DECIMAL(18,2) COMMENT 'Regulatory maximum contaminant level for this analyte as defined by EPA or state primacy agency. Used for automated compliance comparison.',
    `mclg_value` DECIMAL(18,2) COMMENT 'Non-enforceable health goal for this analyte. Represents the level at which no known or anticipated adverse health effects occur, with an adequate margin of safety.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this analytical result record was last modified. Audit trail field for tracking changes and corrections.',
    `percent_recovery` DECIMAL(18,2) COMMENT 'Quality control metric indicating the percentage of analyte recovered in matrix spike or laboratory control sample. Acceptable ranges are method-specific.',
    `qualifier_code` STRING COMMENT 'Data qualifier flag indicating special conditions (e.g., U=non-detect, J=estimated, H=hold-time exceeded, B=blank contamination, E=exceeds calibration range, Q=QC failure). Pipe-separated if multiple qualifiers apply.',
    `quantitation_limit` DECIMAL(18,2) COMMENT 'Minimum concentration at which the analyte can be reliably quantified with a specified level of accuracy and precision. Typically higher than the detection limit.',
    `relative_percent_difference` DECIMAL(18,2) COMMENT 'Quality control metric comparing duplicate sample results. Measures precision and reproducibility of the analytical method.',
    `reporting_required` BOOLEAN COMMENT 'Indicates whether this result must be included in regulatory reports such as CCR, DMR, or MOR. Based on analyte type, sample location, and regulatory schedule.',
    `result_comment` STRING COMMENT 'Free-text notes from the analyst or validator regarding special conditions, anomalies, or interpretation guidance for this result.',
    `result_status` STRING COMMENT 'Current status of the analytical result in the laboratory workflow. Indicates whether the result has been validated and approved for regulatory reporting.. Valid values are `preliminary|final|approved|rejected|cancelled`',
    `result_value` DECIMAL(18,2) COMMENT 'Numerical value of the analytical result as measured by the laboratory. May be null if result is non-detect or qualitative.',
    `sample_matrix` STRING COMMENT 'Type of water or wastewater matrix from which the sample was collected. Affects method selection, detection limits, and regulatory applicability. [ENUM-REF-CANDIDATE: drinking_water|raw_water|treated_water|distribution_system|wastewater_influent|wastewater_effluent|groundwater|surface_water|biosolids — 9 candidates stripped; promote to reference product]',
    `unit_of_measure` STRING COMMENT 'Unit in which the result is expressed (e.g., mg/L, ug/L, NTU, CFU/100mL, pH units, MPN/100mL, pCi/L). Critical for interpretation and compliance comparison.',
    `validated_by` STRING COMMENT 'Identifier of the quality assurance officer or supervisor who validated and approved this result for reporting.',
    `validation_timestamp` TIMESTAMP COMMENT 'Date and time when the result was validated and approved. Marks the transition from preliminary to final status.',
    CONSTRAINT pk_analytical_result PRIMARY KEY(`analytical_result_id`)
) COMMENT 'Laboratory and field analytical result for each parameter tested on a collected water sample or measured by a continuous online instrument. Captures analyte/contaminant reference, CAS number, analytical method (EPA method number), result value, unit of measure, detection limit (MDL/MRL), qualifier flags (non-detect, estimated, hold-time exceeded, presence/absence), result type (grab, composite, continuous, calculated), measurement source (laboratory, field, SCADA/online), laboratory accreditation number, analyst ID, analysis date/time, QA/QC batch reference, instrument ID for online readings, and monitoring period context. Supports all parameter types including conventional chemistry, DBP species, PFAS compounds, bacteriological presence/absence, turbidity NTU, chlorine residuals, and CT calculations. Links to water_sample for discrete samples and online_instrument for continuous readings. Sourced from LIMS (LabWare) and OSIsoft PI Historian.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`quality`.`contaminant` (
    `contaminant_id` BIGINT COMMENT 'Unique identifier for the contaminant record. Primary key for the contaminant reference master.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Contaminants are defined and regulated by specific regulatory requirements (EPA establishes MCLs, MCLGs, monitoring rules). This link connects contaminant definitions to their authoritative regulatory',
    `action_level_unit` STRING COMMENT 'Unit of measure for the action level value. Common units: mg/L, ug/L.',
    `action_level_value` DECIMAL(18,2) COMMENT 'The concentration of a contaminant which, if exceeded, triggers treatment or other requirements. Primarily used for lead and copper under the Lead and Copper Rule Revisions (LCRR).',
    `analytical_method_code` STRING COMMENT 'EPA-approved analytical method code(s) for laboratory testing of this contaminant. Examples: EPA 200.8 (metals), EPA 524.2 (volatile organics), SM 9223B (coliform).',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to chemical substances. Used for precise identification of chemical contaminants.',
    `ccr_language_template` STRING COMMENT 'Standard EPA-approved language template for describing this contaminant and its health effects in the Consumer Confidence Report. Ensures consistent public communication.',
    `ccr_reporting_required` BOOLEAN COMMENT 'Indicates whether detection of this contaminant must be reported in the annual Consumer Confidence Report distributed to customers.',
    `contaminant_code` STRING COMMENT 'Standardized short code or abbreviation for the contaminant used in laboratory and reporting systems. Examples: PB, TC, TTHM, PFOA.',
    `contaminant_name` STRING COMMENT 'Official name of the contaminant as recognized by regulatory agencies (EPA, state programs). Examples: Lead, Total Coliform, Trihalomethanes, PFOA.',
    `contaminant_status` STRING COMMENT 'Current regulatory status of the contaminant in the enterprise taxonomy. Active contaminants are currently monitored; inactive are no longer required; proposed are under rulemaking; withdrawn were removed from regulations.. Valid values are `active|inactive|proposed|withdrawn`',
    `contaminant_type` STRING COMMENT 'Regulatory status indicating whether the contaminant has enforceable standards (regulated), is monitored without enforceable limits (unregulated), is under evaluation (emerging), or has non-enforceable guidelines (secondary).. Valid values are `regulated|unregulated|emerging|secondary`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contaminant record was first created in the system.',
    `detection_limit_unit` STRING COMMENT 'Unit of measure for the method detection limit value.',
    `detection_limit_value` DECIMAL(18,2) COMMENT 'The minimum concentration of a substance that can be measured and reported with 99% confidence that the analyte concentration is greater than zero. Laboratory capability threshold.',
    `effective_date` DATE COMMENT 'Date when the current regulatory requirements for this contaminant became or will become effective. Used to track regulatory changes over time.',
    `health_effect_category` STRING COMMENT 'Classification of the primary health impact associated with exposure to this contaminant. Acute effects occur shortly after exposure; chronic effects develop over long-term exposure; carcinogenic contaminants may cause cancer.. Valid values are `acute|chronic|carcinogenic|non_carcinogenic|aesthetic|unknown`',
    `health_effect_description` STRING COMMENT 'Detailed description of known or potential health effects from exposure to this contaminant. Used in Consumer Confidence Reports (CCR) and public communication.',
    `mcl_unit` STRING COMMENT 'Unit of measure for the MCL value. Common units: mg/L (milligrams per liter), ug/L (micrograms per liter), pCi/L (picocuries per liter), MFL (million fibers per liter), NTU (Nephelometric Turbidity Units).',
    `mcl_value` DECIMAL(18,2) COMMENT 'The highest level of a contaminant that is allowed in drinking water. Enforceable standard set by EPA or state primacy agency. Null if no MCL is established.',
    `mclg_unit` STRING COMMENT 'Unit of measure for the MCLG value. Typically matches MCL unit for consistency in comparison.',
    `mclg_value` DECIMAL(18,2) COMMENT 'The level of a contaminant in drinking water below which there is no known or expected risk to health. Non-enforceable public health goal. May be zero for carcinogens.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contaminant record was last modified.',
    `monitoring_frequency_code` STRING COMMENT 'Standard frequency at which this contaminant must be monitored under regulatory requirements. Actual frequency may vary based on system size, source water type, and previous results. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annually|triennial|variable|not_required — 8 candidates stripped; promote to reference product]',
    `monitoring_location_type` STRING COMMENT 'Standard location(s) in the water system where monitoring for this contaminant is required. Determines sampling point selection for compliance.. Valid values are `source|entry_point|distribution|consumer_tap|treatment_plant|multiple`',
    `notes` STRING COMMENT 'Additional notes, special considerations, or clarifications regarding the contaminant, its monitoring requirements, or regulatory interpretation. Free-text field for operational guidance.',
    `npdes_effluent_limit_unit` STRING COMMENT 'Unit of measure for the NPDES effluent limit value.',
    `npdes_effluent_limit_value` DECIMAL(18,2) COMMENT 'Maximum allowable concentration in wastewater effluent discharge under NPDES permit requirements. Null if not applicable to wastewater.',
    `public_notification_tier` STRING COMMENT 'EPA public notification tier classification determining the urgency and method of public notification required when violations occur. Tier 1 (most urgent, 24 hours), Tier 2 (30 days), Tier 3 (1 year).. Valid values are `tier_1|tier_2|tier_3|not_applicable`',
    `regulatory_program` STRING COMMENT 'Primary federal or state regulatory program under which this contaminant is monitored and regulated. Determines applicable compliance requirements.. Valid values are `sdwa|cwa|npdes|state_specific|none`',
    `reporting_threshold_unit` STRING COMMENT 'Unit of measure for the reporting threshold value.',
    `reporting_threshold_value` DECIMAL(18,2) COMMENT 'The minimum concentration level at which detection and reporting to regulatory agencies is required. Also known as reporting limit or detection limit for regulatory purposes.',
    `revision_date` DATE COMMENT 'Date when the contaminant record was last revised to reflect regulatory updates, new scientific findings, or data corrections.',
    `source_category` STRING COMMENT 'Primary origin or source of the contaminant in water systems. Helps identify root causes and appropriate mitigation strategies. [ENUM-REF-CANDIDATE: naturally_occurring|industrial|agricultural|municipal|treatment_process|distribution_system|multiple — 7 candidates stripped; promote to reference product]',
    `source_description` STRING COMMENT 'Detailed description of how the contaminant enters water systems. Examples: erosion of natural deposits, discharge from factories, runoff from agricultural operations, byproduct of disinfection, corrosion of household plumbing.',
    `subgroup` STRING COMMENT 'Secondary classification providing more granular categorization within the contaminant group. Examples: THM (within DBP), volatile organic compounds (within organic), coliforms (within microbiological).',
    `treatment_technique_description` STRING COMMENT 'Description of the required treatment technique or process. Examples: filtration, disinfection, corrosion control, specific removal efficiency requirements.',
    `treatment_technique_required` BOOLEAN COMMENT 'Indicates whether a treatment technique is required in lieu of or in addition to an MCL. True if EPA requires specific treatment processes rather than or alongside a numeric limit.',
    `violation_trigger_logic` STRING COMMENT 'Business rule describing when exceedances of limits constitute a regulatory violation. Examples: single sample exceeds MCL, running annual average exceeds MCL, 90th percentile exceeds action level.',
    `wastewater_parameter` BOOLEAN COMMENT 'Indicates whether this contaminant is also monitored as a wastewater effluent parameter under NPDES permits or state discharge requirements.',
    CONSTRAINT pk_contaminant PRIMARY KEY(`contaminant_id`)
) COMMENT 'Reference master for all regulated and monitored water quality parameters including drinking water contaminants, wastewater effluent parameters, and emerging contaminants. Captures contaminant name, CAS number, contaminant group (microbiological, inorganic, organic, radiological, DBP, PFAS), regulatory program (SDWA, CWA, NPDES), applicable limits by regulatory context (MCL, MCLG, action level, treatment technique, permit-specific effluent limits with daily max and monthly average), limit effective and superseded dates, jurisdiction (federal, state primacy agency), reporting threshold, and monitoring frequency requirements. Serves as the enterprise-wide contaminant and parameter taxonomy with versioned regulatory limits.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` (
    `contaminant_limit_id` BIGINT COMMENT 'Unique identifier for the contaminant limit record. Primary key for the contaminant_limit product.',
    `contaminant_id` BIGINT COMMENT 'Reference to the specific contaminant (e.g., lead, arsenic, THM, HAA5, PFAS) for which this limit applies.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Contaminant limits are frequently established by specific permit conditions (e.g., NPDES effluent limits, drinking water permit numeric limits). Linking contaminant_limit to permit_condition enables t',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Contaminant limits are set by regulatory requirements (Safe Drinking Water Act rules, NPDES regulations). contaminant_limit.applicable_regulation and jurisdiction_authority are denormalized representa',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: Contaminant limits vary by state primacy agency jurisdiction, which maps directly to service territory. The existing plain-text jurisdiction column is a denormalized representation of territory. Nor',
    `treatment_permit_id` BIGINT COMMENT 'Foreign key linking to treatment.treatment_permit. Business justification: Regulatory contaminant limits (MCLs, discharge limits) are specified in treatment/discharge permits. Links specific numeric limit to authorizing permit for compliance tracking, permit renewal, and var',
    `analytical_method_required` STRING COMMENT 'EPA-approved analytical method(s) required for measuring this contaminant. Examples: EPA Method 200.8 (metals by ICP-MS), EPA Method 524.2 (VOCs), EPA Method 537.1 (PFAS), Standard Method 2320 (alkalinity), EPA Method 1664A (oil and grease).',
    `averaging_period` STRING COMMENT 'Time period over which the limit is calculated or averaged. Instantaneous = single sample, daily_max = maximum value in a day, monthly_avg = average over calendar month, quarterly_avg = average over quarter, annual_avg = average over calendar year, running_annual_avg = rolling 12-month average, locational_running_annual_avg = running annual average at specific sampling location (e.g., for DBPs under Stage 2 DBPR). [ENUM-REF-CANDIDATE: instantaneous|daily_max|monthly_avg|quarterly_avg|annual_avg|running_annual_avg|locational_running_annual_avg — 7 candidates stripped; promote to reference product]',
    `ccr_reporting_required` BOOLEAN COMMENT 'Indicates whether this contaminant must be included in the annual Consumer Confidence Report (CCR) distributed to drinking water customers. True = must report in CCR, False = not required in CCR.',
    `compliance_status` STRING COMMENT 'Current status of this limit record. Active = currently enforceable, superseded = replaced by newer limit, pending = future effective date not yet reached, suspended = temporarily not enforced due to variance or waiver.. Valid values are `active|superseded|pending|suspended`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contaminant limit record was first created in the system. Used for audit trail and data lineage tracking.',
    `detection_limit_required` DECIMAL(18,2) COMMENT 'Minimum detection limit (MDL) or practical quantitation limit (PQL) required for the analytical method. Laboratory results must meet or exceed this sensitivity. Expressed in same unit_of_measure as limit_value.',
    `effective_date` DATE COMMENT 'Date when this contaminant limit became or will become enforceable. Critical for compliance tracking and historical analysis.',
    `exceedance_action_required` STRING COMMENT 'Description of required actions when this limit is exceeded. Examples: Public notification within 24 hours, Implement corrosion control treatment, Increase monitoring frequency, Submit corrective action plan within 30 days, Immediate discharge cessation.',
    `health_effect_category` STRING COMMENT 'Primary health effect category associated with this contaminant. Acute = immediate health impact, chronic = long-term exposure health impact, carcinogen = cancer-causing, developmental = impacts fetal/child development, reproductive = impacts reproductive health, aesthetic = non-health impact (taste, odor, color).. Valid values are `acute|chronic|carcinogen|developmental|reproductive|aesthetic`',
    `limit_type` STRING COMMENT 'Type of regulatory or operational limit. MCL = Maximum Contaminant Level (enforceable), MCLG = Maximum Contaminant Level Goal (non-enforceable health goal), action_level = threshold triggering corrective action (e.g., Lead and Copper Rule), treatment_technique = required treatment process standard, permit_limit = facility-specific NPDES or discharge permit limit.. Valid values are `mcl|mclg|action_level|treatment_technique|permit_limit`',
    `limit_value` DECIMAL(18,2) COMMENT 'Numeric threshold value for the contaminant limit. For example, MCL for lead is 0.015 mg/L. Null if limit is qualitative (e.g., treatment technique with no numeric threshold).',
    `monitoring_frequency_required` STRING COMMENT 'Required sampling and analysis frequency for this contaminant at this context. Examples: Quarterly, Monthly, Weekly, Daily, Continuous, Every 3 years, Per compliance schedule. May reference a compliance_schedule record for complex schedules.',
    `notes` STRING COMMENT 'Additional context, clarifications, or special conditions related to this contaminant limit. May include information about seasonal variations, conditional applicability, calculation methods, or references to related compliance obligations.',
    `public_notification_tier` STRING COMMENT 'Public notification tier required when this limit is violated (drinking water only). Tier_1 = immediate notice (within 24 hours) for acute health risk, tier_2 = notice within 30 days for chronic health risk, tier_3 = notice within 1 year for monitoring/reporting violations, not_applicable = no public notification required (e.g., for wastewater limits).. Valid values are `tier_1|tier_2|tier_3|not_applicable`',
    `sample_location_type` STRING COMMENT 'Type of location where samples are collected for comparison against this limit. Entry_point = water entering distribution system, distribution_system = within distribution network, consumer_tap = at customer premise, source_water = raw water intake, effluent_discharge = treated wastewater discharge point, process_intermediate = within treatment process.. Valid values are `entry_point|distribution_system|consumer_tap|source_water|effluent_discharge|process_intermediate`',
    `superseded_date` DATE COMMENT 'Date when this limit was replaced by a newer regulation or permit condition. Null if the limit is currently active. Used for historical compliance analysis and regulatory change tracking.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the limit value. Common units: mg/L (milligrams per liter), ug/L (micrograms per liter), ppm (parts per million), ppb (parts per billion), ppt (parts per trillion), CFU/100mL (colony forming units per 100 milliliters for bacteriological), NTU (Nephelometric Turbidity Units), SU (standard units for pH), mrem/year (millirem per year for radionuclides). [ENUM-REF-CANDIDATE: mg/l|ug/l|ppm|ppb|ppt|cfu/100ml|ntu|su|mrem/year — 9 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this contaminant limit record was last modified. Used for audit trail and change tracking.',
    `variance_expiration_date` DATE COMMENT 'Date when the variance or waiver expires and standard limit enforcement resumes. Null if no variance is in effect or if variance is indefinite (subject to periodic review).',
    `variance_waiver_flag` BOOLEAN COMMENT 'Indicates whether a variance or waiver has been granted for this limit at this monitoring context. True = variance/waiver in effect (limit may be temporarily relaxed or monitoring reduced), False = standard limit applies without exception.',
    CONSTRAINT pk_contaminant_limit PRIMARY KEY(`contaminant_limit_id`)
) COMMENT 'Regulatory and operational limits for each contaminant at each applicable monitoring context (drinking water, effluent discharge, source water). Captures MCL, MCLG, action level, treatment technique standard, permit-specific effluent limit (daily max, monthly average), applicable regulation citation, effective date, superseded date, and jurisdiction (federal, state primacy agency). Enables automated compliance comparison against analytical_result values.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` (
    `turbidity_reading_id` BIGINT COMMENT 'Unique identifier for the turbidity measurement record. Primary key.',
    `ami_endpoint_id` BIGINT COMMENT 'Foreign key linking to metering.ami_endpoint. Business justification: Distribution system turbidity monitoring points may co-locate with AMI endpoints to correlate water quality events with flow/pressure anomalies. Business process: main break detection, water quality e',
    `analytical_result_id` BIGINT COMMENT 'Unique identifier linking the turbidity reading to a laboratory analysis record in the Laboratory Information Management System (LIMS), if the reading was obtained through laboratory testing.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Continuous turbidity monitoring involves instrument maintenance, calibration, and operator time—all costs allocated to treatment operations cost centers for budget tracking and rate case documentation',
    `mor_id` BIGINT COMMENT 'Foreign key linking to compliance.mor. Business justification: Turbidity readings are the primary data source for Monthly Operating Reports (MOR) under Surface Water Treatment Rule. Operators compile turbidity_reading records into MOR submissions. This FK enables',
    `online_instrument_id` BIGINT COMMENT 'Unique identifier of the turbidity monitoring instrument or analyzer that captured the reading.',
    `facility_id` BIGINT COMMENT 'Unique identifier of the Water Treatment Plant where the turbidity measurement was recorded.',
    `sampling_point_id` BIGINT COMMENT 'Unique identifier of the physical sampling location or monitoring point within the treatment plant or distribution system where the turbidity reading was captured.',
    `alarm_threshold_ntu` DECIMAL(18,2) COMMENT 'The turbidity threshold value in NTU configured in the SCADA system that triggers an operational alarm when exceeded.',
    `alarm_triggered_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the turbidity reading triggered an automated alarm in the SCADA system due to exceeding a predefined threshold.',
    `calibration_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent calibration performed on the turbidity instrument prior to this reading.',
    `compliance_status` STRING COMMENT 'The compliance status of the turbidity reading relative to regulatory requirements, indicating whether the reading meets Surface Water Treatment Rule standards.. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective action taken by plant operators in response to the turbidity reading, such as filter backwash, chemical dosage adjustment, or process shutdown.',
    `ct_compliance_context` STRING COMMENT 'Contextual information linking the turbidity reading to disinfection Contact Time (CT) compliance calculations, indicating whether the reading impacts CT credit eligibility under the Surface Water Treatment Rule.',
    `data_quality_code` STRING COMMENT 'Code indicating the quality and reliability of the turbidity reading, including flags for suspect data, instrument faults, calibration status, or manual overrides.. Valid values are `valid|suspect|invalid|calibration_due|instrument_fault|manual_override`',
    `data_source_system` STRING COMMENT 'The source system from which the turbidity reading was ingested into the lakehouse: OSIsoft PI Historian, LIMS, manual entry, or direct SCADA feed.. Valid values are `pi_historian|lims|manual_entry|scada_direct`',
    `exceedance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the turbidity reading exceeded the regulatory Maximum Contaminant Level (MCL) or treatment technique requirement under the Surface Water Treatment Rule.',
    `filter_unit_number` STRING COMMENT 'Identifier of the specific filter unit at the Water Treatment Plant (WTP) from which the turbidity reading was captured. Applicable for Individual Filter Effluent (IFE) measurements.',
    `flow_rate_mgd` DECIMAL(18,2) COMMENT 'The flow rate through the filter or treatment process at the time of the turbidity measurement, expressed in Million Gallons per Day (MGD).',
    `measurement_location_type` STRING COMMENT 'Designation of where in the treatment process the turbidity measurement was taken: Individual Filter Effluent (IFE), Combined Filter Effluent (CFE), distribution system entry point, raw water intake, settled water, or filtered water.. Valid values are `ife|cfe|distribution_entry|raw_water|settled_water|filtered_water`',
    `measurement_method` STRING COMMENT 'The method used to capture the turbidity measurement, indicating whether it was a continuous online reading, grab sample, or laboratory analysis.. Valid values are `nephelometric|continuous_online|grab_sample|laboratory`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the turbidity measurement was captured by the instrument or collected as a grab sample.',
    `notes` STRING COMMENT 'Free-text field for operator or analyst notes regarding the turbidity reading, including contextual information, anomalies, or special conditions.',
    `pi_tag_name` STRING COMMENT 'The OSIsoft PI Historian tag name associated with the turbidity measurement point, used for SCADA data integration and historical trending.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this turbidity reading record was first created in the lakehouse silver layer.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this turbidity reading record was last updated in the lakehouse silver layer.',
    `regulatory_limit_ntu` DECIMAL(18,2) COMMENT 'The applicable regulatory turbidity limit in NTU for the measurement location and context, as defined by the Surface Water Treatment Rule or state primacy agency requirements.',
    `reporting_period` STRING COMMENT 'The regulatory reporting period (e.g., monthly, quarterly) to which this turbidity reading applies for compliance reporting purposes.',
    `sample_collection_method` STRING COMMENT 'Method by which the water sample was collected for turbidity analysis: automated continuous monitoring, manual grab sample, or composite sample.. Valid values are `automated|manual_grab|composite`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Temperature of the water sample at the time of turbidity measurement, expressed in degrees Celsius. Temperature can affect turbidity readings and is recorded for quality assurance.',
    `turbidity_value_ntu` DECIMAL(18,2) COMMENT 'The measured turbidity value expressed in Nephelometric Turbidity Units (NTU), representing the cloudiness or haziness of the water sample.',
    CONSTRAINT pk_turbidity_reading PRIMARY KEY(`turbidity_reading_id`)
) COMMENT 'High-frequency turbidity monitoring records from continuous online instruments and grab samples at WTP filter effluents, combined filter effluent, and distribution entry points. Captures NTU value, measurement timestamp, instrument ID, measurement method (nephelometric), filter unit number, CT compliance context, IFE (Individual Filter Effluent) vs CFE (Combined Filter Effluent) designation, and exceedance flag against Surface Water Treatment Rule turbidity limits. Sourced from OSIsoft PI Historian via SCADA integration.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`quality`.`ccr_period` (
    `ccr_period_id` BIGINT COMMENT 'Unique identifier for the Consumer Confidence Report period. Primary key.',
    `ccr_id` BIGINT COMMENT 'Foreign key linking to compliance.ccr. Business justification: The quality.ccr_period tracks internal CCR preparation; compliance.ccr is the submitted regulatory artifact. Linking them closes the CCR workflow: the preparation period culminates in a formal CCR sub',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: The Consumer Confidence Report (CCR) is a federally mandated annual report scoped to a service territory — it defines the customer population served, distribution method, and primacy agency. CCR prepa',
    `water_system_id` BIGINT COMMENT 'FK to quality.water_system',
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
    `health_effects_language_included_flag` BOOLEAN COMMENT 'Indicates whether mandatory EPA health effects language was included for all detected contaminants. Required for CCR compliance.',
    `language_accessibility_provided_flag` BOOLEAN COMMENT 'Indicates whether the CCR was made available in languages other than English to serve non-English speaking populations. Required for systems serving significant non-English speaking populations.',
    `lead_copper_educational_information_flag` BOOLEAN COMMENT 'Indicates whether mandatory lead and copper educational information was included in the CCR. Required under Lead and Copper Rule Revisions (LCRR).',
    `mcl_violation_count` STRING COMMENT 'Number of Maximum Contaminant Level violations that occurred during the report year. Must be prominently disclosed in the CCR.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this CCR period record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CCR period record was last modified.',
    `monitoring_violation_count` STRING COMMENT 'Number of monitoring and reporting violations that occurred during the report year. Includes failures to test or report as required.',
    `online_ccr_url` STRING COMMENT 'Web address where the CCR is posted online. Required if using electronic delivery method.',
    `population_served_count` STRING COMMENT 'Estimated total population receiving water from the system during the report year. Used for regulatory classification and reporting.',
    `preparation_start_date` DATE COMMENT 'Date when preparation of the Consumer Confidence Report began. Typically starts in January following the report year.',
    `primacy_agency` STRING COMMENT 'State or tribal agency with primary enforcement responsibility for public water systems under the Safe Drinking Water Act. Typically the state Department of Environmental Quality or Health.',
    `publication_date` DATE COMMENT 'Date when the Consumer Confidence Report was published and made available to customers. Must be by July 1 following the report year per EPA regulations.',
    `pwsid` STRING COMMENT 'EPA-assigned unique identifier for the public water system. Format: two-letter state code followed by seven digits (e.g., CA1234567).. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `report_status` STRING COMMENT 'Current lifecycle status of the Consumer Confidence Report. Tracks progression from draft through publication and certification to primacy agency.. Valid values are `draft|in_review|approved|published|certified|archived`',
    `report_year` STRING COMMENT 'Calendar year for which this Consumer Confidence Report is prepared. CCRs are annual reports covering the previous calendar years water quality data.',
    `source_water_assessment_summary` STRING COMMENT 'Summary of the source water assessment including susceptibility to contamination and availability information. Required CCR content element.',
    `special_notices_included` STRING COMMENT 'Description of any special notices included in the CCR such as boil water advisories, vulnerable population warnings, or emerging contaminant information.',
    `treatment_technique_violation_count` STRING COMMENT 'Number of treatment technique violations that occurred during the report year. Treatment techniques are required processes for contaminants without MCLs.',
    `violation_summary` STRING COMMENT 'Narrative summary of all violations that occurred during the report year, including health effects language and corrective actions taken. Required CCR content element.',
    `water_source_summary` STRING COMMENT 'Narrative description of the water systems sources including surface water, groundwater, purchased water, and source water protection information. Required CCR content element.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this CCR period record.',
    CONSTRAINT pk_ccr_period PRIMARY KEY(`ccr_period_id`)
) COMMENT 'Master record for each annual Consumer Confidence Report (CCR) reporting period. Captures report year, water system name, PWSID (Public Water System ID), primacy agency, report preparation status, publication date, distribution method (mailed, posted, electronic), number of customers served, water source summary, detected contaminant summary count, violation summary, and certification submission date to primacy agency. Serves as the organizing entity for all CCR-related quality data aggregation.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` (
    `quality_public_notification_id` BIGINT COMMENT 'Unique identifier for the quality_public_notification data product (auto-inserted pre-linking).',
    `analytical_result_id` BIGINT COMMENT 'Foreign key linking to quality.exceedance. Business justification: A public notification is issued in direct response to a confirmed exceedance (MCL violation, action level trigger, or permit limit breach). This FK links the notification to the triggering exceedance ',
    `compliance_public_notification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_public_notification. Business justification: Public notification of water quality violations has both a customer-facing dimension (quality.quality_public_notification) and a regulatory compliance dimension (compliance.compliance_public_notificat',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Public notifications for water quality violations (Tier 1/2/3 PN) must be delivered to affected customer accounts with proof of delivery tracking. EPA regulatory requirement: PN delivery documentation',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Geographic targeting of public notifications based on affected service areas (boil water notices, lead exceedances, pressure zone contamination). Operational necessity: incident response, door-to-door',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: SDWA Tier 1/2/3 public notifications are issued to all customers within a service territory. Territory scoping determines notification distribution scope, regulatory authority to notify, and required ',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: A public notification is issued for a specific water system (identified by PWSID). Linking quality_public_notification to water_system enables queries such as all notifications issued for a given wat',
    CONSTRAINT pk_quality_public_notification PRIMARY KEY(`quality_public_notification_id`)
) COMMENT 'Transactional record of each public notification issued to customers and the primacy agency in response to MCL violations, monitoring failures, or other reportable water quality events. Captures notification type (Tier 1 immediate, Tier 2 30-day, Tier 3 annual), triggering violation or event, notification date, delivery method (newspaper, mail, electronic, posting), affected population count, health effects language used, and certification of delivery to primacy agency. Tracks compliance with public notification rule timelines.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`quality`.`online_instrument` (
    `online_instrument_id` BIGINT COMMENT 'Unique identifier for the online water quality monitoring instrument. Primary key for the online instrument registry.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Online instruments (turbidimeters, chlorine analyzers) require specific calibration standards and reagents tracked as material master records. Water utilities must link instruments to their calibratio',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Online instruments measure specific contaminants/parameters. Currently has measurement_parameter as a STRING. Adding contaminant_id normalizes this to reference the contaminant registry and allows rem',
    `facility_id` BIGINT COMMENT 'Identifier of the water treatment plant (WTP), wastewater treatment plant (WWTP), pump station, or other facility where the instrument is installed.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Online instruments are capital assets requiring depreciation tracking, asset management, and inclusion in rate base for rate case proceedings—standard utility practice for capitalizing monitoring equi',
    `registry_id` BIGINT COMMENT 'Reference to the general asset registry if this instrument is also tracked as a capital asset in the CMMS or ERP system. Links quality-specific instrument metadata to enterprise asset management.',
    `sampling_point_id` BIGINT COMMENT 'Reference to the specific sampling point or monitoring location where the instrument is deployed. Links to the sampling point registry for regulatory compliance tracking.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Online instruments purchased from and serviced by vendors. Required for warranty tracking, calibration service scheduling, spare parts procurement, and vendor performance evaluation. No existing unlin',
    `accuracy_specification` STRING COMMENT 'Manufacturers stated accuracy or precision specification for the instrument (e.g., ±0.02 NTU, ±2% of reading, ±0.1 pH units). Critical for data quality assessment.',
    `alarm_high_threshold` DECIMAL(18,2) COMMENT 'Upper alarm threshold value configured in SCADA. When instrument reading exceeds this value, an alarm is triggered for operator response.',
    `alarm_low_threshold` DECIMAL(18,2) COMMENT 'Lower alarm threshold value configured in SCADA. When instrument reading falls below this value, an alarm is triggered for operator response.',
    `calibration_frequency_days` STRING COMMENT 'Required interval between calibrations, expressed in days. Determined by manufacturer recommendations, regulatory requirements, and operational experience.',
    `calibration_standard_used` STRING COMMENT 'Description of the calibration standard or reference material used during the most recent calibration (e.g., NIST-traceable 10 NTU formazin standard, pH 7.0 buffer solution).',
    `calibration_technician` STRING COMMENT 'Name or identifier of the technician who performed the most recent calibration. Used for quality assurance and accountability.',
    `communication_protocol` STRING COMMENT 'Communication protocol used by the instrument to transmit data to SCADA or control systems (e.g., Modbus RTU, Modbus TCP/IP, HART, Profibus, analog 4-20mA signal). [ENUM-REF-CANDIDATE: modbus_rtu|modbus_tcp|hart|profibus|foundation_fieldbus|ethernet_ip|analog_4_20ma|digital_pulse|bacnet — 9 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was first created in the system. Used for data lineage and audit trail.',
    `data_logging_interval_seconds` STRING COMMENT 'Frequency at which the instrument records or transmits data to the SCADA/historian system, expressed in seconds (e.g., 60 for one-minute intervals, 300 for five-minute intervals).',
    `expected_service_life_years` STRING COMMENT 'Anticipated operational lifespan of the instrument in years, based on manufacturer specifications and utility experience. Used for capital planning and replacement scheduling.',
    `gis_feature_code` STRING COMMENT 'Unique identifier in the GIS system linking this instrument to its geographic location and network context. Enables spatial analysis and network modeling.',
    `installation_date` DATE COMMENT 'Date when the instrument was installed and commissioned at its current location. Used for asset lifecycle tracking and warranty management.',
    `installation_location` STRING COMMENT 'Detailed description of where the instrument is physically installed (e.g., WTP Filter Effluent Gallery, Distribution Pump Station 5 Discharge, WWTP Final Clarifier Effluent Channel).',
    `instrument_name` STRING COMMENT 'Descriptive name of the online monitoring instrument indicating its function and location (e.g., WTP Effluent Turbidimeter, Distribution Zone 3 Chlorine Analyzer).',
    `instrument_tag` STRING COMMENT 'Unique alphanumeric tag or asset identifier assigned to the instrument for field identification and maintenance tracking. Typically follows plant or utility tagging conventions.',
    `instrument_type` STRING COMMENT 'Classification of the online instrument by measurement function. Defines the primary water quality parameter or operational metric the instrument monitors. [ENUM-REF-CANDIDATE: turbidimeter|chlorine_analyzer|ph_meter|toc_analyzer|uv254_sensor|flow_meter|conductivity_meter|dissolved_oxygen_analyzer|particle_counter|fluorometer|ammonia_analyzer|nitrate_analyzer|phosphate_analyzer|bod_analyzer|cod_analyzer|tss_analyzer|ozone_analyzer|pressure_transmitter|temperature_sensor — promote to reference product]',
    `last_calibration_date` DATE COMMENT 'Date when the instrument was most recently calibrated. Used to track calibration compliance and schedule next calibration.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the instrument installation location in decimal degrees. Used for mapping and spatial analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the instrument installation location in decimal degrees. Used for mapping and spatial analysis.',
    `maintenance_notes` STRING COMMENT 'Free-text field for recording maintenance history, operational issues, calibration adjustments, or other relevant notes about the instruments performance and service history.',
    `measurement_range_max` DECIMAL(18,2) COMMENT 'Maximum value of the instruments calibrated measurement range. Defines the upper detection limit for accurate readings.',
    `measurement_range_min` DECIMAL(18,2) COMMENT 'Minimum value of the instruments calibrated measurement range. Defines the lower detection limit for accurate readings.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the parameter reported by the instrument (e.g., mg/L, NTU, pH units, µS/cm, ppm, ppb, GPM, MGD, PSI).',
    `model_number` STRING COMMENT 'Manufacturers model or part number for the instrument. Used for procurement, spare parts identification, and technical support.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who most recently modified this instrument record. Used for accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was most recently updated. Used for change tracking and data quality monitoring.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration. Calculated from last calibration date plus calibration frequency. Used for preventive maintenance scheduling.',
    `operational_status` STRING COMMENT 'Current operational state of the instrument. Indicates whether the instrument is actively monitoring, undergoing maintenance, or out of service.. Valid values are `operational|out_of_service|maintenance|calibration|failed|decommissioned`',
    `pi_historian_tag` STRING COMMENT 'Tag name in the OSIsoft PI Historian or equivalent time-series database where continuous instrument readings are stored for trending and analysis.',
    `power_supply_type` STRING COMMENT 'Type of electrical power supply used by the instrument (e.g., AC 120V, DC 24V, battery-powered, solar-powered, loop-powered from 4-20mA signal).. Valid values are `ac_120v|ac_240v|dc_24v|battery|solar|loop_powered`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this instrument is used for regulatory compliance monitoring and reporting (e.g., SDWA, NPDES permit requirements). True if data from this instrument is reported to regulatory agencies.',
    `responsible_department` STRING COMMENT 'Name of the department or work group responsible for maintaining and calibrating this instrument (e.g., Water Quality Lab, Instrumentation & Controls, Plant Operations).',
    `scada_tag_name` STRING COMMENT 'Unique tag identifier in the SCADA system that receives real-time data from this instrument. Used for process control, alarming, and data historian integration.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific instrument unit. Critical for warranty tracking and service history.',
    `treatment_stage` STRING COMMENT 'Stage in the water or wastewater treatment process where the instrument is monitoring. Critical for understanding data context and compliance requirements. [ENUM-REF-CANDIDATE: raw_water|pre_treatment|coagulation|flocculation|sedimentation|filtration|disinfection|post_treatment|distribution|wastewater_influent|primary_treatment|secondary_treatment|tertiary_treatment|effluent_discharge|sludge_processing — promote to reference product]',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty coverage expires. Critical for maintenance planning and budgeting.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this instrument record. Used for accountability and audit trail.',
    CONSTRAINT pk_online_instrument PRIMARY KEY(`online_instrument_id`)
) COMMENT 'Master registry of continuous online water quality monitoring instruments deployed across WTPs, WWTPs, and the distribution network. Captures instrument type (turbidimeter, chlorine analyzer, pH meter, TOC analyzer, UV254 sensor, flow meter), manufacturer, model, serial number, installation location/sampling point, calibration frequency, last calibration date, calibration standard used, communication protocol (SCADA/Modbus/HART), PI Historian tag name, and operational status. Distinct from the asset domains general asset registry by focusing on quality-specific instrument metadata and calibration management.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`quality`.`compliance_determination` (
    `compliance_determination_id` BIGINT COMMENT 'Unique identifier for the compliance_determination data product (auto-inserted pre-linking).',
    `ccr_period_id` BIGINT COMMENT 'Foreign key linking to quality.ccr_period. Business justification: A compliance determination is a period-level record that feeds directly into the Consumer Confidence Report for that reporting year. Linking compliance_determination to ccr_period enables the CCR prep',
    `compliance_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_violation. Business justification: A compliance determination is the formal regulatory assessment that a violation occurred. Linking compliance_determination directly to compliance_violation is the core regulatory workflow: the determi',
    `contaminant_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant. Business justification: Compliance determinations are contaminant-specific (e.g., compliance determination for lead, for TTHM, etc.). This FK identifies which contaminant the determination applies to.',
    `contaminant_limit_id` BIGINT COMMENT 'Foreign key linking to quality.contaminant_limit. Business justification: A compliance determination evaluates whether analytical results meet or exceed a specific regulatory limit. Linking compliance_determination directly to contaminant_limit (the specific MCL, action lev',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: LCRR compliance determinations for lead service line material classification must be traceable to specific asset registry records. Treatment technique compliance determinations reference specific trea',
    `sampling_schedule_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_schedule. Business justification: Compliance determinations aggregate analytical results for a specific sampling schedule over a monitoring period. This FK links the compliance determination to the schedule being evaluated, eliminatin',
    `superseded_compliance_determination_id` BIGINT COMMENT 'Self-referencing FK on compliance_determination (superseded_compliance_determination_id)',
    CONSTRAINT pk_compliance_determination PRIMARY KEY(`compliance_determination_id`)
) COMMENT 'Period-level compliance determination record that aggregates analytical results into a formal compliance status for each contaminant group, monitoring period, and regulatory rule. Captures determination period (monthly, quarterly, annual), contaminant or contaminant group, applicable rule (SDWA, CWA, NPDES), calculation method (single sample max, running annual average, 90th percentile), calculated compliance value, applicable limit, pass/fail status, and determination date. Bridges the gap between individual analytical results and regulatory reporting by providing the formal compliance roll-up that drives CCR preparation, DMR submission, and violation determination.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`quality`.`water_system` (
    `water_system_id` BIGINT COMMENT 'Primary key for water_system',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Every public water system operates under a compliance permit (operating permit or NPDES permit). This system-level FK is fundamental for compliance tracking, permit renewal, and regulatory reporting. ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each water system maps to a cost center for O&M budgeting, financial reporting, and rate case cost allocation. Water utilities manage finances at the water system level — a domain expert would expect ',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Water systems are financed through specific enterprise funds (e.g., water enterprise fund vs. wastewater fund). Utilities must segregate revenues and expenditures by fund per GASB requirements. This l',
    `parent_water_system_id` BIGINT COMMENT 'Self-referencing FK on water_system (parent_water_system_id)',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to finance.finance_rate_case. Business justification: Rate cases are filed by water system — each rate case establishes revenue requirements for a specific water system. Regulators and utility finance teams must link water system operational data (qualit',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: A water system serves a defined service territory — this is a foundational operational relationship governing rate cases, CCR reporting, regulatory jurisdiction, and customer population served. Every ',
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
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next inspection.',
    `number_of_units` STRING COMMENT 'Count of major equipment units within the system (e.g., pumps, filters).',
    `owner_organization` STRING COMMENT 'Name of the organization that owns the water system.',
    `permit_expiry_date` DATE COMMENT 'Expiration date of the regulatory permit.',
    `ph_range` STRING COMMENT 'Typical pH range of output water (e.g., 6.5-8.5).',
    `source_type` STRING COMMENT 'Primary source of raw water for the system.',
    `system_code` STRING COMMENT 'Unique alphanumeric code assigned to the water system.',
    `system_type` STRING COMMENT 'Category of the water system based on function.',
    `total_coliforms_cfu_100ml` DECIMAL(18,2) COMMENT 'Typical total coliform count.',
    `treatment_processes` STRING COMMENT 'Comma-separated list of treatment processes applied (e.g., coagulation, filtration, disinfection).',
    `turbidity_ntu` DECIMAL(18,2) COMMENT 'Typical turbidity measurement in Nephelometric Turbidity Units.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `water_quality_category` STRING COMMENT 'Classification of water quality produced.',
    `water_system_name` STRING COMMENT 'Human readable name of the water system.',
    `water_system_status` STRING COMMENT 'Current operational status of the water system.',
    CONSTRAINT pk_water_system PRIMARY KEY(`water_system_id`)
) COMMENT 'Master reference table for water_system. Referenced by water_system_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ADD CONSTRAINT `fk_quality_sampling_point_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ADD CONSTRAINT `fk_quality_sampling_schedule_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_parent_sample_water_sample_id` FOREIGN KEY (`parent_sample_water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ADD CONSTRAINT `fk_quality_water_sample_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ADD CONSTRAINT `fk_quality_analytical_result_water_sample_id` FOREIGN KEY (`water_sample_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_sample`(`water_sample_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ADD CONSTRAINT `fk_quality_contaminant_limit_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `water_utilities_ecm`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_online_instrument_id` FOREIGN KEY (`online_instrument_id`) REFERENCES `water_utilities_ecm`.`quality`.`online_instrument`(`online_instrument_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ADD CONSTRAINT `fk_quality_turbidity_reading_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ADD CONSTRAINT `fk_quality_ccr_period_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_analytical_result_id` FOREIGN KEY (`analytical_result_id`) REFERENCES `water_utilities_ecm`.`quality`.`analytical_result`(`analytical_result_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ADD CONSTRAINT `fk_quality_quality_public_notification_water_system_id` FOREIGN KEY (`water_system_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_system`(`water_system_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ADD CONSTRAINT `fk_quality_online_instrument_sampling_point_id` FOREIGN KEY (`sampling_point_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_point`(`sampling_point_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_ccr_period_id` FOREIGN KEY (`ccr_period_id`) REFERENCES `water_utilities_ecm`.`quality`.`ccr_period`(`ccr_period_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_contaminant_id` FOREIGN KEY (`contaminant_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant`(`contaminant_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_contaminant_limit_id` FOREIGN KEY (`contaminant_limit_id`) REFERENCES `water_utilities_ecm`.`quality`.`contaminant_limit`(`contaminant_limit_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_sampling_schedule_id` FOREIGN KEY (`sampling_schedule_id`) REFERENCES `water_utilities_ecm`.`quality`.`sampling_schedule`(`sampling_schedule_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ADD CONSTRAINT `fk_quality_compliance_determination_superseded_compliance_determination_id` FOREIGN KEY (`superseded_compliance_determination_id`) REFERENCES `water_utilities_ecm`.`quality`.`compliance_determination`(`compliance_determination_id`);
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ADD CONSTRAINT `fk_quality_water_system_parent_water_system_id` FOREIGN KEY (`parent_water_system_id`) REFERENCES `water_utilities_ecm`.`quality`.`water_system`(`water_system_id`);

-- ========= TAGS =========
ALTER SCHEMA `water_utilities_ecm`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `water_utilities_ecm`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` SET TAGS ('dbx_subdomain' = 'sampling_monitoring');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `access_type` SET TAGS ('dbx_business_glossary_term' = 'Access Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `access_type` SET TAGS ('dbx_value_regex' = 'public|restricted|private_property|confined_space|remote');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `ccr_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Reporting Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Code');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `dmr_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Discharge Monitoring Report (DMR) Reporting Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Feet)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate (Gallons Per Minute - GPM)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `last_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sample Collection Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Sampling Location Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `next_scheduled_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Sample Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `primary_contaminant_group` SET TAGS ('dbx_business_glossary_term' = 'Primary Contaminant Group');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `regulatory_zone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Monitoring Zone');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `residence_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Residence Time (Hours)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `safety_notes` SET TAGS ('dbx_business_glossary_term' = 'Safety Notes');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Method');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_value_regex' = 'grab|composite|continuous_monitor|passive_sampler');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `sampler_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Sampler Name');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `sampler_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `sampling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Sampling Instructions');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `sampling_point_code` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Code');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `sampling_point_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `sampling_point_name` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Name');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `sampling_point_status` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Status');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `sampling_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|temporarily_suspended|decommissioned');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `scada_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_business_glossary_term' = 'Treatment Stage');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `water_source_type` SET TAGS ('dbx_business_glossary_term' = 'Water Source Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `water_source_type` SET TAGS ('dbx_value_regex' = 'surface_water|groundwater|groundwater_under_influence|blended|purchased|recycled');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_point` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` SET TAGS ('dbx_subdomain' = 'sampling_monitoring');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `project_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Project Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Laboratory (Lab) ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `compliance_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|at_risk|non_compliant|pending_review');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `cost_per_sample` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Sample (USD)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `cost_per_sample` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `holding_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Holding Time (Hours)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `last_sample_collected_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sample Collected Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `monitoring_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period End Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `monitoring_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Period Start Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `next_scheduled_sample_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Sample Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `notification_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Notification Lead Time (Days)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `preservation_method` SET TAGS ('dbx_business_glossary_term' = 'Preservation Method');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `regulatory_rule` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rule');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirement');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite|continuous|integrated');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `sample_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume (mL)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `samples_collected_ytd` SET TAGS ('dbx_business_glossary_term' = 'Samples Collected Year-to-Date (YTD)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `samples_per_period` SET TAGS ('dbx_business_glossary_term' = 'Samples Per Period');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `samples_required_ytd` SET TAGS ('dbx_business_glossary_term' = 'Samples Required Year-to-Date (YTD)');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|suspended|completed|cancelled|pending_approval|expired');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'regulatory|operational|investigational|special_study|compliance_verification|routine');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `seasonal_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Adjustment Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`sampling_schedule` ALTER COLUMN `violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Violation Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` SET TAGS ('dbx_subdomain' = 'sampling_monitoring');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `point_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Point Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Container Material Master Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `parent_sample_water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Sample Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Sampler Equipment Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `analysis_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Due Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `collection_notes` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Notes');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `composite_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Composite Sample Duration in Hours');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `composite_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Composite Sample Interval in Minutes');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `container_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Container Volume in Milliliters (mL)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `field_chlorine_residual_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Field Chlorine Residual in Milligrams per Liter (mg/L)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `field_conductivity_us_cm` SET TAGS ('dbx_business_glossary_term' = 'Field Conductivity in Microsiemens per Centimeter (µS/cm)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `field_dissolved_oxygen_mg_l` SET TAGS ('dbx_business_glossary_term' = 'Field Dissolved Oxygen (DO) in Milligrams per Liter (mg/L)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `field_ph` SET TAGS ('dbx_business_glossary_term' = 'Field Potential of Hydrogen (pH)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `field_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Field Temperature in Celsius (°C)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `field_turbidity_ntu` SET TAGS ('dbx_business_glossary_term' = 'Field Turbidity in Nephelometric Turbidity Units (NTU)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `flow_rate_gpm` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate in Gallons per Minute (GPM)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `hold_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Sample Hold Time in Hours');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `lims_submission_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Submission Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `quality_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `requested_analysis_group` SET TAGS ('dbx_business_glossary_term' = 'Requested Analysis Group');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `sample_location_description` SET TAGS ('dbx_business_glossary_term' = 'Sample Location Description');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `sample_matrix` SET TAGS ('dbx_business_glossary_term' = 'Sample Matrix');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `sample_matrix` SET TAGS ('dbx_value_regex' = 'drinking_water|raw_water|treated_water|distribution_water|wastewater_influent|wastewater_effluent');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `sample_purpose` SET TAGS ('dbx_business_glossary_term' = 'Sample Purpose');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Status');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'grab|composite|field_blank|duplicate|split|trip_blank');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `sampler_equipment_code` SET TAGS ('dbx_business_glossary_term' = 'Sampler Equipment Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_sample` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions at Collection');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` SET TAGS ('dbx_subdomain' = 'sampling_monitoring');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Result ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Project Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `installation_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `water_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Water Sample ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `analysis_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Instrument Calibration Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `compliance_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Compliance Limit Exceeded Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `data_validation_level` SET TAGS ('dbx_business_glossary_term' = 'Data Validation Level');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `data_validation_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (MDL)');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `dilution_factor` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `hold_time_compliant` SET TAGS ('dbx_business_glossary_term' = 'Hold Time Compliant Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `hold_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Hold Time Hours');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `laboratory_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Accreditation Number');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `lims_result_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Result ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `mcl_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL)');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `mclg_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level Goal (MCLG)');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `percent_recovery` SET TAGS ('dbx_business_glossary_term' = 'Percent Recovery');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `qualifier_code` SET TAGS ('dbx_business_glossary_term' = 'Result Qualifier Code');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `quantitation_limit` SET TAGS ('dbx_business_glossary_term' = 'Method Quantitation Limit (MQL)');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `relative_percent_difference` SET TAGS ('dbx_business_glossary_term' = 'Relative Percent Difference (RPD)');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `result_comment` SET TAGS ('dbx_business_glossary_term' = 'Result Comment');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|approved|rejected|cancelled');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `sample_matrix` SET TAGS ('dbx_business_glossary_term' = 'Sample Matrix Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By User ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `validated_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`analytical_result` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `action_level_unit` SET TAGS ('dbx_business_glossary_term' = 'Action Level Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `action_level_value` SET TAGS ('dbx_business_glossary_term' = 'Action Level Value');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `analytical_method_code` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Code');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `ccr_language_template` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Language Template');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `ccr_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Reporting Required Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `contaminant_code` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Code');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `contaminant_name` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Name');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `contaminant_status` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Status');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `contaminant_status` SET TAGS ('dbx_value_regex' = 'active|inactive|proposed|withdrawn');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `contaminant_type` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `contaminant_type` SET TAGS ('dbx_value_regex' = 'regulated|unregulated|emerging|secondary');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `detection_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (MDL) Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `detection_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Method Detection Limit (MDL) Value');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_business_glossary_term' = 'Health Effect Category');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_value_regex' = 'acute|chronic|carcinogenic|non_carcinogenic|aesthetic|unknown');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `health_effect_description` SET TAGS ('dbx_business_glossary_term' = 'Health Effect Description');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `health_effect_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `health_effect_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `mcl_unit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `mcl_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Value');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `mclg_unit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level Goal (MCLG) Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `mclg_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level Goal (MCLG) Value');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `monitoring_frequency_code` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency Code');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `monitoring_location_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `monitoring_location_type` SET TAGS ('dbx_value_regex' = 'source|entry_point|distribution|consumer_tap|treatment_plant|multiple');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `npdes_effluent_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Effluent Limit Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `npdes_effluent_limit_value` SET TAGS ('dbx_business_glossary_term' = 'National Pollutant Discharge Elimination System (NPDES) Effluent Limit Value');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `public_notification_tier` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Tier');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `public_notification_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|not_applicable');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_value_regex' = 'sdwa|cwa|npdes|state_specific|none');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `reporting_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Reporting Threshold Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `reporting_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Reporting Threshold Value');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `source_category` SET TAGS ('dbx_business_glossary_term' = 'Source Category');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `source_description` SET TAGS ('dbx_business_glossary_term' = 'Source Description');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `subgroup` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Subgroup');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technique (TT) Description');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_required` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technique (TT) Required Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `treatment_technique_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `violation_trigger_logic` SET TAGS ('dbx_business_glossary_term' = 'Violation Trigger Logic');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant` ALTER COLUMN `wastewater_parameter` SET TAGS ('dbx_business_glossary_term' = 'Wastewater Parameter Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `treatment_permit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `analytical_method_required` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Required');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `averaging_period` SET TAGS ('dbx_business_glossary_term' = 'Averaging Period');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `ccr_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Reporting Required');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'active|superseded|pending|suspended');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `detection_limit_required` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit Required');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `exceedance_action_required` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Action Required');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_business_glossary_term' = 'Health Effect Category');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_value_regex' = 'acute|chronic|carcinogen|developmental|reproductive|aesthetic');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `health_effect_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'mcl|mclg|action_level|treatment_technique|permit_limit');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `limit_value` SET TAGS ('dbx_business_glossary_term' = 'Limit Value');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `monitoring_frequency_required` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency Required');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `public_notification_tier` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Tier');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `public_notification_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|not_applicable');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `sample_location_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Location Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `sample_location_type` SET TAGS ('dbx_value_regex' = 'entry_point|distribution_system|consumer_tap|source_water|effluent_discharge|process_intermediate');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `superseded_date` SET TAGS ('dbx_business_glossary_term' = 'Superseded Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `variance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Variance Expiration Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`contaminant_limit` ALTER COLUMN `variance_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance or Waiver Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` SET TAGS ('dbx_subdomain' = 'sampling_monitoring');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `turbidity_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Reading ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `ami_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Ami Endpoint Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Analysis Identifier');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `mor_id` SET TAGS ('dbx_business_glossary_term' = 'Mor Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `online_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Water Treatment Plant (WTP) Identifier');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Point Identifier');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `alarm_threshold_ntu` SET TAGS ('dbx_business_glossary_term' = 'Alarm Threshold in Nephelometric Turbidity Units (NTU)');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `alarm_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Alarm Triggered Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `calibration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Instrument Calibration Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempt');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `ct_compliance_context` SET TAGS ('dbx_business_glossary_term' = 'Contact Time (CT) Compliance Context');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `data_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Code');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `data_quality_code` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid|calibration_due|instrument_fault|manual_override');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'pi_historian|lims|manual_entry|scada_direct');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Exceedance Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `filter_unit_number` SET TAGS ('dbx_business_glossary_term' = 'Filter Unit Number');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `flow_rate_mgd` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate in Million Gallons per Day (MGD)');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `measurement_location_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Location Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `measurement_location_type` SET TAGS ('dbx_value_regex' = 'ife|cfe|distribution_entry|raw_water|settled_water|filtered_water');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'nephelometric|continuous_online|grab_sample|laboratory');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operator Notes');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `pi_tag_name` SET TAGS ('dbx_business_glossary_term' = 'OSIsoft PI Historian Tag Name');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `regulatory_limit_ntu` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Turbidity Limit in Nephelometric Turbidity Units (NTU)');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Period');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Method');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `sample_collection_method` SET TAGS ('dbx_value_regex' = 'automated|manual_grab|composite');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Sample Temperature in Celsius');
ALTER TABLE `water_utilities_ecm`.`quality`.`turbidity_reading` ALTER COLUMN `turbidity_value_ntu` SET TAGS ('dbx_business_glossary_term' = 'Turbidity Value in Nephelometric Turbidity Units (NTU)');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `ccr_period_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Confidence Report (CCR) Period ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `ccr_id` SET TAGS ('dbx_business_glossary_term' = 'Ccr Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `water_system_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `certification_method` SET TAGS ('dbx_business_glossary_term' = 'Certification Method');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `certification_method` SET TAGS ('dbx_value_regex' = 'electronic|mail|fax|online_portal');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `certification_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Submission Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `certified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Certified By Name');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `certified_by_title` SET TAGS ('dbx_business_glossary_term' = 'Certified By Title');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `customers_served_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Served Count');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `detected_contaminant_count` SET TAGS ('dbx_business_glossary_term' = 'Detected Contaminant Count');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `distribution_method` SET TAGS ('dbx_business_glossary_term' = 'Distribution Method');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `distribution_method` SET TAGS ('dbx_value_regex' = 'mailed|posted_online|electronic_delivery|newspaper|combination');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `document_file_path` SET TAGS ('dbx_business_glossary_term' = 'Document File Path');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `health_effects_language_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Effects Language Included Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `health_effects_language_included_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `health_effects_language_included_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `language_accessibility_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Language Accessibility Provided Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `lead_copper_educational_information_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead and Copper Educational Information Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `mcl_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Contaminant Level (MCL) Violation Count');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `monitoring_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Monitoring and Reporting Violation Count');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `online_ccr_url` SET TAGS ('dbx_business_glossary_term' = 'Online Consumer Confidence Report (CCR) URL');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `population_served_count` SET TAGS ('dbx_business_glossary_term' = 'Population Served Count');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `preparation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Start Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `primacy_agency` SET TAGS ('dbx_business_glossary_term' = 'Primacy Agency');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `pwsid` SET TAGS ('dbx_business_glossary_term' = 'Public Water System Identification (PWSID)');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `pwsid` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|published|certified|archived');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `report_year` SET TAGS ('dbx_business_glossary_term' = 'Report Year');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `source_water_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Source Water Assessment Summary');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `special_notices_included` SET TAGS ('dbx_business_glossary_term' = 'Special Notices Included');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `treatment_technique_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Treatment Technique (TT) Violation Count');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `treatment_technique_violation_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `treatment_technique_violation_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `violation_summary` SET TAGS ('dbx_business_glossary_term' = 'Violation Summary');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `water_source_summary` SET TAGS ('dbx_business_glossary_term' = 'Water Source Summary');
ALTER TABLE `water_utilities_ecm`.`quality`.`ccr_period` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ALTER COLUMN `quality_public_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for quality_public_notification');
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ALTER COLUMN `analytical_result_id` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ALTER COLUMN `compliance_public_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Public Notification Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`quality_public_notification` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` SET TAGS ('dbx_subdomain' = 'sampling_monitoring');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `online_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Online Instrument ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Material Master Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `accuracy_specification` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Specification');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `alarm_high_threshold` SET TAGS ('dbx_business_glossary_term' = 'Alarm High Threshold Value');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `alarm_low_threshold` SET TAGS ('dbx_business_glossary_term' = 'Alarm Low Threshold Value');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `calibration_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency in Days');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `calibration_standard_used` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard Used');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `calibration_technician` SET TAGS ('dbx_business_glossary_term' = 'Calibration Technician Name');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `data_logging_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Data Logging Interval in Seconds');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `expected_service_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Service Life in Years');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature ID');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `installation_location` SET TAGS ('dbx_business_glossary_term' = 'Installation Location Description');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'Instrument Name');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `instrument_tag` SET TAGS ('dbx_business_glossary_term' = 'Instrument Tag Number');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `maintenance_notes` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Notes');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `measurement_range_max` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Maximum');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `measurement_range_min` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Minimum');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|out_of_service|maintenance|calibration|failed|decommissioned');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `pi_historian_tag` SET TAGS ('dbx_business_glossary_term' = 'Process Information (PI) Historian Tag');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `power_supply_type` SET TAGS ('dbx_business_glossary_term' = 'Power Supply Type');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `power_supply_type` SET TAGS ('dbx_value_regex' = 'ac_120v|ac_240v|dc_24v|battery|solar|loop_powered');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Monitoring Flag');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `scada_tag_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Name');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_business_glossary_term' = 'Treatment Stage');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `treatment_stage` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `water_utilities_ecm`.`quality`.`online_instrument` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ALTER COLUMN `compliance_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for compliance_determination');
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ALTER COLUMN `ccr_period_id` SET TAGS ('dbx_business_glossary_term' = 'Ccr Period Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ALTER COLUMN `compliance_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ALTER COLUMN `contaminant_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ALTER COLUMN `contaminant_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Contaminant Limit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ALTER COLUMN `sampling_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Schedule Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`compliance_determination` ALTER COLUMN `superseded_compliance_determination_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` SET TAGS ('dbx_subdomain' = 'compliance_reporting');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Identifier');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ALTER COLUMN `parent_water_system_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Rate Case Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ALTER COLUMN `treatment_processes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`quality`.`water_system` ALTER COLUMN `treatment_processes` SET TAGS ('dbx_pii' = 'true');
