-- Schema for Domain: test | Business: Semiconductors | Version: v1_mvm
-- Generated on: 2026-05-06 20:34:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `semiconductors_ecm`.`test` COMMENT 'Wafer probing, die sort, final test, and reliability testing operations. Manages ATPG programs, ATE configurations, test coverage, bin mapping, test yield, parametric test data, and correlation studies between wafer-level and package-level test. Distinct from quality domain which focuses on QMS and compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`program` (
    `program_id` BIGINT COMMENT 'System-generated unique identifier for each test program record.',
    `ate_configuration_id` BIGINT COMMENT 'Foreign key linking to test.ate_configuration. Business justification: Test programs are executed on specific ATE configurations; many programs can share one configuration, so add FK from test_program to ate_configuration.',
    `eda_tool_id` BIGINT COMMENT 'Foreign key linking to design.eda_tool. Business justification: The ATPG EDA tool (e.g., Synopsys TetraMAX, Siemens Tessent) used to generate test patterns is a qualified, licensed tool tracked in eda_tool. Role-prefix atpg_ distinguishes this from other EDA too',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budgeting process: each test program is funded by a specific cost center; required for cost allocation reports.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Test programs must track ECCN classification of target devices for trade compliance screening, export license determination, and deemed export control when foreign nationals access test data. Critical',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Required for Test Program Definition: each test program is created for a specific technology node to ensure correct test parameters and compliance reporting.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Test Engineering defines a test program per manufacturing flow; linking enables the Test Flow Specification report that maps each program to its process flow.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Test Program Management requires linking each test program to the IC catalog entry it validates for release tracking.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Test programs are developed for specific IC design projects; DFT coverage reporting, NRE cost allocation, and tapeout readiness sign-off all require tracing a test program back to its originating desi',
    `netlist_id` BIGINT COMMENT 'Foreign key linking to design.netlist. Business justification: ATPG tools (TetraMAX, Tessent) consume the gate-level netlist to generate stuck-at and transition fault test patterns that form the test program. Netlist-to-test-program traceability is fundamental to',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Test programs are qualified against a specific PDK version — process corners, parametric limits, and SPICE models used in test are PDK-version-specific. PDK-to-test-program traceability is required fo',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability tracking: test program results are evaluated against profit center performance for ROI analysis.',
    `rtl_specification_id` BIGINT COMMENT 'Foreign key linking to design.rtl_specification. Business justification: ATPG test programs are derived directly from the RTL specifications DFT strategy (scan chains, BIST, boundary scan). Linking test_program to rtl_specification enables DFT coverage gap analysis and en',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Test programs specify approved suppliers for ATE platforms, load boards, probe cards, and test consumables. Enables procurement qualification, vendor management, and supply chain risk assessment for c',
    `actual_coverage_percent` DECIMAL(18,2) COMMENT 'Measured fault‑coverage achieved after program execution.',
    `approval_date` DATE COMMENT 'Date on which the program was approved.',
    `ate_platform` STRING COMMENT 'Automatic Test Equipment platform compatible with the program.. Valid values are `ATE_9000|ATE_9500|ATE_10000|Custom`',
    `bin_mapping_reference` STRING COMMENT 'Identifier of the bin‑mapping table associated with this program.',
    `change_description` STRING COMMENT 'Detailed narrative of modifications to test flows, limits, or parameters.',
    `correlation_study_reference` STRING COMMENT 'Identifier of the wafer‑to‑package correlation study associated with the program.',
    `coverage_target_percent` DECIMAL(18,2) COMMENT 'Desired fault‑coverage percentage the program aims to achieve.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `deprecation_date` DATE COMMENT 'Date on which the program version was marked as deprecated.',
    `impact_assessment` STRING COMMENT 'Narrative assessment of the programs impact on yield, cost, and schedule.',
    `is_deprecated` BOOLEAN COMMENT 'Flag indicating whether the program version is deprecated.',
    `owner` STRING COMMENT 'Name of the engineer or team responsible for the program.',
    `parametric_test_data_reference` STRING COMMENT 'Link to the parametric test data set used for limit verification.',
    `program_category` STRING COMMENT 'High‑level classification of the test program purpose.. Valid values are `functional|structural|parametric|mixed`',
    `program_code` STRING COMMENT 'Business‑assigned code that uniquely identifies the test program across systems.',
    `release_date` DATE COMMENT 'Calendar date when the program version was officially released for production use.',
    `target_device` STRING COMMENT 'Specific device part number or SKU the program validates.',
    `target_device_family` STRING COMMENT 'Family or series of devices the program is intended for (e.g., FinFET‑45nm, GAA‑7nm).',
    `test_coverage_metric` STRING COMMENT 'Metric used to express coverage (e.g., fault, code, timing).. Valid values are `fault_coverage|code_coverage|timing_coverage`',
    `test_environment` STRING COMMENT 'Physical environment where the program is executed.. Valid values are `lab|production|prototype`',
    `test_flow_description` STRING COMMENT 'Detailed description of the test flow sequence executed by the program.',
    `test_flow_version` STRING COMMENT 'Version identifier of the underlying test flow definition.',
    `test_limit_units` STRING COMMENT 'Units for numeric test limits (e.g., mV, mA, ns).',
    `test_limit_value` DECIMAL(18,2) COMMENT 'Numeric value of the primary test limit associated with the program.',
    `test_program_name` STRING COMMENT 'Human‑readable name of the test program.',
    `test_program_status` STRING COMMENT 'Overall lifecycle state of the test program.. Valid values are `active|inactive|deprecated|retired`',
    `test_type` STRING COMMENT 'Category of testing performed by the program (e.g., wafer probe, die sort, final test, burn‑in, system level test).. Valid values are `wafer_probe|die_sort|final_test|burn_in|slit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the program record.',
    `validation_status` STRING COMMENT 'Current validation state of the program version.. Valid values are `draft|validated|released|rejected`',
    `version_description` STRING COMMENT 'Free‑form description of changes introduced in this version.',
    `version_number` STRING COMMENT 'Semantic version identifier for the program (e.g., 1.0.3).',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master record for ATPG-generated and manually authored test programs used on ATE platforms, with full version lifecycle management. Captures program name, target device family, test type (wafer probe, die sort, final test, burn-in, SLT), ATE platform compatibility, ATPG tool used, coverage targets, and program lifecycle status. Includes version-level tracking: version number, change description, changed test flows or limits, validation status, release date, approved-by engineer, associated PCN/ECO reference, and change impact assessment. SSOT for all test program definitions and their complete evolution history across test operations.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`ate_configuration` (
    `ate_configuration_id` BIGINT COMMENT 'Unique system-generated identifier for the ATE configuration record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: ATE equipment depreciation, maintenance, and operating expenses are charged to specific cost centers for budgeting and variance analysis. Standard semiconductor fab cost accounting practice.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Test equipment utilization and profitability are tracked by profit center to analyze test operations margin contribution and capacity planning decisions.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: ATE equipment is physically located in controlled storage facilities. Operations teams need to track where each ATE configuration resides for maintenance scheduling, capacity planning, and cleanroom c',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: ATE configurations track equipment manufacturer/supplier for maintenance contracts, spare parts procurement, calibration services, and warranty management. Critical for equipment lifecycle management ',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: ATE platforms are often optimized for product families (shared test infrastructure). Test capacity planning, platform roadmaps, and capital equipment allocation require family-level ATE configuration ',
    `technology_control_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.technology_control_plan. Business justification: ATE configurations contain controlled test technology (proprietary algorithms, test IP, device characterization methods) requiring Technology Control Plan documentation per EAR/ITAR for deemed export ',
    `ate_configuration_name` STRING COMMENT 'Human‑readable name identifying this ATE configuration.',
    `bin_mapping_version` STRING COMMENT 'Version identifier for the binning map used in this configuration.',
    `calibration_due_date` DATE COMMENT 'Date by which the configuration must be re‑calibrated.',
    `calibration_status` STRING COMMENT 'Current calibration state of the configuration.. Valid values are `calibrated|due|overdue`',
    `change_reason` STRING COMMENT 'Free‑text reason describing why the configuration was changed.',
    `compliance_ear_status` STRING COMMENT 'Indicates whether the configuration complies with Export Administration Regulations.. Valid values are `compliant|non_compliant|exempt`',
    `compliance_itar_status` STRING COMMENT 'Indicates whether the configuration complies with International Traffic in Arms Regulations.. Valid values are `compliant|non_compliant|exempt`',
    `configuration_code` STRING COMMENT 'Business identifier code used to reference the configuration in work orders and test plans.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the configuration record was first created.',
    `effective_end_date` DATE COMMENT 'Date when the configuration is retired (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the configuration becomes valid for use.',
    `hardware_revision` STRING COMMENT 'Revision identifier for the ATE hardware bundle (e.g., Rev A, Rev B).',
    `instrument_resource_allocation` STRING COMMENT 'List of instrument resources (e.g., power supplies, signal generators) allocated to this configuration.',
    `last_calibration_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent calibration activity.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the configuration.. Valid values are `active|inactive|retired|decommissioned`',
    `load_board_qualification_status` STRING COMMENT 'Current qualification status of the load board for production use.. Valid values are `qualified|pending|rejected`',
    `load_board_revision` STRING COMMENT 'Revision identifier of the load board / Device Interface Board used.',
    `maintenance_window` STRING COMMENT 'Scheduled maintenance window description (e.g., weekly Saturday 02:00‑04:00).',
    `max_parallel_site_count` STRING COMMENT 'Maximum number of test sites that can be exercised simultaneously.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the configuration.',
    `parametric_test_supported` BOOLEAN COMMENT 'Indicates whether parametric testing is enabled for this configuration.',
    `pin_electronics_card_map` STRING COMMENT 'Mapping description of pin‑to‑electronics card assignments for the configuration.',
    `platform_type` STRING COMMENT 'Type of test platform the configuration supports (wafer probe, final test, or reliability).. Valid values are `wafer_probe|final_test|reliability`',
    `supported_device_families` STRING COMMENT 'Comma‑separated list of device families (e.g., ASIC, SoC, FPGA) that this configuration can test.',
    `test_coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of functional test coverage provided by this configuration.',
    `test_yield_target_percentage` DECIMAL(18,2) COMMENT 'Target yield percentage that the configuration aims to achieve during test runs.',
    `tester_model` STRING COMMENT 'Model of the Automatic Test Equipment platform (e.g., Advantest V93000).. Valid values are `Advantest V93000|Teradyne UltraFlex|National Instruments PXI`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the configuration record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the configuration record.',
    `version` STRING COMMENT 'Semantic version identifier for the configuration (e.g., 1.2.0).',
    `warranty_expiration_date` DATE COMMENT 'Date when the hardware warranty for this configuration expires.',
    `created_by` STRING COMMENT 'User identifier of the person who created the configuration record.',
    CONSTRAINT pk_ate_configuration PRIMARY KEY(`ate_configuration_id`)
) COMMENT 'Master configuration record for Automatic Test Equipment (ATE) platform setups used across wafer probe and final test operations. Captures tester model and platform type (e.g., Advantest V93000, Teradyne UltraFlex), hardware configuration revision, pin electronics card map, load board/DIB (Device Interface Board) revision and qualification status, instrument resource allocation, calibration status and due date, supported device families, maximum parallel site count, and configuration effective dates. SSOT for ATE setup definitions that test runs reference for full equipment traceability. Links to equipment domain for physical asset and maintenance tracking.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`probe_card` (
    `probe_card_id` BIGINT COMMENT 'Unique identifier for the probe card.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Probe card maintenance, needle replacement, and depreciation expenses are allocated to cost centers for wafer probe operations cost tracking and budgeting.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Probe cards are exportable commodities requiring ECCN classification for international shipments to offshore test sites, cross-border transfers, and deemed export control when serviced by foreign nati',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the prober equipment to which the probe card is currently assigned.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.technology_node. Business justification: Probe cards are qualified per technology node; linking ensures traceability of card usage to node specifications for yield and reliability analysis.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Probe cards are capitalized fixed assets requiring depreciation tracking, asset tagging, and lifecycle management per GAAP/IFRS accounting standards for semiconductor manufacturing equipment.',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: Probe card design (needle pitch, die site layout, pad coordinates) is directly derived from the physical layouts die geometry (die_height_um, die_width_um, pad pitch). Probe card vendors require the ',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Probe card design (pitch, needle material) is process-node-dependent. Foundry compatibility verification and probe card inventory management by technology node require this linkage. No existing column',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Probe cards are precision assets requiring controlled storage (humidity, temperature, ESD protection). Asset management systems track storage location for retrieval, calibration scheduling, and enviro',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Probe cards are precision consumables procured from specialized suppliers. Tracking supplier_id enables quality performance tracking, warranty claims, needle replacement part ordering, and supplier sc',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Probe cards are designed for specific die layouts/pad configurations. Equipment planning, probe card qualification tracking, and maintenance scheduling require linking cards to target products. No exi',
    `card_name` STRING COMMENT 'Human‑readable name of the probe card used for identification in test engineering.',
    `compliance_status` STRING COMMENT 'Regulatory compliance classification applicable to the probe card.. Valid values are `itar|ear|rohs|none|restricted|export_control`',
    `contact_resistance_ohm` DECIMAL(18,2) COMMENT 'Measured electrical resistance of needle contacts in ohms.',
    `cost_usd` DECIMAL(18,2) COMMENT 'Acquisition cost of the probe card in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the probe card record was first created in the system.',
    `die_site_layout` STRING COMMENT 'Description of the die site arrangement on the wafer for this probe card.',
    `last_maintenance_date` DATE COMMENT 'Date when the probe card last underwent scheduled maintenance.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent test run that utilized the probe card.',
    `maintenance_cycle_months` STRING COMMENT 'Planned interval in months between preventive maintenance activities.',
    `needle_count` STRING COMMENT 'Total number of probing needles/pins on the card.',
    `needle_replacements` STRING COMMENT 'Cumulative number of needle replacement events performed on the card.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next preventive maintenance.',
    `notes` STRING COMMENT 'Any additional remarks or observations about the probe card.',
    `pitch_um` DECIMAL(18,2) COMMENT 'Center‑to‑center spacing of needles in micrometers.',
    `probe_card_description` STRING COMMENT 'Free‑form text describing special features, notes, or remarks about the probe card.',
    `probe_card_status` STRING COMMENT 'Current lifecycle state of the probe card within test operations.. Valid values are `in_service|retired|maintenance|decommissioned|qualified|failed`',
    `probe_card_type` STRING COMMENT 'Design classification of the probe card (e.g., cantilever, vertical, MEMS, advanced).. Valid values are `cantilever|vertical|mems|advanced|custom|other`',
    `qualification_date` DATE COMMENT 'Date when the probe card was qualified for production use.',
    `qualification_status` STRING COMMENT 'Current status of the probe card qualification process.. Valid values are `qualified|pending|failed|rejected|under_review`',
    `safety_classification` STRING COMMENT 'Safety classification level for handling the probe card.. Valid values are `class_a|class_b|class_c|class_d|class_e|class_f`',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number that uniquely identifies the physical probe card.',
    `touchdown_count` STRING COMMENT 'Number of successful needle contacts recorded per test cycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the probe card record.',
    `usage_hours` DECIMAL(18,2) COMMENT 'Total operational hours the probe card has been used in testing.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty for the probe card expires.',
    CONSTRAINT pk_probe_card PRIMARY KEY(`probe_card_id`)
) COMMENT 'Master record for probe cards used in wafer probing operations, owned by test engineering for qualification, assignment, and performance tracking. Captures probe card type (cantilever, vertical, MEMS, advanced), needle/pin count, pitch, technology node compatibility, die site layout, touchdown count, maintenance cycle, current condition status, and assigned prober tool. Tracks probe card lifecycle from incoming qualification through active use to retirement, including needle replacement history and contact resistance trending. Links to equipment domain for physical asset management while test domain owns operational qualification and assignment decisions.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`bin_definition` (
    `bin_definition_id` BIGINT COMMENT 'Unique surrogate key for each bin definition record.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Bin maps are product-specific (each IC has unique yield/quality classification bins). Production control systems, yield analysis, and wafer sort operations require linking bin definitions to products.',
    `insertion_id` BIGINT COMMENT 'Foreign key linking to test.insertion. Business justification: Bin definitions are often insertion-specific — wafer sort bins and final test bins differ. The bin_definition already has test_level (string) which suggests insertion-level differentiation. Linking bi',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Bin definitions belong to a test program; many bins per program, so add FK from bin_definition to test_program.',
    `bin_category` STRING COMMENT 'Classification of the bin outcome according to JEDEC taxonomy.. Valid values are `pass|functional_fail|parametric_fail|contact_fail|leakage_fail`',
    `bin_code` STRING COMMENT 'Alphanumeric code used in test programs to reference the bin.',
    `bin_definition_description` STRING COMMENT 'Detailed free‑text description of the bin purpose and usage.',
    `bin_definition_status` STRING COMMENT 'Current lifecycle status of the bin definition.. Valid values are `active|inactive|deprecated`',
    `bin_name` STRING COMMENT 'Human‑readable name describing the purpose of the bin.',
    `bin_number` BIGINT COMMENT 'Numeric identifier assigned to the test bin within a test program.',
    `bin_sort_order` STRING COMMENT 'Display order for bins in reports and UI.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bin definition record was first created.',
    `device_family` STRING COMMENT 'Product family or platform to which the bin definition applies.',
    `disposition_rule` STRING COMMENT 'Action to be taken for devices falling into this bin.. Valid values are `ship|scrap|rework|hold`',
    `effective_from` DATE COMMENT 'Date when the bin definition becomes active.',
    `effective_until` DATE COMMENT 'Date when the bin definition is retired (null if indefinite).',
    `failure_mode` STRING COMMENT 'Root cause or failure mechanism associated with the bin.',
    `is_default` BOOLEAN COMMENT 'Flag indicating whether this bin is the default for its category.',
    `parameter_set` STRING COMMENT 'Set of parametric test parameters associated with the bin.',
    `test_level` STRING COMMENT 'Stage of testing where the bin is applied.. Valid values are `wafer|final|reliability`',
    `updated_by` STRING COMMENT 'User identifier who last modified the bin definition record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bin definition.',
    `yield_impact_classification` STRING COMMENT 'Indicates how the bin affects overall wafer or lot yield.. Valid values are `high|medium|low|none`',
    `created_by` STRING COMMENT 'User identifier who created the bin definition record.',
    CONSTRAINT pk_bin_definition PRIMARY KEY(`bin_definition_id`)
) COMMENT 'Reference master defining all test bin codes used in wafer sort and final test. Captures bin number, bin name, bin category (pass, functional fail, parametric fail, contact fail, leakage fail), disposition rule (ship, scrap, rework, hold), yield impact classification, and associated failure mode. Provides standardized bin taxonomy across all test programs and device families per JEDEC and internal standards.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` (
    `wafer_probe_run_id` BIGINT COMMENT 'Unique identifier for each wafer probing execution event.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Billing & Reporting: wafer probe runs are billed to the customer account that owns the wafer lot, required for financial and compliance reports.',
    `ate_configuration_id` BIGINT COMMENT 'FK to test.ate_configuration.ate_configuration_id — Each probe run executes on a specific ATE configuration. Required for traceability and equipment correlation analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each wafer probe run incurs direct costs (labor, equipment time, consumables) that must be charged to a cost center for production cost accounting and variance tracking.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Wafer probe runs for export-controlled devices must track license consumption for government reporting, license utilization monitoring, and compliance audits when tested wafers are shipped internation',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the wafer prober equipment used.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: Wafer probe yield is correlated to the originating fabrication lot for process excursion analysis and yield learning — a core YMS workflow. Yield engineers must trace probe bin results back to the spe',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Wafer Probe Run records must be associated with the IC catalog entry to trace probe results to the specific product version.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Wafer probe runs are performed on wafers from a given design project; yield analysis links probe data to the originating IC design project.',
    `insertion_id` BIGINT COMMENT 'Foreign key linking to test.insertion. Business justification: Wafer probe runs execute at a specific test insertion point (wafer sort is a defined insertion in the test flow). The insertion entity defines the test insertion architecture including sequence order,',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Internal order captures labor and equipment cost for each wafer probe run; used in cost‑of‑goods‑sold calculations.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Probe test results at order line granularity enable SKU-level yield tracking, customer part number specific test data reporting, and RMA root cause analysis requiring order line → probe run → failure ',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: Probe testing occurs after specific lot process runs. Test engineers correlate probe yield with exact process run conditions (temperature, pressure, time) to identify excursions, optimize processes, a',
    `physical_layout_id` BIGINT COMMENT 'Foreign key linking to design.physical_layout. Business justification: Wafer probe runs are executed on die whose pad geometry is defined by the physical layout. Linking wafer_probe_run to physical_layout enables probe yield correlation against layout iterations (DFM sco',
    `probe_card_id` BIGINT COMMENT 'Identifier of the probe card installed on the prober for this run.',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Wafer probe runs are executed under a specific test program; replace version string with FK to test_program.',
    `process_step_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_process_step. Business justification: Wafer probe insertions occur at defined steps within the fabrication process flow (e.g., post-metal, final probe). Linking the probe run to the specific fabrication process step enables process engine',
    `wafer_id` BIGINT COMMENT 'Foreign key linking to fabrication.wafer. Business justification: Wafer probe runs are executed on individual wafers. Traceability from probe results to the specific fabrication wafer (substrate type, resistivity, epitaxial data) is essential for wafer-level yield a',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Wafer probe yield and throughput metrics are tracked by profit center for product line profitability analysis and capacity allocation decisions.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Wafer probe runs consume materials (probe cards, test interface boards, consumables) procured via purchase orders. Enables test cost allocation, material traceability, and variance analysis between pl',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to process.process_qualification. Business justification: Probe yield data is a key qualification metric. Process qualification records must link to probe runs that demonstrate process capability (Cpk, yield) for customer approval and production release.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Wafer probe testing executes against specific process recipes. Test engineers correlate probe yield and parametric results with exact recipes for yield learning, failure analysis, and process optimiza',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Probe runs are scheduled after a specific process step; the Probe Run Scheduling dashboard needs the step reference to track yield impact.',
    `wafer_probe_card_id` BIGINT COMMENT 'FK to test.probe_card.probe_card_id — Probe card assignment is critical for wafer probe operations — probe card condition directly impacts yield and contact quality.',
    `ate_configuration` STRING COMMENT 'Configuration identifier for the Automatic Test Equipment used in the run.. Valid values are `CFG-w{3,}`',
    `bin_map_version` STRING COMMENT 'Version identifier of the binning map used to classify die test results.',
    `contact_yield_percent` DECIMAL(18,2) COMMENT 'Percentage of dies that made electrical contact during probing.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the wafer probing run completed or was terminated.',
    `fail_die_count` STRING COMMENT 'Number of dies that failed one or more test criteria.',
    `gross_die_count` STRING COMMENT 'Total die count before any filtering (e.g., before known‑good die certification).',
    `parametric_test_data_available` BOOLEAN COMMENT 'Indicates whether parametric test measurements were captured for this run.',
    `pass_die_count` STRING COMMENT 'Number of dies that passed all test criteria.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this run record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this run record.',
    `remarks` STRING COMMENT 'Free‑form notes or comments entered by the operator or quality engineer.',
    `run_number` STRING COMMENT 'Business identifier assigned to the probe run, typically following the pattern RUN-######.. Valid values are `RUN-d{6}`',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the wafer probing run started.',
    `test_coverage_percent` DECIMAL(18,2) COMMENT 'Proportion of functional tests executed relative to the total test plan.',
    `total_die_count` STRING COMMENT 'Total number of dies present on the wafer.',
    `wafer_probe_run_status` STRING COMMENT 'Current lifecycle status of the probe run.. Valid values are `scheduled|running|completed|failed|canceled`',
    `wafer_sequence_number` STRING COMMENT 'Sequential number of the wafer within the lot.',
    CONSTRAINT pk_wafer_probe_run PRIMARY KEY(`wafer_probe_run_id`)
) COMMENT 'Transactional record capturing each wafer probing execution event. Records wafer lot ID, wafer sequence number, probe card used, ATE configuration, test program version, prober tool, start and end timestamps, total die count, pass die count, fail die count, contact yield, gross die count, and operator ID. Core operational event for wafer-level electrical test and die sort operations.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`unit_test_result` (
    `unit_test_result_id` BIGINT COMMENT 'Primary key for unit_test_result',
    `case_id` BIGINT COMMENT 'Foreign key linking to test.test_case. Business justification: Unit test results are produced by executing specific test cases. test_case is the master reference defining what test was performed (test_case_name, test_case_type, pass_fail_criteria via test_step). ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Unit-level test costs are allocated to cost centers for per-die cost accounting, enabling accurate product costing and margin analysis in semiconductor manufacturing.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Each die test result is linked to the devices ECCN classification for export‑control compliance reporting and analytics.',
    `excursion_id` BIGINT COMMENT 'Foreign key linking to process.excursion. Business justification: Test failures may be caused by process excursions. Linking test results to excursion records enables impact assessment, lot disposition, and customer notification. Critical for excursion containment a',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment (ATE) used.',
    `final_test_run_id` BIGINT COMMENT 'FK to test.final_test_run.final_test_run_id — Package-level test results must link back to the final test run event. Required for lot disposition and DPPM tracking.',
    `insertion_id` BIGINT COMMENT 'Foreign key linking to test.insertion. Business justification: Unit test results are produced at specific test insertions (wafer sort, final test, system-level test, etc.). The insertion entity defines the complete test insertion architecture for each device type',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Unit test results must be traceable to the inventory wafer lot for quality tracking and stock accounting.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Individual die/unit test results must trace to order lines for serialized traceability, customer-specific screening (automotive/aerospace grade), and warranty claim investigation requiring unit serial',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: Die-level test results must trace to specific lot process runs for root cause analysis. Engineers use this link to correlate test failures with process run parameters, identify tool-specific issues, a',
    `netlist_id` BIGINT COMMENT 'Foreign key linking to design.netlist. Business justification: Die test results are correlated to the netlist version used for synthesis; debugging reports require the netlist_id reference.',
    `bin_definition_id` BIGINT COMMENT 'FK to test.bin_definition.bin_definition_id — Every unit test result is assigned a bin code from the bin_definition master. This is the core yield classification link.',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Unit test results are produced by a test program; add FK to capture the originating program.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Individual die test results must be traceable to process recipes for failure analysis and yield improvement. Engineers use recipe-level traceability to identify systematic defects, optimize process pa',
    `test_step_id` BIGINT COMMENT 'Foreign key linking to test.test_step. Business justification: Unit test results are produced at specific test steps within a test program. test_step defines individual steps including step_type, pass_fail_criteria, and measurement_unit. Linking unit_test_result ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Each tested unit is a specific SKU variant. RMA root cause analysis, customer quality reports, and traceability regulations require linking individual test results to the exact SKU tested. No existing',
    `wafer_id` BIGINT COMMENT 'Identifier of the wafer containing the unit.',
    `wafer_probe_run_id` BIGINT COMMENT 'FK to test.wafer_probe_run.wafer_probe_run_id — Die-level test results from wafer probing must link back to the probe run event. Required for wafer map generation and lot traceability.',
    `assembly_position` STRING COMMENT 'Position identifier for multi-die or chiplet assemblies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result record was created in the system.',
    `device_serial_number` STRING COMMENT 'Serial number of the packaged device, if applicable.',
    `hard_bin_code` STRING COMMENT 'Hard bin classification assigned to the unit based on test outcome.',
    `kgd_status` STRING COMMENT 'Qualification status of the unit as a Known Good Die.. Valid values are `kgd|non_kgd|pending`',
    `measurement_summary` STRING COMMENT 'Concise summary of parametric measurement values for the unit.',
    `measurement_units` STRING COMMENT 'Units of the parametric measurements reported. [ENUM-REF-CANDIDATE: C|V|Ohm|nA|pF|%|dB — 7 candidates stripped; promote to reference product]',
    `parametric_flags` STRING COMMENT 'Flags indicating which parametric tests were executed or passed.',
    `pass_fail` STRING COMMENT 'Overall pass or fail result for the unit.. Valid values are `pass|fail`',
    `retest_count` STRING COMMENT 'Number of times the unit has been retested.',
    `retest_indicator` BOOLEAN COMMENT 'Indicates whether the unit was retested after an initial failure.',
    `soft_bin_code` STRING COMMENT 'Soft bin classification for detailed failure analysis.',
    `source_system` STRING COMMENT 'Source system that generated the test result record.. Valid values are `Camstar|KLA|Custom|Other`',
    `test_condition` STRING COMMENT 'Descriptive condition of the test environment.. Valid values are `room_temp|high_temp|low_temp|stress`',
    `test_result_comment` STRING COMMENT 'Free-text comments or notes associated with the test result.',
    `test_result_version` STRING COMMENT 'Version identifier of the test result format or schema.',
    `test_stage` STRING COMMENT 'Discriminator indicating the test insertion stage where the result was captured.. Valid values are `wafer_probe|die_sort|final_test|system_level_test`',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the unit was tested, in degrees Celsius.',
    `test_time_seconds` DECIMAL(18,2) COMMENT 'Total duration of the test execution for the unit, in seconds.',
    `test_timestamp` TIMESTAMP COMMENT 'Date and time when the test was performed.',
    `test_voltage_v` DECIMAL(18,2) COMMENT 'Voltage level applied during testing, in volts.',
    `test_yield_flag` BOOLEAN COMMENT 'Indicates if the unit is counted towards lot yield calculations.',
    `unit_identifier` STRING COMMENT 'Identifier of the tested unit, expressed as wafer X/Y coordinates for wafer-level or serial number for package-level.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test result record.',
    CONSTRAINT pk_unit_test_result PRIMARY KEY(`unit_test_result_id`)
) COMMENT 'Transactional record capturing individual unit-level test results from all test insertions including wafer probing, die sort, final test, and system-level test (SLT). Records unit identifier (X/Y die coordinates for wafer-level or device serial/unit position for package-level), test insertion stage discriminator, assigned hard-bin and soft-bin codes per bin_definition, pass/fail status, total test time, parametric measurement summary flags, retest indicator and retest count, KGD (Known Good Die) qualification status, multi-die/chiplet assembly position, and test temperature/voltage condition. Serves as the single source of truth for all unit-level test outcomes across the entire test flow, enabling wafer map generation, unit-level yield analysis, full lot traceability, and die-to-package correlation. Aligns with STDF PTR/FTR/MPR record concepts.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`final_test_run` (
    `final_test_run_id` BIGINT COMMENT 'Unique internal identifier for the package-level test execution event.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Delivery Acceptance: final test results are associated with the customer account to confirm product acceptance and trigger invoicing.',
    `ate_configuration_id` BIGINT COMMENT 'FK to test.ate_configuration.ate_configuration_id — Final test runs execute on specific ATE configurations. Required for equipment utilization and correlation analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Final test operations labor, equipment, and handler costs are charged to cost centers for production cost tracking and budget variance analysis.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Final test of devices slated for export must be tied to the governing export license to satisfy USML/EAR control reporting.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the specific ATE equipment unit used.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Final test runs validate a completed process flow; the Final Test Yield Summary links each run to its originating flow.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Final test run outcomes are reported per IC product to support qualification, release, and compliance documentation.',
    `insertion_id` BIGINT COMMENT 'Foreign key linking to test.insertion. Business justification: Final test runs execute at a specific test insertion point (final test, system-level test are defined insertions). The insertion entity defines the test insertion architecture including sequence order',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Final test execution costs are booked to an internal order for expense tracking and profitability reporting.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Final test run outcomes are recorded against the inventory wafer lot to update inventory status and yield metrics.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Final test results at order line level enable customer part number specific test data, line-item yield tracking, and warranty analysis. Critical for automotive customers requiring serialized traceabil',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Final test runs are generated by a specific test program; add FK to capture this relationship.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Final test validates devices produced with specific process recipes. Quality teams track recipe-to-test correlations for yield learning, process qualification, and customer quality reporting. Essentia',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Final test is executed on taped‑out silicon; the Final Test Yield report must reference the tapeout_id for traceability.',
    `ate_name` STRING COMMENT 'Name or model of the ATE system executing the test.',
    `bin_distribution` STRING COMMENT 'Compact representation of test bin counts (e.g., JSON or delimited string).',
    `boot_success_count` STRING COMMENT 'Number of devices that successfully booted during SLT.',
    `comments` STRING COMMENT 'Free‑form notes captured by the operator or system.',
    `defect_code` STRING COMMENT 'Standardized code describing the primary failure mode when the run fails.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the test execution completed.',
    `fail_count` STRING COMMENT 'Number of devices that failed one or more test criteria.',
    `final_test_run_status` STRING COMMENT 'Current lifecycle status of the test run.. Valid values are `pending|running|completed|failed`',
    `handler_name` STRING COMMENT 'Identifier of the handler module that loads devices into the ATE.',
    `parametric_test_fail` STRING COMMENT 'Count of parametric test points that failed.',
    `parametric_test_pass` STRING COMMENT 'Count of parametric test points that passed.',
    `pass_count` STRING COMMENT 'Number of devices that passed all test criteria.',
    `power_consumption_mw` DECIMAL(18,2) COMMENT 'Measured average power consumption during system‑level test, in milliwatts.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when this test run record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to this test run record.',
    `slt_board_code` STRING COMMENT 'Identifier of the board used for system‑level testing, if applicable.',
    `socket_code` STRING COMMENT 'Identifier of the socket used to hold the device during testing.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the test execution started.',
    `test_location` STRING COMMENT 'Code of the laboratory or floor where the test was performed.',
    `test_program_version` STRING COMMENT 'Version identifier of the ATE test program used for this run.',
    `test_result` STRING COMMENT 'Aggregated result of the test run.. Valid values are `pass|fail`',
    `test_run_code` STRING COMMENT 'Business identifier assigned to the test run, used for tracking across systems.',
    `test_shift` STRING COMMENT 'Work shift during which the test run was executed.. Valid values are `A|B|C|D`',
    `test_temperature_c` DECIMAL(18,2) COMMENT 'Temperature at which the test was performed, expressed in degrees Celsius.',
    `test_time_seconds` DECIMAL(18,2) COMMENT 'Total duration of the test execution for the device.',
    `test_type` STRING COMMENT 'Discriminator indicating whether the run is a final test or system‑level test (SLT).. Valid values are `final_test|slt`',
    `total_sites` STRING COMMENT 'Number of parallel test sites active on the ATE for this run.',
    `yield_percent` DECIMAL(18,2) COMMENT 'Yield of the test run expressed as a percentage of passed devices.',
    CONSTRAINT pk_final_test_run PRIMARY KEY(`final_test_run_id`)
) COMMENT 'Transactional record for package-level test execution events on ATE including final test and system-level test (SLT). Captures device lot ID, package type, test type discriminator (final_test, SLT), test configuration (socket, ATE, handler, SLT board), test program version, test temperature, test time, pass/fail counts, bin distribution, power consumption (SLT), boot success (SLT), and test site count. Covers all post-packaging test operations distinct from wafer-level probing.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`parametric_measurement` (
    `parametric_measurement_id` BIGINT COMMENT 'Unique surrogate key for each parametric measurement record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Quality Compliance: parametric measurements are reported back to the owning customer account for quality assurance and regulatory compliance.',
    `bin_definition_id` BIGINT COMMENT 'Foreign key linking to test.bin_definition. Business justification: Parametric measurements reference a bin definition; replace ad‑hoc bin fields with FK to bin_definition.',
    `calibration_record_id` BIGINT COMMENT 'Identifier of the calibration record applied to the equipment for this measurement.',
    `case_id` BIGINT COMMENT 'Foreign key linking to test.test_case. Business justification: Parametric measurements are taken as part of specific test cases. test_case is the master reference defining the test being performed. Linking parametric_measurement to test_case enables traceability ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Parametric test activities consume equipment time and engineering resources that are allocated to cost centers for test operations cost accounting and budgeting.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment (ATE, probe card, etc.) that generated the measurement.',
    `final_test_run_id` BIGINT COMMENT 'Foreign key linking to test.final_test_run. Business justification: Parametric measurements are captured during both wafer probe and final test (package-level) operations. The domain description explicitly states parametric_measurement stores measurements captured dur',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Parametric measurements need the IC catalog reference to correlate measured values with product specifications.',
    `insertion_id` BIGINT COMMENT 'Foreign key linking to test.insertion. Business justification: Parametric measurements are taken at specific test insertions (wafer probe insertion, final test insertion, etc.). The insertion entity defines the test insertion architecture. Linking parametric_meas',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Parametric measurements are associated with the inventory wafer lot for SPC and statistical analysis.',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: Parametric measurements correlate with specific process run conditions. Engineers use this for real-time process control, excursion detection, and tool matching studies. Critical for SPC and advanced ',
    `unit_test_result_id` BIGINT COMMENT 'Identifier linking to the overall test result set for the die.',
    `parametric_unit_test_result_id` BIGINT COMMENT 'FK to test.unit_test_result.unit_test_result_id — Parametric measurements are captured per unit under test. Must link to the parent unit result for traceability.',
    `wafer_id` BIGINT COMMENT 'Identifier of the individual die on which the measurement was performed.',
    `process_step_id` BIGINT COMMENT 'Identifier of the specific test step within the program.',
    `program_id` BIGINT COMMENT 'Identifier of the test program or ATPG pattern set used for the measurement.',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Parametric measurements (Vt, Idsat, leakage) are direct outputs of process recipes. Process engineers use recipe-level parametric data for SPC, recipe optimization, and process capability studies. Cri',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Parametric measurements are captured after a defined process step; required for the Process Step Parameter Trending report.',
    `tapeout_id` BIGINT COMMENT 'Foreign key linking to design.tapeout. Business justification: Parametric measurements are taken on final silicon; regulatory and reliability reports link each measurement to the tapeout that produced the device.',
    `wafer_probe_run_id` BIGINT COMMENT 'Foreign key linking to test.wafer_probe_run. Business justification: Parametric measurements are captured during wafer probe runs. While parametric_measurement already links to unit_test_result (which in turn links to wafer_probe_run), a direct FK to wafer_probe_run is',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement event was captured by the test system.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Lower acceptable bound for the parameter as defined by the product spec.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric value recorded for the test parameter.',
    `measurement_average_value` DECIMAL(18,2) COMMENT 'Average of repeated measurements for the parameter.',
    `measurement_comment` STRING COMMENT 'Free‑form comment entered by the operator or analyst.',
    `measurement_condition_frequency_mhz` DECIMAL(18,2) COMMENT 'Frequency condition during the measurement, expressed in megahertz.',
    `measurement_condition_temperature_c` DECIMAL(18,2) COMMENT 'Temperature condition during the measurement, expressed in degrees Celsius.',
    `measurement_condition_voltage_mv` DECIMAL(18,2) COMMENT 'Voltage condition applied during the measurement, expressed in millivolts.',
    `measurement_evaluated_against_limit` BIGINT COMMENT 'FK to test.test_limit.test_limit_id — Each parametric measurement is evaluated against specification limits defined in test_limit. This link enables pass/fail determination and SPC analysis.',
    `measurement_flagged` BOOLEAN COMMENT 'Indicates if the measurement was flagged for outlier review.',
    `measurement_for_unit_result` BIGINT COMMENT 'FK to test.die_test_result.die_test_result_id — Parametric measurements are captured for specific die/device test results. This is the detail-level link from measurement to the unit being tested.',
    `measurement_location` STRING COMMENT 'Physical location on the die where the measurement was taken.. Valid values are `center|edge`',
    `measurement_mode` STRING COMMENT 'Mode of the test, indicating whether the measurement is parametric or functional.. Valid values are `parametric|functional`',
    `measurement_quality_flag` STRING COMMENT 'Quality assessment of the measurement data.. Valid values are `good|questionable|bad`',
    `measurement_repeat_count` STRING COMMENT 'Number of times the parameter was measured in this test cycle.',
    `measurement_review_status` STRING COMMENT 'Current review status of the measurement.. Valid values are `pending|reviewed|closed`',
    `measurement_review_timestamp` TIMESTAMP COMMENT 'Timestamp when the measurement review was completed.',
    `measurement_sequence` STRING COMMENT 'Ordinal position of this measurement within the test program.',
    `measurement_source` STRING COMMENT 'Source of the measurement data, e.g., probe card or automatic test equipment.. Valid values are `probe_card|ATE`',
    `measurement_status` STRING COMMENT 'Lifecycle status of the measurement record.. Valid values are `recorded|validated|rejected`',
    `measurement_std_dev` DECIMAL(18,2) COMMENT 'Statistical standard deviation of repeated measurements.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Exact time the physical measurement occurred (may differ from ingestion time).',
    `measurement_tool_version` STRING COMMENT 'Software/firmware version of the test tool that generated the measurement.',
    `measurement_type` STRING COMMENT 'Indicates whether the measurement is analog or digital.. Valid values are `analog|digital`',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Estimated uncertainty of the measured value.',
    `parametric_against_limit` BIGINT COMMENT 'FK to test.test_limit.test_limit_id — Each parametric measurement is evaluated against a test limit specification. Required for pass/fail determination and SPC.',
    `parametric_checked_against_limit` BIGINT COMMENT 'FK to test.test_limit.test_limit_id — Each parametric measurement is evaluated against a test limit. This FK enables limit-vs-actual analysis and SPC trending.',
    `pass_fail_status` STRING COMMENT 'Result of the measurement against spec limits.. Valid values are `pass|fail`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the measurement record was first persisted in the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the measurement record.',
    `test_parameter_name` STRING COMMENT 'Name of the specific parametric test parameter (e.g., Vth, Idsat).',
    `unit_of_measure` STRING COMMENT 'Engineering unit associated with the measured value. [ENUM-REF-CANDIDATE: V|mV|A|mA|Ohm|C|K|Hz — 8 candidates stripped; promote to reference product]',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper acceptable bound for the parameter as defined by the product spec.',
    CONSTRAINT pk_parametric_measurement PRIMARY KEY(`parametric_measurement_id`)
) COMMENT 'Transactional record storing individual parametric test measurements captured during wafer probe and final test. Records test parameter name, measured value, lower specification limit (LSL), upper specification limit (USL), pass/fail status, measurement unit, test condition (voltage, temperature, frequency), and associated die or device result. Enables SPC analysis, parametric yield optimization, and process-test correlation studies.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`limit` (
    `limit_id` BIGINT COMMENT 'System-generated unique identifier for the test limit record.',
    `bin_definition_id` BIGINT COMMENT 'Foreign key linking to test.bin_definition. Business justification: Parametric test limits are associated with specific bin definitions — when a unit fails a limit, it is assigned to a specific bin. The limit entity has bin_mapping_code (string) which is a denormalize',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Test limits are defined per IC catalog entry to ensure each product revision meets its specification envelope.',
    `insertion_id` BIGINT COMMENT 'Foreign key linking to test.insertion. Business justification: Parametric test limits are often insertion-specific — wafer sort limits and final test limits differ for the same parameter. The insertion entity defines the test insertion architecture. Linking limit',
    `pdk_id` BIGINT COMMENT 'Foreign key linking to design.pdk. Business justification: Test limits are defined per process node; the Test Limit Specification requires the PDK identifier to ensure correct corner definitions.',
    `program_id` BIGINT COMMENT 'Identifier of the ATPG or ATE program that consumes this limit.',
    `approval_status` STRING COMMENT 'Current approval state of the limit record.. Valid values are `pending|approved|rejected|revoked`',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the limit.',
    `audit_trail` STRING COMMENT 'Chronological log of actions performed on the limit record.',
    `change_reason` STRING COMMENT 'Narrative explanation for why the limit was changed.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard governing the limit.. Valid values are `SEMI|JEDEC|IEC|ISO`',
    `created_by_department` STRING COMMENT 'Organizational department responsible for creating the limit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the limit record was first created.',
    `data_source` STRING COMMENT 'Origin of the measurement data used for the limit.. Valid values are `ATE|ATPG|simulation|lab`',
    `device_type` STRING COMMENT 'Classification of the semiconductor device (e.g., ASIC, SoC, FPGA) to which the limit applies.',
    `effective_date` DATE COMMENT 'Date on which the limit becomes active for production testing.',
    `expiration_date` DATE COMMENT 'Date after which the limit is no longer valid (null for open‑ended).',
    `is_active` BOOLEAN COMMENT 'Indicates whether the limit is currently active in the test flow.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the limit.',
    `limit_category` STRING COMMENT 'High‑level category of the limit.. Valid values are `voltage|current|resistance|capacitance|frequency|temperature`',
    `limit_source` STRING COMMENT 'Origin of the limit definition.. Valid values are `design|customer|regulatory|internal`',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable measured value for the parameter.',
    `measurement_type` STRING COMMENT 'Category of measurement the limit belongs to.. Valid values are `parametric|functional|timing`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the limit.',
    `parameter_name` STRING COMMENT 'Human‑readable name of the parametric test parameter (e.g., Vdd, Idd).',
    `product_revision` STRING COMMENT 'Internal revision identifier of the product (e.g., A1, B2) linked to the limit.',
    `regulatory_flag` BOOLEAN COMMENT 'True if the limit is mandated by a regulatory requirement.',
    `review_cycle` STRING COMMENT 'Scheduled frequency for limit review.. Valid values are `annual|semiannual|quarterly`',
    `risk_level` STRING COMMENT 'Risk classification associated with the limit deviation.. Valid values are `low|medium|high|critical`',
    `sample_size` STRING COMMENT 'Number of samples used to calculate the limit.',
    `statistical_method` STRING COMMENT 'Statistical approach used to derive the limit.. Valid values are `mean|median|percentile|sigma`',
    `target_value` DECIMAL(18,2) COMMENT 'Nominal target value that the process aims to achieve.',
    `test_condition_set` STRING COMMENT 'Named set of test conditions (temperature, voltage, frequency) under which the limit is valid.',
    `test_flow_name` STRING COMMENT 'Name of the test flow or sequence where the limit is applied.',
    `tolerance_percent` DECIMAL(18,2) COMMENT 'Allowed percentage deviation from the target value.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the limit values. [ENUM-REF-CANDIDATE: V|mV|A|mA|Ohm|kOhm|nF|pF|C|% — 10 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the limit record.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable measured value for the parameter.',
    `version` STRING COMMENT 'Version identifier for the limit record, incremented on each change.',
    `version_history` STRING COMMENT 'JSON or delimited text capturing historical versions of the limit.',
    CONSTRAINT pk_limit PRIMARY KEY(`limit_id`)
) COMMENT 'Master record defining parametric test limits for each test parameter by device type, product revision, and test condition. Captures parameter name, LSL, USL, target value, measurement unit, test condition set, limit revision history, effective date, and approval status. SSOT for all test specification limits used across ATPG programs and ATE test flows. Supports limit change management and PCN-driven limit updates.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`coverage` (
    `coverage_id` BIGINT COMMENT 'Unique surrogate key for each test coverage record.',
    `ic_catalog_id` BIGINT COMMENT 'Surrogate key linking to the device type master data.',
    `coverage_ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Test coverage reports are generated per IC product to assess validation completeness before tape‑out.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Test coverage metrics are reported per design project; the Design Coverage Dashboard aggregates coverage by ic_design_project_id.',
    `insertion_id` BIGINT COMMENT 'Foreign key linking to test.insertion. Business justification: Test coverage metrics are measured per test insertion point. The insertion entity defines the test insertion architecture including test_coverage_percent and yield_gate_criteria_percent. Linking cover',
    `program_id` BIGINT COMMENT 'Surrogate key linking to the master test program entity.',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to process.process_qualification. Business justification: Test coverage analysis is required for process qualification sign-off. Qualification records must reference coverage studies (stuck-at, transition, path delay) to demonstrate adequate defect detection',
    `verification_plan_id` BIGINT COMMENT 'Foreign key linking to design.verification_plan. Business justification: Coverage records actual achieved fault/functional coverage percentages; verification_plan defines the coverage targets (fault_coverage_target_pct, functional_coverage_target_pct). Linking them enables',
    `comments` STRING COMMENT 'Free‑form notes or observations about the coverage run.',
    `correlation_score` DECIMAL(18,2) COMMENT 'Score indicating correlation between wafer‑level and package‑level test results.',
    `coverage_category` STRING COMMENT 'High‑level category of coverage measured (functional, parametric, structural, timing).. Valid values are `functional|parametric|structural|timing`',
    `coverage_date` DATE COMMENT 'Calendar date on which the coverage metrics were measured.',
    `coverage_method` STRING COMMENT 'Method used to obtain coverage metrics.. Valid values are `simulation|silicon|mixed`',
    `coverage_status` STRING COMMENT 'Current lifecycle status of the coverage record.. Valid values are `draft|active|retired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the coverage record was first created in the system.',
    `defect_density` DECIMAL(18,2) COMMENT 'Number of defects per unit area observed during testing.',
    `device_type` STRING COMMENT 'Logical classification of the device (e.g., ASIC, SoC, FPGA) for which coverage is measured.',
    `dft_structure_coverage_percent` DECIMAL(18,2) COMMENT 'Coverage of DFT structures such as scan chains, BIST, and boundary‑scan.',
    `fault_coverage_percent` DECIMAL(18,2) COMMENT 'Overall percentage of detectable faults covered by the test program.',
    `iddq_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of IDDQ (quiescent current) tests covered.',
    `is_approved` BOOLEAN COMMENT 'Indicates whether the coverage record has been formally approved.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the coverage level is critical for tapeout readiness.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent formal review of the coverage data.',
    `path_delay_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of timing paths meeting delay specifications.',
    `source_system` STRING COMMENT 'Originating system that supplied the coverage data (e.g., MES, PLM).',
    `stuck_at_fault_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of stuck‑at faults covered.',
    `tapeout_ready` BOOLEAN COMMENT 'True if the coverage meets the tapeout release criteria.',
    `test_program_version` STRING COMMENT 'Version identifier of the test program associated with this coverage record.',
    `tool` STRING COMMENT 'Name of the software tool used to generate coverage metrics.',
    `tool_version` STRING COMMENT 'Version identifier of the coverage analysis tool.',
    `total_faults` STRING COMMENT 'Total number of fault models considered for coverage analysis.',
    `transition_fault_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of transition‑faults covered.',
    `units` STRING COMMENT 'Units for coverage metrics, typically percent.',
    `untestable_fault_count` STRING COMMENT 'Number of faults that cannot be tested with the current program.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the coverage record.',
    `version_number` STRING COMMENT 'Sequential version number for the coverage record.',
    `yield_estimate_percent` DECIMAL(18,2) COMMENT 'Projected silicon yield based on current coverage levels.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_coverage PRIMARY KEY(`coverage_id`)
) COMMENT 'Master record tracking test coverage metrics for each test program version by device type. Captures fault coverage percentage, stuck-at fault coverage, transition fault coverage, path delay coverage, IDDQ coverage, DFT structure coverage (scan chains, BIST, boundary scan), and untestable fault count. Links test program to design DFT intent and supports tapeout readiness reviews.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`reliability_test_run` (
    `reliability_test_run_id` BIGINT COMMENT 'System-generated unique identifier for each reliability test run record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Warranty & Reliability Reporting: reliability test outcomes are linked to the customer account for warranty claims and reliability guarantees.',
    `ate_configuration_id` BIGINT COMMENT 'Foreign key linking to test.ate_configuration. Business justification: Reliability tests (burn-in, qualification, stress screening) are executed on ATE platforms with specific configurations. The ate_configuration entity captures the ATE platform setup including tester_m',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reliability testing (burn-in, stress testing) is a distinct cost center activity with dedicated equipment, labor, and budget for qualification and failure analysis.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Reliability test data for export-controlled devices requires ECCN tracking to enforce data export restrictions, control sharing with foreign entities, and manage deemed export when foreign nationals a',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the test equipment (ATE, probe station) used for the run.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: JEDEC JESD47 qualification requires reliability tests (HTOL, ELFR, TDDB) to be explicitly tied to a technology node for node-level qualification sign-off. Reliability engineers track qualification sta',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Identifier of the wafer lot from which the tested devices were drawn.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Reliability test runs must be linked to the IC catalog entry to track long‑term performance and warranty metrics per product.',
    `ic_design_project_id` BIGINT COMMENT 'Foreign key linking to design.ic_design_project. Business justification: Reliability qualification runs (HTOL, ELFR, TDDB) are executed against specific IC design projects for JEDEC and AEC-Q100 qualification. Linking to ic_design_project enables qualification status track',
    `insertion_id` BIGINT COMMENT 'Foreign key linking to test.insertion. Business justification: Reliability test runs (burn-in, qualification, stress screening) correspond to specific test insertion points in the overall test flow. The insertion entity defines the complete test insertion archite',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Reliability test runs are executed on a specific inventory wafer lot; linking enables lot-level reliability tracking.',
    `program_id` BIGINT COMMENT 'FK to test.test_program.test_program_id — Reliability test executions (including burn-in) reference test programs for pre/post stress testing.',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to process.process_qualification. Business justification: Reliability testing is a required component of process qualification. Qualification records must reference reliability test runs (HTOL, burn-in, TDDB) for sign-off. Essential for customer qualificatio',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Reliability qualification (HTOL, TC, HAST) is performed on specific SKU grades (automotive, extended temp). Qualification status tracking and reliability reports are SKU-specific for customer certific',
    `recipe_id` BIGINT COMMENT 'Foreign key linking to process.recipe. Business justification: Reliability testing (HTOL, burn-in, TDDB) validates process recipe robustness. Qualification requires recipe-level reliability data to ensure long-term device performance. Essential for customer quali',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Reliability testing often uses specialized equipment or outsourced services from external suppliers (burn-in boards, environmental chambers, third-party test labs). Enables supplier performance tracki',
    `acceleration_factor` DOUBLE COMMENT 'Factor used to extrapolate stress results to normal operating conditions.',
    `bias_condition` STRING COMMENT 'Electrical bias applied to the device (e.g., Vdd=1.2V, ground), described in free text.',
    `burn_in_board_code` STRING COMMENT 'Identifier of the burn‑in board or fixture used for the test.',
    `compliance_standard` STRING COMMENT 'Applicable industry standard or specification (e.g., JEDEC JESD47) governing the test.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test run record was first created in the system.',
    `data_capture_rate_hz` DOUBLE COMMENT 'Sampling frequency of test data acquisition.',
    `duration_hours` DOUBLE COMMENT 'Total time the device is subjected to the stress conditions, expressed in hours.',
    `failure_count` STRING COMMENT 'Number of devices that failed during the test run.',
    `humidity_control_method` STRING COMMENT 'Method used to maintain humidity (e.g., saturated salt solution, humidifier).',
    `infant_mortality_rate` DOUBLE COMMENT 'Percentage of early‑life failures observed during the test.',
    `measurement_method` STRING COMMENT 'Technique used to capture test data (e.g., ATE, probe).',
    `notes` STRING COMMENT 'Free‑form comments or observations recorded by the operator.',
    `post_stress_yield_percent` DOUBLE COMMENT 'Yield percentage measured after stress exposure.',
    `pre_stress_yield_percent` DOUBLE COMMENT 'Yield percentage measured before applying stress.',
    `qualification_status` STRING COMMENT 'Result of the qualification assessment per JEDEC standards.. Valid values are `qualified|conditionally_qualified|rejected|pending`',
    `sample_size` STRING COMMENT 'Number of individual devices (dies) included in the test run.',
    `screen_effectiveness_percent` DOUBLE COMMENT 'Effectiveness of the stress screen in removing latent defects, expressed as a percentage.',
    `stress_humidity_percent` DOUBLE COMMENT 'Relative humidity level maintained during the stress test, expressed as a percentage.',
    `stress_mode` STRING COMMENT 'Pattern of stress application during the run.. Valid values are `constant|cyclic|step`',
    `stress_temperature_c` DOUBLE COMMENT 'Maximum temperature applied during the stress phase, expressed in degrees Celsius.',
    `stress_voltage_v` DOUBLE COMMENT 'Voltage level applied to the device under test during stress, expressed in volts.',
    `temperature_ramp_rate_c_per_min` DOUBLE COMMENT 'Rate at which temperature was increased during ramp‑up.',
    `test_batch_code` STRING COMMENT 'Identifier grouping multiple test runs executed as a batch.',
    `test_data_file_path` STRING COMMENT 'File system path or URI to the raw test data file.',
    `test_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the stress phase completed.',
    `test_failure_mode` STRING COMMENT 'Category of failure observed during the test.. Valid values are `parametric|functional|both`',
    `test_failure_rate_percent` DOUBLE COMMENT 'Percentage of devices that failed out of the sample.',
    `test_location` STRING COMMENT 'Physical location or fab where the test was performed.',
    `test_program_version` STRING COMMENT 'Version of the test program or script executed.',
    `test_result_file_hash` STRING COMMENT 'Hash (e.g., SHA‑256) of the test result file for integrity verification.',
    `test_result_summary` STRING COMMENT 'High‑level textual summary of the test outcome (e.g., PASS, FAIL, PARTIAL).',
    `test_run_number` STRING COMMENT 'Human‑readable business identifier assigned to the test run (e.g., TRT‑20230915‑001).',
    `test_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the stress phase began.',
    `test_status` STRING COMMENT 'Current operational state of the test run.. Valid values are `scheduled|running|completed|failed|cancelled`',
    `test_type` STRING COMMENT 'Specifies the category of reliability stress applied during the run.. Valid values are `htol|hast|esd|latch_up|electromigration|burn_in`',
    `test_yield_improvement_percent` DOUBLE COMMENT 'Improvement in yield attributable to the stress screening.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the test run record.',
    `voltage_ramp_rate_v_per_sec` DOUBLE COMMENT 'Rate at which voltage was increased during ramp‑up.',
    CONSTRAINT pk_reliability_test_run PRIMARY KEY(`reliability_test_run_id`)
) COMMENT 'Transactional record for reliability, qualification, and burn-in stress screening test executions. Covers HTOL, HAST, ESD, latch-up, electromigration, and burn-in stress screens. Captures test type, stress conditions (temperature, voltage, humidity, bias), duration, sample size, device lot, burn-in board ID, failure count, acceleration factor, pre/post-stress test results, infant mortality rate, screen effectiveness, and qualification status per JEDEC standards. Consolidates all reliability and stress screening operations into a single transactional record.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`insertion` (
    `insertion_id` BIGINT COMMENT 'System-generated unique identifier for the test insertion definition.',
    `ate_configuration_id` BIGINT COMMENT 'Foreign key linking to test.ate_configuration. Business justification: Insertions are executed on specific ATE configurations. The insertion entity has ate_platform_type (string) which is a denormalized reference to the ATE configuration. Adding ate_configuration_id FK n',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Test Insertion Planning requires assigning a specific Fab Tool; the Insertion Schedule report lists the Fab Tool needed for each insertion.',
    `program_id` BIGINT COMMENT 'FK to test.test_program',
    `bin_mapping_reference` STRING COMMENT 'Identifier of the binning scheme applied to test results at this insertion.',
    `conditional_flag` BOOLEAN COMMENT 'Indicates the insertion is executed only when specific pre‑conditions are met.',
    `correlation_study_flag` BOOLEAN COMMENT 'Indicates whether data from this insertion is used in wafer‑to‑package correlation studies.',
    `cost_per_unit_usd` DECIMAL(18,2) COMMENT 'Estimated cost incurred for each unit processed at this insertion.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the insertion record was first created.',
    `effective_from` DATE COMMENT 'Date when the insertion definition becomes active in the test flow.',
    `effective_until` DATE COMMENT 'Date when the insertion definition is retired; null if still active.',
    `handler_requirement` STRING COMMENT 'Specifies the handler or prober needed for the insertion.. Valid values are `wafer_prober|die_handler|none`',
    `insertion_code` STRING COMMENT 'Unique alphanumeric code used to reference the insertion within the test flow.',
    `insertion_name` STRING COMMENT 'Human‑readable name of the test insertion step (e.g., wafer probe, die sort).',
    `insertion_status` STRING COMMENT 'Current lifecycle status of the insertion definition.. Valid values are `active|inactive|deprecated|planned`',
    `insertion_type` STRING COMMENT 'Category of the insertion step within the manufacturing test flow.. Valid values are `probe|sort|burn_in|final|slt|qa`',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the insertion must be executed for every device.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Highest temperature allowed during the insertion test.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Lowest temperature allowed during the insertion test.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the insertion.',
    `optional_flag` BOOLEAN COMMENT 'Indicates whether the insertion can be skipped without affecting product qualification.',
    `sequence_order` STRING COMMENT 'Ordinal position of the insertion in the overall test flow.',
    `skip_rule_description` STRING COMMENT 'Human‑readable rule that defines when this insertion may be skipped.',
    `test_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of functional or parametric coverage provided by this insertion.',
    `test_parameter_set` STRING COMMENT 'Name of the parameter set applied during the test program execution.',
    `test_time_budget_seconds` STRING COMMENT 'Maximum allowed test time for this insertion, in seconds.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the insertion record.',
    `yield_gate_criteria_percent` DECIMAL(18,2) COMMENT 'Minimum pass‑rate percentage required to allow progression to the next step.',
    CONSTRAINT pk_insertion PRIMARY KEY(`insertion_id`)
) COMMENT 'Reference master defining the complete test insertion architecture for each device type within the manufacturing flow. Captures insertion name (wafer probe, die sort, pre-burn-in, burn-in, post-burn-in, final test, SLT, outgoing QA), sequence order in the flow, mandatory vs. optional vs. conditional flag, assigned test program reference, required ATE platform type, handler/prober requirement, yield gate criteria (minimum pass rate to proceed), test time budget allocation, cost per unit at this insertion, and insertion-level skip rules. SSOT for the test flow architecture governing which tests are performed at which manufacturing stage, in what sequence, and under what conditions. Critical for test cost modeling and flow optimization.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`case` (
    `case_id` BIGINT COMMENT 'Primary key for test_case',
    `insertion_id` BIGINT COMMENT 'Foreign key linking to test.insertion. Business justification: Test cases are associated with specific test insertions — a test case is designed to be executed at a particular insertion point (wafer sort, final test, etc.). The insertion entity defines the test i',
    `parent_test_case_id` BIGINT COMMENT 'Self-referencing FK on test_case (parent_test_case_id)',
    `program_id` BIGINT COMMENT 'Foreign key linking to test.test_program. Business justification: Test cases belong to a test program; adding test_program_id FK eliminates silo and enables navigation.',
    `technology_control_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.technology_control_plan. Business justification: Test cases contain controlled test methodologies, proprietary algorithms, and device characterization techniques requiring Technology Control Plan coverage per EAR for deemed export control and foreig',
    `bin_mapping_version` STRING COMMENT 'Version identifier for the binning scheme associated with this test case.',
    `coverage_percent` DECIMAL(18,2) COMMENT 'Proportion of functional or parametric specifications covered by this test case.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the test case record was first created in the system.',
    `default_duration_seconds` STRING COMMENT 'Standard execution time expected for the test case, in seconds.',
    `effective_from` DATE COMMENT 'Date when the test case becomes valid for use in production.',
    `effective_until` DATE COMMENT 'Date after which the test case is no longer valid; null if open‑ended.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the test case is executed automatically by ATE without manual intervention.',
    `owner` STRING COMMENT 'Name of the engineering group or individual responsible for maintaining the test case.',
    `priority` STRING COMMENT 'Business priority indicating the importance of the test case for production release.',
    `required_equipment` STRING COMMENT 'List of ATE or probe stations required to execute the test case.',
    `specification_url` STRING COMMENT 'Link to the detailed test specification document stored in the PLM system.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Desired yield percentage that the test case aims to achieve.',
    `test_case_category` STRING COMMENT 'Level at which the test is applied, such as wafer‑level, die‑level, package‑level, or system‑level.',
    `test_case_code` STRING COMMENT 'Short alphanumeric code that uniquely identifies the test case within the test management system.',
    `test_case_description` STRING COMMENT 'Free‑form description of the test purpose, methodology, and any special considerations.',
    `test_case_name` STRING COMMENT 'Human‑readable name of the test case used in reports and dashboards.',
    `test_case_status` STRING COMMENT 'Current lifecycle state of the test case definition.',
    `test_case_type` STRING COMMENT 'Category of test performed, indicating the nature of the measurement or stimulus.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the test case record.',
    CONSTRAINT pk_case PRIMARY KEY(`case_id`)
) COMMENT 'Master reference table for test_case. Referenced by test_case_id.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`test`.`test_step` (
    `test_step_id` BIGINT COMMENT 'Primary key for test_step',
    `case_id` BIGINT COMMENT 'Foreign key linking to test.test_case. Business justification: Test steps belong to test cases — a test case is composed of multiple test steps executed in sequence. test_step has step_order which implies it belongs to a parent entity. Linking test_step to test_c',
    `prerequisite_test_step_id` BIGINT COMMENT 'Self-referencing FK on test_step (prerequisite_test_step_id)',
    `program_id` BIGINT COMMENT 'Identifier of the test program that includes this step.',
    `bin_mapping_required` BOOLEAN COMMENT 'True if the steps result must be mapped to a yield bin.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the test step record was first created in the system.',
    `default_duration_seconds` STRING COMMENT 'Typical execution time for the step when run under standard conditions.',
    `effective_from` DATE COMMENT 'Date from which the test step definition is valid for use.',
    `effective_until` DATE COMMENT 'Date after which the test step definition is retired (null if indefinite).',
    `equipment_required` STRING COMMENT 'Identifier of the ATE or fixture needed to execute the step.',
    `is_critical` BOOLEAN COMMENT 'True if failure of this step causes the entire test to be aborted.',
    `measurement_unit` STRING COMMENT 'Unit of the primary measurement captured by the step.',
    `pass_fail_criteria` STRING COMMENT 'Rule or threshold that determines whether the step passes or fails.',
    `step_category` STRING COMMENT 'Phase of the overall test flow where the step occurs.',
    `step_code` STRING COMMENT 'Compact alphanumeric code that uniquely identifies the step within a test program.',
    `step_description` STRING COMMENT 'Detailed description of the purpose, methodology, and expected outcome of the step.',
    `step_name` STRING COMMENT 'Human‑readable name of the test step as used in test programs and reports.',
    `step_order` STRING COMMENT 'Zero‑based sequence number indicating the steps position in the test program.',
    `step_type` STRING COMMENT 'Category of the test step based on its functional purpose.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the test step record.',
    CONSTRAINT pk_test_step PRIMARY KEY(`test_step_id`)
) COMMENT 'Master reference table for test_step. Referenced by test_step_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `semiconductors_ecm`.`test`.`program` ADD CONSTRAINT `fk_test_program_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `semiconductors_ecm`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ADD CONSTRAINT `fk_test_bin_definition_insertion_id` FOREIGN KEY (`insertion_id`) REFERENCES `semiconductors_ecm`.`test`.`insertion`(`insertion_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ADD CONSTRAINT `fk_test_bin_definition_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `semiconductors_ecm`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_insertion_id` FOREIGN KEY (`insertion_id`) REFERENCES `semiconductors_ecm`.`test`.`insertion`(`insertion_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_probe_card_id` FOREIGN KEY (`probe_card_id`) REFERENCES `semiconductors_ecm`.`test`.`probe_card`(`probe_card_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ADD CONSTRAINT `fk_test_wafer_probe_run_wafer_probe_card_id` FOREIGN KEY (`wafer_probe_card_id`) REFERENCES `semiconductors_ecm`.`test`.`probe_card`(`probe_card_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_case_id` FOREIGN KEY (`case_id`) REFERENCES `semiconductors_ecm`.`test`.`case`(`case_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `semiconductors_ecm`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_insertion_id` FOREIGN KEY (`insertion_id`) REFERENCES `semiconductors_ecm`.`test`.`insertion`(`insertion_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `semiconductors_ecm`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_test_step_id` FOREIGN KEY (`test_step_id`) REFERENCES `semiconductors_ecm`.`test`.`test_step`(`test_step_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ADD CONSTRAINT `fk_test_unit_test_result_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `semiconductors_ecm`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `semiconductors_ecm`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_insertion_id` FOREIGN KEY (`insertion_id`) REFERENCES `semiconductors_ecm`.`test`.`insertion`(`insertion_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ADD CONSTRAINT `fk_test_final_test_run_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `semiconductors_ecm`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_case_id` FOREIGN KEY (`case_id`) REFERENCES `semiconductors_ecm`.`test`.`case`(`case_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_final_test_run_id` FOREIGN KEY (`final_test_run_id`) REFERENCES `semiconductors_ecm`.`test`.`final_test_run`(`final_test_run_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_insertion_id` FOREIGN KEY (`insertion_id`) REFERENCES `semiconductors_ecm`.`test`.`insertion`(`insertion_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_unit_test_result_id` FOREIGN KEY (`unit_test_result_id`) REFERENCES `semiconductors_ecm`.`test`.`unit_test_result`(`unit_test_result_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_parametric_unit_test_result_id` FOREIGN KEY (`parametric_unit_test_result_id`) REFERENCES `semiconductors_ecm`.`test`.`unit_test_result`(`unit_test_result_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ADD CONSTRAINT `fk_test_parametric_measurement_wafer_probe_run_id` FOREIGN KEY (`wafer_probe_run_id`) REFERENCES `semiconductors_ecm`.`test`.`wafer_probe_run`(`wafer_probe_run_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_bin_definition_id` FOREIGN KEY (`bin_definition_id`) REFERENCES `semiconductors_ecm`.`test`.`bin_definition`(`bin_definition_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_insertion_id` FOREIGN KEY (`insertion_id`) REFERENCES `semiconductors_ecm`.`test`.`insertion`(`insertion_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ADD CONSTRAINT `fk_test_limit_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ADD CONSTRAINT `fk_test_coverage_insertion_id` FOREIGN KEY (`insertion_id`) REFERENCES `semiconductors_ecm`.`test`.`insertion`(`insertion_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ADD CONSTRAINT `fk_test_coverage_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `semiconductors_ecm`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_insertion_id` FOREIGN KEY (`insertion_id`) REFERENCES `semiconductors_ecm`.`test`.`insertion`(`insertion_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ADD CONSTRAINT `fk_test_reliability_test_run_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ADD CONSTRAINT `fk_test_insertion_ate_configuration_id` FOREIGN KEY (`ate_configuration_id`) REFERENCES `semiconductors_ecm`.`test`.`ate_configuration`(`ate_configuration_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ADD CONSTRAINT `fk_test_insertion_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`case` ADD CONSTRAINT `fk_test_case_insertion_id` FOREIGN KEY (`insertion_id`) REFERENCES `semiconductors_ecm`.`test`.`insertion`(`insertion_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`case` ADD CONSTRAINT `fk_test_case_parent_test_case_id` FOREIGN KEY (`parent_test_case_id`) REFERENCES `semiconductors_ecm`.`test`.`case`(`case_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`case` ADD CONSTRAINT `fk_test_case_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`test_step` ADD CONSTRAINT `fk_test_test_step_case_id` FOREIGN KEY (`case_id`) REFERENCES `semiconductors_ecm`.`test`.`case`(`case_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`test_step` ADD CONSTRAINT `fk_test_test_step_prerequisite_test_step_id` FOREIGN KEY (`prerequisite_test_step_id`) REFERENCES `semiconductors_ecm`.`test`.`test_step`(`test_step_id`);
ALTER TABLE `semiconductors_ecm`.`test`.`test_step` ADD CONSTRAINT `fk_test_test_step_program_id` FOREIGN KEY (`program_id`) REFERENCES `semiconductors_ecm`.`test`.`program`(`program_id`);

