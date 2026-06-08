-- Schema for Domain: instrument | Business: Genomics Biotech | Version: v1_ecm
-- Generated on: 2026-05-06 13:04:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`instrument` COMMENT 'Manages the full lifecycle of sequencing instruments, array scanners, PCR/qPCR platforms, liquid handlers, and gene-editing equipment — covering engineering specifications, installation qualification (IQ/OQ/PQ), calibration records, preventive maintenance schedules, performance telemetry, and field service events. Integrates with ServiceNow for field service dispatch and SAP PM for asset accounting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`asset` (
    `asset_id` BIGINT COMMENT 'Unique identifier for the instrument asset record. Primary key for the instrument asset entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Instrument assets are owned by customer accounts. Essential for service delivery, warranty management, billing, regulatory compliance tracking, and customer success programs. Core ownership relationsh',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: IVD instruments require FDA 510(k) or CE mark approval before clinical use. Asset tracking must link to market authorization to enforce regulatory compliance and prevent use of unapproved devices in d',
    `contract_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_contract. Business justification: Service contracts, leasing agreements, and extended warranties are tied to specific instrument serial numbers for entitlement verification, billing, and SLA enforcement. Essential for determining whic',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Instruments are assigned to cost centers for departmental cost allocation, budget management, and financial reporting. Essential for tracking instrument operating costs (consumables, maintenance, labo',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Sequencing instruments and lab equipment are capital assets that must be tracked in the fixed asset register for depreciation, capitalization, and financial reporting. This links operational instrumen',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Instruments are procured from suppliers/manufacturers; tracking the supplier enables warranty claim processing, service escalation to vendor technical support, and supplier performance analysis for in',
    `model_id` BIGINT COMMENT 'FK to instrument.instrument_model',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Sales teams quote specific instruments by serial number in capital equipment deals. Linking asset to opportunity enables tracking which instruments are being proposed, won/lost analysis by asset type,',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Instruments are physically assigned to organizational units (labs, facilities) for asset tracking, compliance audits, space planning, and budget allocation. Essential for GxP facility management and r',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Field service operations require precise physical location for instrument installation, maintenance dispatch, environmental compliance verification, biosafety level validation, and cold chain logistic',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: Sequencers and analytical instruments are physically assigned to manufacturing work centers (library prep stations, QC bays) for capacity planning, scheduling, and operational tracking. Essential for ',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost paid to acquire the instrument, including purchase price, shipping, and installation. Used for fixed asset accounting and depreciation.',
    `acquisition_date` DATE COMMENT 'Date when the instrument was purchased or acquired by Genomics Biotech. Used for depreciation calculation and asset lifecycle tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument asset record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date when the instrument was taken out of service and decommissioned. Nullable for active instruments.',
    `firmware_version` STRING COMMENT 'Current firmware or embedded software version installed on the instrument. Critical for GxP validation and performance consistency.. Valid values are `^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$`',
    `gxp_classification` STRING COMMENT 'Regulatory classification indicating whether the instrument is used for Research Use Only (RUO), In Vitro Diagnostic (IVD), Laboratory Developed Test (LDT), Good Manufacturing Practice (GMP), or non-regulated purposes. Determines qualification and validation requirements.. Valid values are `RUO|IVD|LDT|GMP|Non-GxP`',
    `installation_date` DATE COMMENT 'Date when the instrument was physically installed and made operational at the site location.',
    `instrument_type` STRING COMMENT 'High-level classification of the instrument platform type. Used for operational segmentation and capacity planning. [ENUM-REF-CANDIDATE: NGS Sequencer|Array Scanner|PCR System|qPCR System|Liquid Handler|Gene Editor|Flow Cytometer|Mass Spectrometer — 8 candidates stripped; promote to reference product]',
    `iq_completion_date` DATE COMMENT 'Date when Installation Qualification protocol was successfully completed. Required for GxP-classified instruments.',
    `is_validated` BOOLEAN COMMENT 'Indicates whether the instrument has completed all required IQ/OQ/PQ validation protocols and is qualified for GxP use.',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration event. Critical for maintaining measurement accuracy and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument asset record was last updated.',
    `last_preventive_maintenance_date` DATE COMMENT 'Date of the most recent scheduled preventive maintenance service.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration event. Used for preventive maintenance planning.',
    `next_preventive_maintenance_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance service. Used for service dispatch planning.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special handling instructions, or historical context about the instrument.',
    `operational_status` STRING COMMENT 'Current operational state of the instrument. Determines availability for production runs and service scheduling. [ENUM-REF-CANDIDATE: Active|Idle|Maintenance|Calibration|Quarantine|Decommissioned|Retired — 7 candidates stripped; promote to reference product]',
    `oq_completion_date` DATE COMMENT 'Date when Operational Qualification protocol was successfully completed. Verifies instrument operates according to specifications.',
    `ownership_type` STRING COMMENT 'Indicates whether the instrument is owned by Genomics Biotech, leased, rented, on loan, or owned by a customer but managed by Genomics Biotech.. Valid values are `Owned|Leased|Rental|Loaned|Customer-Owned`',
    `pq_completion_date` DATE COMMENT 'Date when Performance Qualification protocol was successfully completed. Demonstrates consistent performance under routine conditions.',
    `run_time_hours` DECIMAL(18,2) COMMENT 'Typical duration of a single instrument run in hours. Used for scheduling and turnaround time (TAT) estimation.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned unique serial number for the physical instrument unit. Used for warranty tracking, service dispatch, and asset identification.. Valid values are `^[A-Z0-9]{8,20}$`',
    `service_contract_expiry_date` DATE COMMENT 'Date when the current service contract expires. Used for contract renewal planning.',
    `service_contract_number` STRING COMMENT 'Identifier for the active service or maintenance contract covering this instrument. Links to ServiceNow service agreements.. Valid values are `^SC-[0-9]{8,12}$`',
    `software_version` STRING COMMENT 'Version of the instrument control software or operating system. Tracked for validation and regulatory compliance.. Valid values are `^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$`',
    `tag` STRING COMMENT 'Internal asset tracking identifier assigned by Genomics Biotech for fixed asset accounting and physical inventory management. Links to SAP PM asset master.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `throughput_capacity` DECIMAL(18,2) COMMENT 'Maximum throughput capacity of the instrument per run or per day, measured in instrument-specific units (e.g., samples per run, gigabases per run for sequencers). Used for capacity planning.',
    `throughput_unit` STRING COMMENT 'Unit of measure for throughput capacity (e.g., samples/run, Gb/run, reads/run, wells/plate).',
    `total_run_count` STRING COMMENT 'Cumulative number of runs completed on this instrument since installation. Used for utilization tracking and lifecycle analysis.',
    `total_uptime_hours` DECIMAL(18,2) COMMENT 'Cumulative operational uptime in hours since installation. Used for reliability and availability metrics.',
    `validation_expiry_date` DATE COMMENT 'Date when the current validation status expires and requalification is required. Applicable for GxP-classified instruments.',
    `warranty_expiry_date` DATE COMMENT 'Date when the manufacturer warranty coverage ends. Used for service contract planning and budgeting.',
    `warranty_start_date` DATE COMMENT 'Date when the manufacturer warranty coverage begins.',
    CONSTRAINT pk_asset PRIMARY KEY(`asset_id`)
) COMMENT 'Master record for every physical instrument asset owned or managed by Genomics Biotech — sequencing platforms (NGS, WGS), array scanners, PCR/qPCR systems, liquid handlers, and gene-editing equipment. Captures serial number, model, firmware version, asset tag, acquisition date, warranty expiry, GxP classification (RUO/IVD), site location, and current operational status. This is the SSOT for instrument identity and lifecycle within the instrument domain.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`model` (
    `model_id` BIGINT COMMENT 'Unique identifier for the instrument model. Primary key for the instrument model reference catalog.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Instrument models require regulatory clearance (FDA 510k, CE mark) before they can be sold. This links instrument product definitions to their regulatory approval records, enabling compliance tracking',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Instrument models require regulatory submission (510(k), PMA, CE technical file) for market authorization. Links model to submission dossier for traceability of regulatory pathway, predicate devices, ',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Instrument models have validated compatibility matrices for specific reagent chemistries (e.g., NovaSeq→NovaSeq kits). Critical for procurement planning, IQ/OQ/PQ validation protocols, preventing inco',
    `calibration_frequency_days` STRING COMMENT 'Recommended calibration interval in days as specified by the manufacturer. Drives preventive maintenance scheduling and quality control compliance.',
    `ce_mark_certificate` STRING COMMENT 'CE-IVD certificate number for instruments marketed in the European Union under IVDR 2017/746. Required for clinical diagnostic use in EU.',
    `connectivity_requirements` STRING COMMENT 'Network and connectivity specifications (e.g., Ethernet, Wi-Fi, cloud integration, BaseSpace Sequence Hub). Required for IT infrastructure planning and data transfer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument model record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_output_format` STRING COMMENT 'Primary data output file formats generated by the instrument (e.g., FASTQ, BAM, VCF, IDAT). Determines downstream bioinformatics pipeline requirements.',
    `end_of_life_date` DATE COMMENT 'Date when the manufacturer discontinues production and sales of this instrument model. Critical for long-term procurement and replacement planning.',
    `end_of_support_date` DATE COMMENT 'Date when the manufacturer discontinues technical support, software updates, and spare parts availability. Drives instrument lifecycle and replacement decisions.',
    `environmental_requirements` STRING COMMENT 'Operating environment specifications including temperature range, humidity range, and ventilation requirements. Required for facility qualification and instrument performance.',
    `fda_clearance_number` STRING COMMENT 'FDA 510(k) clearance number or PMA (Premarket Approval) number if the instrument is cleared for clinical diagnostic use in the United States.',
    `flow_cell_type` STRING COMMENT 'Compatible flow cell types or cartridge formats (e.g., S1, S2, S4, SP, Standard, High Output). Determines throughput tier and consumable compatibility.',
    `instrument_type` STRING COMMENT 'High-level classification of the instrument platform type. Determines applicable workflows, consumables, and regulatory requirements. [ENUM-REF-CANDIDATE: sequencer|array_scanner|pcr_analyzer|qpcr_analyzer|liquid_handler|gene_editor|fragment_analyzer|electrophoresis_system — 8 candidates stripped; promote to reference product]',
    `launch_date` DATE COMMENT 'Date when the instrument model was first commercially released to the market. Used for product lifecycle tracking and competitive analysis.',
    `list_price_usd` DECIMAL(18,2) COMMENT 'Manufacturer list price in United States Dollars (USD). Used for budgeting, capital expenditure (CAPEX) planning, and return on investment (ROI) analysis.',
    `manufacturer` STRING COMMENT 'Legal name of the company that manufactures this instrument model. Critical for regulatory traceability and warranty management.',
    `max_reads_per_run` BIGINT COMMENT 'Maximum number of sequencing reads generated per instrument run. Used for sample multiplexing calculations and project planning.',
    `max_throughput_gb` DECIMAL(18,2) COMMENT 'Maximum data output per run in gigabases (Gb). Key specification for capacity planning and application suitability (e.g., 6000 Gb for NovaSeq 6000 S4 flow cell).',
    `mean_time_between_failures_hours` DECIMAL(18,2) COMMENT 'Manufacturer-specified mean time between failures (MTBF) in operational hours. Key reliability metric for capacity planning and uptime forecasting.',
    `mean_time_to_repair_hours` DECIMAL(18,2) COMMENT 'Average time required to repair and restore the instrument to operational status. Used for service level agreement (SLA) planning and downtime estimation.',
    `model_description` STRING COMMENT 'Detailed technical and marketing description of the instrument model, including key features, differentiators, and intended use cases.',
    `model_number` STRING COMMENT 'Manufacturer-assigned model number or SKU that uniquely identifies this instrument model in the product catalog. Used for ordering, service, and regulatory submissions.',
    `model_status` STRING COMMENT 'Current lifecycle status of the instrument model in the product catalog. Active models are available for purchase; discontinued models are no longer sold but may still be supported.. Valid values are `active|discontinued|obsolete|pre_release|beta`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument model record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `multiplexing_capacity` STRING COMMENT 'Maximum number of samples that can be pooled and sequenced simultaneously using index barcodes. Enables high-throughput sample processing.',
    `physical_dimensions` STRING COMMENT 'Instrument physical dimensions (length x width x height) in standard units. Required for laboratory space planning and installation.',
    `platform_generation` STRING COMMENT 'Generation or version of the sequencing/analysis platform (e.g., NextSeq 1000/2000, NovaSeq X Series, Illumina DRAGEN). Indicates technology evolution and capability tier.',
    `power_requirements` STRING COMMENT 'Electrical power specifications (voltage, amperage, phase) required for instrument operation. Critical for facility planning and installation qualification (IQ).',
    `preventive_maintenance_schedule` STRING COMMENT 'Manufacturer-recommended preventive maintenance schedule (e.g., quarterly, semi-annual, annual tasks). Ensures instrument reliability and regulatory compliance.',
    `read_length_capability` STRING COMMENT 'Supported read length configurations in base pairs (e.g., 2x150bp, 2x250bp, single-end 75bp). Critical for application compatibility (WGS, WES, RNA-Seq).',
    `run_time_hours` DECIMAL(18,2) COMMENT 'Typical or maximum run time in hours for a standard sequencing or analysis run. Critical for turnaround time (TAT) planning and capacity modeling.',
    `sequencing_chemistry` STRING COMMENT 'Supported sequencing chemistry or detection method (e.g., Sequencing by Synthesis (SBS), Reversible Terminator, Two-Channel SBS). Defines compatible reagent kits and flow cells.',
    `service_contract_available` BOOLEAN COMMENT 'Indicates whether extended service contracts or service level agreements (SLAs) are available for this instrument model. True if available, False otherwise.',
    `software_platform` STRING COMMENT 'Onboard or companion software platform name and version (e.g., Illumina DRAGEN, BaseSpace, Instrument Control Software). Critical for bioinformatics pipeline compatibility.',
    `supported_applications` STRING COMMENT 'Comma-separated list of validated genomic applications (e.g., WGS, WES, RNA-Seq, Targeted Sequencing, Methylation, CNV Detection, SNP Genotyping). Guides customer application selection.',
    `warranty_period_months` STRING COMMENT 'Standard manufacturer warranty period in months from date of installation. Impacts service agreement planning and total cost of ownership.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Instrument weight in kilograms. Required for shipping, handling, and facility floor load calculations.',
    CONSTRAINT pk_model PRIMARY KEY(`model_id`)
) COMMENT 'Reference catalog of instrument model definitions — sequencing platforms, array scanners, PCR/qPCR analyzers, liquid handlers, and CRISPR delivery systems. Stores manufacturer, model number, platform generation, read length capability, throughput specifications, supported chemistries, regulatory clearance class (IVD/RUO), and compatible reagent families. Serves as the template from which individual instrument assets are instantiated.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` (
    `installation_qualification_id` BIGINT COMMENT 'Unique identifier for the installation qualification record. Primary key for the IQ/OQ/PQ lifecycle event.',
    `address_id` BIGINT COMMENT 'Reference to the customer or internal site location where the instrument is installed and qualified.',
    `asset_id` BIGINT COMMENT 'Reference to the sequencing instrument, array scanner, PCR/qPCR platform, liquid handler, or gene-editing equipment asset undergoing qualification.',
    `employee_id` BIGINT COMMENT 'Reference to the field service engineer or validation specialist who executed the qualification protocol.',
    `document_id` BIGINT COMMENT 'Document management system identifier for the qualification protocol, linking to the controlled document repository (e.g., Veeva Vault, MasterControl).',
    `approval_date` DATE COMMENT 'Date on which the qualification results were formally approved by the quality assurance authority.',
    `approved_by_name` STRING COMMENT 'Full name of the quality assurance manager or authorized signatory who approved the qualification results.',
    `cfr_part_11_compliant_flag` BOOLEAN COMMENT 'Boolean indicator confirming whether electronic records and signatures for this qualification meet FDA 21 CFR Part 11 requirements for electronic records in regulated environments.',
    `comments` STRING COMMENT 'Free-text comments or notes from the qualification engineer, quality reviewer, or customer regarding special conditions, observations, or follow-up actions.',
    `completion_date` DATE COMMENT 'Date on which the qualification was finalized, including all documentation, approvals, and closeout activities.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this qualification record, supporting audit trail requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system, supporting audit trail and data lineage requirements.',
    `customer_acceptance_date` DATE COMMENT 'Date on which the customer formally accepted the qualification results and instrument readiness for use.',
    `customer_signature_captured_flag` BOOLEAN COMMENT 'Boolean indicator confirming whether customer acceptance signature was captured as part of the qualification closeout process.',
    `deviation_count` STRING COMMENT 'Number of deviations or non-conformances identified during the qualification execution.',
    `deviation_summary` STRING COMMENT 'Summary description of deviations, non-conformances, or out-of-specification results noted during qualification, including corrective actions taken.',
    `environmental_conditions` STRING COMMENT 'Recorded environmental conditions during qualification execution, including temperature, humidity, and other relevant parameters required for instrument performance validation.',
    `execution_date` DATE COMMENT 'Date on which the qualification protocol was executed and testing performed. Principal business event timestamp for the qualification lifecycle.',
    `gxp_compliant_flag` BOOLEAN COMMENT 'Boolean indicator confirming whether this qualification was performed under GxP-regulated conditions (GMP, GLP, GCP) as required for FDA, EMA, or other regulatory submissions.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this qualification record, supporting audit trail and change control requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last updated, supporting audit trail and change control requirements.',
    `outcome` STRING COMMENT 'Final pass/fail outcome of the qualification event. Conditional pass indicates acceptance with documented deviations or corrective actions.. Valid values are `pass|fail|conditional_pass`',
    `performed_by_engineer_name` STRING COMMENT 'Full name of the field service engineer or validation specialist who executed the qualification protocol.',
    `protocol_version` STRING COMMENT 'Version identifier of the qualification protocol document used for this execution, ensuring traceability to approved procedures.',
    `qualification_number` STRING COMMENT 'Externally-known unique document number or protocol identifier for this IQ/OQ/PQ qualification event, used for traceability and regulatory submission.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification event: scheduled, in progress, passed, failed, conditional pass (with deviations), cancelled, or pending approval. [ENUM-REF-CANDIDATE: scheduled|in_progress|passed|failed|conditional_pass|cancelled|pending_approval — 7 candidates stripped; promote to reference product]',
    `qualification_type` STRING COMMENT 'Type of qualification performed: IQ (Installation Qualification), OQ (Operational Qualification), PQ (Performance Qualification), or combined phases.. Valid values are `IQ|OQ|PQ|IQ/OQ|OQ/PQ|IQ/OQ/PQ`',
    `regulatory_submission_flag` BOOLEAN COMMENT 'Boolean indicator denoting whether this qualification record is required for or has been included in a regulatory submission to FDA, EMA, or other governing bodies.',
    `scheduled_date` DATE COMMENT 'Planned date for the qualification event, used for resource planning and customer coordination.',
    `service_order_number` STRING COMMENT 'ServiceNow or SAP PM service order number associated with the field service dispatch for this qualification event, enabling integration with field service management.',
    `test_case_count` STRING COMMENT 'Total number of test cases or acceptance criteria executed as part of the qualification protocol.',
    `test_case_passed_count` STRING COMMENT 'Number of test cases that met acceptance criteria and passed during qualification execution.',
    CONSTRAINT pk_installation_qualification PRIMARY KEY(`installation_qualification_id`)
) COMMENT 'Records the IQ/OQ/PQ (Installation Qualification, Operational Qualification, Performance Qualification) lifecycle for each instrument asset at a customer or internal site. Captures qualification type (IQ/OQ/PQ), execution date, performed-by engineer, pass/fail outcome, deviations noted, approval signatures, and GxP compliance attestation. Required for FDA 21 CFR Part 11, ISO 13485, and GxP-regulated environments.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` (
    `calibration_record_id` BIGINT COMMENT 'Unique identifier for the calibration record. Primary key. Inferred role: TRANSACTION_HEADER (calibration event with lifecycle, timestamps, and references to instrument asset).',
    `asset_id` BIGINT COMMENT 'Reference to the instrument asset that was calibrated. Links to the instrument master data product.',
    `equipment_qualification_id` BIGINT COMMENT 'Foreign key linking to manufacturing.equipment_qualification. Business justification: Instrument calibrations satisfy equipment qualification requirements in GMP manufacturing. Regulatory auditors require cross-reference between calibration events and qualification protocols to verify ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Calibration activities may be charged to internal orders for project cost tracking, especially when calibrations support specific R&D projects or when costs should be capitalized as part of instrument',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to instrument.maintenance_event. Business justification: Calibration activities are often performed as part of a maintenance event (preventive or corrective). Many calibration records can be part of one maintenance event. This links the calibration executio',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Calibration events use certified reference materials and calibration standards. Tracking which material lot was used is required for ISO 17025 compliance, enables traceability to calibration standard ',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to instrument.pm_schedule. Business justification: Calibration events may be scheduled as part of the preventive maintenance schedule. Many calibration records can reference one pm_schedule. Removing calibration_frequency_days from calibration_record ',
    `employee_id` BIGINT COMMENT 'Reference to the technician or field service engineer who performed the calibration. Links to workforce or employee master data.',
    `research_protocol_id` BIGINT COMMENT 'Reference to the Standard Operating Procedure (SOP) or work instruction used to perform the calibration. Links to the document control system.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration record was approved by quality assurance or supervisory personnel. Part of the quality control workflow.',
    `calibration_certificate_reference` STRING COMMENT 'Reference number or document identifier for the calibration certificate issued after the calibration event. Links to the formal calibration documentation.',
    `calibration_date` DATE COMMENT 'Date when the calibration was performed. Principal business event timestamp for the calibration activity.',
    `calibration_due_date` DATE COMMENT 'Date when the next calibration is due. Used to schedule preventive maintenance and ensure continuous compliance.',
    `calibration_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration activity was completed. Used for turnaround time (TAT) tracking and resource planning.',
    `calibration_event_number` STRING COMMENT 'Business identifier for the calibration event. Externally-known unique number used for traceability and audit purposes.',
    `calibration_location` STRING COMMENT 'Physical location where the calibration was performed (e.g., customer site, service center, manufacturing facility). Important for field service tracking.',
    `calibration_notes` STRING COMMENT 'Free-text notes or observations recorded by the technician during the calibration event. Captures additional context not covered by structured fields.',
    `calibration_procedure_version` STRING COMMENT 'Version number of the calibration procedure used. Ensures traceability to the specific version of the SOP in effect at the time of calibration.',
    `calibration_standard_certificate_number` STRING COMMENT 'Certificate number of the calibration standard used. Provides traceability to the certifying authority.',
    `calibration_standard_expiry_date` DATE COMMENT 'Expiration date of the calibration standard used. Ensures that only valid, in-date standards are used for calibration.',
    `calibration_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the calibration activity started. Used for turnaround time (TAT) tracking and resource planning.',
    `calibration_status` STRING COMMENT 'Current lifecycle status of the calibration event. Tracks the calibration workflow from scheduling through completion and expiration.. Valid values are `scheduled|in_progress|passed|failed|cancelled|expired`',
    `calibration_type` STRING COMMENT 'Type of calibration performed on the instrument. Categorizes the calibration by the system or subsystem being calibrated.. Valid values are `optical|thermal|fluidic|electrical|mechanical|software`',
    `corrective_action_description` STRING COMMENT 'Description of the corrective action taken or required if the calibration failed or showed out-of-tolerance results.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective action is required based on the calibration results. Triggers follow-up activities if calibration failed or showed significant deviation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this calibration record was first created in the system. Audit trail field for data governance.',
    `deviation_from_standard` DECIMAL(18,2) COMMENT 'Calculated deviation of the measured value from the calibration standard. Used for trend analysis and predictive maintenance.',
    `environmental_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage at the time of calibration. Environmental conditions can affect calibration accuracy.',
    `environmental_temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature in degrees Celsius at the time of calibration. Environmental conditions can affect calibration accuracy.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this calibration record is currently active. Used for soft deletes and historical record management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this calibration record was last updated. Audit trail field for data governance and change tracking.',
    `measured_value` DECIMAL(18,2) COMMENT 'Actual value measured during the calibration event. Compared against tolerance limits to determine pass/fail status.',
    `pass_fail_result` STRING COMMENT 'Outcome of the calibration event. Indicates whether the instrument met the calibration tolerance requirements.. Valid values are `pass|fail|conditional_pass`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the calibration event meets all applicable regulatory compliance requirements (CLIA, CAP, ISO 15189, ISO 13485).',
    `service_order_number` STRING COMMENT 'Reference to the field service order or work order under which the calibration was performed. Links to ServiceNow or SAP PM.',
    `source_system` STRING COMMENT 'Identifier of the source system from which this calibration record originated (e.g., ServiceNow, SAP PM, LabVantage LIMS). Used for data lineage and integration tracking.',
    `technician_certification_number` STRING COMMENT 'Certification or qualification number of the technician who performed the calibration. Ensures that only qualified personnel perform calibration activities.',
    `technician_name` STRING COMMENT 'Full name of the technician who performed the calibration. Captured for audit trail and traceability purposes.',
    `tolerance_lower_limit` DECIMAL(18,2) COMMENT 'Lower acceptable limit for the calibration measurement. Defines the minimum acceptable value for the calibrated parameter.',
    `tolerance_upper_limit` DECIMAL(18,2) COMMENT 'Upper acceptable limit for the calibration measurement. Defines the maximum acceptable value for the calibrated parameter.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the calibration parameter (e.g., degrees Celsius, microliters, nanometers, volts). Ensures consistent interpretation of measured values and tolerance limits.',
    CONSTRAINT pk_calibration_record PRIMARY KEY(`calibration_record_id`)
) COMMENT 'Tracks all calibration events performed on instrument assets — optical, thermal, fluidic, and electrical calibration. Stores calibration date, due date, calibration standard used, tolerance limits, measured values, pass/fail status, calibration certificate reference, and technician ID. Supports CLIA, CAP, ISO 15189, and ISO 13485 compliance requirements for instrument traceability.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record.',
    `asset_id` BIGINT COMMENT 'Reference to a specific instrument asset if this PM schedule applies to an individual unit rather than a model. Nullable for model-level schedules.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PM schedules drive recurring maintenance costs that must be allocated to responsible cost centers for budgeting, variance analysis, and departmental P&L. Replaces denormalized cost_center_code with pr',
    `maintenance_plan_id` BIGINT COMMENT 'Reference to the SAP PM maintenance plan identifier that governs this schedule. Used for integration with SAP PM module.',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: PM schedules specify required consumables (calibration standards, cleaning reagents, replacement filters). Linking to material master enables automated parts reservation in MRP, inventory availability',
    `model_id` BIGINT COMMENT 'Reference to the instrument model for which this PM schedule is defined. Links to the instrument model master data.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: PM schedules are owned and managed by specific organizational units responsible for maintenance execution, resource allocation, and budget tracking. Critical for maintenance planning, cost center allo',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Preventive maintenance schedules are governed by service agreement terms (SLA tiers, included PM visits, frequency). Links maintenance planning to contractual obligations, enables SLA compliance track',
    `document_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_document. Business justification: Preventive maintenance SOPs are controlled regulatory documents required for quality system compliance. Links PM schedule to approved procedure for version control and audit trail. Removes denormalize',
    `applicable_instrument_types` STRING COMMENT 'Comma-separated list of instrument types or categories to which this PM schedule applies (e.g., NGS Sequencer, Array Scanner, qPCR Platform, Liquid Handler).',
    `approved_by` STRING COMMENT 'Username or identifier of the quality or engineering manager who approved this PM schedule for activation. Required for regulatory compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this PM schedule was formally approved and authorized for use. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `auto_generate_work_order_flag` BOOLEAN COMMENT 'Indicates whether work orders should be automatically generated based on this PM schedule. True enables automated work order creation via ServiceNow integration.',
    `change_control_number` STRING COMMENT 'Reference to the formal change control request or engineering change order (ECO) that authorized the creation or modification of this PM schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this PM schedule record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `criticality_level` STRING COMMENT 'Business criticality of this preventive maintenance task based on impact to instrument performance, regulatory compliance, and operational continuity (low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `effective_end_date` DATE COMMENT 'Date on which this preventive maintenance schedule expires or is superseded. Nullable for open-ended schedules. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'Date from which this preventive maintenance schedule becomes active and begins generating work orders. Format: yyyy-MM-dd.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost to perform this preventive maintenance task, including labor, parts, and consumables, expressed in USD. Used for budgeting and cost center allocation.',
    `estimated_duration_minutes` STRING COMMENT 'Expected time required to complete this preventive maintenance task, expressed in minutes. Used for field service resource planning and scheduling.',
    `frequency_interval_days` STRING COMMENT 'Numeric representation of the maintenance frequency expressed in days (e.g., 1 for daily, 7 for weekly, 90 for quarterly, 365 for annual). Used for automated work order scheduling.',
    `grace_period_days` STRING COMMENT 'Number of days after the scheduled maintenance date during which the task can still be completed without being considered overdue. Provides scheduling flexibility.',
    `last_completed_date` DATE COMMENT 'Date when this preventive maintenance task was last successfully completed. Used to calculate next scheduled date. Format: yyyy-MM-dd.',
    `lead_time_days` STRING COMMENT 'Number of days in advance that a PM work order should be generated before the scheduled maintenance date. Used for planning and parts procurement.',
    `maintenance_frequency` STRING COMMENT 'Frequency at which this preventive maintenance task must be performed (daily, weekly, biweekly, monthly, quarterly, semiannual, annual, biennial). [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|semiannual|annual|biennial — 8 candidates stripped; promote to reference product]',
    `maintenance_task_type` STRING COMMENT 'Category of preventive maintenance task to be performed (calibration, inspection, cleaning, lubrication, alignment, replacement, software update, performance verification). [ENUM-REF-CANDIDATE: calibration|inspection|cleaning|lubrication|alignment|replacement|software_update|performance_verification — 8 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this PM schedule record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this PM schedule record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `next_scheduled_date` DATE COMMENT 'Calculated date for the next occurrence of this preventive maintenance task. Updated after each completed maintenance event. Format: yyyy-MM-dd.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special considerations, safety warnings, or contextual information relevant to this preventive maintenance schedule.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this preventive maintenance task is mandated by regulatory requirements (FDA, CLIA, CAP, ISO 13485) or is a best-practice recommendation. True if regulatory-mandated.',
    `required_certifications` STRING COMMENT 'Comma-separated list of certifications or training qualifications required for personnel performing this maintenance task (e.g., Illumina Certified Engineer, Laser Safety Level 2).',
    `required_skill_level` STRING COMMENT 'Minimum skill or certification level required for field service engineers to perform this maintenance task (basic, intermediate, advanced, specialist, certified engineer).. Valid values are `basic|intermediate|advanced|specialist|certified_engineer`',
    `schedule_code` STRING COMMENT 'Unique business identifier or code for this PM schedule used in work order generation and ServiceNow integration (e.g., PM-SEQ-Q1, PM-PCR-A1).',
    `schedule_name` STRING COMMENT 'Human-readable name or title for this preventive maintenance schedule (e.g., Quarterly Flow Cell Calibration, Annual Laser Alignment).',
    `schedule_status` STRING COMMENT 'Current lifecycle status of this preventive maintenance schedule (active, inactive, suspended, under review, obsolete). Only active schedules generate work orders.. Valid values are `active|inactive|suspended|under_review|obsolete`',
    `servicenow_schedule_reference` STRING COMMENT 'External identifier for this PM schedule in the ServiceNow field service management system. Used for bi-directional integration and work order dispatch.',
    `version_number` STRING COMMENT 'Version identifier for this PM schedule. Incremented when schedule parameters are modified. Supports change control and audit requirements.',
    `work_order_template_code` STRING COMMENT 'Reference to the ServiceNow work order template used for automated PM work order generation based on this schedule.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this PM schedule record. Used for audit trail and accountability.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Defines the preventive maintenance (PM) schedule for each instrument model or individual asset — specifying maintenance task type, frequency (daily, weekly, quarterly, annual), estimated duration, required parts/consumables, and applicable SOP reference. Drives automated PM work order generation and field service dispatch via ServiceNow integration. Supports SAP PM maintenance plans.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` (
    `maintenance_event_id` BIGINT COMMENT 'Unique identifier for the maintenance event record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Maintenance events need direct customer account link for billing out-of-contract service, warranty claim processing, customer communication, and service history reporting when service_agreement_id is ',
    `experiment_id` BIGINT COMMENT 'Foreign key linking to research.experiment. Business justification: Unplanned maintenance impacts in-progress experiments. Business process: sample/run impact assessment, deviation documentation, and determining if experiments must be repeated. Critical for quality an',
    `asset_id` BIGINT COMMENT 'Reference to the instrument asset on which maintenance was performed.',
    `capa_id` BIGINT COMMENT 'Reference to the CAPA record if this maintenance event triggered or is part of a formal corrective and preventive action investigation.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_order. Business justification: Instrument downtime impacts production schedules. Operations teams need to track which work orders were delayed or affected by maintenance events for root cause analysis, capacity planning, and custom',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Maintenance work on GxP instruments is often charged to internal orders for cost tracking, capitalization decisions (asset improvements vs. expense), and project accounting in regulated biotech enviro',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Maintenance events consume specific materials (replacement parts, consumables, calibration standards). Tracking material usage per event enables accurate cost accounting, triggers inventory replenishm',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to instrument.pm_schedule. Business justification: Preventive maintenance events are executed instances of a PM schedule. Many maintenance events can be generated from one pm_schedule definition. This links the schedule template to its execution recor',
    `employee_id` BIGINT COMMENT 'Reference to the primary field service technician or engineer who performed the maintenance.',
    `service_agreement_id` BIGINT COMMENT 'Reference to the active service agreement or maintenance contract covering this instrument.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Field service events often involve supplier-provided technical support, warranty repairs, or factory-trained engineers. Tracking which supplier performed service is critical for warranty claim validat',
    `batch_test_id` BIGINT COMMENT 'Reference to the post-maintenance verification test or qualification run performed to validate instrument performance.',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when maintenance work was completed.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when maintenance work began.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the maintenance event is billable to the customer or covered under service agreement.',
    `created_datetime` TIMESTAMP COMMENT 'Timestamp when the maintenance event record was first created in the system.',
    `customer_signoff_datetime` TIMESTAMP COMMENT 'Date and time when the customer or authorized site representative signed off on the completed maintenance work.',
    `customer_signoff_name` STRING COMMENT 'Name of the customer representative who signed off on the maintenance completion.',
    `customer_signoff_required` BOOLEAN COMMENT 'Indicates whether customer or site manager sign-off is required for this maintenance event per service agreement terms.',
    `downtime_duration_minutes` DECIMAL(18,2) COMMENT 'Total instrument downtime in minutes during which the instrument was unavailable for production use.',
    `event_type` STRING COMMENT 'Classification of the maintenance activity: preventive (scheduled), corrective (repair), emergency (unplanned critical), calibration, qualification (IQ/OQ/PQ), or upgrade.. Valid values are `preventive|corrective|emergency|calibration|qualification|upgrade`',
    `follow_up_actions` STRING COMMENT 'Description of recommended or required follow-up actions, including monitoring plans, part orders, or future service visits.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional follow-up actions, monitoring, or future maintenance is required.',
    `impact_assessment` STRING COMMENT 'Business impact assessment of the maintenance event on operations, customer commitments, and data quality.. Valid values are `no_impact|minor|moderate|major|critical`',
    `labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours spent on the maintenance activity, including diagnostics, repair, and verification.',
    `last_modified_datetime` TIMESTAMP COMMENT 'Timestamp when the maintenance event record was last updated.',
    `maintenance_event_status` STRING COMMENT 'Current lifecycle status of the maintenance event.. Valid values are `scheduled|in_progress|completed|cancelled|on_hold|verification_pending`',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or special instructions related to the maintenance event.',
    `priority` STRING COMMENT 'Business priority assigned to the maintenance event based on impact to operations and customer commitments.. Valid values are `critical|high|medium|low`',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this maintenance event must be reported to regulatory authorities (FDA, EMA) due to patient safety or device malfunction implications.',
    `resolution_summary` STRING COMMENT 'Summary of corrective actions taken, parts replaced, adjustments made, and resolution steps performed.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause identified during corrective or emergency maintenance. [ENUM-REF-CANDIDATE: wear_and_tear|operator_error|design_defect|environmental|software|calibration_drift|contamination|power_issue|unknown — 9 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause analysis findings and failure mode.',
    `runs_affected_count` STRING COMMENT 'Number of sequencing runs or assay runs impacted by the instrument issue that triggered this maintenance event.',
    `samples_impacted_count` STRING COMMENT 'Number of biological samples affected by the instrument failure or maintenance downtime.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'Planned start date and time for the maintenance activity.',
    `sla_actual_response_hours` DECIMAL(18,2) COMMENT 'Actual response time in hours from event trigger to technician arrival or remote engagement.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the maintenance event met the contractual SLA response and resolution time commitments.',
    `sla_target_response_hours` DECIMAL(18,2) COMMENT 'Target response time in hours per the service level agreement for this maintenance event priority level.',
    `trigger_source` STRING COMMENT 'What initiated the maintenance event: scheduled preventive maintenance, instrument alarm, operator report, performance degradation detected, quality event, or regulatory inspection finding.. Valid values are `scheduled|alarm|operator_report|performance_degradation|quality_event|regulatory_inspection`',
    `verification_status` STRING COMMENT 'Status of post-maintenance verification testing to confirm instrument performance meets specifications.. Valid values are `not_required|pending|passed|failed|conditional_pass`',
    `warranty_coverage_flag` BOOLEAN COMMENT 'Indicates whether the maintenance event and parts are covered under manufacturer or extended warranty.',
    `work_order_number` STRING COMMENT 'External work order number from ServiceNow field service management system or SAP PM notification.',
    CONSTRAINT pk_maintenance_event PRIMARY KEY(`maintenance_event_id`)
) COMMENT 'Captures every executed maintenance activity on an instrument asset — preventive, corrective, and emergency maintenance — along with associated parts consumption, downtime impact, and post-maintenance verification. Records event type, trigger (scheduled/unscheduled), start and end datetime, downtime duration, technician, parts replaced (part number, quantity, lot, unit cost), labor hours, root cause category, impact assessment (runs affected, samples impacted), resolution notes, customer sign-off, follow-up actions, and post-maintenance verification status. Integrates with ServiceNow field service work orders and SAP PM notifications. Supports SLA compliance tracking, uptime KPI reporting, and parts consumption analytics.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` (
    `field_service_request_id` BIGINT COMMENT 'Unique identifier for the field service request. Primary key for this entity.',
    `address_id` BIGINT COMMENT 'Reference to the specific customer site or facility where the field service will be performed. May be customer location or internal lab.',
    `asset_id` BIGINT COMMENT 'Reference to the specific instrument asset requiring service. Links to instrument master data tracking serial number, model, and installation details.',
    `account_id` BIGINT COMMENT 'Reference to the customer account requesting the field service. Links to customer master data in Salesforce CRM and SAP SD.',
    `employee_id` BIGINT COMMENT 'Reference to the field service engineer assigned to perform the service. Links to workforce management system for skills, availability, and territory.',
    `field_application_activity_id` BIGINT COMMENT 'Foreign key linking to commercial.field_application_activity. Business justification: Field application scientists often coordinate with field service engineers during customer site visits for protocol optimization, training, or troubleshooting. Linking FSR to FAS activity enables trac',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Field service requests may be charged to internal orders for project-specific work, R&D cost tracking, or when service costs should be capitalized as asset improvements rather than expensed.',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to instrument.maintenance_event. Business justification: Field service requests result in maintenance events being executed. One FSR typically results in one maintenance_event record that captures the actual work performed. This links the service request (i',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Service requests often identify materials needed for repair (replacement modules, consumables). Linking to material enables parts reservation before technician dispatch, inventory availability checks ',
    `service_contract_id` BIGINT COMMENT 'Foreign key linking to instrument.service_contract. Business justification: Field service requests are often covered under service contracts that define SLA terms, coverage scope, and entitlements. Many FSRs can reference one service contract. Removing SLA columns from FSR as',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Service requests need primary site contact for coordination, facility access, safety protocols, and service sign-off. Different from account-level contacts. Essential for field service execution and c',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual total cost in USD incurred for this field service request, including labor, travel, and parts. Used for financial reporting and profitability analysis.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Actual on-site service duration in hours from start to completion, used for labor cost calculation and future estimation refinement.',
    `actual_end_time` TIMESTAMP COMMENT 'Actual timestamp when the field service work was completed on-site, used for SLA compliance and labor cost calculation.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual timestamp when the field service engineer began work on-site, used for SLA tracking and billing.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this field service request is billable to the customer. True for out-of-warranty or non-contract services; false for warranty or contract-covered services.',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation if the field service request was cancelled, such as customer request, duplicate request, or issue resolved remotely.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the field service request was cancelled, if applicable. Null for non-cancelled requests.',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the field service request was marked as completed and closed, indicating successful resolution and customer acceptance.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this field service request record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial amounts associated with this request. Typically USD but may vary by customer location.. Valid values are `^[A-Z]{3}$`',
    `customer_feedback` STRING COMMENT 'Free-text customer feedback comments provided after service completion, used for quality improvement and FSE performance evaluation.',
    `customer_satisfaction_score` STRING COMMENT 'Post-service customer satisfaction rating on a scale of 1 to 5, where 5 is highly satisfied. Collected via automated survey after service completion.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost in USD for this field service request, including labor, travel, and parts. Used for budgeting and customer quotation.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated on-site service duration in hours, based on request type and historical data, used for scheduling and resource allocation.',
    `field_service_request_status` STRING COMMENT 'Current lifecycle status of the field service request. Tracks progression from draft through assignment, scheduling, execution, and closure. [ENUM-REF-CANDIDATE: draft|submitted|assigned|scheduled|in_progress|on_hold|completed|cancelled — 8 candidates stripped; promote to reference product]',
    `invoice_amount_usd` DECIMAL(18,2) COMMENT 'Total amount in USD invoiced to the customer for this billable field service request, including labor, travel, parts, and applicable taxes.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this field service request record was last modified, used for audit trail and data synchronization.',
    `parts_required_flag` BOOLEAN COMMENT 'Indicates whether replacement parts or consumables are required for this field service request. True if parts needed; false otherwise.',
    `priority` STRING COMMENT 'Business priority of the field service request. Critical indicates instrument down impacting production; high indicates degraded performance; medium for scheduled work; low for non-urgent requests.. Valid values are `critical|high|medium|low`',
    `problem_description` STRING COMMENT 'Detailed description of the issue, symptom, or service requirement as reported by the customer or internal requester. Includes error codes, performance degradation details, or installation specifications.',
    `request_date` TIMESTAMP COMMENT 'Date and time when the field service request was originally created or submitted by the customer or internal requester.',
    `request_number` STRING COMMENT 'Externally visible unique business identifier for the field service request, typically generated by ServiceNow ITSM in format FSR-NNNNNNNN.. Valid values are `^FSR-[0-9]{8}$`',
    `request_type` STRING COMMENT 'Type of field service request: breakdown (emergency repair), installation (new instrument setup including IQ/OQ/PQ), upgrade (hardware or software enhancement), preventive_maintenance (scheduled PM), application_support (customer training or troubleshooting), or calibration (instrument calibration service).. Valid values are `breakdown|installation|upgrade|preventive_maintenance|application_support|calibration`',
    `resolution_summary` STRING COMMENT 'Summary of actions taken by the field service engineer to resolve the issue, including parts replaced, calibrations performed, software updates applied, or training delivered.',
    `root_cause_category` STRING COMMENT 'Categorization of the underlying root cause identified during service resolution, used for quality analysis and product improvement feedback.. Valid values are `hardware_failure|software_defect|user_error|environmental|consumable_depletion|calibration_drift`',
    `scheduled_end_time` TIMESTAMP COMMENT 'Planned completion timestamp for the field service visit, used for resource planning and customer communication.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise scheduled start timestamp for the field service visit, including time zone information for accurate coordination.',
    `scheduled_visit_date` DATE COMMENT 'Planned date for the field service engineer to visit the customer or internal site to perform the requested service.',
    `service_order_number` STRING COMMENT 'SAP SD service order number linked to this field service request for billing, parts tracking, and financial integration.',
    `sla_compliance_status` STRING COMMENT 'Current compliance status against SLA commitments. Met indicates within target; at_risk indicates approaching deadline; breached indicates SLA violation; not_applicable for requests without SLA.. Valid values are `met|at_risk|breached|not_applicable`',
    `special_instructions` STRING COMMENT 'Special instructions or requirements for the field service visit, such as site access procedures, safety protocols, customer contact preferences, or specific tools required.',
    `travel_distance_km` DECIMAL(18,2) COMMENT 'Estimated or actual travel distance in kilometers from the field service engineer base location to the customer site, used for logistics planning and expense calculation.',
    `travel_required_flag` BOOLEAN COMMENT 'Indicates whether the field service engineer must travel to perform this service. True for on-site visits; false for remote support or internal lab work.',
    CONSTRAINT pk_field_service_request PRIMARY KEY(`field_service_request_id`)
) COMMENT 'Manages field service dispatch requests for instrument assets at customer or internal sites — covering breakdown calls, installation requests, upgrade visits, and application support. Stores request type, priority, SLA tier, customer site, assigned field service engineer (FSE), scheduled visit date, travel details, and resolution status. Sourced from ServiceNow ITSM and linked to SAP SD service orders.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` (
    `performance_telemetry_id` BIGINT COMMENT 'Unique identifier for the performance telemetry record. Primary key for time-series instrument performance data.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Remote monitoring telemetry requires customer account link for proactive service programs, usage analytics, customer success dashboards, and predictive maintenance. Enables account-level performance r',
    `asset_id` BIGINT COMMENT 'Reference to the instrument asset that generated this telemetry event. Links to the instrument master data for sequencing platforms, array scanners, PCR/qPCR systems, liquid handlers, and gene-editing equipment.',
    `employee_id` BIGINT COMMENT 'Identifier of the laboratory technician or operator who initiated the run or maintenance activity. Supports operator-specific performance analysis and training needs assessment. Anonymized for privacy.',
    `experiment_id` BIGINT COMMENT 'Foreign key linking to research.experiment. Business justification: Telemetry metrics (Q30, cluster density, error rates) are reviewed against experimental context for QC decisions. Critical for correlating instrument performance with experiment success/failure and tr',
    `flow_cell_id` BIGINT COMMENT 'Unique identifier of the flow cell consumable used in the sequencing run. Tracks flow cell-specific performance and enables warranty claims for defective consumables. Nullable for non-sequencing instruments.',
    `gene_model_id` BIGINT COMMENT 'Foreign key linking to reference.gene_model. Business justification: Telemetry systems track per-gene coverage metrics, uniformity, and quality scores for targeted panels and exome sequencing. Enables gene-level performance monitoring and detection of coverage dropouts',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Telemetry metrics like alignment rates, coverage uniformity, and error rates are genome-build-dependent. Quality monitoring systems compare telemetry against reference-specific benchmarks. Essential f',
    `genomic_region_id` BIGINT COMMENT 'Foreign key linking to reference.genomic_region. Business justification: Telemetry captures region-specific metrics like on-target rate, uniformity across capture regions, and per-region coverage depth. Essential for monitoring targeted panel performance, detecting capture',
    `instrument_run_id` BIGINT COMMENT 'Identifier of the sequencing run, PCR run, or array scan session associated with this telemetry event. Nullable for system health metrics not tied to a specific analytical run.',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Instrument performance metrics collected during manufacturing QC operations must link to production batches for data integrity audits. FDA 21 CFR Part 11 requires complete audit trail of analytical in',
    `quality_assessment_id` BIGINT COMMENT 'Foreign key linking to data.quality_assessment. Business justification: Telemetry metrics (Q30, signal intensity, error rates) are assessed against quality thresholds in real-time. Links telemetry data points to formal quality assessment records. Enables automated QC work',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Quality investigations routinely correlate instrument performance degradation (Q30 scores, error rates, cluster density) with specific reagent lots. Enables root cause analysis for run failures, suppo',
    `maintenance_event_id` BIGINT COMMENT 'Reference to the field service event or maintenance activity associated with this telemetry record. Links to ServiceNow service tickets for post-service performance validation. Nullable for routine operational telemetry.',
    `anomaly_detection_score` DECIMAL(18,2) COMMENT 'Machine learning-derived anomaly score indicating deviation from expected instrument behavior. Range 0.0000 to 1.0000, where higher values indicate greater anomaly likelihood. Enables predictive maintenance.',
    `calibration_date` DATE COMMENT 'Date of the most recent instrument calibration affecting this metric. Enables correlation of performance drift with calibration intervals. Format: yyyy-MM-dd. Nullable if calibration not applicable.',
    `cluster_density` DECIMAL(18,2) COMMENT 'Number of DNA clusters per square millimeter on the flow cell surface. Critical sequencing quality metric; optimal range varies by platform. Measured in clusters/mm². Nullable for non-sequencing instruments.',
    `coverage_depth` DECIMAL(18,2) COMMENT 'Average number of reads covering each genomic position. Measured as X coverage (e.g., 30X). Critical for variant calling confidence. Nullable for non-sequencing instruments.',
    `cycle_count_cumulative` BIGINT COMMENT 'Total number of sequencing cycles, PCR cycles, or operational cycles completed by the instrument. High-precision counter for component wear prediction and preventive maintenance.',
    `cycle_number` STRING COMMENT 'Sequencing cycle, PCR cycle, or scan pass number when the metric was captured. Enables per-cycle performance trending and quality degradation analysis. Nullable for run-level or system-level metrics.',
    `data_quality_flag` STRING COMMENT 'Assessment of telemetry data quality and reliability. Flags sensor malfunctions, calibration drift, or communication errors that may compromise data integrity.. Valid values are `valid|suspect|invalid|calibration_required|sensor_fault`',
    `error_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of incorrect base calls or measurement errors. Calculated from PhiX control spike-in or known reference. Lower values indicate better performance. Nullable for non-sequencing instruments.',
    `facility_code` STRING COMMENT 'Code identifying the laboratory, manufacturing site, or customer facility where the instrument is installed. Enables multi-site performance comparison and regional trend analysis.',
    `firmware_version` STRING COMMENT 'Instrument firmware or software version active when the telemetry was captured. Critical for correlating performance changes with software updates and supporting root cause analysis.',
    `flow_rate_ml_per_min` DECIMAL(18,2) COMMENT 'Reagent or buffer flow rate in milliliters per minute. Ensures proper reagent delivery timing and volume. Deviations indicate pump wear or fluidics issues. Nullable for instruments without fluidics.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Timestamp when the telemetry record was ingested into the Databricks Lakehouse. Distinct from telemetry_timestamp; used for data pipeline monitoring and latency analysis. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lane_number` STRING COMMENT 'Flow cell lane number for sequencing instruments or array section identifier. Enables lane-specific performance comparison and troubleshooting. Nullable for non-lane-based instruments.',
    `laser_power_watts` DECIMAL(18,2) COMMENT 'Optical laser power output in watts. Critical for imaging-based sequencers and array scanners. Degradation over time indicates laser aging and need for replacement. Nullable for non-optical instruments.',
    `metric_name` STRING COMMENT 'Specific name of the performance metric being measured. Examples include cluster_density, q30_score, phred_score, coverage_depth, error_rate, temperature, pressure, flow_rate, laser_power, run_count, cycle_count, reagent_consumption.',
    `metric_type` STRING COMMENT 'Classification of the telemetry metric being captured. Discriminates between sequencing performance data, PCR curves, array intensities, system health parameters, and operational usage counters.. Valid values are `sequencing_run_metric|pcr_amplification_curve|array_scan_intensity|system_health_indicator|operational_counter|calibration_metric`',
    `metric_value` DECIMAL(18,2) COMMENT 'Numeric value of the telemetry measurement. Precision supports high-resolution sensor data and calculated performance indicators. Interpretation depends on metric_name and unit_of_measure.',
    `phred_score_mean` DECIMAL(18,2) COMMENT 'Average Phred quality score across all base calls in the measurement window. Logarithmic scale representing base call accuracy. Nullable for non-sequencing instruments.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'Fluidics system pressure in pounds per square inch. Monitors pump performance and detects blockages or leaks in liquid handling systems. Nullable for instruments without fluidics.',
    `q30_score_percent` DECIMAL(18,2) COMMENT 'Percentage of bases with Phred quality score of 30 or higher (99.9% base call accuracy). Industry-standard sequencing quality metric. Nullable for non-sequencing instruments.',
    `read_number` STRING COMMENT 'Read identifier for paired-end or multi-read sequencing protocols (e.g., Read 1, Read 2, Index Read). Nullable for single-read runs or non-sequencing instruments.',
    `reagent_volume_consumed_ml` DECIMAL(18,2) COMMENT 'Volume of reagent consumed during the measurement period in milliliters. Tracks reagent usage for inventory management and cost accounting. Cumulative or per-run depending on metric granularity.',
    `retention_policy_class` STRING COMMENT 'Data retention classification determining how long this telemetry record is stored in the lakehouse. Varies by metric type: operational counters may be archived longer than per-cycle metrics.. Valid values are `short_term|medium_term|long_term|regulatory_archive`',
    `run_count_cumulative` STRING COMMENT 'Total number of analytical runs completed by the instrument since installation or last counter reset. Operational counter for predictive maintenance scheduling and warranty tracking.',
    `signal_intensity_mean` DECIMAL(18,2) COMMENT 'Average fluorescence or optical signal intensity. Used for array scanners and imaging-based sequencers. Higher values indicate better signal-to-noise ratio. Arbitrary units specific to instrument platform.',
    `signal_to_noise_ratio` DECIMAL(18,2) COMMENT 'Ratio of signal intensity to background noise. Higher values indicate cleaner data and better instrument performance. Dimensionless ratio. Nullable for non-imaging instruments.',
    `source_system` STRING COMMENT 'Name of the source system or instrument control software that generated the telemetry stream. Examples: Illumina BaseSpace, instrument embedded controller, ServiceNow IoT connector. Supports multi-source data lineage.',
    `telemetry_timestamp` TIMESTAMP COMMENT 'Precise date and time when the telemetry data point was captured by the instrument. Represents the real-world event time of the measurement or observation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Instrument operating temperature in degrees Celsius. Critical system health indicator for thermal cyclers, flow cells, and reagent storage compartments. Out-of-range values trigger maintenance alerts.',
    `threshold_lower_limit` DECIMAL(18,2) COMMENT 'Lower acceptable boundary for the metric value. Values below this threshold trigger quality alerts or instrument service notifications. Defined per metric type and instrument model.',
    `threshold_upper_limit` DECIMAL(18,2) COMMENT 'Upper acceptable boundary for the metric value. Values above this threshold trigger quality alerts or instrument service notifications. Defined per metric type and instrument model.',
    `threshold_violation_flag` BOOLEAN COMMENT 'Indicates whether the metric value falls outside acceptable thresholds. True when metric_value is below threshold_lower_limit or above threshold_upper_limit. Drives automated alerting and service dispatch.',
    `tile_number` STRING COMMENT 'Imaging tile or spatial region identifier within a lane or array. Supports spatial performance analysis and detection of localized instrument issues. Nullable for non-imaging instruments.',
    `unit_of_measure` STRING COMMENT 'Unit of measurement for the metric value. Examples: percent, clusters_per_mm2, phred_score, x_coverage, celsius, psi, ml_per_min, watts, count, cycles. Essential for correct interpretation and trending.',
    CONSTRAINT pk_performance_telemetry PRIMARY KEY(`performance_telemetry_id`)
) COMMENT 'Stores time-series performance telemetry streamed from connected instrument assets — including sequencing run metrics (cluster density, Q30 score, Phred score, coverage depth, error rate), PCR amplification curves, array scan intensities, system health indicators (temperature, pressure, flow rate, laser power), and operational counters (run count, cycle count, reagent consumption). Granularity ranges from per-cycle to per-run depending on metric type. Enables predictive maintenance modeling, remote diagnostics, instrument performance trending, anomaly detection, and proactive field service dispatch. Landed in Databricks Lakehouse with configurable retention policies per metric class.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` (
    `firmware_deployment_id` BIGINT COMMENT 'Unique identifier for the firmware deployment event. Primary key for the firmware deployment data product.',
    `asset_id` BIGINT COMMENT 'Reference to the target instrument asset receiving the firmware deployment.',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: GxP-regulated firmware deployments require formal change control for regulatory compliance, impact assessment, and audit trails. Essential for validated systems in clinical genomics labs and diagnosti',
    `firmware_version_id` BIGINT COMMENT 'Reference to the specific firmware version being deployed from the approved version catalog.',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to instrument.maintenance_event. Business justification: Firmware deployments are often performed as part of a broader maintenance event. Many firmware deployments can be part of one maintenance event (e.g., updating multiple instruments during a site visit',
    `employee_id` BIGINT COMMENT 'Reference to the field service technician or engineer who executed the firmware deployment.',
    `tertiary_firmware_scheduled_by_user_employee_id` BIGINT COMMENT 'Reference to the user who scheduled this firmware deployment event.',
    `approval_status` STRING COMMENT 'Status of management or quality assurance approval for this firmware deployment.. Valid values are `pending|approved|rejected|conditional`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the firmware deployment was formally approved.',
    `backup_created_flag` BOOLEAN COMMENT 'Indicates whether a backup of the previous firmware and instrument configuration was created before deployment.',
    `backup_location` STRING COMMENT 'Storage location or path where the pre-deployment backup was saved.',
    `calibration_completion_date` DATE COMMENT 'Date when post-deployment calibration was completed and verified.',
    `calibration_required_flag` BOOLEAN COMMENT 'Indicates whether instrument recalibration is required following this firmware deployment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this firmware deployment record was first created in the system.',
    `customer_approval_received_date` DATE COMMENT 'Date when customer approval was received for the firmware deployment.',
    `customer_approval_required_flag` BOOLEAN COMMENT 'Indicates whether customer approval was required before executing this firmware deployment.',
    `customer_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the customer was notified about the scheduled firmware deployment and any associated downtime.',
    `deployment_date` DATE COMMENT 'The date when the firmware deployment was executed or scheduled.',
    `deployment_duration_minutes` STRING COMMENT 'Total time in minutes taken to complete the firmware deployment process.',
    `deployment_end_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the firmware deployment process completed or failed.',
    `deployment_location` STRING COMMENT 'Physical or logical location where the firmware deployment was executed.. Valid values are `onsite|remote|depot|lab`',
    `deployment_method` STRING COMMENT 'The technical method used to deploy the firmware to the target instrument.. Valid values are `remote_ota|onsite_manual|usb_transfer|network_push|service_portal`',
    `deployment_notes` STRING COMMENT 'Free-text notes and observations recorded by the technician during the firmware deployment process.',
    `deployment_number` STRING COMMENT 'Business identifier for the firmware deployment event, used for tracking and audit purposes.. Valid values are `^FWD-[0-9]{8}-[A-Z0-9]{6}$`',
    `deployment_package_checksum` STRING COMMENT 'Cryptographic checksum of the firmware deployment package to verify integrity and authenticity.',
    `deployment_priority` STRING COMMENT 'Business priority level assigned to this firmware deployment based on urgency and impact.. Valid values are `critical|high|medium|low`',
    `deployment_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the firmware deployment process began.',
    `deployment_status` STRING COMMENT 'Current lifecycle status of the firmware deployment event.. Valid values are `scheduled|in_progress|completed|failed|rolled_back|cancelled`',
    `downtime_minutes` STRING COMMENT 'Total instrument downtime in minutes caused by the firmware deployment activity.',
    `error_code` STRING COMMENT 'System-generated error code if the firmware deployment failed or encountered issues.',
    `error_message` STRING COMMENT 'Detailed error message describing any failures or issues encountered during firmware deployment.',
    `iq_oq_pq_completion_date` DATE COMMENT 'Date when the IQ/OQ/PQ requalification was completed following the firmware deployment.',
    `iq_oq_pq_required_flag` BOOLEAN COMMENT 'Indicates whether this firmware deployment requires formal IQ/OQ/PQ requalification of the instrument per GxP requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this firmware deployment record was last updated.',
    `post_deployment_validation_status` STRING COMMENT 'Status of validation checks performed after firmware deployment to verify successful installation and functionality.. Valid values are `passed|failed|not_performed|pending`',
    `pre_deployment_validation_status` STRING COMMENT 'Status of validation checks performed before firmware deployment to ensure instrument readiness.. Valid values are `passed|failed|not_performed|waived`',
    `previous_firmware_version` STRING COMMENT 'The firmware version number that was active on the instrument before this deployment.',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether this firmware deployment has regulatory implications requiring additional documentation or approval under GxP or FDA regulations.',
    `rollback_flag` BOOLEAN COMMENT 'Indicates whether this deployment was a rollback to a previous firmware version due to issues.',
    `rollback_reason` STRING COMMENT 'Detailed explanation of why the firmware was rolled back to a previous version.',
    `service_ticket_number` STRING COMMENT 'Reference to the ServiceNow field service ticket associated with this firmware deployment event.',
    CONSTRAINT pk_firmware_deployment PRIMARY KEY(`firmware_deployment_id`)
) COMMENT 'Single source of truth for the firmware and software version lifecycle — encompassing the approved version catalog (version number, release date, release type, regulatory impact flag, supported instrument models, compatible reagent kit versions, change summary) and individual deployment events (target asset, deployment date, deployment method, technician, pre/post validation status, rollback flag). Supports GxP firmware baseline management, change control under ISO 13485 and 21 CFR Part 11, and field service firmware upgrade planning.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` (
    `instrument_run_id` BIGINT COMMENT 'Unique identifier for the instrument run. Primary key for the instrument_run data product.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Clinical and research runs need customer account tracking for service run billing, data ownership, regulatory audit trails (21 CFR Part 11), usage-based pricing models, and customer utilization analyt',
    `asset_id` BIGINT COMMENT 'Reference to the sequencing platform, array scanner, PCR/qPCR system, or gene-editing equipment on which this run was executed.',
    `cartridge_id` BIGINT COMMENT 'Unique identifier or serial number of the array cartridge, PCR plate, or reagent cartridge used in the run. Applicable to array scanners and qPCR/ddPCR platforms.',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Sequencing runs require specific reagent kit selection (library prep, sequencing chemistry). Critical for run setup validation, cost allocation, quality investigations, and ensuring instrument-reagent',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Runs consume reagents, labor, and instrument time that must be allocated to the cost center funding the work. Essential for project costing, chargeback models, and departmental cost allocation in geno',
    `employee_id` BIGINT COMMENT 'Reference to the laboratory technician or scientist who initiated and monitored the instrument run. Links to workforce or user management system.',
    `flow_cell_id` BIGINT COMMENT 'Unique identifier or serial number of the flow cell consumable used in Next-Generation Sequencing (NGS) runs. Null for non-sequencing run types such as array or PCR.',
    `gene_annotation_track_id` BIGINT COMMENT 'Foreign key linking to reference.gene_annotation_track. Business justification: Each sequencing run uses a specific gene annotation version for variant calling and transcript identification. Affects HGVS nomenclature, coverage calculations for target regions, and clinical report ',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Every sequencing run aligns reads to a specific reference genome build (GRCh38, hg19, etc.). This determines coordinate systems, variant calling accuracy, and annotation compatibility. Required for re',
    `genomic_region_id` BIGINT COMMENT 'Foreign key linking to reference.genomic_region. Business justification: Each targeted sequencing run specifies which genomic regions were captured/sequenced (e.g., Agilent SureSelect v7 exome). Determines coverage analysis boundaries, off-target rate calculations, and whi',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Sequencing runs consume specific reagent kits, flow cell prep materials, and library prep consumables. Linking run to material enables lot-level traceability for quality investigations, regulatory com',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: GxP/FDA compliance mandates lot-level traceability for clinical runs. Enables quality investigations linking run failures to specific reagent lots, supports batch record requirements, and facilitates ',
    `research_protocol_id` BIGINT COMMENT 'Foreign key linking to research.protocol. Business justification: Runs execute validated protocols for regulatory compliance and reproducibility. Essential for GxP audit trails, protocol deviation tracking, and method validation. Removes denormalized protocol name/v',
    `sequencing_run_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_run. Business justification: Links instrument execution record to sequencing run for run reconciliation, QC correlation, and instrument utilization reporting. Genomics operations require bidirectional navigation between instrumen',
    `variant_database_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database. Business justification: Clinical sequencing runs specify which variant databases (ClinVar, COSMIC, gnomAD) to use for annotation during analysis. This determines pathogenicity classification and clinical reporting content. R',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_order. Business justification: Sequencing runs support work order QC checkpoints (library quality validation, intermediate product testing). Manufacturing execution systems require linking analytical runs to work orders for real-ti',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the instrument run completed or terminated, as recorded by the instrument control software.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the instrument run commenced, as recorded by the instrument control software or BaseSpace Sequence Hub.',
    `cluster_density` DECIMAL(18,2) COMMENT 'Average cluster density on the flow cell surface, measured in thousands of clusters per square millimeter (K/mm²). Key quality metric for NGS runs.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this instrument run record was first created in the system, typically at run initiation or scheduling.',
    `cycle_count` STRING COMMENT 'Total number of sequencing cycles executed in the run, determining read length and paired-end configuration. Applicable to NGS platforms.',
    `error_rate` DECIMAL(18,2) COMMENT 'Estimated sequencing error rate as a percentage, typically calculated from PhiX control spike-in. Lower values indicate higher accuracy.',
    `failure_reason` STRING COMMENT 'Detailed description of the reason for run failure or abortion, including error codes, instrument alerts, or operator notes. Null for successful runs.',
    `identifier` STRING COMMENT 'Business-facing unique identifier or run name assigned by the operator or Laboratory Information Management System (LIMS). Often includes date, instrument serial, and sequence number.',
    `instrument_software_version` STRING COMMENT 'Version number of the instrument control software or firmware used to execute the run, critical for reproducibility and troubleshooting.',
    `is_clinical_run` BOOLEAN COMMENT 'Boolean flag indicating whether this run was performed under Clinical Laboratory Improvement Amendments (CLIA) or In Vitro Diagnostic (IVD) regulatory requirements (True) or for Research Use Only (RUO) purposes (False).',
    `is_paired_end` BOOLEAN COMMENT 'Boolean flag indicating whether the run used paired-end sequencing (True) or single-end sequencing (False). Applicable to NGS runs only.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this instrument run record was last updated, capturing status changes, QC updates, or data corrections.',
    `mean_quality_score` DECIMAL(18,2) COMMENT 'Average Phred quality score across all bases in the run, indicating base-calling accuracy. Phred score of 30 corresponds to 99.9% accuracy.',
    `multiplexing_index_strategy` STRING COMMENT 'Indexing strategy used for sample multiplexing: single index (one barcode), dual index (two barcodes), unique dual index (UDI for collision avoidance), or none (single sample run).. Valid values are `single_index|dual_index|unique_dual_index|none`',
    `number_of_samples` STRING COMMENT 'Total count of biological samples multiplexed and processed in this instrument run. For single-sample runs, value is 1.',
    `output_data_location` STRING COMMENT 'File system path or cloud storage URI (e.g., Amazon Web Services (AWS) S3 bucket, BaseSpace project path) where raw output data (FASTQ, BAM, or array intensity files) is stored.',
    `output_file_format` STRING COMMENT 'Primary file format of the run output data: FASTQ (raw sequencing reads), Binary Alignment Map (BAM) (aligned reads), IDAT (Illumina array intensity), CEL (Affymetrix array), Variant Call Format (VCF) (variant calls), or other.. Valid values are `FASTQ|BAM|IDAT|CEL|VCF|other`',
    `percent_aligned_to_phix` DECIMAL(18,2) COMMENT 'Percentage of reads that aligned to the PhiX control genome, confirming the expected spike-in concentration (typically 1%).',
    `percent_pf_clusters` DECIMAL(18,2) COMMENT 'Percentage of clusters passing Illumina chastity filter, indicating the proportion of high-quality clusters. Typical target is >80%.',
    `percent_q30_bases` DECIMAL(18,2) COMMENT 'Percentage of bases with Phred quality score of 30 or higher (≥99.9% accuracy). Industry standard quality threshold for clinical and research sequencing.',
    `phix_error_rate` DECIMAL(18,2) COMMENT 'Error rate measured specifically from PhiX control library spike-in, used as internal quality control for sequencing accuracy.',
    `qc_performed_by` BIGINT COMMENT 'Reference to the laboratory personnel or bioinformatician who performed the quality control review and approved or rejected the run.',
    `qc_review_timestamp` TIMESTAMP COMMENT 'Date and time when the quality control review was completed and the run QC status was finalized.',
    `qc_status` STRING COMMENT 'Overall quality control assessment of the run: passed (meets all quality thresholds), failed (does not meet minimum quality), warning (marginal quality requiring review), or not-evaluated (QC pending).. Valid values are `passed|failed|warning|not_evaluated`',
    `read_length` STRING COMMENT 'Length of sequencing reads in base pairs (bp) for NGS runs, e.g., 150 bp paired-end. Null for non-sequencing assays.',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the run: In Vitro Diagnostic (IVD) (FDA-cleared assay), Laboratory Developed Test (LDT) (CLIA-validated), Research Use Only (RUO) (non-clinical), Good Manufacturing Practice (GMP) (manufacturing QC), or not-applicable.. Valid values are `IVD|LDT|RUO|GMP|not_applicable`',
    `run_mode` STRING COMMENT 'Operational mode or workflow configuration selected for the run: standard (default protocol), rapid (accelerated turnaround), high-throughput (maximum sample capacity), low-throughput (small batch), or custom (user-defined parameters).. Valid values are `standard|rapid|high_throughput|low_throughput|custom`',
    `run_status` STRING COMMENT 'Current lifecycle status of the instrument run: queued (scheduled but not started), in-progress (actively running), completed (finished successfully), failed (terminated due to error), aborted (manually stopped by operator), or under-review (completed but awaiting quality control approval).. Valid values are `queued|in_progress|completed|failed|aborted|under_review`',
    `run_type` STRING COMMENT 'Type of genomic assay or experiment performed: Whole Genome Sequencing (WGS), Whole Exome Sequencing (WES), targeted sequencing panel, RNA sequencing, ChIP sequencing, array-based genotyping, gene expression array, quantitative Polymerase Chain Reaction (qPCR), droplet digital PCR (ddPCR), CRISPR screening, or library quality control. [ENUM-REF-CANDIDATE: WGS|WES|targeted_sequencing|RNA_seq|ChIP_seq|array_genotyping|array_expression|qPCR|ddPCR|CRISPR_screen|library_QC — 11 candidates stripped; promote to reference product]',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when the run was scheduled to begin, as recorded in the instrument scheduling system or LIMS.',
    `target_coverage_depth` STRING COMMENT 'Planned average sequencing coverage depth (e.g., 30X for WGS, 100X for WES) as specified in the run protocol. Null for non-sequencing assays.',
    `total_reads_generated` BIGINT COMMENT 'Total number of sequencing reads (or read pairs for paired-end) generated by the run. Null for non-sequencing assays.',
    `total_yield_gb` DECIMAL(18,2) COMMENT 'Total sequencing yield in gigabases (Gb) produced by the run, calculated as total reads multiplied by read length. Null for non-sequencing assays.',
    CONSTRAINT pk_instrument_run PRIMARY KEY(`instrument_run_id`)
) COMMENT 'Records each instrument run executed on a sequencing platform, array scanner, or PCR/qPCR system — capturing run ID, run type (WGS/WES/targeted/array/qPCR), start and end datetime, operator, flow cell or array cartridge used, reagent lot numbers, run parameters (read length, cycle count, multiplexing index), run status (in-progress/completed/failed/aborted), and output data location (FASTQ/BAM path in BaseSpace or cloud storage). Central transactional record linking instrument operations to sequencing and bioinformatics domains.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` (
    `service_contract_id` BIGINT COMMENT 'Unique identifier for the service contract record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account that holds this service contract entitlement.',
    `asset_id` BIGINT COMMENT 'Reference to the sequencing instrument, array scanner, PCR/qPCR platform, liquid handler, or gene-editing equipment covered by this service contract.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Service contracts are sold as catalog items with SKUs and pricing; required for sales order processing, revenue recognition, contract renewal quoting, and financial reporting. Standard practice in gen',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Service contracts are managed by specific employees serving as contract/account managers for renewal tracking, customer relationship management, escalation handling, and contract administration. Essen',
    `header_id` BIGINT COMMENT 'Reference to the SAP SD sales order that originated this service contract, if purchased separately. Null for bundled warranties.',
    `predecessor_contract_service_contract_id` BIGINT COMMENT 'Reference to the previous service contract that this contract renews or replaces. Enables contract history tracking and customer tenure analysis. Null for initial contracts.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Service contracts need designated contact person for contract administration, renewal notifications, service coordination, and escalation management. Distinct from account owner. Essential for contrac',
    `revenue_recognition_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition. Business justification: Service contracts generate deferred revenue that must be recognized ratably over the contract term per ASC 606. Links contract performance obligations to revenue recognition schedules for financial re',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Service contracts often cover instruments at specific sites with different terms per location (multi-site accounts). Site-specific coverage scope, SLA tiers, and service delivery terms require address',
    `acquisition_method` STRING COMMENT 'How the service contract was obtained: bundled with instrument purchase, separately purchased after installation, promotional offer, or upgrade from a lower tier.. Valid values are `bundled_with_purchase|separately_purchased|promotional|upgrade`',
    `annual_contract_value` DECIMAL(18,2) COMMENT 'Total annual value of the service contract in the contract currency. For multi-year contracts, this is the average annual value. Used for revenue recognition and customer lifetime value calculations.',
    `cancellation_date` DATE COMMENT 'Date when the contract was cancelled or terminated early by customer or provider. Null for contracts that ran to natural expiration or are still active.',
    `cancellation_reason` STRING COMMENT 'Reason for early contract termination: instrument decommissioned or sold, customer requested cancellation, non-payment, breach of contract terms, upgraded to a different contract tier, or other.. Valid values are `instrument_decommissioned|customer_request|non_payment|breach_of_terms|upgrade_to_new_contract|other`',
    `claim_eligibility_rules` STRING COMMENT 'Free-text description of conditions that must be met for a service claim to be honored: instrument must be in qualified environment (temperature, humidity per IQ/OQ), operated by trained personnel, using approved consumables, with calibration current. Exclusions for misuse, unauthorized modifications, or force majeure.',
    `consumables_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount on reagents, flow cells, arrays, and other consumables as a benefit of this service contract. Typically 5-15% for premium tiers. Null if no discount applies.',
    `contract_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `contract_number` STRING COMMENT 'Externally visible unique business identifier for the service contract, used in customer communications, invoices, and field service dispatch.. Valid values are `^[A-Z0-9]{8,20}$`',
    `contract_signed_date` DATE COMMENT 'Date when the customer and service provider executed the service contract agreement. Used for contract age analysis and renewal forecasting.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the service contract: draft (not yet active), active (coverage in force), suspended (temporarily paused), expired (end date passed), cancelled (terminated early), renewed (replaced by successor contract).. Valid values are `draft|active|suspended|expired|cancelled|renewed`',
    `contract_type` STRING COMMENT 'Classification of the service entitlement: manufacturer standard warranty (included with purchase), extended warranty, comprehensive service contract (parts, labor, PM), parts-only coverage, time-and-materials agreement, or preventive maintenance only.. Valid values are `manufacturer_warranty|extended_warranty|comprehensive_service|parts_only|time_and_materials|preventive_maintenance`',
    `coverage_scope` STRING COMMENT 'Defines which subsystems and components of the instrument are covered: full system, optics module only, fluidics subsystem, electronics, software updates, or exclusions such as consumables.. Valid values are `full_system|optics_only|fluidics_only|electronics_only|software_only|consumables_excluded`',
    `coverage_territory` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where this service contract is valid. Instruments moved outside this territory may void coverage. Critical for field service dispatch and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service contract record was first created in the system. Used for audit trail and data lineage.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Fixed amount the customer must pay per service incident before contract coverage applies. Common in lower-tier contracts. Null if no deductible.',
    `end_date` DATE COMMENT 'Date when the service contract coverage expires. Nullable for perpetual or lifetime warranties. Triggers renewal workflow 90 days prior.',
    `included_pm_visits` STRING COMMENT 'Number of on-site preventive maintenance visits included in the contract term at no additional charge. Typically 1-4 per year depending on instrument type and SLA tier.',
    `labor_coverage_included` BOOLEAN COMMENT 'Indicates whether field service engineer labor (on-site and remote) is included at no additional charge. True for comprehensive and labor-only contracts, false for parts-only.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this service contract record. Used for change tracking and audit compliance.',
    `loaner_instrument_included` BOOLEAN COMMENT 'Indicates whether a temporary replacement instrument is provided during extended repairs (typically >5 business days downtime). Available only in platinum and gold tiers.',
    `max_claims_per_year` STRING COMMENT 'Maximum number of service incidents that can be claimed under this contract within a 12-month period. Null for unlimited. Exceeding this cap triggers time-and-materials billing.',
    `notes` STRING COMMENT 'Free-text field for additional contract details, special terms, customer-specific accommodations, or operational notes for field service engineers. Not visible to customer.',
    `parts_coverage_included` BOOLEAN COMMENT 'Indicates whether replacement parts (optics, sensors, pumps, valves, circuit boards) are included at no additional charge. True for comprehensive and parts-only contracts, false for labor-only or time-and-materials.',
    `pm_visit_frequency_months` STRING COMMENT 'Scheduled interval in months between preventive maintenance visits (e.g., 3 for quarterly, 6 for semi-annual, 12 for annual). Drives field service scheduling.',
    `priority_parts_shipping` BOOLEAN COMMENT 'Indicates whether replacement parts are shipped via expedited carrier (overnight or same-day) at no additional charge. Standard for platinum/gold, optional upgrade for silver/bronze.',
    `remote_support_included` BOOLEAN COMMENT 'Indicates whether 24/7 remote diagnostics, troubleshooting, and software support via secure VPN connection are included. Standard for all tiers except bronze.',
    `renewal_notice_days` STRING COMMENT 'Number of days before contract end date when renewal notification is sent to the customer. Typically 90, 60, or 30 days depending on contract value and complexity.',
    `renewal_terms` STRING COMMENT 'Defines how the contract renews at expiration: automatic renewal unless cancelled, manual renewal requiring customer action, non-renewable (one-time coverage), opt-in (customer must confirm), opt-out (customer must cancel).. Valid values are `auto_renew|manual_renew|non_renewable|opt_in|opt_out`',
    `response_time_hours` DECIMAL(18,2) COMMENT 'Maximum number of hours from service request submission to field service engineer dispatch or remote support initiation, as committed in the SLA tier.',
    `service_provider` STRING COMMENT 'Entity responsible for delivering service under this contract: manufacturer (Genomics Biotech), authorized service partner, third-party maintenance organization, or customer self-service with remote support.. Valid values are `manufacturer|authorized_partner|third_party|customer_self_service`',
    `service_provider_name` STRING COMMENT 'Legal name of the organization providing service under this contract. For manufacturer service, this is Genomics Biotech. For partners, the authorized partner company name.',
    `sla_tier` STRING COMMENT 'Service level tier defining response time commitments, uptime guarantees, and priority: platinum (4-hour response, 99.5% uptime), gold (8-hour, 98%), silver (next business day, 95%), bronze (48-hour), standard (best effort).. Valid values are `platinum|gold|silver|bronze|standard`',
    `software_updates_included` BOOLEAN COMMENT 'Indicates whether instrument control software, firmware, and bioinformatics pipeline updates are included. Critical for maintaining regulatory compliance (FDA 21 CFR Part 11, IVDR) and performance optimization.',
    `start_date` DATE COMMENT 'Date when the service contract coverage becomes effective. For manufacturer warranties, typically the instrument installation qualification (IQ) completion date.',
    `travel_expenses_included` BOOLEAN COMMENT 'Indicates whether field service engineer travel costs (airfare, mileage, lodging, meals) are included in the contract or billed separately. Typically true for platinum/gold tiers, false for bronze/standard.',
    `uptime_guarantee_percent` DECIMAL(18,2) COMMENT 'Contractually guaranteed instrument availability percentage over the measurement period (typically monthly or quarterly). Failure to meet this may trigger service credits.',
    CONSTRAINT pk_service_contract PRIMARY KEY(`service_contract_id`)
) COMMENT 'Manages all instrument coverage entitlements — including manufacturer standard warranties (included with purchase), extended warranties, and separately purchased service contracts (comprehensive, parts-only, time-and-materials). Captures entitlement type, acquisition method (bundled-with-purchase vs separately-sold), coverage scope, SLA tier (response time, uptime guarantee), start and end dates, annual value, renewal terms, included PM visits, provider (manufacturer/third-party), and claim eligibility rules. Sourced from SAP SD service contracts and Salesforce CRM. SSOT for answering what coverage does this instrument have? for field service entitlement checking, warranty claims, and SLA compliance.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` (
    `spare_part_id` BIGINT COMMENT 'Unique identifier for the spare part or field-replaceable unit (FRU). Primary key.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Spare parts are orderable catalog items; required for procurement order creation, pricing lookup, inventory valuation, customer ordering, and revenue recognition. Essential for supply chain and order ',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer-specific spare parts inventory (consignment stock, customer-owned parts at customer sites, vendor-managed inventory) requires account linkage for inventory management, billing triggers, and s',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Spare parts ARE materials in the supply chain master data. This link unifies spare part inventory with enterprise material management, enables MRP planning for service parts, ensures stock levels are ',
    `supplier_id` BIGINT COMMENT 'Reference to the primary supplier or vendor for this spare part in the procurement system.',
    `calibration_required_flag` BOOLEAN COMMENT 'Indicates whether the spare part requires calibration after installation or replacement to meet instrument performance specifications.',
    `compatible_instrument_models` STRING COMMENT 'Comma-separated list of instrument model identifiers that this spare part is compatible with (e.g., NovaSeq6000,NextSeq2000,MiSeqDx). Used for field service parts selection and maintenance planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the spare part record was first created in the system.',
    `criticality_classification` STRING COMMENT 'Business criticality of the spare part based on impact to instrument uptime and service level agreements (SLA): critical (immediate failure if unavailable), high (significant impact), medium (moderate impact), low (minimal impact).. Valid values are `critical|high|medium|low`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for standard cost and list price (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dimensions` STRING COMMENT 'Physical dimensions of the spare part in format Length x Width x Height with units (e.g., 25.4 x 15.2 x 10.1 cm). Used for packaging and storage planning.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the spare part is classified as hazardous material requiring special handling, storage, and shipping procedures per regulatory requirements.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order for this spare part. Used for demand analysis and supplier performance tracking.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from order placement to delivery. Used for inventory planning and minimum stock level calculations.',
    `list_price` DECIMAL(18,2) COMMENT 'Published list price for the spare part in the base currency. Used for customer quotations and service contract pricing.',
    `lot_controlled_flag` BOOLEAN COMMENT 'Indicates whether this spare part is tracked by lot number for batch traceability and quality control purposes, typically for consumables and reagents.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer (OEM) or supplier of the spare part.',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturer (OEM) part number for cross-referencing with supplier catalogs and procurement systems.',
    `material_group_code` STRING COMMENT 'SAP material group classification code for procurement categorization and spend analysis.',
    `mean_time_between_failures` STRING COMMENT 'Average operational time in hours between failures for this spare part, based on historical field service data. Used for preventive maintenance scheduling and reliability analysis.',
    `minimum_stock_level` STRING COMMENT 'Minimum inventory quantity that must be maintained to support field service operations and prevent stockouts. Triggers reorder when stock falls below this threshold.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the spare part record was last modified in the system.',
    `obsolescence_date` DATE COMMENT 'Date when the spare part will become obsolete and no longer available for ordering. Used for last-time-buy planning and instrument lifecycle management.',
    `part_name` STRING COMMENT 'Human-readable name or description of the spare part (e.g., Flow Cell Optical Sensor, Laser Diode Assembly, Reagent Pump Module).',
    `part_number` STRING COMMENT 'Manufacturer-assigned unique part number for the spare part or FRU. Used for ordering, inventory tracking, and cross-referencing with supplier catalogs.. Valid values are `^[A-Z0-9]{6,20}$`',
    `part_status` STRING COMMENT 'Current lifecycle status of the spare part: active (available for use), obsolete (no longer supported), discontinued (no longer manufactured), phase_out (being retired), or restricted (limited availability or use).. Valid values are `active|obsolete|discontinued|phase_out|restricted`',
    `part_type` STRING COMMENT 'Classification of the spare part by functional category: FRU (Field-Replaceable Unit), consumable, tool, optical component, electronic component, mechanical component, or software license. [ENUM-REF-CANDIDATE: FRU|consumable|tool|optical_component|electronic_component|mechanical_component|software_license — 7 candidates stripped; promote to reference product]',
    `product_hierarchy` STRING COMMENT 'Hierarchical product classification path for reporting and analytics (e.g., Instruments/Sequencing/NovaSeq/Optics/Laser).',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the spare part: IVD (In Vitro Diagnostic), RUO (Research Use Only), GMP (Good Manufacturing Practice), or non_regulated. Determines applicable quality and compliance requirements.. Valid values are `IVD|RUO|GMP|non_regulated`',
    `reorder_point` STRING COMMENT 'Inventory level at which a replenishment order should be triggered, calculated based on lead time, usage rate, and safety stock requirements.',
    `replacement_frequency_months` STRING COMMENT 'Recommended replacement interval in months for preventive maintenance, based on manufacturer specifications and field performance data.',
    `sds_reference_number` STRING COMMENT 'Reference number or document identifier for the Safety Data Sheet (SDS) associated with this spare part, if applicable. Required for hazardous materials.',
    `serialized_flag` BOOLEAN COMMENT 'Indicates whether individual units of this spare part are tracked by unique serial numbers for traceability, warranty management, and quality control.',
    `shelf_life_months` STRING COMMENT 'Maximum storage duration in months before the spare part expires or degrades beyond acceptable quality standards. Null for non-perishable parts.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard unit cost of the spare part in the base currency for inventory valuation and cost accounting. Used for maintenance event cost tracking and financial reporting.',
    `storage_conditions` STRING COMMENT 'Required environmental storage conditions for the spare part (e.g., Store at 2-8°C, Keep dry, room temperature, Protect from light). Critical for maintaining part quality and warranty compliance.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for inventory and ordering: EA (each), SET (set of components), KIT (complete kit), BOX (boxed quantity), ROLL (roll), LITER (liquid volume), PACK (package). [ENUM-REF-CANDIDATE: EA|SET|KIT|BOX|ROLL|LITER|PACK — 7 candidates stripped; promote to reference product]',
    `warranty_period_months` STRING COMMENT 'Manufacturer warranty period in months from date of installation or first use. Used for warranty claim validation and service contract terms.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the spare part in kilograms. Used for shipping cost calculations and logistics planning.',
    CONSTRAINT pk_spare_part PRIMARY KEY(`spare_part_id`)
) COMMENT 'Reference master for spare parts and field-replaceable units (FRUs) used in instrument maintenance and repair — capturing part number, part name, part type (FRU/consumable/tool/optical component), compatible instrument models, manufacturer part cross-reference, unit of measure, criticality classification, lead time, minimum stock level, hazardous material flag, and SDS reference. Supports field service parts ordering, maintenance event parts consumption tracking, and inventory planning. Integrates with SAP MM material master for procurement and stock management.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`configuration` (
    `configuration_id` BIGINT COMMENT 'Unique identifier for the instrument configuration record. Primary key.',
    `asset_id` BIGINT COMMENT 'Reference to the physical instrument asset to which this configuration applies.',
    `baseline_configuration_id` BIGINT COMMENT 'Reference to the validated baseline configuration from which this configuration was derived or against which it is compared.',
    `gene_annotation_track_id` BIGINT COMMENT 'Foreign key linking to reference.gene_annotation_track. Business justification: Validated instrument configurations specify which gene annotation version (GENCODE v38, RefSeq 109) to use for transcript-level analysis. Ensures consistent exon/intron boundaries and variant nomencla',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: IVD-validated instrument configurations lock to specific genome builds to maintain regulatory compliance. Enables audit trails showing which reference genome version was active when clinical samples w',
    `genomic_region_id` BIGINT COMMENT 'Foreign key linking to reference.genomic_region. Business justification: Targeted sequencing configurations specify which genomic regions (exome capture targets, gene panels, regulatory elements) the instrument is validated to analyze. Defines the assays analytical scope ',
    `rd_capitalization_id` BIGINT COMMENT 'Foreign key linking to finance.rd_capitalization. Business justification: Validated instrument configurations for commercial IVD products trigger R&D capitalization decisions when technical feasibility is demonstrated. Links configuration validation milestones to capitaliza',
    `research_protocol_id` BIGINT COMMENT 'Reference to the validation protocol or Installation Qualification/Operational Qualification/Performance Qualification (IQ/OQ/PQ) documentation associated with this configuration.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: IVD software configurations require regulatory submission when changes affect intended use or performance claims per FDA guidance on software as medical device. Links validated configurations to regul',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: GxP-validated instrument configurations require documented validator identity for 21 CFR Part 11 compliance, audit trails, and regulatory inspections. Replaces denormalized approved_by text field with',
    `validation_study_id` BIGINT COMMENT 'Foreign key linking to quality.validation_study. Business justification: Instrument configurations in clinical/GxP environments must link to validation studies that qualified them. Critical for IVD compliance, revalidation tracking, and demonstrating fitness-for-purpose. D',
    `approval_date` DATE COMMENT 'Date on which this configuration was formally approved for use.',
    `audit_trail_enabled_flag` BOOLEAN COMMENT 'Indicates whether audit trail logging is enabled for this configuration, capturing all user actions and system events.',
    `backup_configuration` STRING COMMENT 'Settings for automated data backup including frequency, retention policy, and backup destination.',
    `calibration_profile` STRING COMMENT 'Reference to the calibration settings or calibration curve applied in this configuration, ensuring measurement accuracy.',
    `change_control_number` STRING COMMENT 'Reference to the formal change control request or ticket that authorized this configuration change.',
    `change_description` STRING COMMENT 'Detailed description of what was changed in this configuration version compared to the previous version.',
    `change_reason` STRING COMMENT 'Business or technical justification for this configuration change (e.g., performance improvement, regulatory requirement, bug fix).',
    `checksum` STRING COMMENT 'Cryptographic hash or checksum of the configuration file ensuring integrity and detecting unauthorized changes.',
    `configuration_name` STRING COMMENT 'Human-readable name or label for this configuration profile (e.g., WGS High Throughput v3.2, Clinical IVD Baseline).',
    `configuration_status` STRING COMMENT 'Current lifecycle status of this configuration profile.. Valid values are `draft|active|deprecated|retired|locked`',
    `configuration_type` STRING COMMENT 'Classification of the configuration profile indicating its intended use context.. Valid values are `baseline|custom|validated|development|test|production`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration record was first created in the system.',
    `data_output_format` STRING COMMENT 'Primary data format produced by the instrument under this configuration (e.g., FASTQ for sequencing, IDAT for arrays).. Valid values are `FASTQ|BAM|VCF|BCL|IDAT|CSV`',
    `data_storage_path` STRING COMMENT 'Default file system path or cloud storage location where instrument output data is written.',
    `deployed_by` STRING COMMENT 'Name or identifier of the person or system that deployed this configuration to the instrument.',
    `deployment_method` STRING COMMENT 'Method by which this configuration was deployed to the instrument.. Valid values are `manual|automated|remote|on_site`',
    `deployment_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration was deployed to the instrument.',
    `deviation_from_baseline` STRING COMMENT 'Structured description of any deviations from the validated baseline configuration, including justification and risk assessment.',
    `effective_from_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration became active on the instrument.',
    `effective_until_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration was superseded or deactivated. Null if currently active.',
    `electronic_signature_required_flag` BOOLEAN COMMENT 'Indicates whether electronic signatures are required for critical operations under this configuration.',
    `enabled_modules` STRING COMMENT 'Comma-separated or JSON list of software modules, features, or capabilities enabled in this configuration (e.g., WGS,WES,Targeted_Panel,Methylation).',
    `feature_flags` STRING COMMENT 'JSON or key-value pairs representing software feature toggles and experimental capabilities enabled or disabled in this configuration.',
    `file_path` STRING COMMENT 'File system path or repository location where the full configuration file is stored.',
    `firmware_version` STRING COMMENT 'Version of the firmware installed on the instrument at the time this configuration was captured.',
    `gxp_validated_flag` BOOLEAN COMMENT 'Indicates whether this configuration has been validated under GxP regulations (GMP, GLP, GCP) for use in regulated environments.',
    `ivd_compliant_flag` BOOLEAN COMMENT 'Indicates whether this configuration meets IVD regulatory requirements for clinical diagnostic use.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this configuration record was last updated.',
    `network_configuration` STRING COMMENT 'Network settings for the instrument including IP address, subnet, gateway, DNS, proxy settings, and firewall rules.',
    `quality_control_thresholds` STRING COMMENT 'JSON or structured text defining QC pass/fail thresholds for metrics such as Phred score, coverage depth, cluster density, and error rates.',
    `revalidation_due_date` DATE COMMENT 'Date by which this configuration must be revalidated to maintain compliance.',
    `run_parameter_defaults` STRING COMMENT 'JSON or structured text capturing default run parameters for sequencing or assay execution (e.g., read length, cycle count, flow cell type, chemistry version).',
    `security_settings` STRING COMMENT 'Security configuration including authentication method, encryption settings, access control policies, and audit logging parameters.',
    `software_version` STRING COMMENT 'Version of the control software or operating system running on the instrument at the time this configuration was captured.',
    `user_access_roles` STRING COMMENT 'JSON or structured list defining user roles and permissions configured for this instrument (e.g., operator, supervisor, administrator, service engineer).',
    `validation_completion_date` DATE COMMENT 'Date on which validation activities for this configuration were completed.',
    `validation_status` STRING COMMENT 'Current status of the validation process for this configuration.. Valid values are `not_validated|in_progress|validated|failed|expired`',
    `version` STRING COMMENT 'Version identifier for this configuration profile, following semantic versioning or internal versioning scheme.',
    CONSTRAINT pk_configuration PRIMARY KEY(`configuration_id`)
) COMMENT 'Captures the approved operational configuration state of each instrument asset at a point in time — including run parameter defaults, network configuration, enabled modules, software feature flags, GxP-validated configuration baseline, and configuration change history. Supports 21 CFR Part 11 configuration management and ISO 13485 change control. Distinct from firmware_deployment in that it captures the full configuration profile, not just the firmware version.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` (
    `blanket_agreement_id` BIGINT COMMENT 'Unique identifier for this instrument-specific blanket agreement record. Primary key for the association.',
    `blanket_order_id` BIGINT COMMENT 'Foreign key linking to the blanket order framework agreement. Identifies the overarching multi-year supply contract that covers multiple instrument models.',
    `model_id` BIGINT COMMENT 'Foreign key linking to the specific instrument model covered under this blanket agreement. Identifies which sequencing platform, array scanner, or other instrument type this pricing and commitment applies to.',
    `compatible_reagent_families` STRING COMMENT 'Comma-separated list of reagent kit families or SKU groups covered for this instrument model under the blanket agreement. Defines the scope of products eligible for call-off releases.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument-blanket agreement record was created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this instrument-blanket agreement record was last updated.',
    `model_agreement_end_date` DATE COMMENT 'Expiration date when this instrument model coverage terminates under the blanket order. May differ from overall agreement end date if models are phased out or replaced.',
    `model_agreement_start_date` DATE COMMENT 'Effective start date when this instrument model was added to the blanket order agreement. May differ from the overall blanket order start date if models are added mid-term.',
    `model_committed_quantity` DECIMAL(18,2) COMMENT 'Total quantity of reagent kits or consumables committed for this specific instrument model under the blanket order. Represents the model-level volume commitment within the overall agreement.',
    `model_consumed_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity that has been released and consumed for this specific instrument model against the blanket order. Tracked separately per model to monitor consumption rates and trigger replenishment.',
    `model_lead_time_days` STRING COMMENT 'Standard lead time in days from release request to delivery for reagents specific to this instrument model. Varies by model due to manufacturing complexity and reagent shelf life.',
    `model_minimum_release_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be requested in each call-off release for this specific instrument model. Ensures economical batch sizes for model-specific reagents.',
    `model_remaining_quantity` DECIMAL(18,2) COMMENT 'Quantity remaining available for future call-off releases for this specific instrument model. Calculated as model_committed_quantity minus model_consumed_quantity.',
    `model_specific_discount_percentage` DECIMAL(18,2) COMMENT 'Negotiated discount percentage applied to list price for reagents and consumables for this specific instrument model. Discounts vary by model based on volume commitments and strategic importance.',
    `model_specific_pricing_tier` STRING COMMENT 'Volume-based pricing tier locked for this specific instrument model within the blanket order. Different models may have different tier structures based on consumption patterns and reagent costs.',
    `model_specific_unit_price` DECIMAL(18,2) COMMENT 'Pre-negotiated unit price for reagent kits, consumables, or services specific to this instrument model under this blanket order. Prices vary by model due to different chemistries, throughput requirements, and reagent compatibility.',
    `model_status` STRING COMMENT 'Current lifecycle status of this instrument model coverage within the blanket order. Tracks whether the model-specific terms are active, consumed, or terminated.',
    CONSTRAINT pk_blanket_agreement PRIMARY KEY(`blanket_agreement_id`)
) COMMENT 'This association product represents the Contract between instrument_model and blanket_order. It captures model-specific pricing, volume commitments, and consumption tracking when a blanket order covers multiple instrument models with differentiated terms. Each record links one instrument_model to one blanket_order with pricing and consumption attributes that exist only in the context of this specific model-agreement combination.. Existence Justification: In genomics biotech operations, large genome centers and biopharma customers establish multi-year reagent supply agreements (blanket orders) that cover multiple instrument models simultaneously (e.g., NovaSeq 6000, NextSeq 2000, and MiSeq systems). Each instrument model within the blanket order has model-specific pricing tiers, volume commitments, discount structures, and consumption tracking because reagent costs, chemistries, and throughput requirements vary significantly by platform. The business actively manages these model-specific terms as part of commercial contract administration.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` (
    `spare_parts_supply_agreement_id` BIGINT COMMENT 'Unique identifier for this spare parts supply agreement line within the blanket order framework. Primary key.',
    `blanket_order_id` BIGINT COMMENT 'Foreign key linking to the blanket order framework agreement',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to the spare part covered under this supply agreement',
    `agreement_end_date` DATE COMMENT 'Expiration date when this spare part is no longer available for release under the blanket order. May differ from overall blanket order end date if parts are phased out.',
    `agreement_start_date` DATE COMMENT 'Effective start date when this spare part becomes available for release under the blanket order. May differ from the overall blanket order start date if parts are added incrementally.',
    `committed_quantity` DECIMAL(18,2) COMMENT 'Total quantity of this specific spare part committed under the blanket order agreement over its full term. Part of the overall blanket order volume commitment.',
    `consumed_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of this spare part that has been released and consumed against this blanket order to date. Tracked at the part level for consumption monitoring.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this spare part was added to the blanket order agreement.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Negotiated discount percentage applied to list price for this specific spare part under this blanket order. May vary by part based on volume and strategic importance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this spare parts supply agreement line was last updated (quantity adjustments, status changes, etc.).',
    `last_release_date` DATE COMMENT 'Date of the most recent call-off release for this spare part under this blanket order. Used for consumption pattern analysis and replenishment planning.',
    `lead_time_days` STRING COMMENT 'Negotiated lead time in days from release request to delivery for this specific spare part under this blanket order. May differ from standard part lead time based on stocking agreements.',
    `line_status` STRING COMMENT 'Current lifecycle status of this spare part within the blanket order: active (available for release), suspended (temporarily unavailable), partially_consumed (in progress), fully_consumed (commitment exhausted), expired (past end date), cancelled (terminated early).',
    `maximum_release_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity permitted in a single call-off release for this spare part under this agreement. Controls release patterns and inventory exposure.',
    `minimum_release_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be requested in each call-off release for this specific spare part. Defined at the part level to support efficient fulfillment and inventory management.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Quantity of this spare part remaining available for future call-off releases under this blanket order. Calculated as committed_quantity minus consumed_quantity.',
    `stocking_location` STRING COMMENT 'Designated warehouse or distribution center where inventory for this spare part is maintained to support this blanket order agreement. Enables rapid fulfillment of call-off releases.',
    `unit_price` DECIMAL(18,2) COMMENT 'Pre-negotiated unit price for this specific spare part under this blanket order agreement. Price is locked at the part level and may differ from standard list price based on volume commitments.',
    CONSTRAINT pk_spare_parts_supply_agreement PRIMARY KEY(`spare_parts_supply_agreement_id`)
) COMMENT 'This association product represents the contractual agreement between a spare part and a blanket order framework. It captures the specific terms, pricing, and consumption tracking for each spare part included in a long-term supply agreement. Each record links one spare part to one blanket order with part-specific committed quantities, unit pricing, consumption tracking, lead times, and minimum release quantities that exist only in the context of this supply relationship.. Existence Justification: In genomics biotech service organizations, blanket orders for spare parts supply are structured as multi-line agreements where each blanket order covers multiple spare part SKUs (pumps, lasers, flow cells, optical components) with part-specific pricing, committed quantities, and consumption tracking. A single spare part can be included in multiple blanket orders serving different customers or regions, each with distinct negotiated terms. The business actively manages these supply agreements as operational entities with part-level consumption monitoring, release scheduling, and replenishment triggers.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` (
    `test_qualification_id` BIGINT COMMENT 'Unique identifier for the instrument-test qualification record. Primary key.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the physical instrument asset that has been qualified for the clinical test.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to the clinical IVD test catalog entry that has been validated on the instrument.',
    `qualification_protocol_id` BIGINT COMMENT 'Reference identifier for the formal qualification protocol document executed to validate this instrument-test combination. Links to quality management system documentation for regulatory traceability.',
    `submission_id` BIGINT COMMENT 'Reference identifier for the regulatory submission (FDA 510(k), PMA, or CLIA validation) that includes this instrument-test qualification. Critical for IVD compliance and audit response.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this qualification became effective and the instrument was authorized to process clinical samples for this test. May differ from validation_date if regulatory approval was required.',
    `expiration_date` DATE COMMENT 'Date when this qualification expires and re-validation is required. Driven by regulatory requirements, assay version changes, or instrument qualification intervals. Nullable for qualifications without defined expiration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last updated.',
    `revalidation_due_date` DATE COMMENT 'Scheduled date for the next required revalidation protocol. Used for preventive compliance scheduling to avoid qualification lapses.',
    `validation_approved_by` STRING COMMENT 'Username or identifier of the laboratory director or quality manager who approved the validation results. Required for regulatory compliance.',
    `validation_date` DATE COMMENT 'Date when the qualification validation protocol was successfully completed and the instrument was authorized to run the clinical test. Critical for regulatory audit trails.',
    `validation_notes` STRING COMMENT 'Free-text notes documenting validation results, deviations, special conditions, or instrument-specific configuration details relevant to this qualification.',
    `validation_performed_by` STRING COMMENT 'Username or identifier of the qualified laboratory personnel who performed the validation protocol. Required for CAP accreditation audit trails.',
    `validation_status` STRING COMMENT 'Current status of the instrument-test qualification. active=instrument authorized to run test, expired=revalidation required, suspended=temporarily not authorized, pending_revalidation=validation in progress, retired=qualification no longer applicable.',
    CONSTRAINT pk_test_qualification PRIMARY KEY(`test_qualification_id`)
) COMMENT 'This association product represents the regulatory qualification and validation relationship between physical instrument assets and clinical IVD test catalog entries. It captures the formal validation process required for CLIA compliance, CAP accreditation, and FDA regulatory submissions. Each record links one instrument asset to one validated clinical test with qualification protocol references, validation dates, regulatory submission tracking, and expiration dates for re-qualification. This is the operational SSOT for the IVD Validation Matrix that determines which instruments are authorized to run which clinical tests.. Existence Justification: In genomics biotech clinical operations, each IVD test must be formally validated on specific instrument assets before clinical use, creating a true many-to-many operational relationship. One instrument can be qualified to run multiple different clinical tests (e.g., a NovaSeq 6000 validated for WGS, WES, and multiple targeted panels), and one clinical test must be validated on multiple instruments for capacity, redundancy, and business continuity. The qualification relationship itself is a regulated business entity with validation dates, protocol references, regulatory submission tracking, and expiration dates that trigger re-validation workflows.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` (
    `batch_test_id` BIGINT COMMENT 'Unique identifier for this instrument batch test record. Primary key for the association.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to the instrument asset used to perform this batch test. References the physical instrument platform (sequencer, array scanner, PCR system, etc.) that generated the test results.',
    `instrument_run_id` BIGINT COMMENT 'Unique run identifier generated by the instrument for this test execution. Links to raw data files and instrument logs for full traceability.',
    `employee_id` BIGINT COMMENT 'Reference to the QC analyst or operator who performed this test on this instrument. Required for 21 CFR Part 11 electronic signature and audit trail.',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to the production batch being tested. References the manufactured lot (reagent kit, flow cell, array, consumable) undergoing quality control testing.',
    `test_method_id` BIGINT COMMENT 'Reference to the validated test method or Standard Operating Procedure (SOP) used for this test. Required for GMP compliance and method validation traceability.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this test record was created in the quality management system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this test record was last modified. Required for audit trail.',
    `qc_result_status` STRING COMMENT 'Quality control result status for this specific test on this batch using this instrument. Feeds into overall batch disposition decision. Explicitly identified in detection reasoning.',
    `result_unit` STRING COMMENT 'Unit of measure for the result value (e.g., mg/mL, %, IU/mL, CFU/mL). Nullable for qualitative tests.',
    `result_value` DECIMAL(18,2) COMMENT 'Quantitative result value from this test (e.g., concentration, purity percentage, potency units). Nullable for qualitative tests.',
    `retest_flag` BOOLEAN COMMENT 'Indicates whether this test is a retest of a previous inconclusive or failed result. Important for deviation tracking and batch release timeline. Explicitly identified in detection reasoning.',
    `samples_tested` STRING COMMENT 'Number of samples from this batch tested on this instrument during this test event. Required for statistical validity and CoA documentation. Explicitly identified in detection reasoning.',
    `specification_max` DECIMAL(18,2) COMMENT 'Maximum acceptable value per product specification for this test type. Used to determine pass/fail status.',
    `specification_min` DECIMAL(18,2) COMMENT 'Minimum acceptable value per product specification for this test type. Used to determine pass/fail status.',
    `test_type` STRING COMMENT 'Type of quality control test performed on this batch using this instrument. Different test types require different instrument platforms (e.g., identity testing on sequencers, purity on HPLC, potency on qPCR). Explicitly identified in detection reasoning.',
    `testing_end_timestamp` TIMESTAMP COMMENT 'Date and time when testing completed on this instrument for this batch. Used to calculate test duration and instrument availability. Explicitly identified in detection reasoning.',
    `testing_start_timestamp` TIMESTAMP COMMENT 'Date and time when testing commenced on this instrument for this batch. Critical for GMP audit trail and instrument utilization tracking. Explicitly identified in detection reasoning.',
    CONSTRAINT pk_batch_test PRIMARY KEY(`batch_test_id`)
) COMMENT 'This association product represents the testing event between instrument_asset and production_batch. It captures the quality control testing performed on a specific production batch using a specific instrument asset. Each record links one instrument_asset to one production_batch with attributes that exist only in the context of this testing relationship: test type, timing, sample count, and QC results. Essential for batch release documentation, Certificate of Analysis (CoA) generation, and regulatory compliance (GMP/GxP traceability).. Existence Justification: In genomics biotech manufacturing, production batches undergo multiple quality control tests (identity, purity, potency, sterility) before release, and each test type requires a different instrument platform (sequencers for identity, HPLC for purity, qPCR for potency). A single batch is tested on multiple instruments, and each instrument tests multiple batches over time. The business actively manages these testing events as part of the Electronic Batch Record (EBR) lifecycle and Certificate of Analysis (CoA) generation, tracking test type, timing, sample count, and results for each instrument-batch combination.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` (
    `part_consumption_id` BIGINT COMMENT 'Unique identifier for this part consumption transaction record. Primary key.',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to the maintenance event during which this part was consumed',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to the spare part that was consumed in this maintenance event',
    `consumption_notes` STRING COMMENT 'Free-text notes about this specific part consumption: installation observations, compatibility issues, configuration changes, or special handling requirements.',
    `installation_timestamp` TIMESTAMP COMMENT 'Date and time when this part was installed or consumed during the maintenance event. Used for warranty start date calculation and maintenance timeline tracking.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number of the part consumed. Required for lot-controlled parts to support traceability and recall management.',
    `part_serial_number` STRING COMMENT 'Serial number of the specific part unit installed during this maintenance event. Required for serialized parts to support warranty tracking and field failure analysis.',
    `parts_consumed_count` STRING COMMENT 'Number of distinct parts or components replaced or consumed during the maintenance event. [Moved from maintenance_event: This is an aggregate count that can be derived from the part_consumption association table by counting distinct spare_part_id records for each maintenance_event_id. It does not belong as a stored attribute in maintenance_event.]',
    `quantity_consumed` DECIMAL(18,2) COMMENT 'Quantity of this spare part consumed during the maintenance event, in the parts unit of measure. Supports fractional quantities for consumables.',
    `removal_reason` STRING COMMENT 'Classification or description of why the part was replaced: failure, preventive replacement, upgrade, damage, end of life, calibration drift. Supports root cause analysis and parts reliability tracking.',
    `removed_part_serial_number` STRING COMMENT 'Serial number of the failed or replaced part that was removed during this maintenance event. Supports failure analysis and warranty claims for defective parts.',
    `total_parts_cost` DECIMAL(18,2) COMMENT 'Total cost of all parts and consumables used in the maintenance event, in USD. [Moved from maintenance_event: This is an aggregate sum that can be derived from the part_consumption association table by summing (quantity_consumed * unit_cost) for each maintenance_event_id. It does not belong as a stored attribute in maintenance_event.]',
    `unit_cost` DECIMAL(18,2) COMMENT 'Actual unit cost of the part at the time of consumption, captured from inventory or procurement system. Used for maintenance event cost calculation and variance analysis.',
    `warranty_claim_eligible` BOOLEAN COMMENT 'Indicates whether this part consumption is eligible for warranty claim or vendor reimbursement based on failure analysis and warranty terms.',
    CONSTRAINT pk_part_consumption PRIMARY KEY(`part_consumption_id`)
) COMMENT 'This association product represents the transactional record of spare parts consumed during instrument maintenance events. It captures the detailed part usage for each maintenance activity, including quantity consumed, serial/lot traceability, installation timestamps, and removed part tracking. Each record links one maintenance event to one spare part with attributes that exist only in the context of this consumption transaction. Supports parts inventory management, cost allocation, warranty claims, regulatory compliance, and maintenance analytics.. Existence Justification: In real-world instrument maintenance operations, a single maintenance event routinely consumes multiple spare parts (e.g., replacing flow cell, optical sensor, and tubing in one service visit), and each spare part is consumed across many different maintenance events over time. The business actively manages these part consumption transactions as operational records with specific quantities, serial numbers, lot traceability, installation timestamps, and cost data that belong to neither the maintenance event nor the spare part alone.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`firmware_version` (
    `firmware_version_id` BIGINT COMMENT 'Primary key for firmware_version',
    `superseded_firmware_version_id` BIGINT COMMENT 'Self-referencing FK on firmware_version (superseded_firmware_version_id)',
    `checksum` STRING COMMENT 'Cryptographic checksum of the firmware binary for integrity verification.',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate the checksum.',
    `classification_or_type` STRING COMMENT 'Category of the firmware, e.g., instrument firmware, bootloader, or auxiliary software.',
    `compatible_instrument_models` STRING COMMENT 'Comma‑separated list of instrument model identifiers compatible with this firmware. [ENUM-REF-CANDIDATE: ModelA|ModelB|ModelC|ModelD|ModelE|ModelF|... — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the firmware record was first created in the data lake.',
    `deprecation_date` DATE COMMENT 'Date after which the firmware is considered deprecated and should not be deployed to new instruments.',
    `firmware_version_description` STRING COMMENT 'Brief free‑text description of the firmwares purpose and functionality.',
    `download_url` STRING COMMENT 'Secure URL from which the firmware binary can be downloaded.',
    `end_of_life_date` DATE COMMENT 'Date after which the firmware will no longer receive support or updates.',
    `file_size_bytes` BIGINT COMMENT 'Size of the firmware binary file in bytes.',
    `is_mandatory_update` BOOLEAN COMMENT 'Indicates whether deployment of this firmware version is mandatory for compliance.',
    `is_security_update` BOOLEAN COMMENT 'Indicates whether this firmware version includes security‑related patches.',
    `license_type` STRING COMMENT 'Legal licensing model governing the use of the firmware.',
    `firmware_version_name` STRING COMMENT 'Human‑readable name for the firmware release.',
    `release_date` DATE COMMENT 'Date when the firmware version was officially released.',
    `release_notes` STRING COMMENT 'Textual description of changes, fixes, and enhancements in this firmware version.',
    `release_type` STRING COMMENT 'Classification of the release based on its impact: major, minor, patch, or hotfix.',
    `firmware_version_status` STRING COMMENT 'Current lifecycle status of the firmware version.',
    `supported_os` STRING COMMENT 'Operating system(s) that the firmware can run on, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the firmware record.',
    `vendor` STRING COMMENT 'Company or entity that provides the firmware.',
    `version` STRING COMMENT 'Semantic version identifier of the firmware release.',
    CONSTRAINT pk_firmware_version PRIMARY KEY(`firmware_version_id`)
) COMMENT 'Master reference table for firmware_version. Referenced by firmware_version_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`cartridge` (
    `cartridge_id` BIGINT COMMENT 'Primary key for cartridge',
    `supplier_id` BIGINT COMMENT 'FK to supply.supplier',
    `predecessor_cartridge_id` BIGINT COMMENT 'Self-referencing FK on cartridge (predecessor_cartridge_id)',
    `barcode` STRING COMMENT 'Machine‑readable barcode printed on the cartridge.',
    `calibration_interval_days` STRING COMMENT 'Number of days between required calibrations.',
    `calibration_required` BOOLEAN COMMENT 'Indicates whether the cartridge must be calibrated before use.',
    `capacity_unit` STRING COMMENT 'Unit of measurement for the cartridge capacity.',
    `capacity_value` DECIMAL(18,2) COMMENT 'Maximum number of reactions or samples the cartridge can process.',
    `cartridge_type` STRING COMMENT 'Category of cartridge based on the instrument technology it supports.',
    `compatible_instrument_models` STRING COMMENT 'Comma‑separated list of instrument model identifiers that can use this cartridge.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard purchase cost for a single cartridge.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the cartridge record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost_per_unit.',
    `cartridge_description` STRING COMMENT 'Free‑form description of cartridge specifications and use cases.',
    `disposal_method` STRING COMMENT 'Recommended method for safe disposal of the cartridge.',
    `expiration_date` DATE COMMENT 'Date after which the cartridge should not be used.',
    `hazardous_material_flag` BOOLEAN COMMENT 'True if the cartridge contains hazardous substances.',
    `is_reorderable` BOOLEAN COMMENT 'Indicates whether the cartridge can be automatically reordered.',
    `last_calibrated_timestamp` TIMESTAMP COMMENT 'Date and time when the cartridge was last calibrated.',
    `lead_time_days` STRING COMMENT 'Typical supplier lead time in days from order to receipt.',
    `lot_number` STRING COMMENT 'Batch identifier for manufacturing traceability.',
    `manufacturer` STRING COMMENT 'Company that produces the cartridge.',
    `manufacturer_part_number` STRING COMMENT 'Vendor‑assigned part number for the cartridge.',
    `cartridge_name` STRING COMMENT 'Human‑readable name of the cartridge model.',
    `notes` STRING COMMENT 'Additional free‑form remarks about the cartridge.',
    `regulatory_approval_number` STRING COMMENT 'Identifier of the regulatory approval document.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory clearance.',
    `reorder_quantity` STRING COMMENT 'Standard quantity to order when reordering is triggered.',
    `safety_classification` STRING COMMENT 'Regulatory safety class of the cartridge.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer.',
    `sku` STRING COMMENT 'Internal catalogue code used to reference the cartridge.',
    `cartridge_status` STRING COMMENT 'Current operational status of the cartridge in inventory.',
    `storage_humidity_percent` DECIMAL(18,2) COMMENT 'Recommended relative humidity for storage.',
    `storage_temperature_c` DECIMAL(18,2) COMMENT 'Recommended storage temperature in degrees Celsius.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the cartridge record.',
    `usage_count` STRING COMMENT 'Number of times the cartridge has been used.',
    `usage_limit` STRING COMMENT 'Maximum allowed usage count before the cartridge must be retired.',
    `version` STRING COMMENT 'Version or revision identifier for the cartridge design.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty for the cartridge ends.',
    `warranty_terms` STRING COMMENT 'Textual description of warranty coverage and conditions.',
    CONSTRAINT pk_cartridge PRIMARY KEY(`cartridge_id`)
) COMMENT 'Master reference table for cartridge. Referenced by cartridge_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` (
    `maintenance_plan_id` BIGINT COMMENT 'Primary key for maintenance_plan',
    `asset_id` BIGINT COMMENT 'Identifier of the instrument or equipment the plan applies to.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `location_id` BIGINT COMMENT 'Identifier of the physical location where maintenance is performed.',
    `superseded_maintenance_plan_id` BIGINT COMMENT 'Self-referencing FK on maintenance_plan (superseded_maintenance_plan_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance plan was approved.',
    `approved_by` STRING COMMENT 'Name of the person or role that approved the maintenance plan.',
    `audit_trail` STRING COMMENT 'Chronological log of significant changes to the maintenance plan.',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance obligations tied to the maintenance plan.',
    `cost` DECIMAL(18,2) COMMENT 'Monetary cost of the maintenance plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the maintenance plan record was first created.',
    `currency` STRING COMMENT 'Three‑letter ISO currency code for the plan cost.',
    `effective_end_date` DATE COMMENT 'Date when the maintenance plan expires or is terminated (nullable for open‑ended plans).',
    `effective_start_date` DATE COMMENT 'Date when the maintenance plan becomes effective.',
    `equipment_category` STRING COMMENT 'Broad classification of the instrument or equipment covered (e.g., sequencer, liquid handler).',
    `equipment_model` STRING COMMENT 'Manufacturer model identifier of the equipment.',
    `equipment_serial_number` STRING COMMENT 'Unique serial number of the equipment (device identifier).',
    `escalation_contact` STRING COMMENT 'Name of the person to contact for escalations.',
    `escalation_contact_email` STRING COMMENT 'Email address for escalation contact.',
    `escalation_contact_phone` STRING COMMENT 'Phone number for escalation contact.',
    `frequency_unit` STRING COMMENT 'Time unit for the maintenance interval.',
    `frequency_value` STRING COMMENT 'Numeric part of the maintenance interval (e.g., 30).',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the maintenance activity is critical to operations.',
    `last_maintenance_date` DATE COMMENT 'Date when the most recent maintenance was performed.',
    `last_updated_by` STRING COMMENT 'User or system that performed the most recent update.',
    `last_updated_by_role` STRING COMMENT 'Role or job function of the user who performed the most recent update.',
    `maintenance_scope` STRING COMMENT 'Description of the activities and components covered by the plan.',
    `maintenance_window_hours` DECIMAL(18,2) COMMENT 'Planned duration of the maintenance window in hours.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next maintenance activity.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the plan.',
    `plan_code` STRING COMMENT 'Business-visible code or number assigned to the maintenance plan.',
    `plan_name` STRING COMMENT 'Human‑readable name of the maintenance plan.',
    `plan_type` STRING COMMENT 'Category of maintenance plan indicating its purpose (preventive, corrective, or predictive).',
    `priority_level` STRING COMMENT 'Priority assigned to the maintenance plan for scheduling purposes.',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approvals.',
    `service_level_agreement` STRING COMMENT 'SLA tier associated with the maintenance plan.',
    `maintenance_plan_status` STRING COMMENT 'Current lifecycle status of the maintenance plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the maintenance plan record.',
    `vendor_contact_email` STRING COMMENT 'Primary email address for the vendors maintenance contact.',
    `vendor_contact_phone` STRING COMMENT 'Primary phone number for the vendors maintenance contact.',
    `vendor_name` STRING COMMENT 'Name of the external vendor providing the maintenance service.',
    `warranty_coverage` BOOLEAN COMMENT 'Indicates whether the equipment is under warranty for the maintenance activities.',
    `warranty_expiration_date` DATE COMMENT 'Date when the equipment warranty expires.',
    CONSTRAINT pk_maintenance_plan PRIMARY KEY(`maintenance_plan_id`)
) COMMENT 'Master reference table for maintenance_plan. Referenced by maintenance_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ADD CONSTRAINT `fk_instrument_asset_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ADD CONSTRAINT `fk_instrument_installation_qualification_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ADD CONSTRAINT `fk_instrument_calibration_record_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ADD CONSTRAINT `fk_instrument_pm_schedule_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ADD CONSTRAINT `fk_instrument_pm_schedule_maintenance_plan_id` FOREIGN KEY (`maintenance_plan_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`maintenance_plan`(`maintenance_plan_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ADD CONSTRAINT `fk_instrument_pm_schedule_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ADD CONSTRAINT `fk_instrument_maintenance_event_batch_test_id` FOREIGN KEY (`batch_test_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`batch_test`(`batch_test_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ADD CONSTRAINT `fk_instrument_field_service_request_service_contract_id` FOREIGN KEY (`service_contract_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`service_contract`(`service_contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ADD CONSTRAINT `fk_instrument_performance_telemetry_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ADD CONSTRAINT `fk_instrument_performance_telemetry_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ADD CONSTRAINT `fk_instrument_performance_telemetry_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ADD CONSTRAINT `fk_instrument_firmware_deployment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ADD CONSTRAINT `fk_instrument_firmware_deployment_firmware_version_id` FOREIGN KEY (`firmware_version_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`firmware_version`(`firmware_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ADD CONSTRAINT `fk_instrument_firmware_deployment_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ADD CONSTRAINT `fk_instrument_instrument_run_cartridge_id` FOREIGN KEY (`cartridge_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`cartridge`(`cartridge_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ADD CONSTRAINT `fk_instrument_service_contract_predecessor_contract_service_contract_id` FOREIGN KEY (`predecessor_contract_service_contract_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`service_contract`(`service_contract_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ADD CONSTRAINT `fk_instrument_configuration_baseline_configuration_id` FOREIGN KEY (`baseline_configuration_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`configuration`(`configuration_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ADD CONSTRAINT `fk_instrument_blanket_agreement_model_id` FOREIGN KEY (`model_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`model`(`model_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ADD CONSTRAINT `fk_instrument_spare_parts_supply_agreement_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`spare_part`(`spare_part_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ADD CONSTRAINT `fk_instrument_test_qualification_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ADD CONSTRAINT `fk_instrument_batch_test_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ADD CONSTRAINT `fk_instrument_batch_test_instrument_run_id` FOREIGN KEY (`instrument_run_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`instrument_run`(`instrument_run_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ADD CONSTRAINT `fk_instrument_part_consumption_maintenance_event_id` FOREIGN KEY (`maintenance_event_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`maintenance_event`(`maintenance_event_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ADD CONSTRAINT `fk_instrument_part_consumption_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`spare_part`(`spare_part_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_version` ADD CONSTRAINT `fk_instrument_firmware_version_superseded_firmware_version_id` FOREIGN KEY (`superseded_firmware_version_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`firmware_version`(`firmware_version_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`cartridge` ADD CONSTRAINT `fk_instrument_cartridge_predecessor_cartridge_id` FOREIGN KEY (`predecessor_cartridge_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`cartridge`(`cartridge_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ADD CONSTRAINT `fk_instrument_maintenance_plan_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`asset`(`asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ADD CONSTRAINT `fk_instrument_maintenance_plan_superseded_maintenance_plan_id` FOREIGN KEY (`superseded_maintenance_plan_id`) REFERENCES `genomics_biotech_ecm`.`instrument`.`maintenance_plan`(`maintenance_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`instrument` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `genomics_biotech_ecm`.`instrument` SET TAGS ('dbx_domain' = 'instrument');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Contract Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `model_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Site Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `firmware_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `gxp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Classification');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `gxp_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT|GMP|Non-GxP');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type Classification');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `iq_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Qualification (IQ) Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `is_validated` SET TAGS ('dbx_business_glossary_term' = 'Validation Status Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `last_preventive_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Preventive Maintenance Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `next_preventive_maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Preventive Maintenance Due Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Instrument Notes');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `oq_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Operational Qualification (OQ) Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'Owned|Leased|Rental|Loaned|Customer-Owned');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `pq_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Qualification (PQ) Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `run_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Typical Run Time (Hours)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Serial Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `service_contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `service_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `service_contract_number` SET TAGS ('dbx_value_regex' = '^SC-[0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Control Software Version');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `software_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `tag` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `throughput_capacity` SET TAGS ('dbx_business_glossary_term' = 'Throughput Capacity');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `throughput_unit` SET TAGS ('dbx_business_glossary_term' = 'Throughput Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `total_run_count` SET TAGS ('dbx_business_glossary_term' = 'Total Run Count');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `total_uptime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Uptime Hours');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `validation_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`asset` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Validated Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `calibration_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Calibration Frequency (Days)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `ce_mark_certificate` SET TAGS ('dbx_business_glossary_term' = 'CE (Conformité Européenne) Mark Certificate Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `connectivity_requirements` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Requirements');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `data_output_format` SET TAGS ('dbx_business_glossary_term' = 'Data Output Format');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `end_of_life_date` SET TAGS ('dbx_business_glossary_term' = 'End of Life (EOL) Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `end_of_support_date` SET TAGS ('dbx_business_glossary_term' = 'End of Support Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `environmental_requirements` SET TAGS ('dbx_business_glossary_term' = 'Environmental Requirements');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `fda_clearance_number` SET TAGS ('dbx_business_glossary_term' = 'FDA (Food and Drug Administration) Clearance Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `flow_cell_type` SET TAGS ('dbx_business_glossary_term' = 'Flow Cell Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `list_price_usd` SET TAGS ('dbx_business_glossary_term' = 'List Price (United States Dollars)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `list_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `max_reads_per_run` SET TAGS ('dbx_business_glossary_term' = 'Maximum Reads Per Run');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `max_throughput_gb` SET TAGS ('dbx_business_glossary_term' = 'Maximum Throughput (Gigabases)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `mean_time_between_failures_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Hours');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `mean_time_to_repair_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR) Hours');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `model_description` SET TAGS ('dbx_business_glossary_term' = 'Model Description');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `model_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|obsolete|pre_release|beta');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `multiplexing_capacity` SET TAGS ('dbx_business_glossary_term' = 'Multiplexing Capacity');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `physical_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Physical Dimensions');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `platform_generation` SET TAGS ('dbx_business_glossary_term' = 'Platform Generation');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `power_requirements` SET TAGS ('dbx_business_glossary_term' = 'Power Requirements');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `preventive_maintenance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `read_length_capability` SET TAGS ('dbx_business_glossary_term' = 'Read Length Capability');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `run_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Typical Run Time (Hours)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `sequencing_chemistry` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Chemistry');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `service_contract_available` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Available');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `software_platform` SET TAGS ('dbx_business_glossary_term' = 'Software Platform');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `supported_applications` SET TAGS ('dbx_business_glossary_term' = 'Supported Applications');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`model` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `installation_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Qualification (IQ) Identifier');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Performed By Engineer Identifier');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Document Identifier');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `cfr_part_11_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Part 11 Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Qualification Comments');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `customer_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Acceptance Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `customer_signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Signature Captured Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `deviation_count` SET TAGS ('dbx_business_glossary_term' = 'Deviation Count');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `deviation_summary` SET TAGS ('dbx_business_glossary_term' = 'Deviation Summary');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Execution Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `gxp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Qualification Outcome');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `performed_by_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Performed By Engineer Name');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Qualification Protocol Version');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Document Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'IQ|OQ|PQ|IQ/OQ|OQ/PQ|IQ/OQ/PQ');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `regulatory_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Qualification Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `service_order_number` SET TAGS ('dbx_business_glossary_term' = 'Service Order Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `test_case_count` SET TAGS ('dbx_business_glossary_term' = 'Test Case Count');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`installation_qualification` ALTER COLUMN `test_case_passed_count` SET TAGS ('dbx_business_glossary_term' = 'Test Case Passed Count');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Record Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `equipment_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Qualification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Procedure Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Calibration Certificate Reference');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calibration End Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_event_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Event Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_location` SET TAGS ('dbx_business_glossary_term' = 'Calibration Location');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_notes` SET TAGS ('dbx_business_glossary_term' = 'Calibration Notes');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_procedure_version` SET TAGS ('dbx_business_glossary_term' = 'Calibration Procedure Version');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_standard_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard Certificate Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_standard_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Standard Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calibration Start Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|passed|failed|cancelled|expired');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_type` SET TAGS ('dbx_business_glossary_term' = 'Calibration Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `calibration_type` SET TAGS ('dbx_value_regex' = 'optical|thermal|fluidic|electrical|mechanical|software');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `deviation_from_standard` SET TAGS ('dbx_business_glossary_term' = 'Deviation from Standard');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `environmental_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Environmental Humidity (Percent)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `environmental_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Environmental Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Result');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `service_order_number` SET TAGS ('dbx_business_glossary_term' = 'Service Order Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `technician_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Technician Certification Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `technician_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Name');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `tolerance_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Lower Limit');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `tolerance_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Upper Limit');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`calibration_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'SAP Preventive Maintenance (PM) Plan ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Sop Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `applicable_instrument_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Instrument Types');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `auto_generate_work_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Generate Work Order Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `criticality_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost in United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration in Minutes');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `frequency_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval in Days');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period in Days');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `last_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Completed Maintenance Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `maintenance_frequency` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `maintenance_task_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Task Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `next_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Notes');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `required_skill_level` SET TAGS ('dbx_business_glossary_term' = 'Required Skill Level');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `required_skill_level` SET TAGS ('dbx_value_regex' = 'basic|intermediate|advanced|specialist|certified_engineer');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Code');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Name');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|obsolete');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `servicenow_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'ServiceNow Schedule ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Version Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `work_order_template_code` SET TAGS ('dbx_business_glossary_term' = 'Work Order Template ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`pm_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Experiment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Impacted Work Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Service Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `batch_test_id` SET TAGS ('dbx_business_glossary_term' = 'Verification Test Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `customer_signoff_datetime` SET TAGS ('dbx_business_glossary_term' = 'Customer Sign-Off Date and Time');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `customer_signoff_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Sign-Off Name');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `customer_signoff_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Sign-Off Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `downtime_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration in Minutes');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|emergency|calibration|qualification|upgrade');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `follow_up_actions` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Actions');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment Level');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_value_regex' = 'no_impact|minor|moderate|major|critical');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date and Time');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `maintenance_event_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `maintenance_event_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|on_hold|verification_pending');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Notes');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority Level');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `resolution_summary` SET TAGS ('dbx_business_glossary_term' = 'Resolution Summary');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `runs_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Runs Affected Count');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `samples_impacted_count` SET TAGS ('dbx_business_glossary_term' = 'Samples Impacted Count');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `sla_actual_response_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Response Hours');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `sla_target_response_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Response Hours');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `trigger_source` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Trigger Source');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `trigger_source` SET TAGS ('dbx_value_regex' = 'scheduled|alarm|operator_report|performance_degradation|quality_event|regulatory_inspection');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Maintenance Verification Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|passed|failed|conditional_pass');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `warranty_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_event` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `field_service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Field Service Request ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Field Service Engineer (FSE) ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `field_application_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Field Application Activity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Hours');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `customer_feedback` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `field_service_request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `invoice_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Invoice Amount United States Dollars (USD)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `invoice_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `parts_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Parts Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Request Priority');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `problem_description` SET TAGS ('dbx_business_glossary_term' = 'Problem Description');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Field Service Request Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^FSR-[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'breakdown|installation|upgrade|preventive_maintenance|application_support|calibration');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `resolution_summary` SET TAGS ('dbx_business_glossary_term' = 'Resolution Summary');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'hardware_failure|software_defect|user_error|environmental|consumable_depletion|calibration_drift');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `scheduled_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Visit Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `service_order_number` SET TAGS ('dbx_business_glossary_term' = 'Service Order Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `sla_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `sla_compliance_status` SET TAGS ('dbx_value_regex' = 'met|at_risk|breached|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `travel_distance_km` SET TAGS ('dbx_business_glossary_term' = 'Travel Distance Kilometers (km)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`field_service_request` ALTER COLUMN `travel_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Travel Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `performance_telemetry_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Telemetry ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `flow_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Flow Cell ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `gene_model_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `genomic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `instrument_run_id` SET TAGS ('dbx_business_glossary_term' = 'Run ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `quality_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assessment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Service Event ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `anomaly_detection_score` SET TAGS ('dbx_business_glossary_term' = 'Anomaly Detection Score');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `cluster_density` SET TAGS ('dbx_business_glossary_term' = 'Cluster Density');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Coverage Depth');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `cycle_count_cumulative` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Cycle Count');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Cycle Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|suspect|invalid|calibration_required|sensor_fault');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `error_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Error Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `flow_rate_ml_per_min` SET TAGS ('dbx_business_glossary_term' = 'Flow Rate (mL/min)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `lane_number` SET TAGS ('dbx_business_glossary_term' = 'Lane Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `laser_power_watts` SET TAGS ('dbx_business_glossary_term' = 'Laser Power (Watts)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `metric_name` SET TAGS ('dbx_business_glossary_term' = 'Metric Name');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `metric_type` SET TAGS ('dbx_business_glossary_term' = 'Metric Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `metric_type` SET TAGS ('dbx_value_regex' = 'sequencing_run_metric|pcr_amplification_curve|array_scan_intensity|system_health_indicator|operational_counter|calibration_metric');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `metric_value` SET TAGS ('dbx_business_glossary_term' = 'Metric Value');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `phred_score_mean` SET TAGS ('dbx_business_glossary_term' = 'Mean Phred Score');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pressure (PSI)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `q30_score_percent` SET TAGS ('dbx_business_glossary_term' = 'Q30 Score Percentage');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `read_number` SET TAGS ('dbx_business_glossary_term' = 'Read Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `reagent_volume_consumed_ml` SET TAGS ('dbx_business_glossary_term' = 'Reagent Volume Consumed (mL)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `retention_policy_class` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Class');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `retention_policy_class` SET TAGS ('dbx_value_regex' = 'short_term|medium_term|long_term|regulatory_archive');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `run_count_cumulative` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Run Count');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `signal_intensity_mean` SET TAGS ('dbx_business_glossary_term' = 'Mean Signal Intensity');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `signal_to_noise_ratio` SET TAGS ('dbx_business_glossary_term' = 'Signal-to-Noise Ratio (SNR)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `telemetry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Telemetry Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `threshold_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Lower Limit');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `threshold_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Upper Limit');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `threshold_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Threshold Violation Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `tile_number` SET TAGS ('dbx_business_glossary_term' = 'Tile Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`performance_telemetry` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `firmware_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Firmware Deployment ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `firmware_version_id` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Deployment Technician ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `tertiary_firmware_scheduled_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled By User ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `tertiary_firmware_scheduled_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `tertiary_firmware_scheduled_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `backup_created_flag` SET TAGS ('dbx_business_glossary_term' = 'Backup Created Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `backup_location` SET TAGS ('dbx_business_glossary_term' = 'Backup Location');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `calibration_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `calibration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `customer_approval_received_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Received Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `customer_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `customer_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Deployment Duration (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployment End Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_location` SET TAGS ('dbx_business_glossary_term' = 'Deployment Location');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_location` SET TAGS ('dbx_value_regex' = 'onsite|remote|depot|lab');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_method` SET TAGS ('dbx_business_glossary_term' = 'Deployment Method');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_method` SET TAGS ('dbx_value_regex' = 'remote_ota|onsite_manual|usb_transfer|network_push|service_portal');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_notes` SET TAGS ('dbx_business_glossary_term' = 'Deployment Notes');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_number` SET TAGS ('dbx_business_glossary_term' = 'Firmware Deployment Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_number` SET TAGS ('dbx_value_regex' = '^FWD-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_package_checksum` SET TAGS ('dbx_business_glossary_term' = 'Deployment Package Checksum');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_priority` SET TAGS ('dbx_business_glossary_term' = 'Deployment Priority');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployment Start Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `deployment_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|failed|rolled_back|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `downtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Downtime (Minutes)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `iq_oq_pq_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Qualification (IQ) / Operational Qualification (OQ) / Performance Qualification (PQ) Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `iq_oq_pq_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Installation Qualification (IQ) / Operational Qualification (OQ) / Performance Qualification (PQ) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `post_deployment_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Deployment Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `post_deployment_validation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_performed|pending');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `pre_deployment_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Deployment Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `pre_deployment_validation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_performed|waived');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `previous_firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Previous Firmware Version');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reason');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_deployment` ALTER COLUMN `service_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Service Ticket Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `instrument_run_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Run Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `cartridge_id` SET TAGS ('dbx_business_glossary_term' = 'Cartridge Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `flow_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Flow Cell Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `genomic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Kit Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `variant_database_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `cluster_density` SET TAGS ('dbx_business_glossary_term' = 'Cluster Density (K per square millimeter)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `error_rate` SET TAGS ('dbx_business_glossary_term' = 'Error Rate (Percent)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Run Identifier');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `instrument_software_version` SET TAGS ('dbx_business_glossary_term' = 'Instrument Software Version');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `is_clinical_run` SET TAGS ('dbx_business_glossary_term' = 'Clinical Run Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `is_paired_end` SET TAGS ('dbx_business_glossary_term' = 'Paired-End Sequencing Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `mean_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Mean Quality Score (Phred)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `multiplexing_index_strategy` SET TAGS ('dbx_business_glossary_term' = 'Multiplexing Index Strategy');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `multiplexing_index_strategy` SET TAGS ('dbx_value_regex' = 'single_index|dual_index|unique_dual_index|none');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `number_of_samples` SET TAGS ('dbx_business_glossary_term' = 'Number of Samples');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `output_data_location` SET TAGS ('dbx_business_glossary_term' = 'Output Data Location');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `output_file_format` SET TAGS ('dbx_business_glossary_term' = 'Output File Format');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `output_file_format` SET TAGS ('dbx_value_regex' = 'FASTQ|BAM|IDAT|CEL|VCF|other');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `percent_aligned_to_phix` SET TAGS ('dbx_business_glossary_term' = 'Percent Aligned to PhiX');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `percent_pf_clusters` SET TAGS ('dbx_business_glossary_term' = 'Percent Passing Filter (PF) Clusters');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `percent_q30_bases` SET TAGS ('dbx_business_glossary_term' = 'Percent Q30 Bases');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `phix_error_rate` SET TAGS ('dbx_business_glossary_term' = 'PhiX Control Error Rate (Percent)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `qc_performed_by` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Performed By');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `qc_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Review Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `qc_status` SET TAGS ('dbx_business_glossary_term' = 'Run Quality Control (QC) Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `qc_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_evaluated');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `read_length` SET TAGS ('dbx_business_glossary_term' = 'Read Length (Base Pairs)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'IVD|LDT|RUO|GMP|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `run_mode` SET TAGS ('dbx_business_glossary_term' = 'Run Mode');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `run_mode` SET TAGS ('dbx_value_regex' = 'standard|rapid|high_throughput|low_throughput|custom');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'queued|in_progress|completed|failed|aborted|under_review');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `target_coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Target Coverage Depth (X)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `total_reads_generated` SET TAGS ('dbx_business_glossary_term' = 'Total Reads Generated');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`instrument_run` ALTER COLUMN `total_yield_gb` SET TAGS ('dbx_business_glossary_term' = 'Total Yield (Gigabases)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `predecessor_contract_service_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Service Contract Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Site Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Contract Acquisition Method');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_value_regex' = 'bundled_with_purchase|separately_purchased|promotional|upgrade');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `annual_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Annual Contract Value (ACV)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `annual_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Cancellation Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Cancellation Reason');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'instrument_decommissioned|customer_request|non_payment|breach_of_terms|upgrade_to_new_contract|other');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `claim_eligibility_rules` SET TAGS ('dbx_business_glossary_term' = 'Service Claim Eligibility Rules');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `consumables_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Consumables Discount Percentage');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `consumables_discount_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `contract_currency` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `contract_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|cancelled|renewed');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'manufacturer_warranty|extended_warranty|comprehensive_service|parts_only|time_and_materials|preventive_maintenance');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Coverage Scope');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_value_regex' = 'full_system|optics_only|fluidics_only|electronics_only|software_only|consumables_excluded');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `coverage_territory` SET TAGS ('dbx_business_glossary_term' = 'Coverage Territory Country Code');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `coverage_territory` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Deductible Amount');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `included_pm_visits` SET TAGS ('dbx_business_glossary_term' = 'Included Preventive Maintenance (PM) Visits');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `labor_coverage_included` SET TAGS ('dbx_business_glossary_term' = 'Labor Coverage Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `loaner_instrument_included` SET TAGS ('dbx_business_glossary_term' = 'Loaner Instrument Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `max_claims_per_year` SET TAGS ('dbx_business_glossary_term' = 'Maximum Service Claims Per Year');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Contract Notes');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `parts_coverage_included` SET TAGS ('dbx_business_glossary_term' = 'Parts Coverage Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `pm_visit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Visit Frequency in Months');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `priority_parts_shipping` SET TAGS ('dbx_business_glossary_term' = 'Priority Parts Shipping Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `remote_support_included` SET TAGS ('dbx_business_glossary_term' = 'Remote Support Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period in Days');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Terms');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_value_regex' = 'auto_renew|manual_renew|non_renewable|opt_in|opt_out');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Response Time in Hours');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `service_provider` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `service_provider` SET TAGS ('dbx_value_regex' = 'manufacturer|authorized_partner|third_party|customer_self_service');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `service_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Organization Name');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `software_updates_included` SET TAGS ('dbx_business_glossary_term' = 'Software Updates Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `travel_expenses_included` SET TAGS ('dbx_business_glossary_term' = 'Travel Expenses Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`service_contract` ALTER COLUMN `uptime_guarantee_percent` SET TAGS ('dbx_business_glossary_term' = 'Uptime Guarantee Percentage');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Account Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `calibration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Calibration Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `compatible_instrument_models` SET TAGS ('dbx_business_glossary_term' = 'Compatible Instrument Models');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `criticality_classification` SET TAGS ('dbx_business_glossary_term' = 'Criticality Classification');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `criticality_classification` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `dimensions` SET TAGS ('dbx_business_glossary_term' = 'Dimensions');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `list_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `lot_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Lot Controlled Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `mean_time_between_failures` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `minimum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `obsolescence_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `part_name` SET TAGS ('dbx_business_glossary_term' = 'Part Name');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `part_status` SET TAGS ('dbx_business_glossary_term' = 'Part Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `part_status` SET TAGS ('dbx_value_regex' = 'active|obsolete|discontinued|phase_out|restricted');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `part_type` SET TAGS ('dbx_business_glossary_term' = 'Part Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `product_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Product Hierarchy');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'IVD|RUO|GMP|non_regulated');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `replacement_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Replacement Frequency (Months)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `sds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `serialized_flag` SET TAGS ('dbx_business_glossary_term' = 'Serialized Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Months)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_part` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Configuration ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `baseline_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Baseline ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `genomic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `rd_capitalization_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Capitalization Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `research_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validated By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `audit_trail_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `backup_configuration` SET TAGS ('dbx_business_glossary_term' = 'Backup Configuration');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `backup_configuration` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `calibration_profile` SET TAGS ('dbx_business_glossary_term' = 'Calibration Profile');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Configuration Checksum');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_value_regex' = 'draft|active|deprecated|retired|locked');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `configuration_type` SET TAGS ('dbx_business_glossary_term' = 'Configuration Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `configuration_type` SET TAGS ('dbx_value_regex' = 'baseline|custom|validated|development|test|production');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `data_output_format` SET TAGS ('dbx_business_glossary_term' = 'Data Output Format');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `data_output_format` SET TAGS ('dbx_value_regex' = 'FASTQ|BAM|VCF|BCL|IDAT|CSV');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `data_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Data Storage Path');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `data_storage_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `deployed_by` SET TAGS ('dbx_business_glossary_term' = 'Deployed By');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `deployment_method` SET TAGS ('dbx_business_glossary_term' = 'Deployment Method');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `deployment_method` SET TAGS ('dbx_value_regex' = 'manual|automated|remote|on_site');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `deployment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployment Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `deviation_from_baseline` SET TAGS ('dbx_business_glossary_term' = 'Deviation From Baseline');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `effective_from_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `effective_until_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `electronic_signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `enabled_modules` SET TAGS ('dbx_business_glossary_term' = 'Enabled Modules');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `feature_flags` SET TAGS ('dbx_business_glossary_term' = 'Feature Flags');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'Configuration File Path');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `gxp_validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Validated Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `ivd_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'In Vitro Diagnostic (IVD) Compliant Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `network_configuration` SET TAGS ('dbx_business_glossary_term' = 'Network Configuration');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `network_configuration` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `quality_control_thresholds` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Thresholds');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `revalidation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Revalidation Due Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `run_parameter_defaults` SET TAGS ('dbx_business_glossary_term' = 'Run Parameter Defaults');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `security_settings` SET TAGS ('dbx_business_glossary_term' = 'Security Settings');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `security_settings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `software_version` SET TAGS ('dbx_business_glossary_term' = 'Software Version');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `user_access_roles` SET TAGS ('dbx_business_glossary_term' = 'User Access Roles');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `user_access_roles` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `validation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_validated|in_progress|validated|failed|expired');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`configuration` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` SET TAGS ('dbx_association_edges' = 'instrument.instrument_model,order.blanket_order');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `blanket_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Blanket Agreement Identifier');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Blanket Agreement - Blanket Order Id');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Blanket Agreement - Instrument Model Id');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `compatible_reagent_families` SET TAGS ('dbx_business_glossary_term' = 'Compatible Reagent Families');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `model_agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Model Agreement End Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `model_agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Model Agreement Start Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `model_committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Model-Specific Committed Quantity');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `model_consumed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Model-Specific Consumed Quantity');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `model_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Model-Specific Lead Time');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `model_minimum_release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Model-Specific Minimum Release Quantity');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `model_remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Model-Specific Remaining Quantity');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `model_specific_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Model-Specific Discount Percentage');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `model_specific_pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Model-Specific Pricing Tier');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `model_specific_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Model-Specific Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`blanket_agreement` ALTER COLUMN `model_status` SET TAGS ('dbx_business_glossary_term' = 'Model Agreement Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` SET TAGS ('dbx_association_edges' = 'instrument.spare_part,order.blanket_order');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `spare_parts_supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement Identifier');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Supply Agreement - Blanket Order Id');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Supply Agreement - Spare Part Id');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Part Agreement End Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Part Agreement Start Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Part Committed Quantity');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `consumed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Part Consumed Quantity');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Agreement Line Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Part Discount Percentage');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Agreement Line Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `last_release_date` SET TAGS ('dbx_business_glossary_term' = 'Last Release Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Agreement Lead Time');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Line Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `maximum_release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Part Maximum Release Quantity');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `minimum_release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Part Minimum Release Quantity');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Part Remaining Quantity');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `stocking_location` SET TAGS ('dbx_business_glossary_term' = 'Part Stocking Location');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`spare_parts_supply_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Agreement Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` SET TAGS ('dbx_association_edges' = 'instrument.instrument_asset,clinical.test_catalog');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `test_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Test Qualification ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Test Qualification - Instrument Asset Id');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Test Qualification - Ivd Test Catalog Id');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `qualification_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Protocol ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `revalidation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Revalidation Due Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `validation_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Validation Approved By');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `validation_performed_by` SET TAGS ('dbx_business_glossary_term' = 'Validation Performed By');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`test_qualification` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` SET TAGS ('dbx_association_edges' = 'instrument.instrument_asset,manufacturing.production_batch');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `batch_test_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Batch Test ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Batch Test - Instrument Asset Id');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `instrument_run_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Run ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Batch Test - Production Batch Id');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `test_method_id` SET TAGS ('dbx_business_glossary_term' = 'Test Method ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `qc_result_status` SET TAGS ('dbx_business_glossary_term' = 'QC Result Status');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `result_unit` SET TAGS ('dbx_business_glossary_term' = 'Result Unit');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `retest_flag` SET TAGS ('dbx_business_glossary_term' = 'Retest Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `samples_tested` SET TAGS ('dbx_business_glossary_term' = 'Samples Tested');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `specification_max` SET TAGS ('dbx_business_glossary_term' = 'Specification Maximum');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `specification_min` SET TAGS ('dbx_business_glossary_term' = 'Specification Minimum');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `testing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Testing End Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`batch_test` ALTER COLUMN `testing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Testing Start Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` SET TAGS ('dbx_subdomain' = 'service_operations');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` SET TAGS ('dbx_association_edges' = 'instrument.maintenance_event,instrument.spare_part');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `part_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Part Consumption ID');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Part Consumption - Maintenance Event Id');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Part Consumption - Spare Part Id');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `consumption_notes` SET TAGS ('dbx_business_glossary_term' = 'Part Consumption Notes');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `installation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Part Installation Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Part Lot Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `part_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Installed Part Serial Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `parts_consumed_count` SET TAGS ('dbx_business_glossary_term' = 'Parts Consumed Count');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `quantity_consumed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Consumed');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Part Removal Reason');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `removed_part_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Removed Part Serial Number');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `total_parts_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Parts Cost');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `total_parts_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Part Unit Cost');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`part_consumption` ALTER COLUMN `warranty_claim_eligible` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_version` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_version` ALTER COLUMN `firmware_version_id` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version Identifier');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`firmware_version` ALTER COLUMN `superseded_firmware_version_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`cartridge` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`cartridge` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`cartridge` ALTER COLUMN `cartridge_id` SET TAGS ('dbx_business_glossary_term' = 'Cartridge Identifier');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`cartridge` ALTER COLUMN `supplier_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`cartridge` ALTER COLUMN `predecessor_cartridge_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ALTER COLUMN `maintenance_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plan Identifier');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ALTER COLUMN `superseded_maintenance_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`instrument`.`maintenance_plan` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
