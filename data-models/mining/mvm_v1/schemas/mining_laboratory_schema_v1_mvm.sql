-- Schema for Domain: laboratory | Business: Mining | Version: v1_mvm
-- Generated on: 2026-05-05 14:20:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`laboratory` COMMENT 'Manages sample lifecycle, assay workflows, QA/QC protocols, and analytical results via LIMS (LabWare). Serves as the SSOT for all geochemical and metallurgical test data including fire assay, XRF, and leach test results that underpin resource estimation and process optimisation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`laboratory_sample` (
    `laboratory_sample_id` BIGINT COMMENT 'Unique identifier for the laboratory sample record. Primary key for the laboratory_sample product.',
    `chemical_register_id` BIGINT COMMENT 'Foreign key linking to hse.chemical_register. Business justification: Samples of chemicals stored on site for characterization and SDS verification (sampling bulk fuel for quality/contamination, reagent verification sampling). Supports chemical inventory management.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Mining operations track which drill rig, excavator, or sampling equipment collected each sample for traceability, equipment performance analysis, and contamination investigation. Critical for grade co',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Every sample is collected to assay a specific commodity (iron ore, copper, coal, lithium, nickel). Essential for resource estimation filtering, grade reconciliation by commodity, and commodity-specifi',
    `crm_standard_id` BIGINT COMMENT 'Identifier of the certified reference material (CRM) used if this sample is a QA/QC standard. Links to the known assay values for accuracy verification.',
    `duplicate_of_sample_laboratory_sample_id` BIGINT COMMENT 'Reference to the original sample ID if this sample is a field or lab duplicate. Used to pair duplicates for precision analysis.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Individual samples collected to demonstrate permit compliance (discharge water samples against permit limits, air quality samples for air permit). Required for permit compliance reporting.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Mining operations routinely send samples to external commercial laboratories for independent verification, umpire analysis, and capacity overflow. Tracking the counterparty enables invoice reconciliat',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory. Business justification: Samples must be linked to the laboratory that processes them. This is a critical missing link - laboratory_sample currently has no direct FK to laboratory, making it impossible to determine which lab ',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Samples collected during maintenance activities (oil analysis, wear debris analysis, corrosion samples, material verification) require traceability to the originating work order for condition-based ma',
    `pit_or_level_id` BIGINT COMMENT 'Foreign key linking to mine.pit_or_level. Business justification: laboratory_sample carries denormalized pit_name. Grade control samples are scoped to a specific pit or underground level for resource estimation and reconciliation reporting. Replacing pit_name with a',
    `rom_stockpile_id` BIGINT COMMENT 'Foreign key linking to mine.rom_stockpile. Business justification: ROM stockpile grade control sampling is a routine operational process. Samples collected from ROM stockpiles must reference the specific stockpile for inventory grade tracking, blending decisions, and',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Laboratory samples collected from product stockpiles, process streams, or shipment lots must be traceable to the specific saleable product for quality control and certification purposes. Pre-shipment ',
    `sample_batch_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_batch. Business justification: A laboratory sample belongs to a sample batch for preparation and analytical processing. The sample_batch is the parent grouping entity. laboratory_sample currently carries batch_number as a free-text',
    `sample_program_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_program. Business justification: Every sample is collected under a sampling program or campaign. The sample_program defines the protocol, QA/QC requirements, and analytical suite. Currently laboratory_sample has project_code (STRING)',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Samples collected outside a formal program (blast samples, process stream samples) must be attributed to a tenement for statutory minimum expenditure reporting and JORC compliance. Mining domain exper',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Waste rock dump geochemical and ARD monitoring requires samples to reference the specific dump they were collected from. ARD management plans and environmental compliance reporting depend on tracing s',
    `barcode` STRING COMMENT 'Machine-readable barcode assigned by LIMS for automated sample tracking through preparation and analysis workflows. Ensures chain-of-custody integrity.. Valid values are `^[0-9]{10,20}$`',
    `chain_of_custody_status` STRING COMMENT 'Status of the chain-of-custody documentation for this sample. Intact indicates complete documentation; broken indicates missing or inconsistent records; under investigation indicates active review.. Valid values are `intact|broken|under_investigation`',
    `collection_timestamp` TIMESTAMP COMMENT 'Date and time when the sample was physically collected in the field or plant. Critical for chain-of-custody and time-series analysis of grade trends.',
    `comments` STRING COMMENT 'Free-text field for additional notes about the sample, including field observations, preparation issues, or analytical anomalies.',
    `core_diameter` STRING COMMENT 'Standard drill core diameter designation for diamond drill samples. HQ (63.5mm), NQ (47.6mm), PQ (85mm), BQ (36.4mm), AQ (27mm). Applicable only to drill core samples.. Valid values are `HQ|NQ|PQ|BQ|AQ`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sample record was first created in the LIMS system. Part of audit trail for data governance.',
    `disposal_date` DATE COMMENT 'Date when the sample or its pulp was disposed of or destroyed after the retention period expired.',
    `from_depth_m` DECIMAL(18,2) COMMENT 'Starting depth in meters for the sample interval within the drill hole or channel. Used for spatial correlation with geological models and resource estimation.',
    `location_easting` DECIMAL(18,2) COMMENT 'Easting coordinate (X) of the sample collection point in the mine coordinate system. Used for spatial analysis and integration with geological models.',
    `location_elevation` DECIMAL(18,2) COMMENT 'Elevation (Z) of the sample collection point in meters above sea level. Completes the 3D spatial coordinates for geological modeling.',
    `location_northing` DECIMAL(18,2) COMMENT 'Northing coordinate (Y) of the sample collection point in the mine coordinate system. Used for spatial analysis and integration with geological models.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this sample record was last modified in the LIMS system. Part of audit trail for data governance.',
    `preparation_method` STRING COMMENT 'Sample preparation technique applied before analysis. Crush and split for coarse reduction; pulverize for fine grinding; dry for moisture removal; wet screen for size separation; no prep for direct analysis.. Valid values are `crush_split|pulverize|dry|wet_screen|no_prep`',
    `process_stream_name` STRING COMMENT 'Name of the processing plant stream from which the sample was collected (e.g., ROM feed, crusher discharge, flotation concentrate, tailings). Applicable for process stream samples.',
    `pulp_weight_g` DECIMAL(18,2) COMMENT 'Weight in grams of the pulverized sample (pulp) prepared for assay analysis. Typically 200-500g depending on analytical method and commodity.',
    `qaqc_type` STRING COMMENT 'Classification of the sample for quality control purposes. Field duplicate tests sampling precision; lab duplicate tests analytical precision; standard tests accuracy; blank tests contamination; unknown is a regular production sample.. Valid values are `field_duplicate|lab_duplicate|standard|blank|unknown`',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the sample was received and registered in the laboratory LIMS. Used to track turnaround time and chain-of-custody.',
    `retention_period_days` STRING COMMENT 'Number of days the sample or its pulp must be retained before disposal, as per regulatory or company policy. Typically 90-365 days depending on sample type and jurisdiction.',
    `sample_number` STRING COMMENT 'Externally-known unique business identifier for the sample, typically a barcode or sequential number assigned by LIMS at sample registration. Used for chain-of-custody tracking and laboratory workflows.. Valid values are `^[A-Z0-9]{8,20}$`',
    `sample_status` STRING COMMENT 'Current lifecycle status of the sample in the laboratory workflow. Tracks progression from registration through preparation, analysis, completion, and archival or rejection. [ENUM-REF-CANDIDATE: registered|prepared|submitted|in_analysis|completed|archived|rejected — 7 candidates stripped; promote to reference product]',
    `sample_type` STRING COMMENT 'Classification of the sample based on its origin and purpose. Drill core samples (HQ, NQ, PQ) are from diamond drilling; RC (Reverse Circulation) chips are from percussion drilling; channel samples are from underground faces; process stream samples are from plant operations; metallurgical test charges are for beneficiation studies; quality control samples are standards and blanks.. Valid values are `drill_core|rc_chips|channel|process_stream|metallurgical_test|quality_control`',
    `storage_location` STRING COMMENT 'Physical location where the sample or its pulp/reject is stored after analysis. Used for sample retrieval and archival management.',
    `submitted_by` STRING COMMENT 'Name or identifier of the person or team who submitted the sample to the laboratory. Part of chain-of-custody documentation.',
    `to_depth_m` DECIMAL(18,2) COMMENT 'Ending depth in meters for the sample interval within the drill hole or channel. Defines the sample interval length together with from_depth_m.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Original weight of the sample in kilograms as received by the laboratory. Critical for calculating recovery rates and ensuring representative sub-sampling.',
    CONSTRAINT pk_laboratory_sample PRIMARY KEY(`laboratory_sample_id`)
) COMMENT 'Master record for every physical sample submitted to the laboratory, covering drill core (HQ, NQ, PQ), RC chips, channel samples, process stream samples, and metallurgical test charges. Captures sample identity, origin (drill hole ID, bench, pit, process stream), sample type, weight, preparation method, chain-of-custody status, LIMS barcode, and spatial coordinates (from/to depth or location). This is the SSOT for all sample identity data in LabWare LIMS and underpins resource estimation, grade control, and process optimisation workflows.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`sample_batch` (
    `sample_batch_id` BIGINT COMMENT 'Unique identifier for the sample batch. Primary key for the sample batch entity.',
    `analytical_method_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_method. Business justification: Sample batches are analyzed using a specific analytical method suite. Currently sample_batch has analytical_method_code (STRING) but no FK. Adding analytical_method_id FK links to the method specifica',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Sample batches are charged to cost centres for laboratory services cost tracking, AISC calculation, and opex budget management. Essential for mining cost accounting and variance analysis against budge',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Batch-level tracking of incident-related samples for chain of custody, expedited processing, and regulatory submission. Enables incident investigation workflow management.',
    `laboratory_id` BIGINT COMMENT 'Reference to the laboratory facility (internal or external) assigned to process this batch. Enables workload distribution and capacity planning.',
    `original_batch_sample_batch_id` BIGINT COMMENT 'Reference to the original sample batch identifier if this batch is a reanalysis. Enables traceability and comparison of original versus repeat results.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Grade control sample batches are submitted for specific production periods to enable ore classification and short-term scheduling decisions. Real-world process: weekly/monthly grade control programs t',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to hse.regulatory_submission. Business justification: Batches of samples analyzed specifically for regulatory reporting periods (quarterly groundwater monitoring, annual air quality reporting). Enables batch-level submission tracking.',
    `rom_stockpile_id` BIGINT COMMENT 'Foreign key linking to mine.rom_stockpile. Business justification: ROM stockpile sampling batches are a distinct operational workflow — regular composite samples are taken from stockpiles and batched for submission. Linking sample_batch to rom_stockpile supports stoc',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Sample batches are submitted for analysis as part of a specific saleable products quality assurance program. Batch results feed directly into product certification and shipment release decisions. Min',
    `sample_program_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_program. Business justification: Sample batches are submitted under a sampling program. Currently sample_batch has project_code (STRING) but no sample_program_id FK. Adding this FK links batches to the program that defines the sampli',
    `shift_report_id` BIGINT COMMENT 'Foreign key linking to mine.shift_report. Business justification: Grade control sample batches are collected and submitted per production shift. Linking sample_batch to shift_report enables shift-based reconciliation — comparing samples submitted per shift against o',
    `actual_completion_date` DATE COMMENT 'Date when all analytical work for the batch was completed. Used to calculate actual turnaround time and SLA compliance.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Precise date and time when the batch processing was completed. Enables detailed turnaround time analysis and workflow optimization.',
    `batch_comments` STRING COMMENT 'Free-text field for laboratory technicians and supervisors to record observations, issues, deviations, or special handling instructions related to the batch.',
    `batch_number` STRING COMMENT 'Externally-known unique batch number assigned by the laboratory information management system for tracking and reference purposes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `batch_status` STRING COMMENT 'Current lifecycle status of the sample batch. Tracks progression through laboratory workflow from creation to final release of results.. Valid values are `created|submitted|in_progress|completed|released|cancelled`',
    `batch_type` STRING COMMENT 'Classification of the batch based on the analytical or preparation process. Determines the workflow and equipment requirements.. Valid values are `preparation|fire_assay|xrf|icp|leach|metallurgical`',
    `batch_weight_kg` DECIMAL(18,2) COMMENT 'Total weight in kilograms of all sample material in the batch. Used for material tracking and laboratory capacity planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the batch record was first created in the Laboratory Information Management System (LIMS). Audit trail field for data governance.',
    `expected_turnaround_date` DATE COMMENT 'Target completion date based on the laboratory Service Level Agreement (SLA) and batch priority. Used for planning and performance monitoring.',
    `external_laboratory_flag` BOOLEAN COMMENT 'Indicates whether the batch was processed by an external third-party laboratory. True if external, False if processed in-house.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the batch record was last updated. Tracks changes throughout the batch lifecycle for audit and compliance purposes.',
    `mine_site_code` STRING COMMENT 'Code identifying the mine site or operational location from which the samples in this batch originated. Enables site-level reporting and resource estimation.. Valid values are `^[A-Z0-9]{3,10}$`',
    `priority_level` STRING COMMENT 'Business priority assigned to the batch. Determines processing sequence and resource allocation in the laboratory queue.. Valid values are `routine|high|urgent|critical`',
    `qaqc_compliance_flag` BOOLEAN COMMENT 'Indicates whether the batch meets the required Quality Assurance/Quality Control (QA/QC) insertion rate and protocol compliance. True if compliant, False if non-compliant.',
    `qaqc_insertion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of Quality Assurance/Quality Control (QA/QC) samples relative to total samples in the batch. Used to verify compliance with laboratory quality standards.',
    `qaqc_sample_count` STRING COMMENT 'Number of Quality Assurance/Quality Control (QA/QC) samples (blanks, standards, duplicates, certified reference materials) inserted into the batch for quality validation.',
    `reanalysis_flag` BOOLEAN COMMENT 'Indicates whether this batch is a reanalysis or repeat of a previous batch due to Quality Assurance/Quality Control (QA/QC) failure or data quality concerns. True if reanalysis, False if original analysis.',
    `release_date` DATE COMMENT 'Date when the batch results were formally released and made available to downstream systems and users after Quality Assurance/Quality Control (QA/QC) approval.',
    `release_timestamp` TIMESTAMP COMMENT 'Precise date and time when batch results were released. Critical for audit trail and data lineage tracking.',
    `requesting_department` STRING COMMENT 'Business unit or department that requested the batch analysis (e.g., Exploration, Mine Operations, Mineral Processing). Used for cost allocation and reporting.',
    `sample_count` STRING COMMENT 'Total number of individual samples included in this batch. Used for capacity planning, workload balancing, and batch size optimization.',
    `sample_origin_type` STRING COMMENT 'Classification of the source or origin of samples in the batch. Determines the analytical requirements and data usage downstream.. Valid values are `drill_core|blast_hole|grade_control|process_plant|stockpile|exploration`',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the batch was completed within the agreed Service Level Agreement (SLA) turnaround time. True if compliant, False if breached.',
    `submission_date` DATE COMMENT 'Date when the sample batch was formally submitted to the laboratory for processing. Marks the start of the Service Level Agreement (SLA) turnaround time calculation.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the batch was submitted to the laboratory. Used for detailed workflow tracking and SLA monitoring.',
    `turnaround_time_hours` DECIMAL(18,2) COMMENT 'Actual elapsed time in hours from batch submission to completion. Key performance indicator for laboratory efficiency and Service Level Agreement (SLA) compliance.',
    CONSTRAINT pk_sample_batch PRIMARY KEY(`sample_batch_id`)
) COMMENT 'Groups individual samples into a preparation or analytical batch for laboratory processing. Tracks batch number, batch type (preparation, fire assay, XRF, ICP, leach, metallurgical), submission date, assigned laboratory, priority level, batch status (created, submitted, in-progress, completed, released), expected turnaround date, actual completion date, sample count, and QA/QC insertion compliance flag. Enables throughput management, QA/QC batch-level review, turnaround time monitoring against SLA, and workload balancing across internal and external laboratories.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`assay_result` (
    `assay_result_id` BIGINT COMMENT 'Unique identifier for each assay result record. Primary key for the assay result entity.',
    `analytical_method_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_method. Business justification: Each assay result is produced using a specific analytical method. Currently assay_result has analytical_method_code and analytical_method_name (STRING) but no FK. Adding analytical_method_id FK allows',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Assay results measure grade/concentration of specific commodities. Links analyte measurements to the commodity being analyzed - essential for resource estimation, metallurgical accounting, product qua',
    `component_register_id` BIGINT COMMENT 'Foreign key linking to equipment.component_register. Business justification: Oil analysis assay results (wear metals, viscosity, contamination) are the primary data source for component condition monitoring. component_register.oil_sample_reference is a denormalized reference t',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.corrective_action. Business justification: Assay results trigger or verify corrective actions (elevated lead in soil triggers remediation; post-remediation assays verify success). Critical for closure verification.',
    `crm_standard_id` BIGINT COMMENT 'Identifier of the certified reference material (CRM) or standard reference material (SRM) used for this QA/QC check, if applicable. Empty for non-standard samples.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Mining companies issue Certificates of Analysis (CoA) to specific buyers for cargo quality verification against offtake contract specifications. A domain expert expects assay results to be linked to t',
    `drill_hole_id` BIGINT COMMENT 'FK to exploration.drill_hole.drill_hole_id — Critical for sample provenance tracing — every assay result must be traceable to its source drill hole for JORC/NI 43-101 compliance and resource estimation workflows',
    `grade_parameter_id` BIGINT COMMENT 'Foreign key linking to product.grade_parameter. Business justification: analyte_code and analyte_name on assay_result are denormalizations of grade_parameter (lims_parameter_code maps directly). Assay results report values for defined grade parameters; this FK enables par',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Assay results from incident-related samples (contaminated soil/water analysis) must link to originating incident for regulatory reporting, remediation tracking, and root cause analysis.',
    `instrument_id` BIGINT COMMENT 'Unique identifier of the laboratory instrument used to perform the analysis. Enables traceability and quality control by linking results to specific equipment calibration and maintenance records.',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory. Business justification: Assay results are produced by a specific laboratory. Currently assay_result has laboratory_code and laboratory_name (STRING) but no FK. Adding laboratory_id FK normalizes this relationship and allows ',
    `laboratory_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory_sample. Business justification: An assay result is produced for a specific physical sample registered in laboratory_sample. This is the most fundamental parent-child relationship in the laboratory domain — every geochemical result m',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to hse.regulatory_submission. Business justification: Assay results from environmental monitoring samples are submitted to regulators as part of environmental compliance reporting (water quality, dust, tailings). Regulators require individual result-leve',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Assay results certify that a saleable product meets grade requirements before shipment. Product quality certification and shipment release workflows require traceability from assay result to the speci',
    `sample_batch_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_batch. Business justification: Assay results are produced as part of a batch submission. Currently assay_result has batch_number (STRING) but no FK to sample_batch. Adding sample_batch_id FK allows joining to batch-level metadata (',
    `sample_preparation_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_preparation. Business justification: An assay result is performed on a prepared sample (pulp or split). Linking assay_result to the specific sample_preparation record that produced the analytical portion enables full chain-of-custody tra',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Assay results are evaluated against product specifications to determine grade compliance pass/fail for product release. This is the core QAQC and product certification workflow in mining — every assay',
    `accuracy_percent` DECIMAL(18,2) COMMENT 'Calculated accuracy of the assay result compared to the expected grade for standard reference materials, expressed as a percentage. Measures systematic bias in the analytical method.',
    `analysis_date` DATE COMMENT 'The date on which the assay analysis was performed. Critical for tracking sample turnaround time and ensuring results are used within appropriate timeframes for resource estimation and grade control.',
    `analysis_timestamp` TIMESTAMP COMMENT 'The precise date and time when the assay analysis was completed. Provides granular traceability for quality control and audit purposes.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this assay result was formally approved by a qualified person. Marks the transition from preliminary to certified status.',
    `approved_by` STRING COMMENT 'Identifier of the qualified person or laboratory supervisor who reviewed and approved this assay result for release. Required for certified results used in resource estimation.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `below_detection_flag` BOOLEAN COMMENT 'Indicates whether the assay result was below the detection limit of the analytical method. True if below detection, False otherwise. Results flagged as below detection are typically assigned half the detection limit value for statistical purposes.',
    `certified_result_flag` BOOLEAN COMMENT 'Indicates whether this assay result has been certified and approved for use in JORC/NI 43-101 resource estimation and public reporting. True if certified, False if preliminary or for internal use only.',
    `comments` STRING COMMENT 'Free-text field for analyst or reviewer comments regarding the assay result, including notes on sample condition, analytical issues, QA/QC observations, or special handling requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this assay result record was first created in the Laboratory Information Management System (LIMS). Used for audit trail and data lineage tracking.',
    `detection_limit` DECIMAL(18,2) COMMENT 'The minimum concentration of the analyte that can be reliably detected by the analytical method. Results below this threshold are typically reported as below detection limit (BDL) or less than (<) values.',
    `dilution_factor` DECIMAL(18,2) COMMENT 'The factor by which the sample was diluted prior to analysis, typically applied when initial results exceed the upper detection limit. A value of 1.0 indicates no dilution; values greater than 1.0 indicate the sample was diluted (e.g., 10.0 means 10x dilution).',
    `expected_grade` DECIMAL(18,2) COMMENT 'The certified or expected grade value for a standard reference material. Used to calculate accuracy and bias in QA/QC analysis. Null for non-standard samples.',
    `grade_unit` STRING COMMENT 'Unit of measure for the reported grade. Common units include ppm (parts per million), percent (%), g/t (grams per tonne), oz/t (ounces per ton), mg/kg (milligrams per kilogram), ppb (parts per billion).. Valid values are `ppm|percent|g/t|oz/t|mg/kg|ppb`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this assay result record was last modified in the Laboratory Information Management System (LIMS). Tracks changes for audit and quality control purposes.',
    `over_limit_flag` BOOLEAN COMMENT 'Indicates whether the initial assay result exceeded the upper detection limit of the analytical method, requiring dilution and re-analysis. True if over limit, False otherwise.',
    `precision_percent` DECIMAL(18,2) COMMENT 'Calculated precision of the assay result based on duplicate sample analysis, expressed as a percentage. Measures random error and reproducibility of the analytical method.',
    `qaqc_sample_type` STRING COMMENT 'Identifies the type of QA/QC sample if this result is part of the quality control program. Original indicates a regular production sample; other values indicate QA/QC control samples inserted into the analytical stream.. Valid values are `original|blank|duplicate|standard|pulp_duplicate|coarse_duplicate`',
    `qaqc_status` STRING COMMENT 'Status of quality assurance and quality control checks applied to this assay result. Indicates whether the result passed all QA/QC protocols including blank, duplicate, and standard reference material checks.. Valid values are `passed|failed|pending|not_applicable|conditional`',
    `reported_date` DATE COMMENT 'The date on which the assay result was officially reported and released from the laboratory to the requesting party. May differ from analysis date due to quality control review and approval workflows.',
    `reported_grade` DECIMAL(18,2) COMMENT 'The final assay grade value reported for the analyte in the sample. This is the primary geochemical measurement used for resource estimation, grade control, and metallurgical balance calculations. May be expressed in various units depending on analyte (ppm, percent, g/t).',
    `result_status` STRING COMMENT 'Current lifecycle status of the assay result. Preliminary results are for internal use only; final results are certified for resource estimation; cancelled results have been invalidated; superseded results have been replaced by re-analysis.. Valid values are `preliminary|final|cancelled|superseded|under_review`',
    `upper_limit` DECIMAL(18,2) COMMENT 'The maximum concentration of the analyte that can be accurately measured by the analytical method without dilution. Results exceeding this threshold require sample dilution and re-analysis.',
    CONSTRAINT pk_assay_result PRIMARY KEY(`assay_result_id`)
) COMMENT 'Stores the primary geochemical assay result for each sample-analyte combination, including fire assay, XRF, ICP-MS, ICP-OES, and AAS methods. Records analyte code, reported grade, detection limit, over-limit flag, dilution factor, analytical method, instrument ID, run date, and certified result status. This is the SSOT for all geochemical grade data used in JORC/NI 43-101 resource estimation and grade control.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`metallurgical_test` (
    `metallurgical_test_id` BIGINT COMMENT 'Unique identifier for the metallurgical test record. Primary key.',
    `analytical_method_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_method. Business justification: Metallurgical tests (Bond Work Index, SMC, flotation, leach) are conducted using approved analytical methods catalogued in analytical_method. Linking metallurgical_test to analytical_method enables me',
    `chemical_register_id` BIGINT COMMENT 'Foreign key linking to hse.chemical_register. Business justification: Metallurgical tests use hazardous reagents (cyanide, sulfuric acid, xanthates, lime) that must be traceable to the chemical register for SDS compliance, incident investigation, and chemical inventory ',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Metallurgical tests evaluate processing characteristics of specific commodities. Enables recovery rate analysis by commodity, process optimization, and product specification validation. Replaces denor',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Metallurgical test work is expensive and charged to cost centres for feasibility study and process optimization budgets. Required for project evaluation cost tracking and AISC impact assessment of rec',
    `crm_standard_id` BIGINT COMMENT 'Foreign key linking to laboratory.crm_standard. Business justification: Metallurgical test programs include QA/QC controls using certified reference materials (CRMs) to validate recovery rates and grade measurements. Linking metallurgical_test to crm_standard enables trac',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Metallurgical domains are defined by geological domain boundaries. Metallurgical tests are assigned to geological domains to build domain-specific recovery models used in resource estimation and proce',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Metallurgical tests on materials involved in process safety incidents (spontaneous combustion testing after concentrate fire, reactivity testing after chemical incident) are standard mining practice.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to laboratory.instrument. Business justification: Metallurgical tests are performed using specific laboratory instruments (e.g., Bond mill, SMC tester, flotation cell). Linking metallurgical_test to instrument enables instrument utilisation tracking,',
    `laboratory_id` BIGINT COMMENT 'FK to laboratory.laboratory',
    `laboratory_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory_sample. Business justification: Metallurgical tests are conducted on physical ore samples registered in laboratory_sample. Currently metallurgical_test links to exploration_sample (cross-domain) but lacks a direct FK to the laborato',
    `mining_block_id` BIGINT COMMENT 'Foreign key linking to mine.mining_block. Business justification: Metallurgical variability testing is conducted on material from specific mining blocks to characterize ore hardness, recovery, and reagent consumption by block. This feeds ore type classification in t',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Metallurgical tests are conducted on material from specific orebodies to determine processing parameters (recovery, grind size, reagent consumption) for mine planning and plant design. A metallurgist ',
    `project_valuation_id` BIGINT COMMENT 'Foreign key linking to finance.project_valuation. Business justification: Met test recovery rates, grind indices, and reagent consumption directly underpin NPV/IRR assumptions in feasibility studies. Mining project controllers require traceability from project_valuation bac',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to hse.regulatory_submission. Business justification: Metallurgical test results (cyanide leach recovery, tailings characterization, acid rock drainage) are submitted to regulators as part of environmental impact assessments and mine closure plans. Test ',
    `rom_stockpile_id` BIGINT COMMENT 'Foreign key linking to mine.rom_stockpile. Business justification: Metallurgical tests are routinely performed on ROM stockpile material to determine processing parameters for blending and plant feed optimization. Knowing which ROM stockpile the test composite came f',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Metallurgical tests validate that ore can be processed into a specific saleable product at target recovery and grade. Test programs are designed around a target saleable product; this link is essentia',
    `sample_batch_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_batch. Business justification: Metallurgical tests are grouped into analytical batches for laboratory processing, just as geochemical assays are. Linking metallurgical_test to sample_batch enables batch-level tracking of met test p',
    `sample_program_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_program. Business justification: Metallurgical test programs are conducted under a defined sample program or campaign (e.g., resource definition, process optimisation). Linking metallurgical_test to sample_program enables program-lev',
    `shutdown_plan_id` BIGINT COMMENT 'Foreign key linking to maintenance.shutdown_plan. Business justification: Plant shutdowns in mining are used to conduct metallurgical test campaigns (e.g., grind circuit audits, flotation characterisation) that require plant access. Linking metallurgical_test to shutdown_pl',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Metallurgical test objectives and acceptance criteria are defined by the target product specification (e.g., concentrate grade, moisture limits). Test results are assessed against specification limits',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Metallurgical test work uses specific pilot plant equipment (lab-scale crushers, mills, flotation cells, leach reactors) that must be tracked for test result validation, equipment calibration history,',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Met test results (tailings_grade_percent, recovery_rate_percent) directly inform TSF design capacity, volumetric planning, and tailings characterization studies. Mining engineers routinely link met te',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Metallurgical test programs are part of capital project evaluation and tracked under WBS elements. Essential for NPV calculation, project valuation, and determining technical and commercial viability ',
    `abrasion_index` DECIMAL(18,2) COMMENT 'Measure of ore abrasiveness, indicating wear on grinding media and mill liners. Derived from Bond Abrasion Index test.',
    `approval_date` DATE COMMENT 'Date when the test results were formally approved and released for use in resource estimation, feasibility studies, or process design.',
    `approved_by` STRING COMMENT 'Name or identifier of the metallurgist or laboratory manager who approved and signed off on the test results.',
    `bond_work_index_kwh_per_tonne` DECIMAL(18,2) COMMENT 'Bond Ball Mill Work Index (BWi) or Bond Rod Mill Work Index (RWi) result, measured in kilowatt-hours per tonne. Indicates ore hardness and energy required for comminution.',
    `concentrate_mass_kg` DECIMAL(18,2) COMMENT 'Mass of concentrate product produced from the test, measured in kilograms. Applicable to flotation and DMS tests.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this metallurgical test record was first created in the system.',
    `extraction_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of target commodity extracted into solution during leach test. Equivalent to recovery rate for leach processes.',
    `feed_grade_percent` DECIMAL(18,2) COMMENT 'Assayed grade of the target commodity in the feed sample, expressed as percentage. For example, 1.25% Cu or 2.5 g/t Au converted to percent.',
    `feed_mass_kg` DECIMAL(18,2) COMMENT 'Total mass of ore sample fed into the metallurgical test, measured in kilograms.',
    `feed_p80_microns` DECIMAL(18,2) COMMENT 'Particle size distribution metric for feed material: 80% passing size in microns. Critical parameter for comminution and flotation tests.',
    `flotation_ph` DECIMAL(18,2) COMMENT 'pH level maintained during flotation test. Critical process parameter affecting mineral surface chemistry and reagent performance.',
    `flotation_reagent_type` STRING COMMENT 'Primary reagent or reagent suite used in flotation tests. Examples: xanthate, dithiophosphate, frother (MIBC, DF250), depressant (lime, sodium silicate), activator (copper sulfate).',
    `flotation_time_minutes` DECIMAL(18,2) COMMENT 'Total flotation residence time in minutes. Includes rougher, scavenger, and cleaner stages for locked cycle tests.',
    `grind_size_p80_microns` DECIMAL(18,2) COMMENT 'Target or achieved grind size (80% passing) for the test, measured in microns. Critical for flotation and leach tests.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this metallurgical test record was last updated or modified.',
    `leach_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the leach test, measured in hours. Includes all stages for multi-stage leach tests.',
    `leach_eh_millivolts` DECIMAL(18,2) COMMENT 'Oxidation-reduction potential (Eh) maintained during leach test, measured in millivolts. Critical for controlling oxidation state of dissolved metals.',
    `leach_ph` DECIMAL(18,2) COMMENT 'pH level maintained during leach test. Critical for controlling reaction chemistry and metal solubility.',
    `leach_solution_concentration` DECIMAL(18,2) COMMENT 'Concentration of the leaching reagent in solution, typically expressed in grams per liter (g/L) or molarity (M).',
    `leach_solution_type` STRING COMMENT 'Lixiviant or leaching solution used in the test. Examples: sulfuric acid (H2SO4), cyanide (NaCN), ammonia, ferric chloride, thiosulfate.',
    `leach_temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature maintained during leach test, measured in degrees Celsius. Critical for reaction kinetics.',
    `ore_type` STRING COMMENT 'Classification of the ore sample tested. Examples: oxide, sulphide, transitional, mixed, laterite, primary, secondary. Relevant for copper, nickel, gold, lithium, iron ore.',
    `product_grade_percent` DECIMAL(18,2) COMMENT 'Assayed grade of the target commodity in the final product (concentrate, leach residue, or extracted solution), expressed as percentage.',
    `qaqc_status` STRING COMMENT 'Quality assurance and quality control validation status for the test results. Indicates whether results meet laboratory QA/QC protocols.. Valid values are `passed|failed|pending|not_applicable`',
    `reagent_consumption_g_per_tonne` DECIMAL(18,2) COMMENT 'Total reagent consumption for the test, measured in grams per tonne of ore processed. Critical for operating cost estimation.',
    `recovery_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of the target commodity recovered from the feed into the final product. Key performance metric for all metallurgical tests.',
    `smc_test_parameter_a` DECIMAL(18,2) COMMENT 'SAG Mill Comminution test parameter A, representing ore competence. Used in SAG mill design and modeling.',
    `smc_test_parameter_b` DECIMAL(18,2) COMMENT 'SAG Mill Comminution test parameter B, representing ore abrasion. Used in SAG mill design and modeling.',
    `tailings_grade_percent` DECIMAL(18,2) COMMENT 'Assayed grade of the target commodity remaining in the tailings or waste stream, expressed as percentage. Indicates losses.',
    `test_completion_date` DATE COMMENT 'Date when the metallurgical test program was completed and results finalized.',
    `test_conditions_notes` STRING COMMENT 'Free-text field capturing additional test conditions, parameters, or observations not covered by structured fields. Examples: agitation speed, solid-liquid ratio, oxygen partial pressure, multi-stage configurations.',
    `test_number` STRING COMMENT 'Externally-known unique identifier or work order number for the metallurgical test program, used for tracking and reporting.',
    `test_objective` STRING COMMENT 'Business purpose and goals of the metallurgical test program. Examples: process design, feasibility study, plant optimization, ore variability characterization, flowsheet development.',
    `test_report_reference` STRING COMMENT 'Document reference number or file path to the detailed metallurgical test report containing full methodology, results, and interpretation.',
    `test_start_date` DATE COMMENT 'Date when the metallurgical test program commenced.',
    `test_status` STRING COMMENT 'Current lifecycle status of the metallurgical test program.. Valid values are `planned|in_progress|completed|cancelled|on_hold|failed`',
    `test_subtype` STRING COMMENT 'Specific test method or procedure within the test type category. Examples: Bond Ball Mill Work Index (BWi), Bond Rod Mill Work Index (RWi), SAG Mill Comminution (SMC) test, JK Drop Weight test, batch flotation, locked cycle flotation, bottle roll leach, column leach, heap leach, agitation leach, Carbon-In-Leach (CIL), Carbon-In-Pulp (CIP), High Pressure Grinding Rolls (HPGR), Dense Media Separation (DMS), Solvent Extraction Electrowinning (SX-EW).',
    `test_type` STRING COMMENT 'High-level category of metallurgical test conducted. Comminution includes Bond Work Index, SAG Mill Comminution, JK Drop Weight, HPGR, Abrasion Index. Flotation includes batch and locked cycle tests. Leach includes bottle roll, column, heap, agitation, CIL/CIP, SX-EW.. Valid values are `comminution|flotation|leach|dense_media_separation|solvent_extraction_electrowinning|rheology`',
    CONSTRAINT pk_metallurgical_test PRIMARY KEY(`metallurgical_test_id`)
) COMMENT 'Records all metallurgical test programs conducted on ore samples including comminution tests (Bond Work Index BWi/RWi, SAG Mill Comminution SMC, JK Drop Weight, HPGR, Abrasion Index), flotation tests (batch, locked cycle for Cu, Ni, Pb-Zn, Li spodumene), leach tests (bottle roll, column, heap, agitation, CIL/CIP for Au, Cu, Li), DMS, and SX-EW tests. Captures test type, feed grade, product grade, recovery rate, reagent consumption, grind size (P80), test conditions (pH, Eh, temperature, duration), and time-series extraction data. Serves as SSOT for all metallurgical characterisation data underpinning process design, feasibility studies, and plant optimisation.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`sample_preparation` (
    `sample_preparation_id` BIGINT COMMENT 'Unique identifier for the sample preparation record. Primary key.',
    `asset_id` BIGINT COMMENT 'Identifier of the specific equipment used for preparation (e.g., crusher ID, pulverizer ID, splitter ID). Enables contamination investigation and equipment performance tracking.',
    `chemical_register_id` BIGINT COMMENT 'Foreign key linking to hse.chemical_register. Business justification: Sample preparation uses reagents (acids, fluxes, peroxides) that must be registered in the chemical register for SDS compliance and incident investigation traceability. Mining WHS regulations require ',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Laboratory preparation incidents (chemical spills, equipment injuries during crushing/pulverizing) must be recorded against the preparation activity. This enables incident investigation to identify th',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory. Business justification: Sample preparation is performed at a specific laboratory (may be different from the analytical laboratory). Currently sample_preparation has preparation_laboratory_code and preparation_laboratory_name',
    `laboratory_sample_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory_sample. Business justification: Sample preparation tracks the physical preparation steps applied to each sample prior to analysis. The primary parent of a preparation record is the laboratory_sample being prepared. Currently sample_',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Sample preparation records for maintenance-related samples need work order traceability for audit trails, quality control verification, and chain of custody documentation in mining operations where sa',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Sample preparation (crushing, pulverizing, acid digestion) involves physical and chemical hazards requiring a documented risk assessment (JSEA/JHA) before commencement. Mining HSE systems mandate this',
    `sample_batch_id` BIGINT COMMENT 'Identifier of the preparation batch if multiple samples were prepared together. Supports batch-level quality control and traceability.',
    `actual_turnaround_time_hours` DECIMAL(18,2) COMMENT 'Actual time taken to complete the preparation, measured in hours. Used for performance monitoring and SLA compliance.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the preparation was approved by the supervisor or quality manager. Marks formal acceptance of preparation quality.',
    `approved_by` STRING COMMENT 'Identifier of the supervisor or quality manager who approved the preparation results. Required for quality assurance sign-off.. Valid values are `^[A-Z0-9]{4,12}$`',
    `chain_of_custody_verified` BOOLEAN COMMENT 'Boolean flag indicating whether chain-of-custody was verified and maintained during preparation. True if verified, false otherwise.',
    `contamination_risk_level` STRING COMMENT 'Assessment of contamination risk during preparation based on equipment history, sample type, and preparation method. Used for contamination investigation.. Valid values are `low|medium|high|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the sample preparation record was first created in the LIMS system. Audit trail field.',
    `drying_duration_minutes` STRING COMMENT 'Duration for which the sample was dried, measured in minutes. Ensures consistent moisture removal across samples.',
    `drying_temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature at which the sample was dried during preparation, measured in degrees Celsius. Critical for moisture removal and sample stability.',
    `equipment_type` STRING COMMENT 'Type of equipment used for the preparation step (e.g., crusher, pulverizer, splitter, dryer, sieve). [ENUM-REF-CANDIDATE: crusher|pulverizer|splitter|dryer|sieve|grinder|mill|other — 8 candidates stripped; promote to reference product]',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this preparation record is currently active. False if the record has been superseded or voided.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the sample preparation record was last updated in the LIMS system. Audit trail field.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Moisture content of the sample measured during or after preparation, expressed as a percentage. Critical for dry weight calculations and assay corrections.',
    `operator_name` STRING COMMENT 'Full name of the laboratory technician or operator who performed the sample preparation.',
    `original_sample_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the original sample received for preparation, measured in kilograms. Baseline for mass balance calculations.',
    `particle_size_actual_microns` STRING COMMENT 'Actual particle size achieved after preparation, measured in microns. Used to verify preparation quality and compliance with analytical requirements.',
    `particle_size_target_microns` STRING COMMENT 'Target particle size for the prepared sample, measured in microns. Defines the fineness required for subsequent analytical methods.',
    `preparation_date` DATE COMMENT 'Date on which the sample preparation was performed. Critical for chain-of-custody tracking and sample integrity assessment.',
    `preparation_method_code` STRING COMMENT 'Standardized code identifying the preparation method applied (e.g., CRUSH, PULV, SPLIT, DRY, SIEVE). Defines the specific preparation protocol used.. Valid values are `^[A-Z0-9]{2,10}$`',
    `preparation_method_description` STRING COMMENT 'Detailed description of the preparation method applied, including specific steps, equipment settings, and protocols followed.',
    `preparation_notes` STRING COMMENT 'Free-text notes capturing any deviations, observations, or issues encountered during sample preparation. Supports investigation and audit trails.',
    `preparation_priority` STRING COMMENT 'Priority level assigned to the sample preparation, determining processing sequence and turnaround time.. Valid values are `routine|urgent|critical|expedited`',
    `preparation_status` STRING COMMENT 'Current status of the sample preparation workflow. Tracks progress from initiation to completion.. Valid values are `pending|in_progress|completed|failed|on_hold|cancelled`',
    `preparation_timestamp` TIMESTAMP COMMENT 'Precise date and time when the sample preparation was completed. Supports detailed chain-of-custody and workflow tracking.',
    `pulp_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the fine pulp or prepared sample after preparation, measured in kilograms. This is the material sent for analysis.',
    `qaqc_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this preparation is part of a QA/QC program (e.g., duplicate, blank, standard). True if QA/QC sample, false otherwise.',
    `qaqc_sample_type` STRING COMMENT 'Type of QA/QC sample if applicable (e.g., duplicate, blank, certified reference material, field duplicate). None if not a QA/QC sample.. Valid values are `duplicate|blank|standard|reference_material|field_duplicate|none`',
    `reject_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the coarse reject material removed during preparation (e.g., after crushing or sieving), measured in kilograms. Used for mass balance verification.',
    `sieve_size_mesh` STRING COMMENT 'Mesh size of the sieve used during preparation (e.g., 100, 200, 400 mesh). Defines the particle size separation applied.. Valid values are `^[0-9]{1,4}$`',
    `splitting_method` STRING COMMENT 'Method used to split or sub-sample the prepared material (e.g., riffle splitter, rotary splitter, cone and quarter). Ensures representative sub-sampling.. Valid values are `riffle|rotary|cone_and_quarter|grab|other`',
    `turnaround_time_hours` STRING COMMENT 'Target turnaround time for completing the preparation, measured in hours from receipt to completion.',
    CONSTRAINT pk_sample_preparation PRIMARY KEY(`sample_preparation_id`)
) COMMENT 'Tracks the physical preparation steps applied to each sample prior to analysis, including crushing, pulverising, splitting, drying, and sieving. Records preparation method code, equipment used, preparation date, operator, reject weight, pulp weight, moisture content, and preparation laboratory. Supports chain-of-custody integrity and contamination investigation.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`qaqc_sample` (
    `qaqc_sample_id` BIGINT COMMENT 'Unique identifier for the QA/QC control sample record. Primary key.',
    `analytical_method_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_method. Business justification: QA/QC samples are analyzed using a specific analytical method. Currently qaqc_sample has analytical_method (STRING) but no FK. Adding analytical_method_id FK links to the method specification used for',
    `crm_standard_id` BIGINT COMMENT 'Foreign key linking to laboratory.crm_standard. Business justification: QA/QC control samples reference certified reference materials (CRMs). Currently qaqc_sample has crm_certificate_number and crm_supplier (STRING) but no FK. Adding crm_standard_id FK links to the full ',
    `grade_parameter_id` BIGINT COMMENT 'Foreign key linking to product.grade_parameter. Business justification: analyte_code on qaqc_sample is a denormalization of grade_parameter (lims_parameter_code). QAQC samples validate specific grade parameters; this FK enables parameter-level QAQC performance tracking, b',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory. Business justification: QA/QC samples are analyzed at a specific laboratory. Currently qaqc_sample has laboratory_code (STRING) but no FK. Adding laboratory_id FK links to the laboratory that analyzed the control sample, ena',
    `laboratory_sample_id` BIGINT COMMENT 'Reference to the original production sample from which a duplicate QA/QC sample was created (field duplicate, pulp duplicate, coarse duplicate). Null for CRMs, blanks, and standards. Enables paired comparison for precision analysis.',
    `sample_batch_id` BIGINT COMMENT 'Reference to the analytical batch into which this QA/QC sample was inserted. Links to the parent batch for traceability and batch-level QA/QC reporting.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: QAQC samples are inserted into batches to verify that analytical results meet tolerance limits defined in a product specification. The tolerance_lower, tolerance_upper, and expected_grade fields on qa',
    `absolute_difference` DECIMAL(18,2) COMMENT 'Absolute difference between assay_result and expected_grade (assay_result - expected_grade), expressed in the same unit. Used for precision analysis of duplicate samples and accuracy assessment of CRMs.',
    `analysis_date` DATE COMMENT 'Date the QA/QC sample was analyzed by the laboratory. Used to track analytical delays and correlate QA/QC performance with laboratory workload and instrument calibration cycles.',
    `approval_date` DATE COMMENT 'Date the QA/QC result was formally approved by a qualified person. Null if pending approval. Used for audit trails and regulatory reporting timelines.',
    `approved_by` STRING COMMENT 'Name or identifier of the qualified person (geologist, metallurgist, QA/QC manager) who reviewed and approved this QA/QC result. Null if pending approval. Required for JORC/NI 43-101 competent person sign-off.',
    `assay_result` DECIMAL(18,2) COMMENT 'Actual analytical result returned by the laboratory for this QA/QC sample, expressed in the same unit as expected_grade. Compared against expected_grade and tolerance limits to determine pass/fail status and calculate bias/precision metrics.',
    `assay_result_unit` STRING COMMENT 'Unit of measure for the assay result. Must match expected_grade_unit for valid comparison. Percent (%) for major elements, parts per million (ppm) for trace elements, grams per tonne (g/t) for precious metals.. Valid values are `percent|ppm|g_t|oz_t|mg_kg`',
    `batch_reanalysis_required` BOOLEAN COMMENT 'Boolean flag indicating whether the entire sample batch must be reanalyzed due to systematic QA/QC failure (e.g., multiple CRM failures, blank contamination, duplicate precision failure). True triggers batch rejection and resubmission workflow.',
    `bias_percent` DECIMAL(18,2) COMMENT 'Calculated percentage difference between assay_result and expected_grade, expressed as ((assay_result - expected_grade) / expected_grade) * 100. Positive values indicate over-reporting, negative values indicate under-reporting. Used to assess laboratory accuracy and systematic error.',
    `certified_standard_deviation` DECIMAL(18,2) COMMENT 'Certified standard deviation for CRM samples as documented in the supplier certificate. Null for non-CRM QA/QC sample types. Used to calculate statistical control limits and assess laboratory precision against certified variability.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context regarding this QA/QC sample (e.g., sample handling issues, laboratory comments, unusual results). Supports audit trails and knowledge capture.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this QA/QC sample record was first created in the Laboratory Information Management System (LIMS). Used for audit trails and data lineage tracking.',
    `detection_limit` DECIMAL(18,2) COMMENT 'Lower detection limit of the analytical method for the target analyte, expressed in the same unit as assay_result. Results below this value are typically reported as less-than (<) values. Critical for blank sample evaluation.',
    `expected_grade` DECIMAL(18,2) COMMENT 'Certified or expected assay grade for the QA/QC sample, expressed in the same unit as the target analyte (e.g., % for iron ore, ppm for gold, g/t for precious metals). For CRMs, this is the certified value; for blanks, this is typically zero or below detection limit; for duplicates, this is the original sample grade.',
    `expected_grade_unit` STRING COMMENT 'Unit of measure for the expected grade value. Percent (%) for major elements, parts per million (ppm) for trace elements, grams per tonne (g/t) for precious metals, ounces per ton (oz/t) for imperial systems, milligrams per kilogram (mg/kg) for environmental samples.. Valid values are `percent|ppm|g_t|oz_t|mg_kg`',
    `insertion_ratio` DECIMAL(18,2) COMMENT 'Target insertion frequency of this QA/QC sample type expressed as a percentage of total samples (e.g., 5.00 means 1 in 20 samples). Used to validate compliance with QA/QC protocols and JORC/NI 43-101 requirements.',
    `insertion_sequence` STRING COMMENT 'Sequential position of the QA/QC sample within the batch submission stream. Used to verify insertion frequency and systematic placement per QA/QC protocols (e.g., 1 CRM per 20 samples, 1 blank per 40 samples).',
    `investigation_notes` STRING COMMENT 'Free-text field documenting investigation findings, root cause analysis, and corrective actions taken for failed QA/QC samples. Null if no investigation required. Critical for audit trails and continuous improvement.',
    `investigation_required` BOOLEAN COMMENT 'Boolean flag indicating whether this QA/QC result requires formal investigation due to failure, systematic bias, or contamination. True triggers investigation workflow per JORC/NI 43-101 requirements.',
    `laboratory_job_number` STRING COMMENT 'External job or work order number assigned by the laboratory for this batch submission. Used for cross-referencing with laboratory certificates and invoices.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this QA/QC sample record was last modified in the Laboratory Information Management System (LIMS). Used for audit trails and change tracking.',
    `preparation_method` STRING COMMENT 'Sample preparation technique applied before analysis (e.g., crush_to_minus_2mm, pulverize_to_85pct_minus_75um, dry_at_105c, digest_four_acid). Critical for duplicate QA/QC samples to ensure preparation consistency.',
    `qaqc_sample_number` STRING COMMENT 'Externally-known unique identifier for the QA/QC sample, typically following laboratory naming conventions (e.g., CRM-2023-001, BLK-001, DUP-045). Used for sample tracking and audit trails.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `qaqc_sample_type` STRING COMMENT 'Classification of the QA/QC control sample type. Certified Reference Material (CRM) validates accuracy, blanks detect contamination, field duplicates assess sampling precision, pulp duplicates assess analytical precision, coarse duplicates assess crushing/splitting precision, and standards validate instrument calibration.. Valid values are `certified_reference_material|blank|field_duplicate|pulp_duplicate|coarse_duplicate|standard`',
    `qaqc_status` STRING COMMENT 'Pass/fail status of the QA/QC sample based on comparison of assay_result against tolerance limits. Pass indicates result within acceptable range, fail triggers investigation and potential batch rejection, warning indicates borderline result, pending awaits analysis, not_analyzed indicates sample not yet processed.. Valid values are `pass|fail|warning|pending|not_analyzed`',
    `submission_date` DATE COMMENT 'Date the QA/QC sample was submitted to the laboratory as part of the batch. Used for turnaround time tracking and temporal QA/QC trend analysis.',
    `tolerance_lower` DECIMAL(18,2) COMMENT 'Lower acceptable limit for assay results, typically defined as expected_grade minus acceptable variance (e.g., 2 standard deviations for CRMs, detection limit for blanks). Results below this threshold trigger QA/QC failure flags and investigation.',
    `tolerance_type` STRING COMMENT 'Method used to define tolerance limits. Absolute uses fixed grade units, relative_percent uses percentage of expected grade, standard_deviation uses statistical variance from certified mean. Determines how tolerance_lower and tolerance_upper are calculated.. Valid values are `absolute|relative_percent|standard_deviation`',
    `tolerance_upper` DECIMAL(18,2) COMMENT 'Upper acceptable limit for assay results, typically defined as expected_grade plus acceptable variance (e.g., 2 standard deviations for CRMs, maximum contamination threshold for blanks). Results above this threshold trigger QA/QC failure flags and investigation.',
    CONSTRAINT pk_qaqc_sample PRIMARY KEY(`qaqc_sample_id`)
) COMMENT 'Master record for QA/QC control samples inserted into sample streams, including certified reference materials (CRMs), blanks, field duplicates, and pulp duplicates. Stores QA/QC sample type, insertion position, expected grade, tolerance range, and associated batch. Enables systematic monitoring of laboratory accuracy, precision, and contamination per JORC and NI 43-101 QA/QC requirements.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`qaqc_result` (
    `qaqc_result_id` BIGINT COMMENT 'Unique identifier for the QA/QC result record. Primary key for the qaqc_result data product.',
    `analytical_method_id` BIGINT COMMENT 'FK to laboratory.analytical_method',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.corrective_action. Business justification: qaqc_result has corrective_action_required and corrective_action_description fields but no FK to the corrective_action record. ISO 17025 requires QAQC result failures to generate traceable corrective ',
    `grade_parameter_id` BIGINT COMMENT 'Foreign key linking to product.grade_parameter. Business justification: The analyte field on qaqc_result is a denormalization of grade_parameter. QAQC results control specific grade parameters; this FK enables parameter-level control chart analysis, bias detection, and co',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to laboratory.instrument. Business justification: QA/QC results are generated by specific analytical instruments. Linking qaqc_result to instrument enables instrument-level QA/QC performance monitoring, identification of systematic bias or drift in s',
    `laboratory_id` BIGINT COMMENT 'Reference to the laboratory that performed the analysis. Used to track performance by laboratory and support multi-laboratory quality comparisons.',
    `qaqc_sample_id` BIGINT COMMENT 'Reference to the control sample that was analyzed. Links to the sample record in the Laboratory Information Management System (LIMS).',
    `sample_batch_id` BIGINT COMMENT 'Reference to the analytical batch in which this QA/QC sample was processed. Used to group samples analyzed together for quality control assessment.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: QAQC results are evaluated against specification control limits to determine batch compliance for product release. The jorc_table_1_reference and resource_estimation_approved fields confirm regulatory',
    `absolute_difference` DECIMAL(18,2) COMMENT 'The absolute difference between the reported value and expected value. Calculated as |reported_value - expected_value|. Used for low-grade samples where relative measures may be misleading.',
    `analysis_date` DATE COMMENT 'The date on which the QA/QC sample was analyzed by the laboratory. Used for temporal quality trend analysis and batch traceability.',
    `analysis_timestamp` TIMESTAMP COMMENT 'The precise date and time when the analytical measurement was completed. Provides high-resolution temporal tracking for quality control and audit purposes.',
    `bias_flag` BOOLEAN COMMENT 'Boolean flag indicating whether systematic bias has been detected in the analytical results. True indicates bias is present (consistently high or low results), false indicates no bias detected.',
    `contamination_flag` BOOLEAN COMMENT 'Boolean flag indicating whether contamination has been detected based on blank sample results. True indicates contamination is present, false indicates no contamination detected.',
    `control_sample_number` STRING COMMENT 'The unique identifier or barcode assigned to the physical QA/QC control sample submitted for analysis.',
    `control_sample_type` STRING COMMENT 'Type of QA/QC control sample analyzed. Blank samples detect contamination, standards verify calibration, duplicates assess precision, and certified reference materials (CRM) verify accuracy.. Valid values are `blank|standard|duplicate|certified_reference_material|pulp_duplicate|coarse_duplicate`',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective action is required in response to this QA/QC failure. True triggers workflow for investigation and remediation, false indicates no action needed.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this QA/QC result record was first created in the Laboratory Information Management System (LIMS). Provides audit trail for data lineage.',
    `expected_value` DECIMAL(18,2) COMMENT 'The expected or certified value for the control sample. For standards and certified reference materials (CRM), this is the known concentration. For blanks, this is typically zero. For duplicates, this is the original sample value.',
    `failure_reason` STRING COMMENT 'Detailed explanation of why the QA/QC result failed acceptance criteria. Includes specific metrics that were out of range and potential root causes identified during investigation.',
    `jorc_table_1_reference` STRING COMMENT 'Reference to the specific section of the JORC Code Table 1 documentation where this QA/QC result is disclosed. Required for public reporting of mineral resources and ore reserves.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this QA/QC result record was last updated. Tracks changes to pass/fail status, corrective actions, or review outcomes.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'The lower acceptable threshold for the QA/QC result. Values below this limit indicate a potential quality issue requiring investigation.',
    `pass_fail_status` STRING COMMENT 'The overall assessment of whether the QA/QC result meets acceptance criteria. Pass indicates the result is within control limits, fail indicates a quality issue, warning indicates borderline performance, and under investigation indicates pending review.. Valid values are `pass|fail|warning|under_investigation`',
    `percent_relative_difference` DECIMAL(18,2) COMMENT 'The relative difference between reported and expected values expressed as a percentage. Calculated as ((reported_value - expected_value) / expected_value) * 100. Key metric for duplicate precision assessment.',
    `precision_flag` BOOLEAN COMMENT 'Boolean flag indicating whether precision issues have been detected based on duplicate sample results. True indicates poor precision (high variability), false indicates acceptable precision.',
    `reported_value` DECIMAL(18,2) COMMENT 'The analytical result value reported by the laboratory for this QA/QC control sample. Measured in the unit of measure specified for the analyte.',
    `resource_estimation_approved` BOOLEAN COMMENT 'Boolean flag indicating whether the associated analytical batch has been approved for use in resource estimation based on QA/QC performance. True indicates data is suitable for JORC resource calculations, false indicates data quality issues prevent use.',
    `review_comments` STRING COMMENT 'Additional comments or observations recorded by the reviewer during the QA/QC assessment. May include context for borderline results or justification for acceptance decisions.',
    `review_date` DATE COMMENT 'The date on which the QA/QC result was reviewed and the pass/fail assessment was finalized. Critical for audit trail and regulatory compliance.',
    `reviewed_by` STRING COMMENT 'The name or identifier of the qualified person (QP) or laboratory supervisor who reviewed and approved the QA/QC result assessment. Required for JORC Table 1 compliance.',
    `unit_of_measure` STRING COMMENT 'The unit in which the reported and expected values are expressed. Common units include parts per million (ppm), parts per billion (ppb), percent (%), grams per tonne (g/t), and ounces per ton (oz/t).. Valid values are `ppm|ppb|percent|g_per_t|oz_per_ton|mg_per_kg`',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'The upper acceptable threshold for the QA/QC result. Values above this limit indicate a potential quality issue requiring investigation.',
    `z_score` DECIMAL(18,2) COMMENT 'The number of standard deviations the reported value is from the expected value. Calculated as (reported_value - expected_value) / standard_deviation. Used to assess the statistical significance of deviations.',
    CONSTRAINT pk_qaqc_result PRIMARY KEY(`qaqc_result_id`)
) COMMENT 'Records the analytical result for each QA/QC control sample and its pass/fail assessment against acceptance criteria. Captures reported value, expected value, z-score, percent relative difference (PRD), bias flag, failure reason, and corrective action triggered. Provides the audit trail required for JORC Table 1 QA/QC disclosure and resource estimation sign-off.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`analytical_method` (
    `analytical_method_id` BIGINT COMMENT 'Unique identifier for the analytical method record. Primary key.',
    `accreditation_number` STRING COMMENT 'Unique accreditation certificate or registration number issued by the accrediting body for this specific method. Used for audit trails and regulatory reporting.',
    `accreditation_standard` STRING COMMENT 'The formal accreditation standard under which this method is certified (e.g., NATA for National Association of Testing Authorities in Australia, ISO 17025 for international laboratory accreditation, A2LA for American Association for Laboratory Accreditation). Critical for resource estimation and regulatory compliance.. Valid values are `nata|iso_17025|a2la|ukas|not_accredited`',
    `accuracy_bias_percent` DECIMAL(18,2) COMMENT 'Method accuracy expressed as percentage bias from certified reference material (CRM) true values. Positive values indicate over-reporting; negative values indicate under-reporting. Acceptable bias is typically within ±5% for resource estimation methods.',
    `analysis_duration_minutes` STRING COMMENT 'Typical time required to complete the analytical procedure for a single sample, measured in minutes. Used for laboratory capacity planning and turnaround time estimation.',
    `analyte_list` STRING COMMENT 'Comma-separated list of chemical elements or compounds that this method can detect and quantify (e.g., Au, Ag, Cu, Fe, S, C for multi-element methods; Au only for single-element fire assay). Defines the scope of the methods analytical capability.',
    `approved_for_process_control` BOOLEAN COMMENT 'Boolean flag indicating whether this method is approved for real-time or near-real-time process control and optimization in mineral processing plants. True if suitable for operational decision-making; false if restricted to formal assay reporting.',
    `approved_for_resource_estimation` BOOLEAN COMMENT 'Boolean flag indicating whether this method meets the quality and accreditation standards required for JORC, NI 43-101, or SAMREC compliant mineral resource and ore reserve estimation. True if approved; false if restricted to process control or non-compliant applications.',
    `cost_per_sample` DECIMAL(18,2) COMMENT 'Standard cost to analyze one sample using this method, including labor, consumables, reagents, and instrument time. Used for laboratory budgeting and exploration/production cost estimation. Expressed in the organizations reporting currency.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this analytical method record was first created in the LIMS or laboratory management system. Used for audit trails and data lineage.',
    `detection_limit_lower` DECIMAL(18,2) COMMENT 'Minimum concentration or grade that the method can reliably detect and quantify, expressed in the methods reporting unit. Values below this threshold are reported as below detection limit (BDL).',
    `effective_from_date` DATE COMMENT 'Date from which this method version became active and approved for use in the laboratory. Used for historical data traceability and audit compliance.',
    `effective_to_date` DATE COMMENT 'Date on which this method version was superseded or retired. Null for currently active methods. Used for historical data traceability and method lifecycle management.',
    `instrument_type` STRING COMMENT 'Type or model family of analytical instrument required to perform this method (e.g., Varian AA240 Atomic Absorption Spectrometer, Bruker S8 Tiger XRF, Agilent 7900 ICP-MS, LECO CS844 Carbon/Sulphur Analyzer). Used for instrument scheduling and capacity planning.',
    `interference_notes` STRING COMMENT 'Documentation of known chemical or spectral interferences that may affect method accuracy (e.g., high iron content interfering with copper XRF analysis, arsenic interference in gold fire assay). Used to guide method selection and result interpretation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this analytical method record was last updated. Used for change tracking and audit compliance.',
    `last_validation_date` DATE COMMENT 'Date of the most recent method validation or re-validation exercise, including precision and accuracy testing against certified reference materials. ISO 17025 requires periodic re-validation.',
    `matrix_applicability` STRING COMMENT 'Description of the sample matrix types for which this method is validated and approved (e.g., oxide ore, sulphide ore, concentrate, tailings, soil, water, rock). Critical for ensuring method suitability for different geological and process materials.',
    `method_category` STRING COMMENT 'Business classification of the methods primary application domain (geochemical for ore assays, metallurgical for concentrate and recovery testing, environmental for tailings and water analysis, quality_control for QA/QC samples, process_control for real-time plant monitoring).. Valid values are `geochemical|metallurgical|environmental|quality_control|process_control`',
    `method_code` STRING COMMENT 'Unique alphanumeric code identifying the analytical method (e.g., FA-AAS-01, XRF-PP-02, ICP-MS-03). Used as the business identifier for the method across laboratory systems and resource estimation workflows.. Valid values are `^[A-Z0-9]{2,20}$`',
    `method_documentation_reference` STRING COMMENT 'Reference to the detailed method documentation, standard operating procedure (SOP), or published standard (e.g., SOP-LAB-FA-001, ASTM E1915, ISO 11426). Used to access full procedural details and compliance evidence.',
    `method_name` STRING COMMENT 'Full descriptive name of the analytical method (e.g., Fire Assay with Atomic Absorption Spectroscopy for Gold, X-Ray Fluorescence Pressed Pellet for Multi-Element Analysis).',
    `method_owner` STRING COMMENT 'Name or identifier of the laboratory manager or technical specialist responsible for maintaining and validating this method. Used for accountability and technical queries.',
    `method_status` STRING COMMENT 'Current lifecycle status of the analytical method. Active methods are approved for use; superseded methods have been replaced by newer versions; pending_accreditation methods are awaiting formal approval.. Valid values are `active|inactive|under_review|superseded|pending_accreditation`',
    `method_type` STRING COMMENT 'Classification of the analytical technique family (e.g., fire_assay for FA-AAS/FA-OES, xrf for X-Ray Fluorescence, icp_ms for Inductively Coupled Plasma Mass Spectrometry, leco for LECO carbon/sulphur analyzers). [ENUM-REF-CANDIDATE: fire_assay|xrf|icp_ms|icp_oes|leco|titration|gravimetric|wet_chemistry|spectroscopy|other — 10 candidates stripped; promote to reference product]',
    `method_version` STRING COMMENT 'Version number of the analytical method (e.g., 1.0, 2.1, 3.0.1). Incremented when method parameters, detection limits, or procedures are updated.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    `next_validation_due_date` DATE COMMENT 'Scheduled date for the next method validation or re-validation exercise. Used for laboratory quality management and accreditation maintenance planning.',
    `precision_rsd_percent` DECIMAL(18,2) COMMENT 'Method precision expressed as relative standard deviation (RSD) percentage, derived from replicate analysis of certified reference materials (CRMs). Lower values indicate higher precision. Typical acceptable range is 1-10% depending on analyte and concentration.',
    `reagent_list` STRING COMMENT 'Comma-separated list of chemical reagents required for the analytical procedure (e.g., lithium borate flux, hydrochloric acid, nitric acid, lead oxide, silver nitrate). Used for laboratory inventory management and safety planning.',
    `reference_material_required` STRING COMMENT 'Specification of certified reference materials (CRMs) or standard reference materials (SRMs) that must be analyzed alongside samples for quality control (e.g., OREAS 101a, AMIS 0318, NIST 2709a). Critical for QA/QC protocol compliance.',
    `reporting_unit` STRING COMMENT 'Standard unit of measure in which analytical results are reported (e.g., ppm for parts per million, g_per_t for grams per tonne, percent for percentage concentration). Aligns with JORC and NI 43-101 reporting standards. [ENUM-REF-CANDIDATE: ppm|ppb|percent|g_per_t|mg_per_l|ug_per_l|oz_per_ton — 7 candidates stripped; promote to reference product]',
    `sample_preparation_procedure` STRING COMMENT 'Description of the required sample preparation steps before analysis (e.g., crushing to -2mm, pulverizing to 90% passing 75 microns, drying at 105°C, pressed pellet formation, fusion bead preparation). Critical for method reproducibility and quality control.',
    `turnaround_time_hours` STRING COMMENT 'Standard turnaround time from sample receipt to result reporting, measured in hours. Includes sample preparation, analysis, quality control, and data validation. Used for mine planning and grade control scheduling.',
    `upper_limit` DECIMAL(18,2) COMMENT 'Maximum concentration or grade that the method can accurately measure without dilution or re-analysis. Samples exceeding this limit require dilution or alternative method.',
    CONSTRAINT pk_analytical_method PRIMARY KEY(`analytical_method_id`)
) COMMENT 'Reference catalogue of all approved analytical methods used in the laboratory, including fire assay (FA-AAS, FA-OES), XRF (pressed pellet, fused bead), ICP-MS, ICP-OES, LECO carbon/sulphur, and titration. Stores method code, analyte list, detection limits, upper limits, matrix applicability, accreditation standard (NATA, ISO 17025), and method version. Governs which methods are approved for resource estimation versus process control.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`crm_standard` (
    `crm_standard_id` BIGINT COMMENT 'Unique identifier for the certified reference material standard record. Primary key for the CRM standard register.',
    `analytical_method_id` BIGINT COMMENT 'Foreign key linking to laboratory.analytical_method. Business justification: CRM standards are certified for use with specific analytical methods. crm_standard currently stores analytical_method as a free-text STRING attribute, which should be normalised to a proper FK to anal',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory. Business justification: CRM standards are characterized (certified values determined) at a specific laboratory. Currently crm_standard has characterization_laboratory (STRING) but no FK. Adding characterization_laboratory_id',
    `chemical_register_id` BIGINT COMMENT 'Foreign key linking to hse.chemical_register. Business justification: Certified Reference Materials are chemical substances requiring SDS registration, storage management, and disposal tracking under mining WHS regulations. The chemical register entry governs safe handl',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: commodity_type on crm_standard is a denormalization of commodity. CRM standards are certified reference materials for specific commodities (iron ore CRM, copper CRM). Selecting the correct CRM for a b',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Certified reference materials are purchased from specialized suppliers who are counterparties. This link enables purchase order tracking, supplier performance evaluation, certificate verification, inv',
    `certificate_number` STRING COMMENT 'Unique certificate or lot number issued by the supplier that identifies the batch of certified reference material and links to the official certificate of analysis.',
    `certification_date` DATE COMMENT 'Date on which the reference material was officially certified by the supplier or certifying body, as documented on the certificate of analysis.',
    `certified_value_json` STRING COMMENT 'JSON-formatted string containing certified values for all analytes in the reference material, including element symbol, certified concentration, unit of measure, and uncertainty. Structured as array of objects to support multi-element standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certified reference material record was first created in the laboratory information management system (LIMS).',
    `crm_code` STRING COMMENT 'Unique business identifier for the certified reference material, typically assigned by the supplier or internal laboratory. Used for sample tracking and quality control workflows.',
    `crm_name` STRING COMMENT 'Descriptive name or title of the certified reference material, often including the supplier designation and material type.',
    `crm_status` STRING COMMENT 'Current lifecycle status of the certified reference material in the laboratory inventory and quality assurance program.. Valid values are `active|expired|depleted|quarantined|retired`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost of the certified reference material (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'Date after which the certified reference material is no longer guaranteed to meet its certified values and should not be used in quality control programs. Nullable for materials with indefinite stability.',
    `homogeneity_statement` STRING COMMENT 'Statement or assessment from the supplier regarding the homogeneity of the reference material, indicating whether it is suitable for the intended sample size and analytical method.',
    `is_in_house_standard` BOOLEAN COMMENT 'Boolean flag indicating whether this is an in-house prepared reference material (true) or a commercially sourced certified reference material (false). In-house standards are typically prepared from site-specific ore and characterized through round-robin testing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certified reference material record was last updated in the laboratory information management system (LIMS).',
    `matrix_type` STRING COMMENT 'Physical and chemical composition category of the reference material matrix, indicating the material type it is designed to represent in quality control programs. [ENUM-REF-CANDIDATE: ore|concentrate|tailings|soil|rock|pulp|solution — 7 candidates stripped; promote to reference product]',
    `minimum_stock_level` DECIMAL(18,2) COMMENT 'Minimum inventory threshold for the certified reference material below which reordering should be triggered to ensure continuity of quality control programs.',
    `notes` STRING COMMENT 'Free-text field for additional information, special handling instructions, performance observations, or historical notes related to the certified reference material.',
    `particle_size_description` STRING COMMENT 'Description of the particle size distribution or preparation state of the reference material (e.g., minus 75 micron pulp, coarse reject, -200 mesh), relevant for ensuring homogeneity and representativeness in quality control.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the procurement of this batch of certified reference material, enabling traceability to procurement records and cost allocation.',
    `qaqc_program_name` STRING COMMENT 'Name or identifier of the quality assurance and quality control program in which this certified reference material is used (e.g., Exploration QA/QC, Grade Control QA/QC, Metallurgical QA/QC).',
    `stock_quantity` DECIMAL(18,2) COMMENT 'Current quantity of the certified reference material available in laboratory inventory, measured in the unit specified in stock_unit_of_measure.',
    `stock_unit_of_measure` STRING COMMENT 'Unit of measure for the stock quantity of the certified reference material (e.g., grams, kilograms, vials).. Valid values are `g|kg|vial|bottle|packet`',
    `storage_conditions` STRING COMMENT 'Required environmental conditions for storing the certified reference material to maintain stability and certified values (e.g., temperature range, humidity control, light protection).',
    `storage_location` STRING COMMENT 'Physical location within the laboratory or warehouse where the certified reference material is stored (e.g., cabinet number, shelf, room identifier).',
    `traceability_statement` STRING COMMENT 'Statement describing the metrological traceability of the certified values to international measurement standards or reference materials, as required for compliance with ISO/IEC 17025 and resource reporting codes.',
    `uncertainty_json` STRING COMMENT 'JSON-formatted string containing measurement uncertainty ranges for each certified analyte, including standard deviation, confidence interval, and uncertainty type (e.g., expanded uncertainty at 95% confidence level).',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit (per gram, vial, or packet) of the certified reference material, used for inventory valuation and budgeting of quality control programs.',
    `usage_frequency` STRING COMMENT 'Recommended or actual frequency at which this certified reference material is inserted into the analytical workflow as part of the quality assurance and quality control (QA/QC) program.. Valid values are `every_batch|every_20_samples|every_50_samples|daily|weekly|as_required`',
    CONSTRAINT pk_crm_standard PRIMARY KEY(`crm_standard_id`)
) COMMENT 'Master register of certified reference materials (CRMs) used in QA/QC programs, including commercially sourced and in-house standards. Stores CRM code, supplier, certificate number, certified values per analyte, uncertainty ranges, matrix type, expiry date, and stock quantity. Ensures traceability of QA/QC performance to internationally recognised standards as required by JORC, NI 43-101, and SAMREC.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`sample_dispatch` (
    `sample_dispatch_id` BIGINT COMMENT 'Unique identifier for the sample dispatch record. Primary key for the sample dispatch entity.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: External laboratory dispatch costs are charged to cost centres for budget tracking and cost allocation. Required for laboratory services cost management and opex variance reporting in mining operation',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Sample dispatch to external laboratories requires counterparty linkage for chain of custody documentation, commercial terms enforcement, insurance claims, and dispute resolution. Essential for trackin',
    `laboratory_id` BIGINT COMMENT 'FK to laboratory.laboratory',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Environmental monitoring sample dispatches must reference the permit under which sampling is mandated. Regulators require traceability from dispatch record to permit for compliance audits. A mining HS',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: sample_dispatch carries denormalized origin_site_code. Samples are dispatched from a specific mine site to external laboratories. Replacing origin_site_code with a proper FK to mine_site supports chai',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_purchase_order. Business justification: External laboratory analytical services are procured via purchase orders. Mining procurement teams require sample_dispatch records to reference the authorizing PO for cost reconciliation, invoice matc',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Sample dispatches to external laboratories are sent for certification of specific saleable products (e.g., pre-shipment samples for iron ore lump certification). Dispatch records must be traceable to ',
    `sample_batch_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_batch. Business justification: Sample dispatches send batches of samples from site to laboratory. Currently sample_dispatch has sample_count and sample_type but no explicit FK to sample_batch. Adding sample_batch_id FK links the di',
    `sample_program_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_program. Business justification: Sample dispatches are part of a sampling program. Currently sample_dispatch has project_code (STRING) but no sample_program_id FK. Adding this FK links dispatches to the program that authorized the sa',
    `shift_production_run_id` BIGINT COMMENT 'Foreign key linking to processing.shift_production_run. Business justification: Links sample dispatch events to production shifts for turnaround tracking, metallurgical accounting, and reconciling lab results with shift production data. Essential for performance reporting and ide',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Sample dispatch to external laboratories uses mine-owned transport vehicles (light vehicles, sample trucks) that must be tracked for chain-of-custody compliance, transport cost allocation, and logisti',
    `vendor_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.vendor_invoice. Business justification: External laboratory analytical services generate vendor invoices matched against sample dispatches. Accounts payable teams perform three-way matching (dispatch record → purchase order → vendor invoice',
    `actual_receipt_date` DATE COMMENT 'Actual date when the laboratory confirmed receipt of the sample batch. Null until receipt is confirmed.',
    `actual_receipt_timestamp` TIMESTAMP COMMENT 'Precise date and time when the laboratory logged receipt of the sample batch in their LIMS system.',
    `analysis_suite_requested` STRING COMMENT 'Description or code of the analytical test suite requested for this sample batch (e.g., fire assay, XRF multi-element, leach test).',
    `chain_of_custody_document_reference` STRING COMMENT 'Reference number or identifier of the chain-of-custody documentation accompanying the sample dispatch. Critical for audit trail and sample integrity verification.',
    `courier_name` STRING COMMENT 'Name of the courier or transport service provider responsible for transporting the sample batch.',
    `courier_reference_number` STRING COMMENT 'Tracking or consignment number provided by the courier service for shipment tracking and proof of delivery.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sample dispatch record was first created in the system. Audit trail field.',
    `dispatch_authorized_by` STRING COMMENT 'Name or identifier of the supervisor or geologist who authorized the sample dispatch. Required for chain-of-custody compliance.',
    `dispatch_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost for this sample dispatch including courier fees, laboratory analysis charges, and handling costs. Used for budget tracking.',
    `dispatch_date` DATE COMMENT 'The date when the sample batch was dispatched from the mine site to the laboratory. Principal business event timestamp for the dispatch transaction.',
    `dispatch_notes` STRING COMMENT 'Free-text field for additional comments, observations, or special circumstances related to the sample dispatch.',
    `dispatch_number` STRING COMMENT 'Externally-known unique business identifier for the sample dispatch batch. Used for tracking and reference in chain-of-custody documentation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `dispatch_purpose` STRING COMMENT 'Business purpose or program for which the samples are being dispatched. Determines priority and analysis requirements.. Valid values are `exploration|grade_control|metallurgical_test|quality_control|resource_estimation|environmental`',
    `dispatch_status` STRING COMMENT 'Current lifecycle status of the sample dispatch. Tracks the dispatch from preparation through to laboratory receipt confirmation.. Valid values are `pending|dispatched|in_transit|received|rejected|cancelled`',
    `dispatch_timestamp` TIMESTAMP COMMENT 'Precise date and time when the sample batch was handed over to the courier or transport service. Used for turnaround time calculations.',
    `expected_receipt_date` DATE COMMENT 'Anticipated date when the laboratory is expected to receive the sample batch. Used for planning and turnaround time monitoring.',
    `laboratory_type` STRING COMMENT 'Classification of the receiving laboratory indicating whether it is company-owned or external service provider.. Valid values are `internal|external|third_party|certified`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this sample dispatch record was last updated. Audit trail field for change tracking.',
    `origin_location` STRING COMMENT 'Specific location or facility within the origin site where samples were prepared and dispatched from (e.g., core shed, sample preparation plant).',
    `packaging_type` STRING COMMENT 'Description of the packaging method used for the sample dispatch (e.g., sealed bags, core boxes, drums, crates).',
    `priority_level` STRING COMMENT 'Urgency classification for the sample dispatch. Determines laboratory processing priority and turnaround time commitments.. Valid values are `routine|urgent|critical|rush`',
    `receipt_confirmation_by` STRING COMMENT 'Name or identifier of the laboratory personnel who confirmed receipt and logged the sample batch into the LIMS system.',
    `requested_turnaround_days` STRING COMMENT 'Number of business days requested for laboratory analysis completion from receipt date. Used for scheduling and performance monitoring.',
    `sample_condition_on_receipt` STRING COMMENT 'Assessment of the physical condition and integrity of samples upon receipt at the laboratory. Documents any damage or contamination during transport.. Valid values are `intact|damaged|compromised|acceptable|rejected`',
    `sample_count` STRING COMMENT 'Total number of individual samples included in this dispatch batch. Used for reconciliation and chain-of-custody verification.',
    `sample_type` STRING COMMENT 'Classification of the samples in this dispatch batch. Indicates the nature of the samples being sent for analysis. [ENUM-REF-CANDIDATE: drill_core|chip|pulp|reject|duplicate|standard|blank — 7 candidates stripped; promote to reference product]',
    `special_handling_instructions` STRING COMMENT 'Any special requirements or instructions for sample handling, storage, or analysis (e.g., keep refrigerated, handle as hazardous, rush processing).',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the dispatched sample batch in kilograms, including packaging. Used for freight costing and logistics.',
    `transport_method` STRING COMMENT 'Mode of transportation used to move the sample batch from origin to destination laboratory.. Valid values are `road|air|rail|courier|hand_delivery`',
    CONSTRAINT pk_sample_dispatch PRIMARY KEY(`sample_dispatch_id`)
) COMMENT 'Records the dispatch of sample batches from site to external or internal laboratories, including courier details, dispatch date, number of samples, sample condition on receipt, chain-of-custody document reference, and receiving laboratory confirmation. Supports chain-of-custody compliance and turnaround time tracking for exploration and grade control programs.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`laboratory` (
    `laboratory_id` BIGINT COMMENT 'Unique identifier for the laboratory. Primary key.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: External laboratories are commercial counterparties with master service agreements, credit terms, payment schedules, and performance KPIs. This link enables contract management, vendor performance eva',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Each laboratory facility must have a documented emergency response plan covering chemical spills, fire, and evacuation procedures. Mining HSE systems require the laboratory record to reference its gov',
    `mine_site_id` BIGINT COMMENT 'Foreign key linking to mine.mine_site. Business justification: On-site laboratories are physically located at and operated for a specific mine site. Linking laboratory to mine_site identifies which mine site an on-site lab serves, supporting laboratory contract m',
    `accreditation_body` STRING COMMENT 'The recognized accreditation authority that has certified the laboratory: NATA (National Association of Testing Authorities - Australia), SANAS (South African National Accreditation System), CALA (Canadian Association for Laboratory Accreditation), A2LA (American Association for Laboratory Accreditation), UKAS (United Kingdom Accreditation Service), or ISO/IEC 17025 generic certification.. Valid values are `NATA|SANAS|CALA|A2LA|UKAS|ISO_17025`',
    `accreditation_expiry_date` DATE COMMENT 'The date on which the current accreditation certificate expires and requires renewal or re-assessment.',
    `accreditation_number` STRING COMMENT 'The unique certificate or registration number issued by the accreditation body to this laboratory.',
    `accreditation_scope` STRING COMMENT 'Detailed description of the analytes, methods, and matrices covered under the laboratorys accreditation (e.g., fire assay for gold in ore, XRF for multi-element analysis, leach tests for copper recovery).',
    `address_line_1` STRING COMMENT 'Primary street address or location descriptor for the laboratory facility.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building name, floor, or suite number.',
    `approved_analyte_list` STRING COMMENT 'Comma-separated list of analytes (elements or compounds) that this laboratory is approved and accredited to analyze (e.g., Au, Cu, Fe, Ni, S, moisture, particle size).',
    `approved_method_list` STRING COMMENT 'Comma-separated list of analytical methods that this laboratory is approved to perform (e.g., fire assay, XRF, ICP-MS, AAS, flotation testwork, leach testwork).',
    `city` STRING COMMENT 'City or town where the laboratory is located.',
    `contact_email` STRING COMMENT 'Primary email address for laboratory correspondence, sample submission, and result queries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Full name of the primary contact person or laboratory manager responsible for sample coordination and queries.',
    `contact_phone` STRING COMMENT 'Primary telephone number for the laboratory contact person or reception.',
    `contract_end_date` DATE COMMENT 'Date when the current service contract or agreement with this laboratory expires or is due for renewal.',
    `contract_start_date` DATE COMMENT 'Date when the current service contract or agreement with this laboratory commenced.',
    `cost_per_sample_standard` DECIMAL(18,2) COMMENT 'Average contracted cost per sample for standard analytical packages, used for budgeting and laboratory performance benchmarking.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the laboratory is located (e.g., AUS for Australia, CAN for Canada, ZAF for South Africa).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this laboratory record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for laboratory costs (e.g., USD, AUD, CAD, ZAR).. Valid values are `^[A-Z]{3}$`',
    `laboratory_code` STRING COMMENT 'Short alphanumeric code used to identify the laboratory in operational systems and sample tracking workflows.. Valid values are `^[A-Z0-9]{3,10}$`',
    `laboratory_name` STRING COMMENT 'Full legal or trading name of the laboratory facility.',
    `laboratory_status` STRING COMMENT 'Current operational status of the laboratory: active (approved for use), inactive (not currently used), suspended (temporarily not approved due to quality issues), or under_review (pending audit or accreditation renewal).. Valid values are `active|inactive|suspended|under_review`',
    `laboratory_type` STRING COMMENT 'Classification of the laboratory based on its primary function: preparation (sample crushing, splitting), analytical (assay and chemical analysis), metallurgical (process testwork), geochemical (exploration samples), environmental (water, air, soil compliance), or third_party (external commercial laboratory).. Valid values are `preparation|analytical|metallurgical|geochemical|environmental|third_party`',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal or external audit conducted at this laboratory to verify compliance with quality and accreditation standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this laboratory record was last updated or modified.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next audit or quality review of the laboratory.',
    `notes` STRING COMMENT 'Free-text field for additional information, special instructions, historical performance notes, or operational constraints related to this laboratory.',
    `ownership_type` STRING COMMENT 'Indicates whether the laboratory is owned and operated internally by the mining company, contracted externally, or part of a joint venture arrangement.. Valid values are `internal|external|joint_venture`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the laboratory address.',
    `preferred_laboratory_flag` BOOLEAN COMMENT 'Indicates whether this laboratory is designated as a preferred provider for specific sample types or programs, based on quality, cost, and turnaround performance.',
    `quality_rating` STRING COMMENT 'Internal quality performance rating based on QA/QC (Quality Assurance/Quality Control) results, proficiency testing, and audit outcomes.. Valid values are `excellent|good|acceptable|under_review|non_compliant`',
    `sample_type_scope` STRING COMMENT 'Description of the sample types and matrices the laboratory is equipped to handle (e.g., drill core, ROM ore, concentrate, tailings, water, soil, vegetation).',
    `state_province` STRING COMMENT 'State, province, or administrative region where the laboratory is located.',
    `turnaround_time_rush_days` STRING COMMENT 'Expedited turnaround time in calendar days for priority or rush samples, typically at a premium cost.',
    `turnaround_time_standard_days` STRING COMMENT 'Contracted standard turnaround time in calendar days from sample receipt to result delivery for routine samples, as per the Service Level Agreement (SLA).',
    CONSTRAINT pk_laboratory PRIMARY KEY(`laboratory_id`)
) COMMENT 'Master register of all internal and external laboratories used by the mining operation, including on-site preparation laboratories, on-site analytical laboratories, external commercial assay laboratories, and specialist metallurgical test facilities. Stores laboratory name, location, type (preparation, analytical, metallurgical), accreditation body (NATA, SANAS, CALA, A2LA), accreditation number, accreditation expiry, approved analyte and method scope, contracted turnaround time SLA by sample type, cost per sample, preferred laboratory flag, and active/inactive status. Governs laboratory selection rules for different sample types, programs, and priority levels, and supports laboratory performance benchmarking.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`sample_program` (
    `sample_program_id` BIGINT COMMENT 'Unique identifier for the sample program or campaign. Primary key.',
    `area_id` BIGINT COMMENT 'Reference to the specific mine area, pit, or underground zone where sampling is being conducted.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Sample programs target specific commodities for exploration or grade control. Supports program planning, budget allocation by commodity, regulatory reporting (JORC/NI 43-101), and analytical suite sel',
    `competent_person_id` BIGINT COMMENT 'Reference to the Competent Person (CP) or Qualified Person (QP) responsible for validating and signing off on the sample program design and data quality for regulatory reporting purposes.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Sample programs are budgeted and tracked against cost centres for exploration and grade control expenditure management. Required for budget vs actual reporting and cost variance analysis in mining ope',
    `drill_program_id` BIGINT COMMENT 'Foreign key linking to exploration.drill_program. Business justification: Sample programs are scoped to drill programs for budget allocation and statutory expenditure tracking. Links laboratory analytical spend to exploration drill program budgets, essential for minimum exp',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Sampling programs designed to meet specific permit monitoring requirements (groundwater monitoring for mining lease, discharge water monitoring for EPA permit). Direct regulatory compliance linkage.',
    `expenditure_commitment_id` BIGINT COMMENT 'Foreign key linking to tenement.expenditure_commitment. Business justification: In Australian and similar jurisdictions, laboratory and sampling costs are claimable against tenement minimum expenditure commitments. Linking sample_program to expenditure_commitment enables tenement',
    `licence_id` BIGINT COMMENT 'Foreign key linking to exploration.licence. Business justification: Sample programs must track exploration licence context for statutory reporting and minimum expenditure compliance. Regulatory authorities require analytical expenditure to be reported by licence for a',
    `laboratory_id` BIGINT COMMENT 'Reference to the primary laboratory facility (internal or external) contracted to perform analytical work for this program.',
    `pit_or_level_id` BIGINT COMMENT 'Foreign key linking to mine.pit_or_level. Business justification: Sample programs are scoped to specific pits or underground levels (e.g., a grade control program for Pit 3 or Level 15). This scoping drives sampling density, protocol selection, and budget allocation',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Sample programs target specific prospects for resource definition. Links analytical campaigns to geological targets, critical for resource estimation workflows, geological domain assignment, and compe',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Tenement regulatory conditions frequently mandate specific sampling programs (e.g., environmental baseline, geochemical monitoring). Compliance managers must track which sample programs satisfy which ',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Sample programs (field drilling, process, environmental) require a program-level risk assessment covering field sampling hazards, chemical handling, and personnel safety before commencement. Mining HS',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Sample programs are designed to qualify or monitor a specific saleable product (e.g., grade control program for iron ore lump). The programs analytical suite, sampling frequency, and QAQC protocols a',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: analytical_suite_specification on sample_program is a denormalization of specification. Sample programs are designed to verify compliance with a defined product specification; the specification drives',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Sample programs must track the tenement under which they operate for regulatory expenditure reporting, compliance with annual expenditure commitments, and resource estimation within tenement boundarie',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: TSF environmental compliance and tailings characterization sampling programs are scoped to a specific TSF. Regulators require traceability of all sampling campaigns to the facility being monitored. Mi',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Exploration sample programs are tracked under WBS elements for IFRS6 exploration expenditure capitalization and project cost tracking. Essential for determining technical feasibility and reclassificat',
    `actual_sample_count` STRING COMMENT 'Actual number of samples collected to date under this program, excluding QA/QC samples. Updated as sampling progresses.',
    `approval_date` DATE COMMENT 'Date when the sample program was formally approved by the responsible authority (Chief Geologist, Competent Person, or Mine Manager) to commence.',
    `blank_insertion_rate_percent` DECIMAL(18,2) COMMENT 'Specific insertion rate for blank samples to detect contamination, typically 2-5% of total samples.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for this sample program covering drilling, sampling, sample preparation, analytical costs, and logistics. Expressed in the companys reporting currency.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sample program record was first created in the LIMS system.',
    `duplicate_insertion_rate_percent` DECIMAL(18,2) COMMENT 'Specific insertion rate for field or laboratory duplicate samples to assess sampling and analytical precision, typically 5-10% of total samples.',
    `end_date` DATE COMMENT 'Planned or actual date when sample collection and analysis was completed for this program. Nullable for ongoing programs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sample program record was last updated in the LIMS system.',
    `planned_sample_count` STRING COMMENT 'Target number of samples to be collected under this program, excluding QA/QC samples.',
    `program_code` STRING COMMENT 'Externally-known unique business identifier for the sample program, used in LIMS and reporting systems.. Valid values are `^[A-Z0-9]{4,20}$`',
    `program_description` STRING COMMENT 'Detailed narrative description of the sample program objectives, scope, and methodology, including geological targets, sampling density, and expected outcomes.',
    `program_name` STRING COMMENT 'Human-readable name of the sampling program or campaign, such as Q1 2024 Resource Definition Drilling or Grade Control Blast Hole Sampling.',
    `program_status` STRING COMMENT 'Current lifecycle status of the sample program: draft (planning), active (sampling underway), suspended (temporarily paused), completed (all samples collected and analyzed), or cancelled.. Valid values are `draft|active|suspended|completed|cancelled`',
    `program_type` STRING COMMENT 'Classification of the sampling program by its business purpose: resource definition drilling, grade control, infill drilling, geotechnical investigation, process plant feed characterisation, metallurgical variability, or environmental monitoring programs. [ENUM-REF-CANDIDATE: resource_definition|grade_control|infill_drilling|geotechnical_investigation|metallurgical_variability|process_plant_feed|environmental_monitoring|exploration|quality_assurance — 9 candidates stripped; promote to reference product]',
    `qaqc_insertion_rate_percent` DECIMAL(18,2) COMMENT 'Required percentage of QA/QC control samples (blanks, standards, duplicates) to be inserted into the sample stream for this program, typically 5-20% depending on program criticality.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this sample program is subject to regulatory reporting requirements under JORC, NI 43-101, SEC S-K 1300, or SAMREC codes (True) or is for internal operational purposes only (False).',
    `reporting_standard` STRING COMMENT 'The mineral resource reporting standard that this sample program data will support: JORC (Australia), NI 43-101 (Canada), SEC S-K 1300 (USA), SAMREC (South Africa), or internal (non-public reporting).. Valid values are `JORC|NI_43_101|SEC_SK_1300|SAMREC|internal`',
    `sample_security_level` STRING COMMENT 'Security classification for samples in this program: standard (normal handling), high_value (precious metals requiring secure transport), or confidential (exploration samples requiring restricted access).. Valid values are `standard|high_value|confidential`',
    `sampling_protocol_reference` STRING COMMENT 'Reference to the documented sampling protocol or Standard Operating Procedure (SOP) that governs sample collection, handling, and chain of custody for this program.',
    `standard_insertion_rate_percent` DECIMAL(18,2) COMMENT 'Specific insertion rate for certified reference material (CRM) standards to monitor analytical accuracy, typically 5-10% of total samples.',
    `start_date` DATE COMMENT 'Planned or actual date when sample collection commenced for this program.',
    `turnaround_priority` STRING COMMENT 'Priority level for laboratory turnaround time: routine (standard turnaround), expedited (faster than standard), urgent (high priority), or critical (immediate processing required for operational decisions).. Valid values are `routine|expedited|urgent|critical`',
    CONSTRAINT pk_sample_program PRIMARY KEY(`sample_program_id`)
) COMMENT 'Defines the sampling program or campaign under which samples are collected, such as resource definition drilling, grade control, infill drilling, geotechnical investigation, process plant feed characterisation, metallurgical variability, or environmental monitoring programs. Stores program name, type, associated project or mine area, target commodity, sampling protocol reference, analytical suite specification (which analytes and methods apply), QA/QC insertion rate requirements, start and end date, budget, and responsible geologist or metallurgist. Serves as the governing entity that links samples to their originating business purpose and controls which analytical methods, QA/QC protocols, and turnaround priorities apply to all samples collected under the program.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`instrument` (
    `instrument_id` BIGINT COMMENT 'Unique identifier for the analytical instrument. Primary key for the instrument register.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Laboratory instruments are physical assets registered in the EAM for maintenance scheduling, depreciation, and lifecycle management. Mining labs manage instrument maintenance (calibration, repair) thr',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Laboratory instruments (ICP-MS, XRF, AAS) are capitalized fixed assets on the mining companys asset register. Finance tracks depreciation, net book value, and insurance for each instrument. AISC sust',
    `laboratory_id` BIGINT COMMENT 'Reference to the laboratory facility where this instrument is installed and operated.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Laboratory instruments (XRF, ICP-MS, fire assay furnaces, microwave digesters) require documented risk assessments for safe operation. Mining HSE management systems require each instrument to referenc',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_vendor. Business justification: Mining laboratory instruments have a designated service/calibration vendor (manufacturer or authorized agent). Procurement manages service contracts, spare parts sourcing, and calibration services aga',
    `accreditation_scope` STRING COMMENT 'Description of the accredited scope of testing for this instrument under ISO/IEC 17025 or equivalent laboratory accreditation. Identifies which tests are covered by accreditation.',
    `accuracy_specification` STRING COMMENT 'Manufacturers accuracy specification or laboratory-validated accuracy for the instrument. Expressed as percentage, absolute value, or relative standard deviation.',
    `acquisition_date` DATE COMMENT 'Date when the instrument was acquired or purchased by the organization.',
    `applicable_methods` STRING COMMENT 'List of analytical methods or standard operating procedures (SOPs) that this instrument is qualified to perform. May reference industry standards such as ASTM, ISO, or internal method codes.',
    `calibration_frequency_days` STRING COMMENT 'Standard calibration interval in days as defined by the instrument manufacturer, regulatory requirements, or laboratory quality procedures.',
    `calibration_status` STRING COMMENT 'Current calibration status of the instrument. In Calibration (calibration in progress), Calibration Passed (within calibration validity period), Calibration Failed (failed last calibration check), Calibration Overdue (past due date), Not Applicable (instrument does not require calibration).. Valid values are `In Calibration|Calibration Passed|Calibration Failed|Calibration Overdue|Not Applicable`',
    `commissioning_date` DATE COMMENT 'Date when the instrument was commissioned and put into operational service in the laboratory.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was first created in the system.',
    `decommissioning_date` DATE COMMENT 'Date when the instrument was decommissioned and removed from operational service. Null if still in service.',
    `instrument_code` STRING COMMENT 'Business identifier code for the instrument used in laboratory operations and reporting. Typically assigned by LIMS or laboratory management.. Valid values are `^[A-Z0-9]{6,20}$`',
    `instrument_name` STRING COMMENT 'Human-readable name or designation of the analytical instrument used for identification in laboratory workflows.',
    `instrument_type` STRING COMMENT 'Classification of the analytical instrument by technology type. XRF (X-Ray Fluorescence), ICP-MS (Inductively Coupled Plasma Mass Spectrometry), ICP-OES (Inductively Coupled Plasma Optical Emission Spectrometry), AAS (Atomic Absorption Spectroscopy), LECO (Carbon/Sulfur Analyser), Fire Assay Furnace, Particle Size Analyser, XRD (X-Ray Diffraction), SEM (Scanning Electron Microscope). [ENUM-REF-CANDIDATE: XRF|ICP-MS|ICP-OES|AAS|LECO|Fire Assay Furnace|Particle Size Analyser|XRD|SEM|Other — 10 candidates stripped; promote to reference product]',
    `last_calibration_date` DATE COMMENT 'Date of the most recent successful calibration performed on the instrument.',
    `last_calibration_result` STRING COMMENT 'Outcome of the most recent calibration check. Pass (within tolerance), Fail (outside tolerance), Conditional Pass (marginal performance, monitoring required).. Valid values are `Pass|Fail|Conditional Pass`',
    `last_calibration_standard` STRING COMMENT 'Identifier or description of the certified reference material or calibration standard used in the most recent calibration.',
    `last_calibration_technician` STRING COMMENT 'Name or identifier of the technician who performed the most recent calibration. Required for ISO 17025 traceability.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance performed on the instrument.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument record was last updated in the system.',
    `location` STRING COMMENT 'Physical location of the instrument within the laboratory facility. Includes building, room number, or laboratory section identifier.',
    `maintenance_schedule` STRING COMMENT 'Description of the preventive maintenance schedule for the instrument (e.g., daily, weekly, monthly, quarterly). May reference maintenance procedure documents.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the analytical instrument.',
    `measurement_range_lower` DECIMAL(18,2) COMMENT 'Lower limit of the instruments measurement range or detection limit. Units depend on instrument type and analyte.',
    `measurement_range_upper` DECIMAL(18,2) COMMENT 'Upper limit of the instruments measurement range. Units depend on instrument type and analyte.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the instruments measurement range (e.g., ppm, percent, g/t, mg/L). Varies by instrument type and application.',
    `model_number` STRING COMMENT 'Manufacturers model number or designation for the instrument. Used for parts procurement and technical support.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next calibration of the instrument. Critical for ISO 17025 compliance and result validity.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance activity on the instrument.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special handling instructions, known issues, or operational considerations for the instrument.',
    `operational_status` STRING COMMENT 'Current operational state of the instrument. Operational (available for use), Under Maintenance (scheduled or unscheduled maintenance), Out of Service (not functional), Calibration Required (due for calibration), Decommissioned (retired from service), Quarantined (results suspect pending investigation).. Valid values are `Operational|Under Maintenance|Out of Service|Calibration Required|Decommissioned|Quarantined`',
    `precision_specification` STRING COMMENT 'Manufacturers precision specification or laboratory-validated precision (repeatability) for the instrument. Typically expressed as relative standard deviation (RSD) or coefficient of variation (CV).',
    `responsible_technician` STRING COMMENT 'Name or identifier of the laboratory technician or analyst responsible for the operation and routine maintenance of this instrument.',
    `sample_throughput_capacity` STRING COMMENT 'Maximum number of samples the instrument can process per day under normal operating conditions. Used for capacity planning and scheduling.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific instrument unit. Critical for warranty, service contracts, and traceability.',
    `service_contract_expiry_date` DATE COMMENT 'Expiration date of the current service or maintenance contract. Null if no active contract.',
    `service_contract_number` STRING COMMENT 'Reference number for the active service or maintenance contract with the manufacturer or third-party service provider.',
    `usage_hours` DECIMAL(18,2) COMMENT 'Total cumulative operating hours logged for the instrument since commissioning. Used for lifecycle management and maintenance planning.',
    CONSTRAINT pk_instrument PRIMARY KEY(`instrument_id`)
) COMMENT 'Master register of all analytical instruments in the laboratory including XRF spectrometers, ICP-MS, ICP-OES, AAS, LECO analysers, fire assay furnaces, and particle size analysers. Stores instrument ID, type, manufacturer, model, serial number, operational status, and full calibration history (calibration date, type, standard used, pass/fail, drift correction, next due date, certifying technician). Supports instrument traceability for ISO 17025 compliance, result validation, and preventive maintenance scheduling.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_crm_standard_id` FOREIGN KEY (`crm_standard_id`) REFERENCES `mining_ecm`.`laboratory`.`crm_standard`(`crm_standard_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_duplicate_of_sample_laboratory_sample_id` FOREIGN KEY (`duplicate_of_sample_laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_sample_program_id` FOREIGN KEY (`sample_program_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_program`(`sample_program_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_original_batch_sample_batch_id` FOREIGN KEY (`original_batch_sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_sample_program_id` FOREIGN KEY (`sample_program_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_program`(`sample_program_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_crm_standard_id` FOREIGN KEY (`crm_standard_id`) REFERENCES `mining_ecm`.`laboratory`.`crm_standard`(`crm_standard_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `mining_ecm`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_sample_preparation_id` FOREIGN KEY (`sample_preparation_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_preparation`(`sample_preparation_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_crm_standard_id` FOREIGN KEY (`crm_standard_id`) REFERENCES `mining_ecm`.`laboratory`.`crm_standard`(`crm_standard_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `mining_ecm`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_sample_program_id` FOREIGN KEY (`sample_program_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_program`(`sample_program_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ADD CONSTRAINT `fk_laboratory_qaqc_sample_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ADD CONSTRAINT `fk_laboratory_qaqc_sample_crm_standard_id` FOREIGN KEY (`crm_standard_id`) REFERENCES `mining_ecm`.`laboratory`.`crm_standard`(`crm_standard_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ADD CONSTRAINT `fk_laboratory_qaqc_sample_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ADD CONSTRAINT `fk_laboratory_qaqc_sample_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ADD CONSTRAINT `fk_laboratory_qaqc_sample_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ADD CONSTRAINT `fk_laboratory_qaqc_result_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ADD CONSTRAINT `fk_laboratory_qaqc_result_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `mining_ecm`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ADD CONSTRAINT `fk_laboratory_qaqc_result_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ADD CONSTRAINT `fk_laboratory_qaqc_result_qaqc_sample_id` FOREIGN KEY (`qaqc_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`qaqc_sample`(`qaqc_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ADD CONSTRAINT `fk_laboratory_qaqc_result_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ADD CONSTRAINT `fk_laboratory_crm_standard_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ADD CONSTRAINT `fk_laboratory_crm_standard_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_sample_program_id` FOREIGN KEY (`sample_program_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_program`(`sample_program_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`laboratory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `mining_ecm`.`laboratory` SET TAGS ('dbx_domain' = 'laboratory');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `chemical_register_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `crm_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Reference Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `duplicate_of_sample_laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Duplicate of Sample Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'External Laboratory Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `pit_or_level_id` SET TAGS ('dbx_business_glossary_term' = 'Pit Or Level Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Rom Stockpile Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Batch Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `sample_program_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Barcode');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `barcode` SET TAGS ('dbx_value_regex' = '^[0-9]{10,20}$');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Status');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_value_regex' = 'intact|broken|under_investigation');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Sample Comments');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `core_diameter` SET TAGS ('dbx_business_glossary_term' = 'Core Diameter');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `core_diameter` SET TAGS ('dbx_value_regex' = 'HQ|NQ|PQ|BQ|AQ');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `from_depth_m` SET TAGS ('dbx_business_glossary_term' = 'From Depth (Meters)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `location_easting` SET TAGS ('dbx_business_glossary_term' = 'Location Easting Coordinate');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `location_elevation` SET TAGS ('dbx_business_glossary_term' = 'Location Elevation (Meters Above Sea Level)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `location_northing` SET TAGS ('dbx_business_glossary_term' = 'Location Northing Coordinate');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `preparation_method` SET TAGS ('dbx_business_glossary_term' = 'Preparation Method');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `preparation_method` SET TAGS ('dbx_value_regex' = 'crush_split|pulverize|dry|wet_screen|no_prep');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `process_stream_name` SET TAGS ('dbx_business_glossary_term' = 'Process Stream Name');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `pulp_weight_g` SET TAGS ('dbx_business_glossary_term' = 'Pulp Weight (Grams)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `qaqc_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Type');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `qaqc_type` SET TAGS ('dbx_value_regex' = 'field_duplicate|lab_duplicate|standard|blank|unknown');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Received Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Days)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Number');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `sample_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `sample_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Status');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `sample_type` SET TAGS ('dbx_value_regex' = 'drill_core|rc_chips|channel|process_stream|metallurgical_test|quality_control');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `submitted_by` SET TAGS ('dbx_business_glossary_term' = 'Submitted By');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `to_depth_m` SET TAGS ('dbx_business_glossary_term' = 'To Depth (Meters)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Sample Weight (Kilograms)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Batch Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `original_batch_sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Original Batch Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Rom Stockpile Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `sample_program_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `batch_comments` SET TAGS ('dbx_business_glossary_term' = 'Batch Comments');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'created|submitted|in_progress|completed|released|cancelled');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_value_regex' = 'preparation|fire_assay|xrf|icp|leach|metallurgical');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `batch_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Batch Weight Kilograms (kg)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `expected_turnaround_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Turnaround Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `external_laboratory_flag` SET TAGS ('dbx_business_glossary_term' = 'External Laboratory Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `mine_site_code` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Code');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `mine_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|high|urgent|critical');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `qaqc_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance/Quality Control (QA/QC) Compliance Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `qaqc_insertion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance/Quality Control (QA/QC) Insertion Rate Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `qaqc_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance/Quality Control (QA/QC) Sample Count');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `reanalysis_flag` SET TAGS ('dbx_business_glossary_term' = 'Reanalysis Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `sample_origin_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Origin Type');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `sample_origin_type` SET TAGS ('dbx_value_regex' = 'drill_core|blast_hole|grade_control|process_plant|stockpile|exploration');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time Hours');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `assay_result_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Result Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `component_register_id` SET TAGS ('dbx_business_glossary_term' = 'Component Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `crm_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Reference Material Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `grade_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Parameter Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Batch Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `sample_preparation_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Preparation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `analysis_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `approved_by` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `below_detection_flag` SET TAGS ('dbx_business_glossary_term' = 'Below Detection Limit Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `certified_result_flag` SET TAGS ('dbx_business_glossary_term' = 'Certified Result Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Assay Result Comments');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `dilution_factor` SET TAGS ('dbx_business_glossary_term' = 'Dilution Factor');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `expected_grade` SET TAGS ('dbx_business_glossary_term' = 'Expected Grade for Standard');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `grade_unit` SET TAGS ('dbx_value_regex' = 'ppm|percent|g/t|oz/t|mg/kg|ppb');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `over_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'Over Limit Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `precision_percent` SET TAGS ('dbx_business_glossary_term' = 'Precision Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `qaqc_sample_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Sample Type');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `qaqc_sample_type` SET TAGS ('dbx_value_regex' = 'original|blank|duplicate|standard|pulp_duplicate|coarse_duplicate');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Status');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable|conditional');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Result Reported Date');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `reported_grade` SET TAGS ('dbx_business_glossary_term' = 'Reported Grade');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|cancelled|superseded|under_review');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Detection Limit');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `metallurgical_test_id` SET TAGS ('dbx_business_glossary_term' = 'Metallurgical Test ID');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `chemical_register_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `crm_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Crm Standard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `mining_block_id` SET TAGS ('dbx_business_glossary_term' = 'Mining Block Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `project_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Project Valuation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Rom Stockpile Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Batch Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `sample_program_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `shutdown_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `abrasion_index` SET TAGS ('dbx_business_glossary_term' = 'Abrasion Index');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `bond_work_index_kwh_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Bond Work Index (kWh per Tonne)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `concentrate_mass_kg` SET TAGS ('dbx_business_glossary_term' = 'Concentrate Mass (kg)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `extraction_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Extraction Rate (Percent)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `feed_grade_percent` SET TAGS ('dbx_business_glossary_term' = 'Feed Grade (Percent)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `feed_mass_kg` SET TAGS ('dbx_business_glossary_term' = 'Feed Mass (kg)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `feed_p80_microns` SET TAGS ('dbx_business_glossary_term' = 'Feed P80 (Microns)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `flotation_ph` SET TAGS ('dbx_business_glossary_term' = 'Flotation pH');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `flotation_reagent_type` SET TAGS ('dbx_business_glossary_term' = 'Flotation Reagent Type');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `flotation_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Flotation Time (Minutes)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `grind_size_p80_microns` SET TAGS ('dbx_business_glossary_term' = 'Grind Size P80 (Microns)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `leach_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Leach Duration (Hours)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `leach_eh_millivolts` SET TAGS ('dbx_business_glossary_term' = 'Leach Eh (Millivolts)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `leach_ph` SET TAGS ('dbx_business_glossary_term' = 'Leach pH');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `leach_solution_concentration` SET TAGS ('dbx_business_glossary_term' = 'Leach Solution Concentration');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `leach_solution_type` SET TAGS ('dbx_business_glossary_term' = 'Leach Solution Type');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `leach_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Leach Temperature (Celsius)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `ore_type` SET TAGS ('dbx_business_glossary_term' = 'Ore Type');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `product_grade_percent` SET TAGS ('dbx_business_glossary_term' = 'Product Grade (Percent)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Status');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `reagent_consumption_g_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Reagent Consumption (g per Tonne)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `recovery_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Recovery Rate (Percent)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `smc_test_parameter_a` SET TAGS ('dbx_business_glossary_term' = 'SAG Mill Comminution (SMC) Test Parameter A');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `smc_test_parameter_b` SET TAGS ('dbx_business_glossary_term' = 'SAG Mill Comminution (SMC) Test Parameter B');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `tailings_grade_percent` SET TAGS ('dbx_business_glossary_term' = 'Tailings Grade (Percent)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `test_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Test Completion Date');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `test_conditions_notes` SET TAGS ('dbx_business_glossary_term' = 'Test Conditions Notes');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Test Number');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `test_objective` SET TAGS ('dbx_business_glossary_term' = 'Test Objective');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `test_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Report Reference');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `test_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Start Date');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|on_hold|failed');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `test_subtype` SET TAGS ('dbx_business_glossary_term' = 'Test Subtype');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'comminution|flotation|leach|dense_media_separation|solvent_extraction_electrowinning|rheology');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `sample_preparation_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Preparation ID');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `chemical_register_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `actual_turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Turnaround Time (Hours)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `approved_by` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `chain_of_custody_verified` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Verified');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `contamination_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Contamination Risk Level');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `contamination_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `drying_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Drying Duration (Minutes)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `drying_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Drying Temperature (Celsius)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content (Percent)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `original_sample_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Original Sample Weight (kg)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `particle_size_actual_microns` SET TAGS ('dbx_business_glossary_term' = 'Particle Size Actual (Microns)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `particle_size_target_microns` SET TAGS ('dbx_business_glossary_term' = 'Particle Size Target (Microns)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `preparation_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `preparation_method_code` SET TAGS ('dbx_business_glossary_term' = 'Preparation Method Code');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `preparation_method_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `preparation_method_description` SET TAGS ('dbx_business_glossary_term' = 'Preparation Method Description');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `preparation_notes` SET TAGS ('dbx_business_glossary_term' = 'Preparation Notes');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `preparation_priority` SET TAGS ('dbx_business_glossary_term' = 'Preparation Priority');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `preparation_priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|critical|expedited');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `preparation_status` SET TAGS ('dbx_business_glossary_term' = 'Preparation Status');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `preparation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|on_hold|cancelled');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `preparation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preparation Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `pulp_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Pulp Weight (kg)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `qaqc_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `qaqc_sample_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Sample Type');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `qaqc_sample_type` SET TAGS ('dbx_value_regex' = 'duplicate|blank|standard|reference_material|field_duplicate|none');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `reject_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Reject Weight (kg)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `sieve_size_mesh` SET TAGS ('dbx_business_glossary_term' = 'Sieve Size (Mesh)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `sieve_size_mesh` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}$');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `splitting_method` SET TAGS ('dbx_business_glossary_term' = 'Splitting Method');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `splitting_method` SET TAGS ('dbx_value_regex' = 'riffle|rotary|cone_and_quarter|grab|other');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (Hours)');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `qaqc_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Sample Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `crm_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Crm Standard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `grade_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Parameter Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Original Sample Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Batch Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `absolute_difference` SET TAGS ('dbx_business_glossary_term' = 'Absolute Difference Value');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Name');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `assay_result` SET TAGS ('dbx_business_glossary_term' = 'Assay Result Value');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `assay_result_unit` SET TAGS ('dbx_business_glossary_term' = 'Assay Result Unit of Measure');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `assay_result_unit` SET TAGS ('dbx_value_regex' = 'percent|ppm|g_t|oz_t|mg_kg');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `batch_reanalysis_required` SET TAGS ('dbx_business_glossary_term' = 'Batch Reanalysis Required Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `bias_percent` SET TAGS ('dbx_business_glossary_term' = 'Bias Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `certified_standard_deviation` SET TAGS ('dbx_business_glossary_term' = 'Certified Standard Deviation');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `detection_limit` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit Value');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `expected_grade` SET TAGS ('dbx_business_glossary_term' = 'Expected Grade Value');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `expected_grade_unit` SET TAGS ('dbx_business_glossary_term' = 'Expected Grade Unit of Measure');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `expected_grade_unit` SET TAGS ('dbx_value_regex' = 'percent|ppm|g_t|oz_t|mg_kg');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `insertion_ratio` SET TAGS ('dbx_business_glossary_term' = 'Insertion Ratio Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `insertion_sequence` SET TAGS ('dbx_business_glossary_term' = 'Insertion Sequence Number');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `investigation_required` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `laboratory_job_number` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Job Number');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `laboratory_job_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `preparation_method` SET TAGS ('dbx_business_glossary_term' = 'Sample Preparation Method');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `qaqc_sample_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Sample Number');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `qaqc_sample_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `qaqc_sample_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Sample Type');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `qaqc_sample_type` SET TAGS ('dbx_value_regex' = 'certified_reference_material|blank|field_duplicate|pulp_duplicate|coarse_duplicate|standard');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Status');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `qaqc_status` SET TAGS ('dbx_value_regex' = 'pass|fail|warning|pending|not_analyzed');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `tolerance_lower` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Lower Limit');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `tolerance_type` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Type Classification');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `tolerance_type` SET TAGS ('dbx_value_regex' = 'absolute|relative_percent|standard_deviation');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `tolerance_upper` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Upper Limit');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `qaqc_result_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Result Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `grade_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Parameter Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `qaqc_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Sample Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Batch Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `absolute_difference` SET TAGS ('dbx_business_glossary_term' = 'Absolute Difference');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `analysis_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `bias_flag` SET TAGS ('dbx_business_glossary_term' = 'Bias Detection Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `contamination_flag` SET TAGS ('dbx_business_glossary_term' = 'Contamination Detection Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `control_sample_number` SET TAGS ('dbx_business_glossary_term' = 'Control Sample Number');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `control_sample_type` SET TAGS ('dbx_business_glossary_term' = 'Control Sample Type');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `control_sample_type` SET TAGS ('dbx_value_regex' = 'blank|standard|duplicate|certified_reference_material|pulp_duplicate|coarse_duplicate');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `expected_value` SET TAGS ('dbx_business_glossary_term' = 'Expected Analytical Value');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Description');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `jorc_table_1_reference` SET TAGS ('dbx_business_glossary_term' = 'Joint Ore Reserves Committee (JORC) Table 1 Reference');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Status');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|warning|under_investigation');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `percent_relative_difference` SET TAGS ('dbx_business_glossary_term' = 'Percent Relative Difference (PRD)');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `precision_flag` SET TAGS ('dbx_business_glossary_term' = 'Precision Issue Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `reported_value` SET TAGS ('dbx_business_glossary_term' = 'Reported Analytical Value');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `resource_estimation_approved` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimation Approval Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'Review Comments');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Person Name');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'ppm|ppb|percent|g_per_t|oz_per_ton|mg_per_kg');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `z_score` SET TAGS ('dbx_business_glossary_term' = 'Z-Score Statistical Measure');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `accreditation_standard` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Standard');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `accreditation_standard` SET TAGS ('dbx_value_regex' = 'nata|iso_17025|a2la|ukas|not_accredited');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `accuracy_bias_percent` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Bias Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `analysis_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Analysis Duration in Minutes');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `analyte_list` SET TAGS ('dbx_business_glossary_term' = 'Analyte List');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `approved_for_process_control` SET TAGS ('dbx_business_glossary_term' = 'Approved for Process Control Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `approved_for_resource_estimation` SET TAGS ('dbx_business_glossary_term' = 'Approved for Resource Estimation Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `cost_per_sample` SET TAGS ('dbx_business_glossary_term' = 'Cost per Sample');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `cost_per_sample` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `detection_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Lower Detection Limit');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `interference_notes` SET TAGS ('dbx_business_glossary_term' = 'Interference Notes');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `last_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Validation Date');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `matrix_applicability` SET TAGS ('dbx_business_glossary_term' = 'Matrix Applicability');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `method_category` SET TAGS ('dbx_business_glossary_term' = 'Method Category');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `method_category` SET TAGS ('dbx_value_regex' = 'geochemical|metallurgical|environmental|quality_control|process_control');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `method_code` SET TAGS ('dbx_business_glossary_term' = 'Method Code');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `method_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `method_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Method Documentation Reference');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `method_name` SET TAGS ('dbx_business_glossary_term' = 'Method Name');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `method_owner` SET TAGS ('dbx_business_glossary_term' = 'Method Owner');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `method_status` SET TAGS ('dbx_business_glossary_term' = 'Method Status');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `method_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|superseded|pending_accreditation');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `method_type` SET TAGS ('dbx_business_glossary_term' = 'Method Type');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `method_version` SET TAGS ('dbx_business_glossary_term' = 'Method Version');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `method_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `next_validation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Validation Due Date');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `precision_rsd_percent` SET TAGS ('dbx_business_glossary_term' = 'Precision Relative Standard Deviation (RSD) Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `reagent_list` SET TAGS ('dbx_business_glossary_term' = 'Reagent List');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `reference_material_required` SET TAGS ('dbx_business_glossary_term' = 'Reference Material Required');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `reporting_unit` SET TAGS ('dbx_business_glossary_term' = 'Reporting Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `sample_preparation_procedure` SET TAGS ('dbx_business_glossary_term' = 'Sample Preparation Procedure');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time in Hours');
ALTER TABLE `mining_ecm`.`laboratory`.`analytical_method` ALTER COLUMN `upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Reporting Limit');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `crm_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Certified Reference Material (CRM) Standard ID');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Characterization Laboratory Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `chemical_register_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `certified_value_json` SET TAGS ('dbx_business_glossary_term' = 'Certified Value JSON');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `crm_code` SET TAGS ('dbx_business_glossary_term' = 'Certified Reference Material (CRM) Code');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `crm_name` SET TAGS ('dbx_business_glossary_term' = 'Certified Reference Material (CRM) Name');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `crm_status` SET TAGS ('dbx_business_glossary_term' = 'Certified Reference Material (CRM) Status');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `crm_status` SET TAGS ('dbx_value_regex' = 'active|expired|depleted|quarantined|retired');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `homogeneity_statement` SET TAGS ('dbx_business_glossary_term' = 'Homogeneity Statement');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `is_in_house_standard` SET TAGS ('dbx_business_glossary_term' = 'Is In-House Standard');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `matrix_type` SET TAGS ('dbx_business_glossary_term' = 'Matrix Type');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `minimum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `particle_size_description` SET TAGS ('dbx_business_glossary_term' = 'Particle Size Description');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `qaqc_program_name` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Program Name');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Stock Quantity');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `stock_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Stock Unit of Measure');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `stock_unit_of_measure` SET TAGS ('dbx_value_regex' = 'g|kg|vial|bottle|packet');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `traceability_statement` SET TAGS ('dbx_business_glossary_term' = 'Traceability Statement');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `uncertainty_json` SET TAGS ('dbx_business_glossary_term' = 'Uncertainty JSON');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `usage_frequency` SET TAGS ('dbx_business_glossary_term' = 'Usage Frequency');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `usage_frequency` SET TAGS ('dbx_value_regex' = 'every_batch|every_20_samples|every_50_samples|daily|weekly|as_required');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `sample_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Dispatch Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Batch Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `sample_program_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `shift_production_run_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Production Run Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `actual_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `analysis_suite_requested` SET TAGS ('dbx_business_glossary_term' = 'Analysis Suite Requested');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `chain_of_custody_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody (COC) Document Reference');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `courier_name` SET TAGS ('dbx_business_glossary_term' = 'Courier Name');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `courier_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Courier Reference Number');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `dispatch_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Authorized By');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `dispatch_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Cost Estimate');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `dispatch_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `dispatch_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Notes');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `dispatch_number` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Number');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `dispatch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `dispatch_purpose` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Purpose');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `dispatch_purpose` SET TAGS ('dbx_value_regex' = 'exploration|grade_control|metallurgical_test|quality_control|resource_estimation|environmental');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `dispatch_status` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Status');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `dispatch_status` SET TAGS ('dbx_value_regex' = 'pending|dispatched|in_transit|received|rejected|cancelled');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `expected_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Receipt Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `laboratory_type` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Type');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `laboratory_type` SET TAGS ('dbx_value_regex' = 'internal|external|third_party|certified');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|critical|rush');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `receipt_confirmation_by` SET TAGS ('dbx_business_glossary_term' = 'Receipt Confirmation By');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `requested_turnaround_days` SET TAGS ('dbx_business_glossary_term' = 'Requested Turnaround Days');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `sample_condition_on_receipt` SET TAGS ('dbx_business_glossary_term' = 'Sample Condition on Receipt');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `sample_condition_on_receipt` SET TAGS ('dbx_value_regex' = 'intact|damaged|compromised|acceptable|rejected');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `sample_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Type');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `transport_method` SET TAGS ('dbx_business_glossary_term' = 'Transport Method');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `transport_method` SET TAGS ('dbx_value_regex' = 'road|air|rail|courier|hand_delivery');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_value_regex' = 'NATA|SANAS|CALA|A2LA|UKAS|ISO_17025');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `accreditation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiry Date');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `accreditation_scope` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `approved_analyte_list` SET TAGS ('dbx_business_glossary_term' = 'Approved Analyte List');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `approved_method_list` SET TAGS ('dbx_business_glossary_term' = 'Approved Method List');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `cost_per_sample_standard` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Sample (Standard)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `cost_per_sample_standard` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `laboratory_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Code');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `laboratory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `laboratory_name` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Name');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `laboratory_status` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Status');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `laboratory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `laboratory_type` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Type');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `laboratory_type` SET TAGS ('dbx_value_regex' = 'preparation|analytical|metallurgical|geochemical|environmental|third_party');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Notes');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'internal|external|joint_venture');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `preferred_laboratory_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Laboratory Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `quality_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|acceptable|under_review|non_compliant');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `sample_type_scope` SET TAGS ('dbx_business_glossary_term' = 'Sample Type Scope');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `turnaround_time_rush_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time Rush (Days)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `turnaround_time_standard_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time Standard (Days)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `sample_program_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Area Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `drill_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Program Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `expenditure_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Commitment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `licence_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Licence Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `pit_or_level_id` SET TAGS ('dbx_business_glossary_term' = 'Pit Or Level Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `actual_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Sample Count');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Approval Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `blank_insertion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Blank Sample Insertion Rate Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Budget Amount');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `duplicate_insertion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Sample Insertion Rate Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Program End Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `planned_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Sample Count');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Code');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Description');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Name');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Status');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|completed|cancelled');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Type');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `qaqc_insertion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Insertion Rate Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Mineral Resource Reporting Standard');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `reporting_standard` SET TAGS ('dbx_value_regex' = 'JORC|NI_43_101|SEC_SK_1300|SAMREC|internal');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `sample_security_level` SET TAGS ('dbx_business_glossary_term' = 'Sample Security Level');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `sample_security_level` SET TAGS ('dbx_value_regex' = 'standard|high_value|confidential');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `sampling_protocol_reference` SET TAGS ('dbx_business_glossary_term' = 'Sampling Protocol Reference');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `standard_insertion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Certified Reference Material (CRM) Standard Insertion Rate Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Start Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `turnaround_priority` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Turnaround Priority');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `turnaround_priority` SET TAGS ('dbx_value_regex' = 'routine|expedited|urgent|critical');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Vendor Procurement Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `accreditation_scope` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `accuracy_specification` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Specification');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `applicable_methods` SET TAGS ('dbx_business_glossary_term' = 'Applicable Analytical Methods');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `calibration_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency in Days');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'In Calibration|Calibration Passed|Calibration Failed|Calibration Overdue|Not Applicable');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `instrument_code` SET TAGS ('dbx_business_glossary_term' = 'Instrument Code');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `instrument_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `instrument_name` SET TAGS ('dbx_business_glossary_term' = 'Instrument Name');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_result` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Result');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_result` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Conditional Pass');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_standard` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Standard Used');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_calibration_technician` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Technician');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Physical Location');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `measurement_range_lower` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Lower Limit');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `measurement_range_upper` SET TAGS ('dbx_business_glossary_term' = 'Measurement Range Upper Limit');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `next_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Instrument Notes');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'Operational|Under Maintenance|Out of Service|Calibration Required|Decommissioned|Quarantined');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `precision_specification` SET TAGS ('dbx_business_glossary_term' = 'Precision Specification');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `responsible_technician` SET TAGS ('dbx_business_glossary_term' = 'Responsible Technician');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `sample_throughput_capacity` SET TAGS ('dbx_business_glossary_term' = 'Sample Throughput Capacity per Day');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `service_contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Expiry Date');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `service_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Number');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `usage_hours` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Usage Hours');