-- ========= TAGS =========
ALTER SCHEMA `semiconductors_ecm`.`test` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `semiconductors_ecm`.`test` SET TAGS ('dbx_domain' = 'test');
ALTER TABLE `semiconductors_ecm`.`test`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`test`.`program` SET TAGS ('dbx_subdomain' = 'program_configuration');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `eda_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Atpg Eda Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `netlist_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `rtl_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Rtl Specification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `actual_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Coverage Percentage');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `ate_platform` SET TAGS ('dbx_business_glossary_term' = 'ATE Platform');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `ate_platform` SET TAGS ('dbx_value_regex' = 'ATE_9000|ATE_9500|ATE_10000|Custom');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `bin_mapping_reference` SET TAGS ('dbx_business_glossary_term' = 'Bin Mapping Reference');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `correlation_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Correlation Study Reference');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `coverage_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Coverage Target Percentage');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Is Deprecated');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Test Program Owner');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `parametric_test_data_reference` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Data Reference');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'functional|structural|parametric|mixed');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Test Program Code');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `target_device` SET TAGS ('dbx_business_glossary_term' = 'Target Device');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `target_device_family` SET TAGS ('dbx_business_glossary_term' = 'Target Device Family');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `test_coverage_metric` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Metric');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `test_coverage_metric` SET TAGS ('dbx_value_regex' = 'fault_coverage|code_coverage|timing_coverage');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `test_environment` SET TAGS ('dbx_value_regex' = 'lab|production|prototype');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `test_flow_description` SET TAGS ('dbx_business_glossary_term' = 'Test Flow Description');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `test_flow_version` SET TAGS ('dbx_business_glossary_term' = 'Test Flow Version');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `test_limit_units` SET TAGS ('dbx_business_glossary_term' = 'Test Limit Units');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `test_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Test Limit Value');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `test_program_name` SET TAGS ('dbx_business_glossary_term' = 'Test Program Name');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `test_program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `test_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|retired');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'wafer_probe|die_sort|final_test|burn_in|slit');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'draft|validated|released|rejected');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `version_description` SET TAGS ('dbx_business_glossary_term' = 'Version Description');
ALTER TABLE `semiconductors_ecm`.`test`.`program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` SET TAGS ('dbx_subdomain' = 'program_configuration');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'ATE Configuration Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Target Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `technology_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Control Plan Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `ate_configuration_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `bin_mapping_version` SET TAGS ('dbx_business_glossary_term' = 'Bin Mapping Version');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'calibrated|due|overdue');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `compliance_ear_status` SET TAGS ('dbx_business_glossary_term' = 'EAR Compliance Status');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `compliance_ear_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `compliance_itar_status` SET TAGS ('dbx_business_glossary_term' = 'ITAR Compliance Status');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `compliance_itar_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `hardware_revision` SET TAGS ('dbx_business_glossary_term' = 'Hardware Revision');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `instrument_resource_allocation` SET TAGS ('dbx_business_glossary_term' = 'Instrument Resource Allocation');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `last_calibration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|decommissioned');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `load_board_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Load Board Qualification Status');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `load_board_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|rejected');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `load_board_revision` SET TAGS ('dbx_business_glossary_term' = 'Load Board Revision');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `max_parallel_site_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Parallel Site Count');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `parametric_test_supported` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Supported');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `pin_electronics_card_map` SET TAGS ('dbx_business_glossary_term' = 'Pin Electronics Card Map');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `platform_type` SET TAGS ('dbx_business_glossary_term' = 'Platform Type');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `platform_type` SET TAGS ('dbx_value_regex' = 'wafer_probe|final_test|reliability');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `supported_device_families` SET TAGS ('dbx_business_glossary_term' = 'Supported Device Families');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `test_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Percentage');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `test_yield_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Test Yield Target Percentage');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `tester_model` SET TAGS ('dbx_business_glossary_term' = 'Tester Model');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `tester_model` SET TAGS ('dbx_value_regex' = 'Advantest V93000|Teradyne UltraFlex|National Instruments PXI');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `semiconductors_ecm`.`test`.`ate_configuration` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` SET TAGS ('dbx_subdomain' = 'program_configuration');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `probe_card_id` SET TAGS ('dbx_business_glossary_term' = 'Probe Card ID');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Prober Tool Identifier (APTI)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Target Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `card_name` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Name (PCN)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'itar|ear|rohs|none|restricted|export_control');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `contact_resistance_ohm` SET TAGS ('dbx_business_glossary_term' = 'Contact Resistance (Ohm) (CR)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost (USD) (COST)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `die_site_layout` SET TAGS ('dbx_business_glossary_term' = 'Die Site Layout Description (DSL)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (LMD)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp (LUT)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `maintenance_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle (Months) (MC)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `needle_count` SET TAGS ('dbx_business_glossary_term' = 'Needle Count (NC)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `needle_replacements` SET TAGS ('dbx_business_glossary_term' = 'Needle Replacement Count (NRC)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date (NMDD)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (AN)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `pitch_um` SET TAGS ('dbx_business_glossary_term' = 'Needle Pitch (µm) (NP)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `probe_card_description` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Description (PCD)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `probe_card_status` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Lifecycle Status (PCS)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `probe_card_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|maintenance|decommissioned|qualified|failed');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `probe_card_type` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Type (PCT)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `probe_card_type` SET TAGS ('dbx_value_regex' = 'cantilever|vertical|mems|advanced|custom|other');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date (QD)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QS)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|failed|rejected|under_review');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification (SC)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `safety_classification` SET TAGS ('dbx_value_regex' = 'class_a|class_b|class_c|class_d|class_e|class_f');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Probe Card Serial Number (PCS)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `touchdown_count` SET TAGS ('dbx_business_glossary_term' = 'Touchdown Count per Test (TC)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `usage_hours` SET TAGS ('dbx_business_glossary_term' = 'Usage Hours (UH)');
ALTER TABLE `semiconductors_ecm`.`test`.`probe_card` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date (WED)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` SET TAGS ('dbx_subdomain' = 'program_configuration');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `insertion_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `bin_category` SET TAGS ('dbx_business_glossary_term' = 'Bin Category (BIN_CAT)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `bin_category` SET TAGS ('dbx_value_regex' = 'pass|functional_fail|parametric_fail|contact_fail|leakage_fail');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `bin_code` SET TAGS ('dbx_business_glossary_term' = 'Bin Code (BIN_CD)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `bin_definition_description` SET TAGS ('dbx_business_glossary_term' = 'Bin Description (BIN_DESC)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `bin_definition_status` SET TAGS ('dbx_business_glossary_term' = 'Bin Status (BIN_STS)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `bin_definition_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `bin_name` SET TAGS ('dbx_business_glossary_term' = 'Bin Name (BIN_NM)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bin Number (BIN_NUM)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `bin_sort_order` SET TAGS ('dbx_business_glossary_term' = 'Bin Sort Order (BIN_ORDER)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRE_TS)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `device_family` SET TAGS ('dbx_business_glossary_term' = 'Device Family (DEV_FAM)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `disposition_rule` SET TAGS ('dbx_business_glossary_term' = 'Disposition Rule (DISP_RULE)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `disposition_rule` SET TAGS ('dbx_value_regex' = 'ship|scrap|rework|hold');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode (FAIL_MODE)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Bin (IS_DEF)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `parameter_set` SET TAGS ('dbx_business_glossary_term' = 'Parameter Set (PARAM_SET)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `test_level` SET TAGS ('dbx_business_glossary_term' = 'Test Level (TEST_LVL)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `test_level` SET TAGS ('dbx_value_regex' = 'wafer|final|reliability');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User (UPD_BY)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TS)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `yield_impact_classification` SET TAGS ('dbx_business_glossary_term' = 'Yield Impact Classification (YLD_IMPACT)');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `yield_impact_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low|none');
ALTER TABLE `semiconductors_ecm`.`test`.`bin_definition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CRE_BY)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` SET TAGS ('dbx_subdomain' = 'execution_results');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run ID');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Prober Tool ID (PROBER_TOOL_ID)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `insertion_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `physical_layout_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Layout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `probe_card_id` SET TAGS ('dbx_business_glossary_term' = 'Probe Card ID (PROBE_CARD_ID)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Probe Fabrication Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Probed Wafer Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `ate_configuration` SET TAGS ('dbx_business_glossary_term' = 'ATE Configuration (ATE_CFG)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `ate_configuration` SET TAGS ('dbx_value_regex' = 'CFG-w{3,}');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `bin_map_version` SET TAGS ('dbx_business_glossary_term' = 'Bin Map Version (BIN_MAP_VER)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `contact_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Contact Yield Percent (YIELD_CONTACT)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run End Timestamp (END_TIME)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `fail_die_count` SET TAGS ('dbx_business_glossary_term' = 'Fail Die Count (FAIL_DIE)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `gross_die_count` SET TAGS ('dbx_business_glossary_term' = 'Gross Die Count (GROSS_DIE)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `parametric_test_data_available` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Data Available (PARAM_DATA)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `pass_die_count` SET TAGS ('dbx_business_glossary_term' = 'Pass Die Count (PASS_DIE)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_AT)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_AT)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks (REMARKS)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number (RUN)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `run_number` SET TAGS ('dbx_value_regex' = 'RUN-d{6}');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Run Start Timestamp (START_TIME)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `test_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Percent (COVERAGE)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `total_die_count` SET TAGS ('dbx_business_glossary_term' = 'Total Die Count (TOTAL_DIE)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_probe_run_status` SET TAGS ('dbx_business_glossary_term' = 'Run Status (STATUS)');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_probe_run_status` SET TAGS ('dbx_value_regex' = 'scheduled|running|completed|failed|canceled');
ALTER TABLE `semiconductors_ecm`.`test`.`wafer_probe_run` ALTER COLUMN `wafer_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Sequence Number (WAFER_SEQ_NUM)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` SET TAGS ('dbx_subdomain' = 'execution_results');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Test Result Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Test Case Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `excursion_id` SET TAGS ('dbx_business_glossary_term' = 'Excursion Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment ID');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `insertion_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `netlist_id` SET TAGS ('dbx_business_glossary_term' = 'Netlist Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `test_step_id` SET TAGS ('dbx_business_glossary_term' = 'Test Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Tested Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer ID');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `assembly_position` SET TAGS ('dbx_business_glossary_term' = 'Assembly Position');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `hard_bin_code` SET TAGS ('dbx_business_glossary_term' = 'Hard Bin Code');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `kgd_status` SET TAGS ('dbx_business_glossary_term' = 'Known Good Die (KGD) Status');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `kgd_status` SET TAGS ('dbx_value_regex' = 'kgd|non_kgd|pending');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `measurement_summary` SET TAGS ('dbx_business_glossary_term' = 'Measurement Summary');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `measurement_units` SET TAGS ('dbx_business_glossary_term' = 'Measurement Units');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `parametric_flags` SET TAGS ('dbx_business_glossary_term' = 'Parametric Flags');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `pass_fail` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `pass_fail` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `retest_count` SET TAGS ('dbx_business_glossary_term' = 'Retest Count');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `retest_indicator` SET TAGS ('dbx_business_glossary_term' = 'Retest Indicator');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `soft_bin_code` SET TAGS ('dbx_business_glossary_term' = 'Soft Bin Code');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Camstar|KLA|Custom|Other');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `test_condition` SET TAGS ('dbx_business_glossary_term' = 'Test Condition');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `test_condition` SET TAGS ('dbx_value_regex' = 'room_temp|high_temp|low_temp|stress');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `test_result_comment` SET TAGS ('dbx_business_glossary_term' = 'Test Result Comment');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `test_result_version` SET TAGS ('dbx_business_glossary_term' = 'Test Result Version');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `test_stage` SET TAGS ('dbx_business_glossary_term' = 'Test Stage (Wafer Probe, Die Sort, Final Test, System-Level Test)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `test_stage` SET TAGS ('dbx_value_regex' = 'wafer_probe|die_sort|final_test|system_level_test');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `test_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Test Time (seconds)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `test_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Test Voltage (V)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `test_yield_flag` SET TAGS ('dbx_business_glossary_term' = 'Yield Contribution Flag');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `unit_identifier` SET TAGS ('dbx_business_glossary_term' = 'Unit Identifier (Die Coordinates or Serial Number)');
ALTER TABLE `semiconductors_ecm`.`test`.`unit_test_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` SET TAGS ('dbx_subdomain' = 'execution_results');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Identifier (EQID)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `insertion_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `ate_name` SET TAGS ('dbx_business_glossary_term' = 'Automatic Test Equipment Name (ATEN)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `bin_distribution` SET TAGS ('dbx_business_glossary_term' = 'Bin Distribution (BD)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `boot_success_count` SET TAGS ('dbx_business_glossary_term' = 'Boot Success Count (BSC)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Test Run Comments (TRC)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code (DC)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test End Timestamp (TET)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `fail_count` SET TAGS ('dbx_business_glossary_term' = 'Fail Count (FC)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `final_test_run_status` SET TAGS ('dbx_business_glossary_term' = 'Test Run Status (TRS)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `final_test_run_status` SET TAGS ('dbx_value_regex' = 'pending|running|completed|failed');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `handler_name` SET TAGS ('dbx_business_glossary_term' = 'Test Handler Name (THN)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `parametric_test_fail` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Fail Count (PTFC)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `parametric_test_pass` SET TAGS ('dbx_business_glossary_term' = 'Parametric Test Pass Count (PTPC)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `pass_count` SET TAGS ('dbx_business_glossary_term' = 'Pass Count (PC)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `power_consumption_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Consumption (mW) (PC)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (RACT)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (RAUT)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `slt_board_code` SET TAGS ('dbx_business_glossary_term' = 'System‑Level Test Board Identifier (SLTBI)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `socket_code` SET TAGS ('dbx_business_glossary_term' = 'Socket Identifier (SID)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Start Timestamp (TST)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location Code (TLC)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `test_program_version` SET TAGS ('dbx_business_glossary_term' = 'Test Program Version (TPV)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Test Result (OTR)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `test_run_code` SET TAGS ('dbx_business_glossary_term' = 'Test Run Code (TRC)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `test_shift` SET TAGS ('dbx_business_glossary_term' = 'Test Shift (TS)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `test_shift` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `test_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Test Temperature (°C) (TT)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `test_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Time (seconds) (TET)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type (TT)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'final_test|slt');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `total_sites` SET TAGS ('dbx_business_glossary_term' = 'Total Test Sites (TTS)');
ALTER TABLE `semiconductors_ecm`.`test`.`final_test_run` ALTER COLUMN `yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Percentage (YP)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` SET TAGS ('dbx_subdomain' = 'execution_results');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `parametric_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Parametric Measurement ID (PMID)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `calibration_record_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Identifier (CAL_ID)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Test Case Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Identifier (EQP_ID)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `final_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Final Test Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `insertion_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `unit_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Identifier (RES_ID)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Die Identifier (DIE_ID)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Test Step Identifier (STEP_ID)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier (TP_ID)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `tapeout_id` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `wafer_probe_run_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Probe Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp (ET)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value (MV)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_average_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Average Value (AVG)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_comment` SET TAGS ('dbx_business_glossary_term' = 'Measurement Comment (CMNT)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_condition_frequency_mhz` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency (F_MHZ)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_condition_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Measurement Temperature (T_C)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_condition_voltage_mv` SET TAGS ('dbx_business_glossary_term' = 'Measurement Voltage (V_MV)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_flagged` SET TAGS ('dbx_business_glossary_term' = 'Measurement Flagged (FLAG)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_location` SET TAGS ('dbx_business_glossary_term' = 'Measurement Location (MLOC)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_location` SET TAGS ('dbx_value_regex' = 'center|edge');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_business_glossary_term' = 'Measurement Mode (MODE)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_value_regex' = 'parametric|functional');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Measurement Quality Flag (QFLAG)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_repeat_count` SET TAGS ('dbx_business_glossary_term' = 'Measurement Repeat Count (RPT_CNT)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_review_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Review Status (REV_STAT)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_review_status` SET TAGS ('dbx_value_regex' = 'pending|reviewed|closed');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Review Timestamp (REV_TIME)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_sequence` SET TAGS ('dbx_business_glossary_term' = 'Measurement Sequence (SEQ)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source (SRC)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'probe_card|ATE');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status (MSTAT)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'recorded|validated|rejected');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_std_dev` SET TAGS ('dbx_business_glossary_term' = 'Measurement Standard Deviation (STDDEV)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp (MTIME)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Measurement Tool Version (VER)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type (MTYPE)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'analog|digital');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty (UNC)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status (PFS)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `test_parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter Name (TPN)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `semiconductors_ecm`.`test`.`parametric_measurement` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` SET TAGS ('dbx_subdomain' = 'program_configuration');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `limit_id` SET TAGS ('dbx_business_glossary_term' = 'Test Limit Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `bin_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Definition Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `insertion_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Pdk Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revoked');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'SEMI|JEDEC|IEC|ISO');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `created_by_department` SET TAGS ('dbx_business_glossary_term' = 'Created By Department');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'ATE|ATPG|simulation|lab');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `limit_category` SET TAGS ('dbx_business_glossary_term' = 'Limit Category');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `limit_category` SET TAGS ('dbx_value_regex' = 'voltage|current|resistance|capacitance|frequency|temperature');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `limit_source` SET TAGS ('dbx_business_glossary_term' = 'Limit Source');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `limit_source` SET TAGS ('dbx_value_regex' = 'design|customer|regulatory|internal');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'parametric|functional|timing');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter Name');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `product_revision` SET TAGS ('dbx_business_glossary_term' = 'Product Revision Code');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Flag');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|semiannual|quarterly');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `statistical_method` SET TAGS ('dbx_business_glossary_term' = 'Statistical Method');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `statistical_method` SET TAGS ('dbx_value_regex' = 'mean|median|percentile|sigma');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `test_condition_set` SET TAGS ('dbx_business_glossary_term' = 'Test Condition Set');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `test_flow_name` SET TAGS ('dbx_business_glossary_term' = 'Test Flow Name');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percent');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Limit Version');
ALTER TABLE `semiconductors_ecm`.`test`.`limit` ALTER COLUMN `version_history` SET TAGS ('dbx_business_glossary_term' = 'Version History');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` SET TAGS ('dbx_subdomain' = 'program_configuration');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Record Identifier (TC_ID)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Device Type Identifier (DT_ID)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `coverage_ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `insertion_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Identifier (TP_ID)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `verification_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Verification Plan Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Coverage Comments (CCOM)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `correlation_score` SET TAGS ('dbx_business_glossary_term' = 'Coverage Correlation Score (CCS)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `coverage_category` SET TAGS ('dbx_business_glossary_term' = 'Coverage Category (CC)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `coverage_category` SET TAGS ('dbx_value_regex' = 'functional|parametric|structural|timing');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `coverage_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Measurement Date (CMD)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `coverage_method` SET TAGS ('dbx_business_glossary_term' = 'Coverage Determination Method (CDM)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `coverage_method` SET TAGS ('dbx_value_regex' = 'simulation|silicon|mixed');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Record Status (CRS)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'draft|active|retired');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `defect_density` SET TAGS ('dbx_business_glossary_term' = 'Defect Density (DD)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type (DT)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `dft_structure_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'DFT Structure Coverage Percentage (DFTSCP)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `fault_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Fault Coverage Percentage (FCP)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `iddq_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'IDDQ Coverage Percentage (IDDQCP)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `is_approved` SET TAGS ('dbx_business_glossary_term' = 'Approval Flag (AF)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Coverage Flag (CCF)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (LRT)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `path_delay_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Path Delay Coverage Percentage (PDCP)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Coverage Source System (CSS)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `stuck_at_fault_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Stuck‑at Fault Coverage Percentage (SAFCP)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `tapeout_ready` SET TAGS ('dbx_business_glossary_term' = 'Tapeout Readiness Flag (TRF)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `test_program_version` SET TAGS ('dbx_business_glossary_term' = 'Test Program Version (TPV)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `tool` SET TAGS ('dbx_business_glossary_term' = 'Coverage Analysis Tool (CAT)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `tool_version` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tool Version (CTV)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `total_faults` SET TAGS ('dbx_business_glossary_term' = 'Total Fault Count (TFC)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `transition_fault_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Transition Fault Coverage Percentage (TFCP)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `units` SET TAGS ('dbx_business_glossary_term' = 'Coverage Units (CU)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `untestable_fault_count` SET TAGS ('dbx_business_glossary_term' = 'Untestable Fault Count (UFC)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By (RUB)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Coverage Record Version Number (CRVN)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `yield_estimate_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Estimate Percentage (YEP)');
ALTER TABLE `semiconductors_ecm`.`test`.`coverage` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By (RCB)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` SET TAGS ('dbx_subdomain' = 'execution_results');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `reliability_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Run Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Device Lot Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Design Project Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `insertion_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `acceleration_factor` SET TAGS ('dbx_business_glossary_term' = 'Acceleration Factor');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `bias_condition` SET TAGS ('dbx_business_glossary_term' = 'Bias Condition');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `burn_in_board_code` SET TAGS ('dbx_business_glossary_term' = 'Burn‑In Board Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `data_capture_rate_hz` SET TAGS ('dbx_business_glossary_term' = 'Data Capture Rate (Hz)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Stress Duration (Hours)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `failure_count` SET TAGS ('dbx_business_glossary_term' = 'Failure Count');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `humidity_control_method` SET TAGS ('dbx_business_glossary_term' = 'Humidity Control Method');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `infant_mortality_rate` SET TAGS ('dbx_business_glossary_term' = 'Infant Mortality Rate (%)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Test Run Notes');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `post_stress_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Post‑Stress Yield (%)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `pre_stress_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Stress Yield (%)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|conditionally_qualified|rejected|pending');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `screen_effectiveness_percent` SET TAGS ('dbx_business_glossary_term' = 'Screen Effectiveness (%)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `stress_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Stress Relative Humidity (%)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `stress_mode` SET TAGS ('dbx_business_glossary_term' = 'Stress Mode');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `stress_mode` SET TAGS ('dbx_value_regex' = 'constant|cyclic|step');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `stress_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Stress Temperature (°C)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `stress_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Stress Voltage (V)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `temperature_ramp_rate_c_per_min` SET TAGS ('dbx_business_glossary_term' = 'Temperature Ramp Rate (°C/min)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_batch_code` SET TAGS ('dbx_business_glossary_term' = 'Test Batch Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_data_file_path` SET TAGS ('dbx_business_glossary_term' = 'Test Data File Path');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test End Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Test Failure Mode');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_failure_mode` SET TAGS ('dbx_value_regex' = 'parametric|functional|both');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_failure_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Failure Rate (%)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_location` SET TAGS ('dbx_business_glossary_term' = 'Test Location');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_program_version` SET TAGS ('dbx_business_glossary_term' = 'Test Program Version');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_result_file_hash` SET TAGS ('dbx_business_glossary_term' = 'Test Result File Hash');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_result_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Result Summary');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_run_number` SET TAGS ('dbx_business_glossary_term' = 'Test Run Number');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Run Status');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|running|completed|failed|cancelled');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Reliability Test Type (HTOL, HAST, ESD, Latch‑Up, Electromigration, Burn‑In)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'htol|hast|esd|latch_up|electromigration|burn_in');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `test_yield_improvement_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Improvement (%)');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`reliability_test_run` ALTER COLUMN `voltage_ramp_rate_v_per_sec` SET TAGS ('dbx_business_glossary_term' = 'Voltage Ramp Rate (V/s)');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` SET TAGS ('dbx_subdomain' = 'program_configuration');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `insertion_id` SET TAGS ('dbx_business_glossary_term' = 'Test Insertion Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `ate_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Ate Configuration Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `program_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `bin_mapping_reference` SET TAGS ('dbx_business_glossary_term' = 'Bin Mapping Reference');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `conditional_flag` SET TAGS ('dbx_business_glossary_term' = 'Conditional Flag');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `correlation_study_flag` SET TAGS ('dbx_business_glossary_term' = 'Correlation Study Flag');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `cost_per_unit_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit (USD)');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `handler_requirement` SET TAGS ('dbx_business_glossary_term' = 'Handler Requirement');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `handler_requirement` SET TAGS ('dbx_value_regex' = 'wafer_prober|die_handler|none');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `insertion_code` SET TAGS ('dbx_business_glossary_term' = 'Test Insertion Code');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `insertion_name` SET TAGS ('dbx_business_glossary_term' = 'Test Insertion Name');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `insertion_status` SET TAGS ('dbx_business_glossary_term' = 'Test Insertion Status');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `insertion_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|planned');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `insertion_type` SET TAGS ('dbx_business_glossary_term' = 'Test Insertion Type');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `insertion_type` SET TAGS ('dbx_value_regex' = 'probe|sort|burn_in|final|slt|qa');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `min_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `optional_flag` SET TAGS ('dbx_business_glossary_term' = 'Optional Flag');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Sequence Order');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `skip_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Skip Rule Description');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `test_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage (Percent)');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `test_parameter_set` SET TAGS ('dbx_business_glossary_term' = 'Test Parameter Set');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `test_time_budget_seconds` SET TAGS ('dbx_business_glossary_term' = 'Test Time Budget (Seconds)');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`test`.`insertion` ALTER COLUMN `yield_gate_criteria_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Gate Criteria (Percent)');
ALTER TABLE `semiconductors_ecm`.`test`.`case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`test`.`case` SET TAGS ('dbx_subdomain' = 'program_configuration');
ALTER TABLE `semiconductors_ecm`.`test`.`case` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Test Case Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`case` ALTER COLUMN `insertion_id` SET TAGS ('dbx_business_glossary_term' = 'Insertion Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`case` ALTER COLUMN `parent_test_case_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `semiconductors_ecm`.`test`.`case` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Test Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`case` ALTER COLUMN `technology_control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Control Plan Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`test_step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`test`.`test_step` SET TAGS ('dbx_subdomain' = 'program_configuration');
ALTER TABLE `semiconductors_ecm`.`test`.`test_step` ALTER COLUMN `test_step_id` SET TAGS ('dbx_business_glossary_term' = 'Test Step Identifier');
ALTER TABLE `semiconductors_ecm`.`test`.`test_step` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Test Case Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`test`.`test_step` ALTER COLUMN `prerequisite_test_step_id` SET TAGS ('dbx_self_ref_fk' = 'true');
