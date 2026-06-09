-- Schema for Domain: laboratory | Business: Mining | Version: v1_ecm
-- Generated on: 2026-05-05 10:54:40

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`laboratory` COMMENT 'Manages sample lifecycle, assay workflows, QA/QC protocols, and analytical results via LIMS (LabWare). Serves as the SSOT for all geochemical and metallurgical test data including fire assay, XRF, and leach test results that underpin resource estimation and process optimisation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`laboratory_sample` (
    `laboratory_sample_id` BIGINT COMMENT 'Unique identifier for the laboratory sample record. Primary key for the laboratory_sample product.',
    `blast_execution_id` BIGINT COMMENT 'Foreign key linking to mine.blast_execution. Business justification: Post-blast samples verify fragmentation quality and ore/waste classification for blast reconciliation. Real-world process: blast performance analysis and ore loss/dilution assessment. New FK needed as',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Samples are collected for project feasibility studies, resource definition, and metallurgical programs. Essential for stage-gate decisions and project evaluation. Mining projects commission sampling p',
    `chemical_register_id` BIGINT COMMENT 'Foreign key linking to hse.chemical_register. Business justification: Samples of chemicals stored on site for characterization and SDS verification (sampling bulk fuel for quality/contamination, reagent verification sampling). Supports chemical inventory management.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Mining operations track which drill rig, excavator, or sampling equipment collected each sample for traceability, equipment performance analysis, and contamination investigation. Critical for grade co',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Every sample is collected to assay a specific commodity (iron ore, copper, coal, lithium, nickel). Essential for resource estimation filtering, grade reconciliation by commodity, and commodity-specifi',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.corrective_action. Business justification: Samples collected as part of corrective action verification (post-remediation soil sampling to verify contamination removal, follow-up water sampling after spill cleanup).',
    `crm_standard_id` BIGINT COMMENT 'Identifier of the certified reference material (CRM) used if this sample is a QA/QC standard. Links to the known assay values for accuracy verification.',
    `cultural_heritage_site_id` BIGINT COMMENT 'Foreign key linking to community.cultural_heritage_site. Business justification: Samples collected within or near cultural heritage sites require tracking for regulatory compliance and heritage management protocols. Mining operations must document samples from heritage areas to de',
    `drill_hole_id` BIGINT COMMENT 'Identifier of the drill hole from which the sample was collected. Applicable for drill core and RC chip samples. Links sample to exploration or grade control drilling program.',
    `duplicate_of_sample_laboratory_sample_id` BIGINT COMMENT 'Reference to the original sample ID if this sample is a field or lab duplicate. Used to pair duplicates for precision analysis.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Individual samples collected to demonstrate permit compliance (discharge water samples against permit limits, air quality samples for air permit). Required for permit compliance reporting.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Mining operations routinely send samples to external commercial laboratories for independent verification, umpire analysis, and capacity overflow. Tracking the counterparty enables invoice reconciliat',
    `failure_report_id` BIGINT COMMENT 'Foreign key linking to maintenance.failure_report. Business justification: Samples collected during failure investigation (fractured parts, contaminated fluids, corroded materials, failed welds) must link to the failure report for root cause analysis documentation, regulator',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Samples collected from environmental incident sites (spills, contamination) for forensic analysis and regulatory compliance reporting. Standard practice in mining environmental incident investigation.',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory. Business justification: Samples must be linked to the laboratory that processes them. This is a critical missing link - laboratory_sample currently has no direct FK to laboratory, making it impossible to determine which lab ',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Samples collected during maintenance activities (oil analysis, wear debris analysis, corrosion samples, material verification) require traceability to the originating work order for condition-based ma',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Samples collected to quantify exposure levels for risk assessments (dust samples for silica exposure assessment, soil samples for contaminated land risk assessment).',
    `sample_program_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_program. Business justification: Every sample is collected under a sampling program or campaign. The sample_program defines the protocol, QA/QC requirements, and analytical suite. Currently laboratory_sample has project_code (STRING)',
    `barcode` STRING COMMENT 'Machine-readable barcode assigned by LIMS for automated sample tracking through preparation and analysis workflows. Ensures chain-of-custody integrity.. Valid values are `^[0-9]{10,20}$`',
    `batch_number` STRING COMMENT 'Laboratory batch identifier grouping samples prepared and analyzed together. Used for quality control and batch-level reconciliation.. Valid values are `^[A-Z0-9_-]{6,20}$`',
    `bench_name` STRING COMMENT 'Designation of the mining bench or level from which the sample was collected. Used for grade control and reconciliation workflows.',
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
    `pit_name` STRING COMMENT 'Name of the open pit or mining area from which the sample was collected. Applicable for grade control and production samples.',
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
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Sample batches are submitted under project codes for cost allocation and program tracking. Enables project managers to track analytical spend against project budgets and link laboratory costs to WBS e',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Sample batches are charged to cost centres for laboratory services cost tracking, AISC calculation, and opex budget management. Essential for mining cost accounting and variance analysis against budge',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Sample batches sent to external laboratories require counterparty tracking for purchase order matching, invoice verification, payment processing, and service level agreement monitoring. The external_l',
    `grievance_id` BIGINT COMMENT 'Foreign key linking to community.grievance. Business justification: Sample batches can be subject of community grievances when sampling activities cause disturbance, dust, noise, or access issues. Grievances reference specific batch numbers for investigation and corre',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Batch-level tracking of incident-related samples for chain of custody, expedited processing, and regulatory submission. Enables incident investigation workflow management.',
    `laboratory_id` BIGINT COMMENT 'Reference to the laboratory facility (internal or external) assigned to process this batch. Enables workload distribution and capacity planning.',
    `original_batch_sample_batch_id` BIGINT COMMENT 'Reference to the original sample batch identifier if this batch is a reanalysis. Enables traceability and comparison of original versus repeat results.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who submitted the batch to the laboratory. Provides accountability and contact point for batch-related queries.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Grade control sample batches are submitted for specific production periods to enable ore classification and short-term scheduling decisions. Real-world process: weekly/monthly grade control programs t',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to hse.regulatory_submission. Business justification: Batches of samples analyzed specifically for regulatory reporting periods (quarterly groundwater monitoring, annual air quality reporting). Enables batch-level submission tracking.',
    `sample_program_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_program. Business justification: Sample batches are submitted under a sampling program. Currently sample_batch has project_code (STRING) but no sample_program_id FK. Adding this FK links batches to the program that defines the sampli',
    `shift_production_run_id` BIGINT COMMENT 'Foreign key linking to processing.shift_production_run. Business justification: Associates laboratory sample batches with production shifts for reconciliation, performance reporting, and tracking sample turnaround against shift schedules. Standard practice for metallurgical accou',
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
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Assay results feed resource estimates and grade models that underpin feasibility studies and project economics. Project teams require traceability from assay data to project deliverables for competent',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Assay results measure grade/concentration of specific commodities. Links analyte measurements to the commodity being analyzed - essential for resource estimation, metallurgical accounting, product qua',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.corrective_action. Business justification: Assay results trigger or verify corrective actions (elevated lead in soil triggers remediation; post-remediation assays verify success). Critical for closure verification.',
    `crm_standard_id` BIGINT COMMENT 'Identifier of the certified reference material (CRM) or standard reference material (SRM) used for this QA/QC check, if applicable. Empty for non-standard samples.',
    `drill_hole_id` BIGINT COMMENT 'FK to exploration.drill_hole.drill_hole_id — Critical for sample provenance tracing — every assay result must be traceable to its source drill hole for JORC/NI 43-101 compliance and resource estimation workflows',
    `employee_id` BIGINT COMMENT 'Identifier of the laboratory analyst or technician who performed the assay analysis. Enables traceability and accountability for quality control purposes.',
    `exploration_sample_id` BIGINT COMMENT 'Reference to the sample that was analyzed to produce this assay result. Links to the sample master record in the Laboratory Information Management System (LIMS).',
    `failure_report_id` BIGINT COMMENT 'Foreign key linking to maintenance.failure_report. Business justification: Analytical results from failure investigation samples are critical evidence in root cause analysis and must be traceable to the failure report for engineering decisions, warranty claims, and continuou',
    `grade_control_block_id` BIGINT COMMENT 'Foreign key linking to mine.grade_control_block. Business justification: Individual assay results classify grade control blocks for ore/waste designation and dispatch routing. Real-world process: grade control block model population and ore classification workflow. New FK ',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Assay results from incident-related samples (contaminated soil/water analysis) must link to originating incident for regulatory reporting, remediation tracking, and root cause analysis.',
    `instrument_id` BIGINT COMMENT 'Unique identifier of the laboratory instrument used to perform the analysis. Enables traceability and quality control by linking results to specific equipment calibration and maintenance records.',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory. Business justification: Assay results are produced by a specific laboratory. Currently assay_result has laboratory_code and laboratory_name (STRING) but no FK. Adding laboratory_id FK normalizes this relationship and allows ',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Assay results from maintenance-related samples (lubricant chemistry, coolant analysis, material composition verification) must link to work orders for root cause analysis, predictive maintenance decis',
    `sample_batch_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_batch. Business justification: Assay results are produced as part of a batch submission. Currently assay_result has batch_number (STRING) but no FK to sample_batch. Adding sample_batch_id FK allows joining to batch-level metadata (',
    `accuracy_percent` DECIMAL(18,2) COMMENT 'Calculated accuracy of the assay result compared to the expected grade for standard reference materials, expressed as a percentage. Measures systematic bias in the analytical method.',
    `analysis_date` DATE COMMENT 'The date on which the assay analysis was performed. Critical for tracking sample turnaround time and ensuring results are used within appropriate timeframes for resource estimation and grade control.',
    `analysis_timestamp` TIMESTAMP COMMENT 'The precise date and time when the assay analysis was completed. Provides granular traceability for quality control and audit purposes.',
    `analyte_code` STRING COMMENT 'Standard code representing the element or compound analyzed (e.g., AU for gold, CU for copper, FE for iron, S for sulfur). Follows periodic table symbols or industry-standard compound codes.. Valid values are `^[A-Z]{1,4}[0-9]{0,2}$`',
    `analyte_name` STRING COMMENT 'Full name of the element or compound analyzed (e.g., Gold, Copper, Iron, Sulfur, Arsenic). Human-readable description of the analyte.',
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
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Metallurgical testwork directly supports project flowsheet development, process design, and feasibility studies. Critical for determining recovery rates and operating costs used in project NPV calcula',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Metallurgical tests evaluate processing characteristics of specific commodities. Enables recovery rate analysis by commodity, process optimization, and product specification validation. Replaces denor',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Metallurgical test work is expensive and charged to cost centres for feasibility study and process optimization budgets. Required for project evaluation cost tracking and AISC impact assessment of rec',
    `exploration_sample_id` BIGINT COMMENT 'Reference to the ore sample subjected to this metallurgical test. Links to the sample register in LIMS.',
    `failure_report_id` BIGINT COMMENT 'Foreign key linking to maintenance.failure_report. Business justification: Metallurgical analysis of failed components (fracture mechanics, material defects, fatigue analysis, corrosion mechanisms) is core to failure investigation and must link directly to the failure report',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Metallurgical tests on materials involved in process safety incidents (spontaneous combustion testing after concentrate fire, reactivity testing after chemical incident) are standard mining practice.',
    `laboratory_id` BIGINT COMMENT 'FK to laboratory.laboratory',
    `lom_plan_id` BIGINT COMMENT 'Foreign key linking to mine.lom_plan. Business justification: Metallurgical testwork results (recovery rates, grind parameters, reagent consumption) directly inform LOM plan assumptions and economic models. Real-world process: feasibility studies and resource es',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Metallurgical testing of failed components (fracture analysis, metallography, hardness testing, microstructure examination) is standard practice in mining equipment failure investigation and must link',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.offtake_agreement. Business justification: Metallurgical test programs directly inform product specifications and quality parameters negotiated in offtake agreements. Mining companies conduct met tests to demonstrate product characteristics (r',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Metallurgical test work uses specific pilot plant equipment (lab-scale crushers, mills, flotation cells, leach reactors) that must be tracked for test result validation, equipment calibration history,',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Metallurgical test execution requires operator tracking for competency verification, QA/QC accountability, and regulatory compliance (JORC/NI 43-101). Test validity depends on qualified personnel perf',
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
    `employee_id` BIGINT COMMENT 'Identifier of the laboratory technician or operator who performed the sample preparation. Supports accountability and quality control.',
    `exploration_sample_id` BIGINT COMMENT 'Identifier of the parent sample that underwent this preparation. Links to the sample master record in LIMS.',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory. Business justification: Sample preparation is performed at a specific laboratory (may be different from the analytical laboratory). Currently sample_preparation has preparation_laboratory_code and preparation_laboratory_name',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Sample preparation records for maintenance-related samples need work order traceability for audit trails, quality control verification, and chain of custody documentation in mining operations where sa',
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
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory. Business justification: QA/QC samples are analyzed at a specific laboratory. Currently qaqc_sample has laboratory_code (STRING) but no FK. Adding laboratory_id FK links to the laboratory that analyzed the control sample, ena',
    `laboratory_sample_id` BIGINT COMMENT 'Reference to the original production sample from which a duplicate QA/QC sample was created (field duplicate, pulp duplicate, coarse duplicate). Null for CRMs, blanks, and standards. Enables paired comparison for precision analysis.',
    `sample_batch_id` BIGINT COMMENT 'Reference to the analytical batch into which this QA/QC sample was inserted. Links to the parent batch for traceability and batch-level QA/QC reporting.',
    `absolute_difference` DECIMAL(18,2) COMMENT 'Absolute difference between assay_result and expected_grade (assay_result - expected_grade), expressed in the same unit. Used for precision analysis of duplicate samples and accuracy assessment of CRMs.',
    `analysis_date` DATE COMMENT 'Date the QA/QC sample was analyzed by the laboratory. Used to track analytical delays and correlate QA/QC performance with laboratory workload and instrument calibration cycles.',
    `analyte_code` STRING COMMENT 'Chemical element or compound code for which this QA/QC sample provides control (e.g., FE for iron, CU for copper, AU for gold, S for sulfur). Aligns with periodic table symbols and laboratory analytical methods.. Valid values are `^[A-Z]{1,4}$`',
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
    `laboratory_id` BIGINT COMMENT 'Reference to the laboratory that performed the analysis. Used to track performance by laboratory and support multi-laboratory quality comparisons.',
    `qaqc_sample_id` BIGINT COMMENT 'Reference to the control sample that was analyzed. Links to the sample record in the Laboratory Information Management System (LIMS).',
    `sample_batch_id` BIGINT COMMENT 'Reference to the analytical batch in which this QA/QC sample was processed. Used to group samples analyzed together for quality control assessment.',
    `absolute_difference` DECIMAL(18,2) COMMENT 'The absolute difference between the reported value and expected value. Calculated as |reported_value - expected_value|. Used for low-grade samples where relative measures may be misleading.',
    `analysis_date` DATE COMMENT 'The date on which the QA/QC sample was analyzed by the laboratory. Used for temporal quality trend analysis and batch traceability.',
    `analysis_timestamp` TIMESTAMP COMMENT 'The precise date and time when the analytical measurement was completed. Provides high-resolution temporal tracking for quality control and audit purposes.',
    `analyte` STRING COMMENT 'The element or compound being measured in the QA/QC sample (e.g., Au, Cu, Fe, SiO2). Represents the target mineral or geochemical parameter.',
    `bias_flag` BOOLEAN COMMENT 'Boolean flag indicating whether systematic bias has been detected in the analytical results. True indicates bias is present (consistently high or low results), false indicates no bias detected.',
    `contamination_flag` BOOLEAN COMMENT 'Boolean flag indicating whether contamination has been detected based on blank sample results. True indicates contamination is present, false indicates no contamination detected.',
    `control_sample_number` STRING COMMENT 'The unique identifier or barcode assigned to the physical QA/QC control sample submitted for analysis.',
    `control_sample_type` STRING COMMENT 'Type of QA/QC control sample analyzed. Blank samples detect contamination, standards verify calibration, duplicates assess precision, and certified reference materials (CRM) verify accuracy.. Valid values are `blank|standard|duplicate|certified_reference_material|pulp_duplicate|coarse_duplicate`',
    `corrective_action_description` STRING COMMENT 'Description of the corrective action taken or planned in response to the QA/QC failure. May include re-analysis, batch rejection, equipment recalibration, or procedural changes.',
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
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to laboratory.laboratory. Business justification: CRM standards are characterized (certified values determined) at a specific laboratory. Currently crm_standard has characterization_laboratory (STRING) but no FK. Adding characterization_laboratory_id',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Certified reference materials are purchased from specialized suppliers who are counterparties. This link enables purchase order tracking, supplier performance evaluation, certificate verification, inv',
    `analytical_method` STRING COMMENT 'Primary analytical technique or method used to certify the reference material values (e.g., fire assay, XRF, ICP-MS, ICP-OES, AAS). May list multiple methods if inter-laboratory certification was performed.',
    `certificate_number` STRING COMMENT 'Unique certificate or lot number issued by the supplier that identifies the batch of certified reference material and links to the official certificate of analysis.',
    `certification_date` DATE COMMENT 'Date on which the reference material was officially certified by the supplier or certifying body, as documented on the certificate of analysis.',
    `certified_value_json` STRING COMMENT 'JSON-formatted string containing certified values for all analytes in the reference material, including element symbol, certified concentration, unit of measure, and uncertainty. Structured as array of objects to support multi-element standards.',
    `commodity_type` STRING COMMENT 'Primary commodity or element group that the certified reference material is designed to represent, aligning with the mine sites ore body characteristics. [ENUM-REF-CANDIDATE: gold|copper|iron_ore|nickel|lithium|coal|multi_element — 7 candidates stripped; promote to reference product]',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Chain of custody tracking is a regulatory requirement in mining sample management. Dispatch preparation must be traceable to a specific employee for audit trails, quality assurance, and accountability',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Sample dispatches may require stakeholder notification under benefit-sharing agreements (local content requirements for laboratory services) or when samples transit through traditional lands requiring',
    `sample_batch_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_batch. Business justification: Sample dispatches send batches of samples from site to laboratory. Currently sample_dispatch has sample_count and sample_type but no explicit FK to sample_batch. Adding sample_batch_id FK links the di',
    `sample_program_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_program. Business justification: Sample dispatches are part of a sampling program. Currently sample_dispatch has project_code (STRING) but no sample_program_id FK. Adding this FK links dispatches to the program that authorized the sa',
    `shift_production_run_id` BIGINT COMMENT 'Foreign key linking to processing.shift_production_run. Business justification: Links sample dispatch events to production shifts for turnaround tracking, metallurgical accounting, and reconciling lab results with shift production data. Essential for performance reporting and ide',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Sample dispatch to external laboratories uses mine-owned transport vehicles (light vehicles, sample trucks) that must be tracked for chain-of-custody compliance, transport cost allocation, and logisti',
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
    `origin_site_code` STRING COMMENT 'Code identifying the mine site or facility from which the samples were dispatched. Links to site master data.. Valid values are `^[A-Z]{3,6}$`',
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

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`sample_resubmission` (
    `sample_resubmission_id` BIGINT COMMENT 'Unique identifier for the sample resubmission event. Primary key for the sample resubmission product.',
    `laboratory_id` BIGINT COMMENT 'Reference to the laboratory facility assigned to perform the re-analysis. May be the same laboratory as the original analysis or a different laboratory for umpire assay purposes.',
    `laboratory_sample_id` BIGINT COMMENT 'Reference to the original sample that is being resubmitted for re-analysis. Links to the parent sample record in the sample management system.',
    `assay_result_id` BIGINT COMMENT 'Reference to the original assay result that triggered the resubmission. Links to the initial analytical result record that failed QA/QC or required verification.',
    `employee_id` BIGINT COMMENT 'User identifier of the laboratory technician, geologist, or quality assurance officer who initiated the resubmission request.',
    `qaqc_sample_id` BIGINT COMMENT 'Identifier of the QA/QC control sample (CRM, blank, or duplicate) that failed and triggered the resubmission of the associated batch samples.',
    `tertiary_sample_competent_person_signoff_user_employee_id` BIGINT COMMENT 'User identifier of the JORC or NI 43-101 competent person who reviewed and signed off on the final result validation decision.',
    `tertiary_sample_final_accepted_result_assay_result_id` BIGINT COMMENT 'Reference to the final accepted assay result after competent person review and sign-off. May be the new result, the original result, or an average of multiple results depending on the validation decision.',
    `competent_person_signoff_date` DATE COMMENT 'Date when the competent person formally signed off on the result validation decision, completing the resubmission audit trail.',
    `cost_centre_code` STRING COMMENT 'Financial cost centre code to which the resubmission analytical costs are charged. Links to the SAP FI/CO cost centre hierarchy.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the resubmission record was first created in the data platform. Part of the audit trail for data lineage and compliance.',
    `deviation_magnitude` DECIMAL(18,2) COMMENT 'Calculated magnitude of deviation from expected value or tolerance limit, expressed as percentage or absolute difference depending on the QA/QC protocol.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost of the resubmission analysis in the operating currency. Used for budget tracking and cost control of QA/QC activities.',
    `expected_value` DECIMAL(18,2) COMMENT 'Expected or certified value for the QA/QC control sample that failed. Used to calculate bias and precision metrics. Unit of measure depends on the element being analyzed.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the resubmission record was last modified in the data platform. Part of the audit trail for data lineage and compliance.',
    `new_result_received_date` DATE COMMENT 'Date when the new assay result from the resubmission was received and recorded in the LIMS system. Null until the re-analysis is completed.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or special instructions related to the resubmission event. May include sample handling notes, analytical method variations, or geological context.',
    `observed_value` DECIMAL(18,2) COMMENT 'Actual observed value from the original analysis that triggered the resubmission. Used to calculate deviation from expected value or tolerance limits.',
    `original_assay_method` STRING COMMENT 'Analytical method code used for the original analysis that is being resubmitted. Examples: FA-AAS (Fire Assay - Atomic Absorption Spectroscopy), XRF (X-Ray Fluorescence), ICP-MS (Inductively Coupled Plasma Mass Spectrometry).',
    `original_element_suite` STRING COMMENT 'Comma-separated list of elements or compounds analyzed in the original assay. Examples: Au,Ag,Cu or Fe,SiO2,Al2O3.',
    `priority_level` STRING COMMENT 'Priority classification for the resubmission turnaround time. ROUTINE: Standard processing queue; URGENT: Expedited processing for resource estimation deadlines; CRITICAL: Immediate processing for production control or compliance requirements.. Valid values are `ROUTINE|URGENT|CRITICAL`',
    `qaqc_failure_type` STRING COMMENT 'Specific type of QA/QC failure that triggered the resubmission. CRM_BIAS: Certified Reference Material result outside accuracy tolerance; CRM_PRECISION: CRM result outside precision tolerance; BLANK_CONTAMINATION: Blank sample shows contamination; DUPLICATE_PRECISION: Field or pulp duplicate exceeds precision threshold; NONE: Resubmission not due to QA/QC failure.. Valid values are `CRM_BIAS|CRM_PRECISION|BLANK_CONTAMINATION|DUPLICATE_PRECISION|NONE`',
    `resubmission_assay_method` STRING COMMENT 'Analytical method code to be used for the re-analysis. May be the same as the original method or a different method for verification purposes.',
    `resubmission_date` DATE COMMENT 'Date when the sample was formally resubmitted for re-analysis. Represents the business event timestamp for the resubmission workflow initiation.',
    `resubmission_element_suite` STRING COMMENT 'Comma-separated list of elements or compounds to be analyzed in the re-analysis. May be a subset or superset of the original element suite.',
    `resubmission_number` STRING COMMENT 'Business identifier for the resubmission event. Format: RESUB-YYYYMMDD-NNNN where YYYYMMDD is the resubmission date and NNNN is a sequential counter.. Valid values are `^RESUB-[0-9]{8}-[0-9]{4}$`',
    `resubmission_reason_code` STRING COMMENT 'Standardized code indicating why the sample was resubmitted. QC_CRM_FAIL: Certified Reference Material out of tolerance; QC_BLANK_CONTAM: Blank contamination detected; QC_DUP_EXCEED: Duplicate precision exceedance; OVERLIMIT_DILUTION: Result over instrument limit requiring dilution; CHECK_ASSAY: Verification assay for resource estimation; UMPIRE_ASSAY: Inter-laboratory bias assessment.. Valid values are `QC_CRM_FAIL|QC_BLANK_CONTAM|QC_DUP_EXCEED|OVERLIMIT_DILUTION|CHECK_ASSAY|UMPIRE_ASSAY`',
    `resubmission_reason_description` STRING COMMENT 'Detailed narrative explanation of the specific circumstances that triggered the resubmission, including reference values, tolerance limits, and deviation magnitude.',
    `resubmission_status` STRING COMMENT 'Current lifecycle status of the resubmission workflow. REQUESTED: Initial request logged; APPROVED: Management approval obtained; SUBMITTED: Sample dispatched to laboratory; IN_PROGRESS: Analysis underway; COMPLETED: New result received; SIGNED_OFF: Competent person validation complete; CANCELLED: Resubmission cancelled. [ENUM-REF-CANDIDATE: REQUESTED|APPROVED|SUBMITTED|IN_PROGRESS|COMPLETED|SIGNED_OFF|CANCELLED — 7 candidates stripped; promote to reference product]',
    `resubmission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the resubmission event was recorded in the LIMS system, including time zone information.',
    `resubmission_type` STRING COMMENT 'Classification of the resubmission workflow. INTERNAL_REPEAT: Same laboratory re-analysis; EXTERNAL_CHECK: Different laboratory verification; UMPIRE_ASSAY: Third-party inter-laboratory comparison; DILUTION_RERUN: Re-analysis with sample dilution.. Valid values are `INTERNAL_REPEAT|EXTERNAL_CHECK|UMPIRE_ASSAY|DILUTION_RERUN`',
    `result_validation_decision` STRING COMMENT 'Competent person decision on which result to accept for resource estimation and reporting. ACCEPT_NEW: Use new resubmission result; ACCEPT_ORIGINAL: Original result deemed acceptable; ACCEPT_AVERAGE: Use average of original and new; REJECT_BOTH: Both results rejected, further investigation required; PENDING: Decision not yet made.. Valid values are `ACCEPT_NEW|ACCEPT_ORIGINAL|ACCEPT_AVERAGE|REJECT_BOTH|PENDING`',
    `tolerance_limit` DECIMAL(18,2) COMMENT 'Acceptable tolerance limit (as percentage or absolute value) for the QA/QC control sample. Exceedance of this limit triggers resubmission.',
    `turnaround_time_days` STRING COMMENT 'Expected or actual turnaround time in days from resubmission date to new result received date. Used for laboratory performance monitoring and resource estimation scheduling.',
    `validation_decision_rationale` STRING COMMENT 'Detailed explanation of the competent person rationale for the result validation decision, including statistical analysis, geological context, and compliance considerations.',
    CONSTRAINT pk_sample_resubmission PRIMARY KEY(`sample_resubmission_id`)
) COMMENT 'Tracks resubmission events where samples are re-analysed due to QA/QC failures (CRM out-of-tolerance, blank contamination, duplicate exceedance), over-limit results requiring dilution, check assays for resource estimation verification, or umpire assay requests for inter-laboratory bias assessment. Records original result reference, resubmission reason code, resubmission date, assigned laboratory, new result reference, and final accepted result with sign-off. Provides the audit trail for result validation decisions required under JORC Table 1 and NI 43-101 competent person sign-off.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`laboratory` (
    `laboratory_id` BIGINT COMMENT 'Unique identifier for the laboratory. Primary key.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: External laboratories are commercial counterparties with master service agreements, credit terms, payment schedules, and performance KPIs. This link enables contract management, vendor performance eva',
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
    `capital_project_id` BIGINT COMMENT 'Reference to the parent mining project or exploration project under which this sample program is conducted.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Sample programs target specific commodities for exploration or grade control. Supports program planning, budget allocation by commodity, regulatory reporting (JORC/NI 43-101), and analytical suite sel',
    `competent_person_id` BIGINT COMMENT 'Reference to the Competent Person (CP) or Qualified Person (QP) responsible for validating and signing off on the sample program design and data quality for regulatory reporting purposes.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Sample programs on traditional lands require stakeholder consultation and FPIC. Indigenous groups and landowners are consulted before drilling/sampling campaigns commence. This link tracks which stake',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Sample programs are budgeted and tracked against cost centres for exploration and grade control expenditure management. Required for budget vs actual reporting and cost variance analysis in mining ope',
    `drill_program_id` BIGINT COMMENT 'Foreign key linking to exploration.drill_program. Business justification: Sample programs are scoped to drill programs for budget allocation and statutory expenditure tracking. Links laboratory analytical spend to exploration drill program budgets, essential for minimum exp',
    `employee_id` BIGINT COMMENT 'Reference to the user who last modified this sample program record.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Sampling programs designed to meet specific permit monitoring requirements (groundwater monitoring for mining lease, discharge water monitoring for EPA permit). Direct regulatory compliance linkage.',
    `licence_id` BIGINT COMMENT 'Foreign key linking to exploration.licence. Business justification: Sample programs must track exploration licence context for statutory reporting and minimum expenditure compliance. Regulatory authorities require analytical expenditure to be reported by licence for a',
    `legal_register_id` BIGINT COMMENT 'Foreign key linking to hse.legal_register. Business justification: Sampling programs must comply with specific legislation (MSHA respirable dust sampling, state EPA tailings monitoring). Links program design to legal obligation.',
    `laboratory_id` BIGINT COMMENT 'Reference to the primary laboratory facility (internal or external) contracted to perform analytical work for this program.',
    `mine_area_id` BIGINT COMMENT 'Reference to the specific mine area, pit, or underground zone where sampling is being conducted.',
    `primary_sample_employee_id` BIGINT COMMENT 'Reference to the geologist or metallurgist responsible for overseeing this sample program, including protocol compliance and data quality.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Sample programs target specific prospects for resource definition. Links analytical campaigns to geological targets, critical for resource estimation workflows, geological domain assignment, and compe',
    `social_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to community.social_impact_assessment. Business justification: Mining sample programs support SIA baseline studies for regulatory approval. Environmental and social baseline sampling protocols are documented in SIAs, particularly for exploration projects requirin',
    `stage_gate_id` BIGINT COMMENT 'Foreign key linking to project.stage_gate. Business justification: Sample programs are tied to stage-gate milestones with defined deliverables (e.g., PFS requires infill drilling, FS requires metallurgical testwork). Stage-gate criteria include completion of specifie',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Sample programs must track the tenement under which they operate for regulatory expenditure reporting, compliance with annual expenditure commitments, and resource estimation within tenement boundarie',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Exploration sample programs are tracked under WBS elements for IFRS6 exploration expenditure capitalization and project cost tracking. Essential for determining technical feasibility and reclassificat',
    `actual_sample_count` STRING COMMENT 'Actual number of samples collected to date under this program, excluding QA/QC samples. Updated as sampling progresses.',
    `analytical_suite_specification` STRING COMMENT 'Specification of which analytes and analytical methods apply to samples collected under this program, such as Fire Assay Au + ICP-MS multi-element or XRF Fe, SiO2, Al2O3, P, S + LOI.',
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
    `laboratory_id` BIGINT COMMENT 'Reference to the laboratory facility where this instrument is installed and operated.',
    `accreditation_scope` STRING COMMENT 'Description of the accredited scope of testing for this instrument under ISO/IEC 17025 or equivalent laboratory accreditation. Identifies which tests are covered by accreditation.',
    `accuracy_specification` STRING COMMENT 'Manufacturers accuracy specification or laboratory-validated accuracy for the instrument. Expressed as percentage, absolute value, or relative standard deviation.',
    `acquisition_date` DATE COMMENT 'Date when the instrument was acquired or purchased by the organization.',
    `applicable_methods` STRING COMMENT 'List of analytical methods or standard operating procedures (SOPs) that this instrument is qualified to perform. May reference industry standards such as ASTM, ISO, or internal method codes.',
    `asset_tag` STRING COMMENT 'Internal asset tag or property number assigned by the organization for fixed asset tracking and inventory management.',
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

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`result_validation` (
    `result_validation_id` BIGINT COMMENT 'Unique identifier for the result validation record. Primary key.',
    `laboratory_sample_id` BIGINT COMMENT 'Reference to the laboratory sample whose assay results are being validated.',
    `resource_estimate_id` BIGINT COMMENT 'Foreign key linking to exploration.resource_estimate. Business justification: Result validation approval is required for specific resource estimates under JORC/NI 43-101. Competent persons must certify that analytical data quality meets reporting standards for each estimate, li',
    `sample_batch_id` BIGINT COMMENT 'Foreign key linking to laboratory.sample_batch. Business justification: Result validation is performed at the batch level - a competent person validates all results in a batch before release. Currently result_validation has validation_batch_number (STRING) but no FK. Addi',
    `employee_id` BIGINT COMMENT 'Internal employee identifier of the validator, linking to the HR system for competency verification and audit purposes.',
    `approved_for_process_control` BOOLEAN COMMENT 'Indicates whether the validated assay results are approved for use in metallurgical process control and optimization. True if approved, False if not approved.',
    `approved_for_resource_estimation` BOOLEAN COMMENT 'Indicates whether the validated assay results are approved for use in mineral resource estimation under JORC, NI 43-101, or SAMREC standards. True if approved, False if not approved.',
    `blank_contamination_check` BOOLEAN COMMENT 'Indicates whether blank samples showed acceptable low contamination levels. True if passed (no contamination detected), False if failed (contamination detected).',
    `comments` STRING COMMENT 'Additional free-text comments or observations recorded by the validator. Used to capture context, special circumstances, or additional information not covered by structured fields.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective action to be taken, such as re-assay of samples, recalibration of instruments, or investigation of laboratory procedures. Populated when corrective_action_required is True.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is required following this validation (e.g., re-assay, investigation of laboratory procedures). True if corrective action is needed, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this validation record was first created in the system. Used for audit trail and data lineage.',
    `duplicate_precision_check` BOOLEAN COMMENT 'Indicates whether duplicate samples met precision acceptance criteria (e.g., relative percent difference within acceptable limits). True if passed, False if failed.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this validation record was last modified. Used for audit trail and change tracking.',
    `peer_review_date` DATE COMMENT 'Date on which the peer review was completed. Populated only when peer review was performed.',
    `peer_reviewer_name` STRING COMMENT 'Name of the peer reviewer who independently reviewed the validation, if peer review was performed. Used for additional quality assurance on critical validations.',
    `qaqc_pass_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of QA/QC samples (standards, duplicates, blanks) that passed acceptance criteria during this validation. Used to quantify the quality of the assay batch.',
    `qualification_notes` STRING COMMENT 'Free-text notes documenting any qualifications, conditions, or limitations applied to the validated results. Used when validation outcome is qualified to explain the nature of the qualification and any restrictions on data use.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the assay results were rejected, including specific QA/QC failures, procedural errors, or data quality issues. Populated only when validation outcome is rejected.',
    `standard_deviation_check` BOOLEAN COMMENT 'Indicates whether the assay results passed statistical standard deviation checks against certified reference materials (CRMs). True if passed, False if failed.',
    `validation_date` DATE COMMENT 'The date on which the validation was formally completed and signed off by the competent person. This is the principal business event timestamp for the validation lifecycle.',
    `validation_method` STRING COMMENT 'The method or technique used to validate the assay results. Indicates the type of quality control check performed (e.g., statistical analysis of QA/QC samples, comparison with certified reference materials, visual inspection of data patterns, peer review). [ENUM-REF-CANDIDATE: statistical_review|qaqc_check|visual_inspection|duplicate_comparison|standard_comparison|blank_check|peer_review|automated_rule — 8 candidates stripped; promote to reference product]',
    `validation_number` STRING COMMENT 'Externally-known unique business identifier for this validation event, used for audit trail and traceability.. Valid values are `^VAL-[0-9]{8}-[A-Z0-9]{6}$`',
    `validation_outcome` STRING COMMENT 'Final outcome of the validation process: accepted (results approved for use), rejected (results failed validation), or qualified (results accepted with conditions or limitations).. Valid values are `accepted|rejected|qualified`',
    `validation_software_version` STRING COMMENT 'Version of the LIMS or validation software used to perform the validation. Important for audit trail and reproducibility of validation decisions.',
    `validation_status` STRING COMMENT 'Current lifecycle status of the validation record. Indicates whether the validation is pending review, under review, accepted, rejected, accepted with qualifications, or superseded by a later validation.. Valid values are `pending|in_review|accepted|rejected|qualified|superseded`',
    `validation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the validation was completed, including time-of-day. Used for detailed audit trail and chronological sequencing of validation events.',
    `validator_name` STRING COMMENT 'Full name of the competent person (geologist, metallurgist, or laboratory manager) who performed and signed off on the validation. Required for JORC, NI 43-101, and SAMREC competent person requirements.',
    `validator_professional_registration` STRING COMMENT 'Professional registration or membership number of the validator with a recognized professional body (e.g., AusIMM, CIM, SACNASP). Required to demonstrate competent person status under JORC, NI 43-101, and SAMREC.',
    `validator_role` STRING COMMENT 'Professional role or title of the validator. Indicates the authority and competency level of the person performing the validation.. Valid values are `competent_person|senior_geologist|chief_geologist|metallurgist|laboratory_manager|qaqc_officer`',
    CONSTRAINT pk_result_validation PRIMARY KEY(`result_validation_id`)
) COMMENT 'Records the formal validation and sign-off of assay results by a competent geologist or metallurgist prior to release for use in resource estimation or process control. Stores validation date, validator name and role, validation method (statistical review, QA/QC check, visual inspection), validation outcome (accepted, rejected, qualified), and any qualification notes. Supports JORC, NI 43-101, and SAMREC competent person requirements.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`approval` (
    `approval_id` BIGINT COMMENT 'Unique identifier for this laboratory approval record. Primary key.',
    `competent_person_id` BIGINT COMMENT 'Foreign key linking to the Competent Person who grants or manages the laboratory approval',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to the laboratory that is approved for use by the Competent Person',
    `accreditation_scope_approved` STRING COMMENT 'The specific subset of the laboratorys accreditation scope (analytes, methods, matrices) that this Competent Person has approved for their work. May be narrower than the laboratorys full accreditation scope based on CP commodity expertise.',
    `approval_date` DATE COMMENT 'The date on which the Competent Person formally approved this laboratory for use in their resource estimation and reporting work.',
    `approval_status` STRING COMMENT 'Current status of the CPs approval of this laboratory for resource estimation work. Values: approved, pending, suspended, revoked, expired.',
    `approved_commodity_list` STRING COMMENT 'Comma-separated list of mineral commodities for which this CP has approved this laboratory, aligned with the CPs commodity expertise and the laboratorys analytical capabilities.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this laboratory approval record was created in the system.',
    `expiry_date` DATE COMMENT 'The date on which this CP-laboratory approval expires and requires renewal or re-evaluation.',
    `last_audit_date` DATE COMMENT 'The date of the most recent audit or quality review of this laboratory conducted or reviewed by this Competent Person for their approval purposes.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this laboratory approval record was last updated.',
    `next_audit_due_date` DATE COMMENT 'The scheduled date for the next audit or quality review of this laboratory by or on behalf of this Competent Person to maintain approval status.',
    `notes` STRING COMMENT 'Free-text field for the Competent Person to document specific conditions, limitations, or qualifications related to their approval of this laboratory.',
    `quality_rating` STRING COMMENT 'The Competent Persons quality performance rating for this laboratory based on QA/QC results, turnaround time adherence, and accuracy of results for their specific work. Values: excellent, good, acceptable, marginal, unacceptable.',
    CONSTRAINT pk_approval PRIMARY KEY(`approval_id`)
) COMMENT 'This association product represents the approval relationship between a Competent Person and a laboratory for JORC/NI 43-101/SAMREC compliance purposes. It captures the formal approval status, accreditation scope, audit history, and quality ratings that exist only in the context of a specific CP-laboratory pairing. Each record links one competent person to one laboratory with attributes tracking the approval lifecycle, quality assurance, and regulatory compliance requirements for mineral resource and ore reserve reporting.. Existence Justification: In mining operations, Competent Persons must approve multiple laboratories for different commodities, analytical methods, and project types based on their professional judgment and the laboratorys accreditation scope. Simultaneously, each laboratory is approved by multiple Competent Persons across different commodity specializations and reporting codes (JORC, NI 43-101, SAMREC). This approval relationship is actively managed as a regulatory compliance requirement, with each CP-laboratory pairing having its own approval status, quality rating, audit schedule, and approved scope that cannot reside on either entity alone.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`service_agreement` (
    `service_agreement_id` BIGINT COMMENT 'Unique identifier for this laboratory service agreement. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to the capital project receiving laboratory services under this agreement',
    `employee_id` BIGINT COMMENT 'Reference to the employee who created this laboratory service agreement record, typically the project geologist or contracts administrator.',
    `laboratory_id` BIGINT COMMENT 'Foreign key linking to the laboratory providing analytical services under this agreement',
    `last_modified_by_employee_id` BIGINT COMMENT 'Reference to the employee who last modified this laboratory service agreement record.',
    `agreement_status` STRING COMMENT 'Current status of the laboratory service agreement: draft (under negotiation), active (in effect and receiving samples), suspended (temporarily paused), completed (contract period ended normally), terminated (ended early).',
    `analytical_suite_scope` STRING COMMENT 'Detailed description of the analytical methods, analytes, and sample types covered under this specific project-laboratory agreement, which may be a subset of the laboratorys full accreditation scope tailored to project requirements.',
    `contract_end_date` DATE COMMENT 'Date on which the laboratory service agreement expires or is scheduled to terminate, after which the laboratory is no longer authorized to receive project samples unless renewed.',
    `contract_reference_number` STRING COMMENT 'External contract or purchase order reference number used in procurement and financial systems to track this laboratory service agreement.',
    `contract_start_date` DATE COMMENT 'Date on which the laboratory service agreement becomes effective and the laboratory is authorized to receive samples from the project.',
    `cost_per_sample` DECIMAL(18,2) COMMENT 'Negotiated cost per sample for this specific project-laboratory agreement, which may differ from the laboratorys standard pricing based on sample volume commitments, contract duration, or project-specific analytical requirements.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this laboratory service agreement record was created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost_per_sample amount (e.g., USD, AUD, CAD, ZAR).',
    `laboratory_role` STRING COMMENT 'The role this laboratory plays in the projects quality assurance framework: primary (main analytical provider), check (independent verification of primary results), umpire (dispute resolution when primary and check disagree), or specialist (specific testwork such as metallurgical or geotechnical).',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this laboratory service agreement record.',
    `sample_volume_commitment` STRING COMMENT 'Minimum number of samples the project commits to submit to this laboratory over the contract period, used to negotiate preferential pricing and secure laboratory capacity allocation.',
    `turnaround_sla_days` STRING COMMENT 'Contracted service level agreement for turnaround time in calendar days from sample receipt to result delivery, negotiated specifically for this project and may differ from the laboratorys standard turnaround time based on project priority and volume commitments.',
    CONSTRAINT pk_service_agreement PRIMARY KEY(`service_agreement_id`)
) COMMENT 'This association product represents the contractual service agreement between a laboratory and a capital project. It captures the specific terms, analytical scope, turnaround commitments, and pricing negotiated for each project-laboratory engagement. Each record links one laboratory to one capital project with attributes that exist only in the context of this specific service contract, enabling projects to engage multiple laboratories (primary, check, umpire) for different analytical suites while laboratories serve multiple concurrent projects.. Existence Justification: In mining operations, capital projects routinely engage multiple laboratories simultaneously to fulfill different analytical roles: a primary laboratory for routine assays, a check laboratory for independent QA/QC verification (typically 5-10% of samples), and an umpire laboratory for dispute resolution when results diverge. Conversely, each laboratory serves multiple concurrent projects across different sites and commodities. This is not a theoretical possibility but standard operational practice driven by quality assurance requirements, risk management, and the need for specialized analytical capabilities (e.g., metallurgical testwork vs routine geochemistry).';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` (
    `program_equipment_assignment_id` BIGINT COMMENT 'Unique identifier for each equipment assignment to a sample program. Primary key.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the mining asset (drill rig, excavator, sampler) assigned to the program',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically mine planner, geology supervisor, or equipment coordinator) who authorized this equipment assignment to the sample program.',
    `sample_program_id` BIGINT COMMENT 'Foreign key linking to the sample program or campaign that this equipment assignment supports',
    `assignment_end_date` DATE COMMENT 'Date when the asset completed work on this sample program or was deallocated. Null if assignment is ongoing. Identified in detection phase relationship data.',
    `assignment_notes` STRING COMMENT 'Free-text notes about this equipment assignment, including special requirements, operational constraints, performance issues, or reasons for early termination.',
    `assignment_start_date` DATE COMMENT 'Date when the asset was allocated to and began working on this sample program. Identified in detection phase relationship data.',
    `assignment_status` STRING COMMENT 'Current operational status of this equipment assignment: planned (scheduled but not started), active (equipment currently working on program), suspended (temporarily paused due to weather, maintenance, or program hold), completed (assignment finished successfully), cancelled (assignment terminated before completion).',
    `cost_allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of the assets operating costs allocated to this sample program during the assignment period. Used when equipment is shared across multiple concurrent programs. Sum of cost_allocation_percent across all concurrent program assignments for an asset should equal 100%. Identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment assignment record was created in the system.',
    `equipment_role` STRING COMMENT 'The functional role the asset performed within this sample program: primary_drilling (main drill rig for sample collection), support_drilling (infill or verification drilling), excavation (pit access or trench sampling), sample_collection (dedicated sampling equipment), sample_transport (moving samples to storage), site_preparation (access roads, pads), other. Identified in detection phase relationship data.',
    `equipment_utilization_hours` DECIMAL(18,2) COMMENT 'Total engine hours or operating hours the asset spent working on this specific sample program. Used for cost allocation and program budget tracking. Identified in detection phase relationship data.',
    `planned_utilization_hours` DECIMAL(18,2) COMMENT 'Estimated or planned engine hours for this asset to complete its role in the sample program. Used for resource planning and variance analysis against actual utilization hours.',
    `program_phase` STRING COMMENT 'The phase of the sample program during which this equipment assignment is active: planning (equipment reserved but not yet deployed), mobilization (equipment being moved to site), active_sampling (equipment actively collecting samples), demobilization (equipment being removed from program), completed (assignment finished). Identified in detection phase relationship data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this equipment assignment record was last modified.',
    CONSTRAINT pk_program_equipment_assignment PRIMARY KEY(`program_equipment_assignment_id`)
) COMMENT 'This association product represents the Assignment between sample_program and asset. It captures the allocation of mining equipment (drill rigs, excavators, samplers) to specific sampling programs for the duration of their participation. Each record links one sample_program to one asset with attributes that track utilization hours, cost allocation, assignment timing, equipment role, and program phase. This enables accurate tracking of equipment utilization across concurrent programs and supports cost allocation for shared equipment resources.. Existence Justification: In mining operations, sample programs (resource definition drilling, grade control, metallurgical campaigns) routinely utilize multiple assets concurrently—a resource definition program may deploy 3 drill rigs, 2 excavators, and sample collection equipment simultaneously across different mine areas. Conversely, each asset (especially mobile equipment like drill rigs) participates in multiple sample programs over time and often concurrently when programs overlap geographically or temporally. The business actively manages these assignments to track equipment utilization hours per program, allocate operating costs across concurrent programs, and plan resource availability.';

CREATE OR REPLACE TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` (
    `study_analytical_specification_id` BIGINT COMMENT 'Unique identifier for this study analytical specification record. Primary key.',
    `analytical_method_id` BIGINT COMMENT 'Foreign key linking to the analytical method selected for use in this feasibility study',
    `feasibility_study_id` BIGINT COMMENT 'Foreign key linking to the feasibility study for which this analytical method was specified',
    `approved_for_study_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this method has been formally approved for use in this specific feasibility study by the competent person or study lead consultant.',
    `cost_per_sample` DECIMAL(18,2) COMMENT 'Study-specific cost per sample for this analytical method, which may differ from the standard laboratory cost due to volume discounts, external laboratory pricing, or study-specific contract terms.',
    `detection_limit_adequacy` STRING COMMENT 'Assessment of whether the methods detection limits are adequate for the expected grade ranges and resource estimation requirements of this specific feasibility study. Values: adequate, marginal, inadequate.',
    `expected_sample_count` STRING COMMENT 'Estimated number of samples that will be analyzed using this method during this feasibility study, used for cost estimation and laboratory capacity planning.',
    `laboratory_provider` STRING COMMENT 'Name of the specific laboratory (internal or external) that will perform this analytical method for this feasibility study, as different studies may use different laboratory providers.',
    `method_selection_rationale` STRING COMMENT 'Documented business justification for why this specific analytical method was selected for this feasibility study, including technical suitability, cost considerations, accreditation requirements, and matrix compatibility with expected sample types.',
    `primary_analyte_target` STRING COMMENT 'The primary element or compound of interest for this method in the context of this feasibility study (e.g., Au for gold projects, Cu for copper projects), which may be a subset of the methods full analyte list.',
    `specification_date` DATE COMMENT 'Date when this analytical method was formally specified and approved for use in this feasibility study.',
    `specification_status` STRING COMMENT 'Current status of this method specification within the feasibility study lifecycle. Values: proposed (under review), approved (ready for use), active (currently in use), completed (study finished), superseded (replaced by alternative method).',
    `turnaround_time_days` STRING COMMENT 'Expected turnaround time in days for this analytical method within the context of this feasibility study, accounting for study-specific logistics, sample volumes, and laboratory capacity constraints.',
    CONSTRAINT pk_study_analytical_specification PRIMARY KEY(`study_analytical_specification_id`)
) COMMENT 'This association product represents the specification and selection of analytical methods for feasibility studies. It captures the formal selection of which laboratory analytical methods will be used to analyze samples during a feasibility study, including the rationale for selection, adequacy assessment, and study-specific cost and timing parameters. Each record links one analytical method to one feasibility study with attributes that exist only in the context of this study-method pairing.. Existence Justification: In mining feasibility studies, multiple analytical methods are specified for different elements, matrices, and purposes (e.g., fire assay for gold, ICP-MS for multi-element suites, XRF for major oxides). Each method is reused across multiple feasibility studies over time. The relationship represents a formal specification decision made during study planning, where the study team selects which methods are appropriate for their specific commodity, expected grade ranges, and resource estimation requirements.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_crm_standard_id` FOREIGN KEY (`crm_standard_id`) REFERENCES `mining_ecm`.`laboratory`.`crm_standard`(`crm_standard_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_duplicate_of_sample_laboratory_sample_id` FOREIGN KEY (`duplicate_of_sample_laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ADD CONSTRAINT `fk_laboratory_laboratory_sample_sample_program_id` FOREIGN KEY (`sample_program_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_program`(`sample_program_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_original_batch_sample_batch_id` FOREIGN KEY (`original_batch_sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ADD CONSTRAINT `fk_laboratory_sample_batch_sample_program_id` FOREIGN KEY (`sample_program_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_program`(`sample_program_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_crm_standard_id` FOREIGN KEY (`crm_standard_id`) REFERENCES `mining_ecm`.`laboratory`.`crm_standard`(`crm_standard_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_instrument_id` FOREIGN KEY (`instrument_id`) REFERENCES `mining_ecm`.`laboratory`.`instrument`(`instrument_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ADD CONSTRAINT `fk_laboratory_assay_result_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ADD CONSTRAINT `fk_laboratory_metallurgical_test_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ADD CONSTRAINT `fk_laboratory_sample_preparation_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ADD CONSTRAINT `fk_laboratory_qaqc_sample_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ADD CONSTRAINT `fk_laboratory_qaqc_sample_crm_standard_id` FOREIGN KEY (`crm_standard_id`) REFERENCES `mining_ecm`.`laboratory`.`crm_standard`(`crm_standard_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ADD CONSTRAINT `fk_laboratory_qaqc_sample_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ADD CONSTRAINT `fk_laboratory_qaqc_sample_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ADD CONSTRAINT `fk_laboratory_qaqc_sample_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ADD CONSTRAINT `fk_laboratory_qaqc_result_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ADD CONSTRAINT `fk_laboratory_qaqc_result_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ADD CONSTRAINT `fk_laboratory_qaqc_result_qaqc_sample_id` FOREIGN KEY (`qaqc_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`qaqc_sample`(`qaqc_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ADD CONSTRAINT `fk_laboratory_qaqc_result_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ADD CONSTRAINT `fk_laboratory_crm_standard_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ADD CONSTRAINT `fk_laboratory_sample_dispatch_sample_program_id` FOREIGN KEY (`sample_program_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_program`(`sample_program_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ADD CONSTRAINT `fk_laboratory_sample_resubmission_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ADD CONSTRAINT `fk_laboratory_sample_resubmission_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ADD CONSTRAINT `fk_laboratory_sample_resubmission_assay_result_id` FOREIGN KEY (`assay_result_id`) REFERENCES `mining_ecm`.`laboratory`.`assay_result`(`assay_result_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ADD CONSTRAINT `fk_laboratory_sample_resubmission_qaqc_sample_id` FOREIGN KEY (`qaqc_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`qaqc_sample`(`qaqc_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ADD CONSTRAINT `fk_laboratory_sample_resubmission_tertiary_sample_final_accepted_result_assay_result_id` FOREIGN KEY (`tertiary_sample_final_accepted_result_assay_result_id`) REFERENCES `mining_ecm`.`laboratory`.`assay_result`(`assay_result_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ADD CONSTRAINT `fk_laboratory_sample_program_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ADD CONSTRAINT `fk_laboratory_instrument_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_laboratory_sample_id` FOREIGN KEY (`laboratory_sample_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory_sample`(`laboratory_sample_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ADD CONSTRAINT `fk_laboratory_result_validation_sample_batch_id` FOREIGN KEY (`sample_batch_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_batch`(`sample_batch_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ADD CONSTRAINT `fk_laboratory_approval_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ADD CONSTRAINT `fk_laboratory_service_agreement_laboratory_id` FOREIGN KEY (`laboratory_id`) REFERENCES `mining_ecm`.`laboratory`.`laboratory`(`laboratory_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ADD CONSTRAINT `fk_laboratory_program_equipment_assignment_sample_program_id` FOREIGN KEY (`sample_program_id`) REFERENCES `mining_ecm`.`laboratory`.`sample_program`(`sample_program_id`);
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ADD CONSTRAINT `fk_laboratory_study_analytical_specification_analytical_method_id` FOREIGN KEY (`analytical_method_id`) REFERENCES `mining_ecm`.`laboratory`.`analytical_method`(`analytical_method_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`laboratory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `mining_ecm`.`laboratory` SET TAGS ('dbx_domain' = 'laboratory');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `blast_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Blast Event Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `chemical_register_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Collection Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `crm_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Reference Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `cultural_heritage_site_id` SET TAGS ('dbx_business_glossary_term' = 'Cultural Heritage Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `drill_hole_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `duplicate_of_sample_laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Duplicate of Sample Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'External Laboratory Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `failure_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Report Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `sample_program_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Barcode');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `barcode` SET TAGS ('dbx_value_regex' = '^[0-9]{10,20}$');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,20}$');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `bench_name` SET TAGS ('dbx_business_glossary_term' = 'Bench Name');
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
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory_sample` ALTER COLUMN `pit_name` SET TAGS ('dbx_business_glossary_term' = 'Pit Name');
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
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'External Laboratory Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Grievance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `original_batch_sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Original Batch Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By User Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `sample_program_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_batch` ALTER COLUMN `shift_production_run_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Production Run Id (Foreign Key)');
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
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `crm_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Reference Material Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `exploration_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `failure_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Report Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `grade_control_block_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Control Block Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Batch Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `accuracy_percent` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `analysis_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `analyte_code` SET TAGS ('dbx_business_glossary_term' = 'Analyte Code');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `analyte_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,4}[0-9]{0,2}$');
ALTER TABLE `mining_ecm`.`laboratory`.`assay_result` ALTER COLUMN `analyte_name` SET TAGS ('dbx_business_glossary_term' = 'Analyte Name');
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
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `exploration_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `failure_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Report Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `lom_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Lom Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Offtake Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Test Operator Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`metallurgical_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `exploration_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_preparation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Id (Foreign Key)');
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
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Original Sample Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Batch Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `absolute_difference` SET TAGS ('dbx_business_glossary_term' = 'Absolute Difference Value');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `analyte_code` SET TAGS ('dbx_business_glossary_term' = 'Analyte Element Code');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_sample` ALTER COLUMN `analyte_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,4}$');
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
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `qaqc_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Sample Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Analytical Batch Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `absolute_difference` SET TAGS ('dbx_business_glossary_term' = 'Absolute Difference');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Analysis Date');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `analysis_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `analyte` SET TAGS ('dbx_business_glossary_term' = 'Analyte Element or Compound');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `bias_flag` SET TAGS ('dbx_business_glossary_term' = 'Bias Detection Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `contamination_flag` SET TAGS ('dbx_business_glossary_term' = 'Contamination Detection Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `control_sample_number` SET TAGS ('dbx_business_glossary_term' = 'Control Sample Number');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `control_sample_type` SET TAGS ('dbx_business_glossary_term' = 'Control Sample Type');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `control_sample_type` SET TAGS ('dbx_value_regex' = 'blank|standard|duplicate|certified_reference_material|pulp_duplicate|coarse_duplicate');
ALTER TABLE `mining_ecm`.`laboratory`.`qaqc_result` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
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
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Characterization Laboratory Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `analytical_method` SET TAGS ('dbx_business_glossary_term' = 'Analytical Method');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `certified_value_json` SET TAGS ('dbx_business_glossary_term' = 'Certified Value JSON');
ALTER TABLE `mining_ecm`.`laboratory`.`crm_standard` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
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
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Prepared By Employee Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Batch Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `sample_program_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Program Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `shift_production_run_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Production Run Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Asset Id (Foreign Key)');
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
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `origin_site_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Site Code');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_dispatch` ALTER COLUMN `origin_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,6}$');
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
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` SET TAGS ('dbx_subdomain' = 'sample_management');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `sample_resubmission_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Resubmission ID');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Laboratory ID');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Original Sample ID');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `assay_result_id` SET TAGS ('dbx_business_glossary_term' = 'Original Result ID');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By User ID');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `qaqc_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Control Sample ID');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `tertiary_sample_competent_person_signoff_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Sign-Off User ID');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `tertiary_sample_competent_person_signoff_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `tertiary_sample_competent_person_signoff_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `tertiary_sample_final_accepted_result_assay_result_id` SET TAGS ('dbx_business_glossary_term' = 'Final Accepted Result ID');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `competent_person_signoff_date` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Sign-Off Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Code');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `deviation_magnitude` SET TAGS ('dbx_business_glossary_term' = 'Deviation Magnitude');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `expected_value` SET TAGS ('dbx_business_glossary_term' = 'Expected Value');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `new_result_received_date` SET TAGS ('dbx_business_glossary_term' = 'New Result Received Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `observed_value` SET TAGS ('dbx_business_glossary_term' = 'Observed Value');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `original_assay_method` SET TAGS ('dbx_business_glossary_term' = 'Original Assay Method');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `original_element_suite` SET TAGS ('dbx_business_glossary_term' = 'Original Element Suite');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'ROUTINE|URGENT|CRITICAL');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `qaqc_failure_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Failure Type');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `qaqc_failure_type` SET TAGS ('dbx_value_regex' = 'CRM_BIAS|CRM_PRECISION|BLANK_CONTAMINATION|DUPLICATE_PRECISION|NONE');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `resubmission_assay_method` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Assay Method');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `resubmission_date` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Date');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `resubmission_element_suite` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Element Suite');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `resubmission_number` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Number');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `resubmission_number` SET TAGS ('dbx_value_regex' = '^RESUB-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `resubmission_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Reason Code');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `resubmission_reason_code` SET TAGS ('dbx_value_regex' = 'QC_CRM_FAIL|QC_BLANK_CONTAM|QC_DUP_EXCEED|OVERLIMIT_DILUTION|CHECK_ASSAY|UMPIRE_ASSAY');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `resubmission_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Reason Description');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `resubmission_status` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Status');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `resubmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `resubmission_type` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Type');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `resubmission_type` SET TAGS ('dbx_value_regex' = 'INTERNAL_REPEAT|EXTERNAL_CHECK|UMPIRE_ASSAY|DILUTION_RERUN');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `result_validation_decision` SET TAGS ('dbx_business_glossary_term' = 'Result Validation Decision');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `result_validation_decision` SET TAGS ('dbx_value_regex' = 'ACCEPT_NEW|ACCEPT_ORIGINAL|ACCEPT_AVERAGE|REJECT_BOTH|PENDING');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `tolerance_limit` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Limit');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time Days');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_resubmission` ALTER COLUMN `validation_decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Validation Decision Rationale');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`laboratory` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
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
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Competent Person Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Consultation Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `drill_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Program Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `licence_id` SET TAGS ('dbx_business_glossary_term' = 'Exploration Licence Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `legal_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Legal Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `mine_area_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Area Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `primary_sample_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Geologist Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `primary_sample_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `primary_sample_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `social_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Social Impact Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `stage_gate_id` SET TAGS ('dbx_business_glossary_term' = 'Stage Gate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `actual_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Sample Count');
ALTER TABLE `mining_ecm`.`laboratory`.`sample_program` ALTER COLUMN `analytical_suite_specification` SET TAGS ('dbx_business_glossary_term' = 'Analytical Suite Specification');
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
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `accreditation_scope` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `accuracy_specification` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Specification');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `applicable_methods` SET TAGS ('dbx_business_glossary_term' = 'Applicable Analytical Methods');
ALTER TABLE `mining_ecm`.`laboratory`.`instrument` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
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
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` SET TAGS ('dbx_subdomain' = 'analytical_testing');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `result_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Result Validation Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `laboratory_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Sample Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `resource_estimate_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Estimate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `sample_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Batch Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validator Employee Identifier (ID)');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `approved_for_process_control` SET TAGS ('dbx_business_glossary_term' = 'Approved for Process Control');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `approved_for_resource_estimation` SET TAGS ('dbx_business_glossary_term' = 'Approved for Resource Estimation');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `blank_contamination_check` SET TAGS ('dbx_business_glossary_term' = 'Blank Contamination Check');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `duplicate_precision_check` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Precision Check');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `peer_review_date` SET TAGS ('dbx_business_glossary_term' = 'Peer Review Date');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `peer_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Peer Reviewer Name');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `peer_reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `peer_reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `qaqc_pass_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Quality Control (QA/QC) Pass Rate Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `qualification_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `standard_deviation_check` SET TAGS ('dbx_business_glossary_term' = 'Standard Deviation Check');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validation_method` SET TAGS ('dbx_business_glossary_term' = 'Validation Method');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validation_number` SET TAGS ('dbx_business_glossary_term' = 'Validation Number');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validation_number` SET TAGS ('dbx_value_regex' = '^VAL-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Validation Outcome');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_value_regex' = 'accepted|rejected|qualified');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validation_software_version` SET TAGS ('dbx_business_glossary_term' = 'Validation Software Version');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|accepted|rejected|qualified|superseded');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validator_name` SET TAGS ('dbx_business_glossary_term' = 'Validator Name');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validator_professional_registration` SET TAGS ('dbx_business_glossary_term' = 'Validator Professional Registration Number');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validator_role` SET TAGS ('dbx_business_glossary_term' = 'Validator Role');
ALTER TABLE `mining_ecm`.`laboratory`.`result_validation` ALTER COLUMN `validator_role` SET TAGS ('dbx_value_regex' = 'competent_person|senior_geologist|chief_geologist|metallurgist|laboratory_manager|qaqc_officer');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` SET TAGS ('dbx_association_edges' = 'exploration.competent_person,laboratory.laboratory');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Approval ID');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `competent_person_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Approval - Competent Person Id');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Approval - Laboratory Id');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `accreditation_scope_approved` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Scope Approved');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `approved_commodity_list` SET TAGS ('dbx_business_glossary_term' = 'Approved Commodity List');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Date');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `mining_ecm`.`laboratory`.`approval` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` SET TAGS ('dbx_association_edges' = 'laboratory.laboratory,project.capital_project');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Service Agreement ID');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Service Agreement - Capital Project Id');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Service Agreement - Laboratory Id');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee ID');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `analytical_suite_scope` SET TAGS ('dbx_business_glossary_term' = 'Analytical Suite Scope');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `cost_per_sample` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Sample');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `laboratory_role` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Role');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `sample_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Sample Volume Commitment');
ALTER TABLE `mining_ecm`.`laboratory`.`service_agreement` ALTER COLUMN `turnaround_sla_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround SLA Days');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` SET TAGS ('dbx_association_edges' = 'laboratory.sample_program,equipment.asset');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `program_equipment_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Equipment Assignment Identifier');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Program Equipment Assignment - Asset Id');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Employee');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `sample_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Equipment Assignment - Sample Program Id');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `cost_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `equipment_role` SET TAGS ('dbx_business_glossary_term' = 'Equipment Role');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `equipment_utilization_hours` SET TAGS ('dbx_business_glossary_term' = 'Equipment Utilization Hours');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `planned_utilization_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Utilization Hours');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `program_phase` SET TAGS ('dbx_business_glossary_term' = 'Program Phase');
ALTER TABLE `mining_ecm`.`laboratory`.`program_equipment_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` SET TAGS ('dbx_association_edges' = 'laboratory.analytical_method,project.feasibility_study');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ALTER COLUMN `study_analytical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Study Analytical Specification ID');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ALTER COLUMN `analytical_method_id` SET TAGS ('dbx_business_glossary_term' = 'Study Analytical Specification - Analytical Method Id');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ALTER COLUMN `feasibility_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Analytical Specification - Feasibility Study Id');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ALTER COLUMN `approved_for_study_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved for Study Flag');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ALTER COLUMN `cost_per_sample` SET TAGS ('dbx_business_glossary_term' = 'Cost per Sample');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ALTER COLUMN `detection_limit_adequacy` SET TAGS ('dbx_business_glossary_term' = 'Detection Limit Adequacy');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ALTER COLUMN `expected_sample_count` SET TAGS ('dbx_business_glossary_term' = 'Expected Sample Count');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ALTER COLUMN `laboratory_provider` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Provider');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ALTER COLUMN `method_selection_rationale` SET TAGS ('dbx_business_glossary_term' = 'Method Selection Rationale');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ALTER COLUMN `primary_analyte_target` SET TAGS ('dbx_business_glossary_term' = 'Primary Analyte Target');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ALTER COLUMN `specification_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Date');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ALTER COLUMN `specification_status` SET TAGS ('dbx_business_glossary_term' = 'Specification Status');
ALTER TABLE `mining_ecm`.`laboratory`.`study_analytical_specification` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time Days');
