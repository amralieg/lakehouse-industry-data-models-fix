-- Schema for Domain: process | Business: Semiconductors | Version: v1_mvm
-- Generated on: 2026-05-06 20:34:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `semiconductors_ecm`.`process` COMMENT 'Process engineering data for all semiconductor manufacturing process flows including photolithography, etch, diffusion, implant, deposition, and metrology steps. Manages SPC control charts, process capability indices, OPC rule sets, MEEF parameters, process qualification, yield optimization, and technology node readiness.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`flow` (
    `flow_id` BIGINT COMMENT 'Unique identifier for the semiconductor manufacturing process flow definition. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation of a process flow to a cost center is required for internal cost‑of‑goods‑sold calculations and budgeting.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Process flows may specify default WIP staging or material storage locations for flow execution. Supports fab layout planning, material handling automation, and flow-level logistics optimization in sem',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export compliance review requires each process flow to be linked to the specific export license governing the technology used.',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: A process flow is designed for a specific product family (e.g., mobile CPU family uses a dedicated BEOL flow). NPI gate reviews and product roadmap planning require this link. device_family is a denor',
    `process_technology_node_id` BIGINT COMMENT 'FK to process.technology_node.technology_node_id — Every process flow is designed for a specific technology node. This is the top-level classification relationship enabling node-based process management.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Process Flow Assignment report links each flow to the IC product it manufactures; experts expect a flow‑to‑product FK.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Process flows represent intellectual property owned by specific legal entities. Required for IP ownership tracking, transfer pricing between fabs, and compliance with export control regulations tied t',
    `opc_rule_set_id` BIGINT COMMENT 'Foreign key linking to process.opc_rule_set. Business justification: process_flow currently stores opc_rule_set_version as a STRING, which is a denormalized reference to the OPC rule set used by the flow. Adding a proper FK opc_rule_set_id to opc_rule_set normalizes th',
    `pdk_id` BIGINT COMMENT 'Reference to the Process Design Kit (PDK) that defines the design rules, device models, and technology files associated with this process flow.',
    `primary_flow_process_technology_node_id` BIGINT COMMENT 'Foreign key linking to process.process_technology_node. Business justification: A process flow is defined for a particular technology node; linking directly within the process domain eliminates cross‑domain indirection.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Process flows generate revenue for specific product lines; profit‑center linkage supports profitability reporting per flow.',
    `baseline_cpk` DECIMAL(18,2) COMMENT 'Baseline process capability index (Cpk) representing the statistical process control capability of the flow at qualification.',
    `beol_step_count` STRING COMMENT 'Number of process steps in the Back End of Line (BEOL) phase, covering metal interconnect layers and passivation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process flow record was first created in the system.',
    `critical_layer_count` STRING COMMENT 'Number of critical layers requiring advanced lithography techniques (EUV, multi-patterning, or tight overlay control).',
    `cycle_time_days` DECIMAL(18,2) COMMENT 'Standard manufacturing cycle time in days for a wafer lot to complete the entire process flow under normal production conditions.',
    `dfm_rule_set_version` STRING COMMENT 'Version identifier of the Design for Manufacturability (DFM) rule set associated with this process flow.',
    `effective_end_date` DATE COMMENT 'Date when this process flow version was superseded or retired from production use. Null for currently active flows.',
    `effective_start_date` DATE COMMENT 'Date when this process flow version became effective and available for production use.',
    `euv_layer_count` STRING COMMENT 'Number of layers using Extreme Ultraviolet (EUV) lithography in the process flow.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility (FAB) where this process flow is qualified and executed.',
    `feol_step_count` STRING COMMENT 'Number of process steps in the Front End of Line (FEOL) phase, covering transistor formation and isolation.',
    `flow_code` STRING COMMENT 'Unique alphanumeric code identifying the process flow in manufacturing execution systems and production planning. Used as the external business identifier.',
    `flow_name` STRING COMMENT 'Business name of the process flow, typically indicating the technology node and device family (e.g., 5nm FinFET Logic Flow, 28nm CMOS Analog Flow).',
    `flow_type` STRING COMMENT 'Classification of the process flow by device application domain (logic, memory, analog, mixed-signal, power, RF, sensor). [ENUM-REF-CANDIDATE: logic|memory|analog|mixed_signal|power|rf|sensor — 7 candidates stripped; promote to reference product]',
    `is_baseline_flow` BOOLEAN COMMENT 'Flag indicating whether this is the baseline (reference) process flow for the technology node. True if baseline, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this process flow record was last modified or updated.',
    `lithography_layer_count` STRING COMMENT 'Total number of photolithography (patterning) layers in the complete process flow.',
    `metal_layer_count` STRING COMMENT 'Total number of metal interconnect layers defined in the BEOL portion of the process flow.',
    `mol_step_count` STRING COMMENT 'Number of process steps in the Middle of Line (MOL) phase, covering contact formation and local interconnects.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the process flow execution, qualification, or usage.',
    `owner_organization` STRING COMMENT 'Process engineering organization or department responsible for this process flow (e.g., Advanced Logic Process, Memory Process Engineering).',
    `process_flow_description` STRING COMMENT 'Detailed textual description of the process flow, including key process characteristics, intended applications, and any special considerations.',
    `qualification_date` DATE COMMENT 'Date when the process flow successfully completed qualification testing and was approved for production release.',
    `qualification_status` STRING COMMENT 'Current qualification and release status of the process flow. Indicates readiness for production use.. Valid values are `development|qualification|qualified|production|deprecated|obsolete`',
    `revision` STRING COMMENT 'Version or revision identifier for the process flow definition. Incremented when process steps, parameters, or sequences are modified.',
    `supports_multi_patterning` BOOLEAN COMMENT 'Flag indicating whether the process flow includes multi-patterning lithography techniques (LELE, SADP, SAQP). True if multi-patterning is used, False otherwise.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target die yield percentage (good dies per wafer) for production lots running this qualified process flow.',
    `total_step_count` STRING COMMENT 'Total number of unit process steps in the complete flow from wafer start through final inspection.',
    CONSTRAINT pk_flow PRIMARY KEY(`flow_id`)
) COMMENT 'Master definition of a semiconductor manufacturing process flow (recipe sequence) for a given technology node. Captures the ordered sequence of unit process steps from FEOL through MOL and BEOL, including process node designation (e.g., 5nm, 3nm, 28nm), flow revision, qualification status, applicable device families, and PDK linkage. SSOT for all process flow definitions used in wafer fabrication.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`step` (
    `step_id` BIGINT COMMENT 'Unique identifier for the individual process step within the semiconductor manufacturing process flow. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Process steps consume fab resources (labor, utilities, materials) that must be allocated to cost centers for activity-based costing and variance analysis. Essential for manufacturing cost accounting i',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this process step is designed and qualified.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Required for material traceability per step in Yield Loss Analysis and compliance reports; experts expect each step to reference the exact material used.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Process steps consume chemicals, gases, and materials from specific fab storage locations (WIP staging areas, chemical cabinets). Essential for material traceability and fab logistics planning in semi',
    `opc_rule_set_id` BIGINT COMMENT 'Reference to the OPC rule set applied during mask data preparation for lithography steps, compensating for optical diffraction effects.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Production planning assigns each process step a primary fab tool; the step definition must reference the specific fab_tool for scheduling and capacity planning.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: A process step belongs to a process flow; adding internal FK enables direct navigation within the process domain.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Process steps are often qualified for specific equipment/material suppliers (e.g., Applied Materials etch chamber with Lam Research-qualified recipe). Critical for vendor-specific process control, sup',
    `recipe_id` BIGINT COMMENT 'Reference to the nominal equipment recipe or parameter set used for this process step. Links to the detailed process control parameters.',
    `step_flow_id` BIGINT COMMENT 'FK to process.process_flow.process_flow_id — Every process step must reference its parent process flow. This is the fundamental header-to-line relationship in the domain. Without this FK, you cannot reconstruct the ordered sequence of steps in a',
    `substance_inventory_id` BIGINT COMMENT 'Foreign key linking to compliance.substance_inventory. Business justification: Process steps consume specific chemicals/materials (gases, precursors, etchants) subject to regulatory control. Environmental compliance reporting and hazardous substance tracking require mapping proc',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Step definition includes the default chamber where the operation occurs; linking enables chamber allocation, maintenance, and utilization reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process step record was first created in the system.',
    `cycle_time_target_minutes` DECIMAL(18,2) COMMENT 'Target processing time for this step in minutes, used for manufacturing planning, scheduling, and throughput optimization.',
    `dose_target` DECIMAL(18,2) COMMENT 'Target ion implantation dose in ions per square centimeter, or exposure dose in millijoules per square centimeter for lithography steps.',
    `effective_end_date` DATE COMMENT 'Date when this process step version was superseded or retired from active use. Null indicates currently active.',
    `effective_start_date` DATE COMMENT 'Date when this process step version became effective and available for use in production flows.',
    `energy_target_kev` DECIMAL(18,2) COMMENT 'Target ion implantation energy in kilo-electron volts (keV), controlling the depth of dopant penetration into the silicon substrate.',
    `gas_flow_rate_sccm` DECIMAL(18,2) COMMENT 'Nominal gas flow rate in standard cubic centimeters per minute (SCCM) for process steps involving gas delivery such as CVD or etch.',
    `is_critical_step` BOOLEAN COMMENT 'Boolean flag indicating whether this step is classified as critical for yield, quality, or device performance, requiring enhanced monitoring and control.',
    `is_rework_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether wafers can be reworked or reprocessed through this step if defects or out-of-spec conditions are detected.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this process step record was most recently updated, supporting audit trail and change tracking.',
    `meef_value` DECIMAL(18,2) COMMENT 'Mask Error Enhancement Factor for lithography steps, quantifying how mask CD errors are amplified on the wafer.',
    `operation_type` STRING COMMENT 'Classification of the manufacturing operation performed in this step. Categorizes the fundamental process technology applied. [ENUM-REF-CANDIDATE: photolithography|etch|deposition|implant|diffusion|cmp|metrology|inspection|cleaning|annealing — 10 candidates stripped; promote to reference product]',
    `power_setpoint_watts` DECIMAL(18,2) COMMENT 'Nominal RF or DC power setpoint in watts for plasma-based process steps such as reactive ion etch or PECVD.',
    `pressure_setpoint_torr` DECIMAL(18,2) COMMENT 'Nominal chamber pressure setpoint in Torr for vacuum process steps such as CVD, PVD, or plasma etch.',
    `process_category` STRING COMMENT 'High-level classification indicating whether this step belongs to Front End of Line (FEOL), Middle of Line (MOL), or Back End of Line (BEOL) processing stages.. Valid values are `feol|mol|beol`',
    `process_time_seconds` DECIMAL(18,2) COMMENT 'Nominal duration of the actual process operation in seconds, excluding load/unload and setup time.',
    `qualification_date` DATE COMMENT 'Date when this process step successfully completed qualification and was approved for production release.',
    `qualification_status` STRING COMMENT 'Status of process qualification for this step, indicating whether it has passed validation testing and is approved for production use.. Valid values are `not_started|in_progress|qualified|failed|waived`',
    `sequence_order` STRING COMMENT 'Numeric ordering of this step within the parent process flow, determining the execution sequence in the manufacturing line.',
    `step_description` STRING COMMENT 'Detailed textual description of the process step, including technical objectives, materials used, and special handling requirements.',
    `step_name` STRING COMMENT 'Human-readable name of the process step, describing the operation performed (e.g., Gate Oxide CVD, Contact Lithography, Metal 1 Etch).',
    `step_number` STRING COMMENT 'Business identifier for the process step, typically a hierarchical or sequential code used in manufacturing documentation and traveler cards.',
    `step_status` STRING COMMENT 'Current lifecycle status of the process step, indicating whether it is in active production use, under development, or retired.. Valid values are `active|inactive|development|qualification|deprecated|obsolete`',
    `target_cd_nm` DECIMAL(18,2) COMMENT 'Target critical dimension in nanometers for lithography and etch steps, defining the feature size specification.',
    `target_layer` STRING COMMENT 'The specific material layer or structure being processed in this step (e.g., Poly Gate, Metal 2, Contact Via, STI Oxide).',
    `target_thickness_angstrom` DECIMAL(18,2) COMMENT 'Target film thickness in angstroms for deposition steps, used as the process control specification.',
    `temperature_setpoint_celsius` DECIMAL(18,2) COMMENT 'Nominal process temperature setpoint in degrees Celsius for thermal process steps such as deposition, diffusion, or annealing.',
    `tool_class` STRING COMMENT 'Equipment class or tool type required to execute this process step (e.g., EUV Scanner, PECVD Reactor, CMP Polisher, Ion Implanter).',
    `version_number` STRING COMMENT 'Version identifier for this process step definition, supporting change control and revision tracking.',
    CONSTRAINT pk_step PRIMARY KEY(`step_id`)
) COMMENT 'Individual unit process step within a process flow, representing a discrete manufacturing operation such as photolithography exposure, CVD deposition, CMP planarization, ion implantation, dry etch, wet clean, or metrology measurement. Captures step sequence number, operation type, tool class, target layer, nominal recipe parameters, and step classification (FEOL/MOL/BEOL). Owned by the process domain as the atomic building block of all process flows.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`recipe` (
    `recipe_id` BIGINT COMMENT 'Primary key for recipe',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Recipes often developed and baselined on specific chamber. Recipe management, transfer protocols, and chamber matching studies require baseline chamber attribution in semiconductor process engineering',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Recipes define material consumption, tool time, and process parameters that drive costs allocated to specific cost centers. Required for standard cost calculation and recipe cost modeling in wafer fab',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: A recipe is authored for a specific fab tool model; the FK supports recipe‑tool compatibility checks and tool‑specific parameter validation.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Recipe Management tracks which IC product uses a recipe; required for change control and qualification.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Recipes define usage of specific chemicals/materials; linking to material_master enables supplier certification, lot tracking, and regulatory compliance.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Recipes are qualified with specific material suppliers (e.g., Tokyo Ohka photoresist formulation, Air Products specialty gas specification). Essential for supply chain qualification, change control (P',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to inventory.raw_material. Business justification: Recipe must reference the exact raw material used for traceability and compliance; linking supports material usage reports and regulatory audits.',
    `reach_svhc_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.reach_svhc_declaration. Business justification: Recipes using SVHC substances must be linked to customer-facing REACH declarations. Regulatory compliance requires tracing which recipes use listed substances to generate accurate product-level SVHC d',
    `substance_inventory_id` BIGINT COMMENT 'Foreign key linking to compliance.substance_inventory. Business justification: Recipes specify controlled chemicals/gases (etch chemistry, slurry, dopants) that must be tracked in substance inventory for REACH/SVHC/conflict minerals compliance. Regulatory declarations require tr',
    `approval_status` STRING COMMENT 'Current approval and qualification state of the recipe: draft (under development), under_review (pending approval), approved (released for use), qualified (validated on production tool), deprecated (phasing out), or obsolete (no longer valid).. Valid values are `draft|under_review|approved|qualified|deprecated|obsolete`',
    `chamber_configuration` STRING COMMENT 'Specific chamber or module configuration within the tool class, including chamber ID and hardware configuration state.',
    `cmp_pad_type` STRING COMMENT 'CMP polishing pad material and type identifier. Null for non-CMP recipes.',
    `cmp_platen_pressure_psi` DECIMAL(18,2) COMMENT 'Downforce pressure in PSI applied to wafer during CMP. Null for non-CMP recipes.',
    `cmp_removal_target_nm` DECIMAL(18,2) COMMENT 'Target material removal thickness in nanometers for CMP process. Null for non-CMP recipes.',
    `cmp_slurry_type` STRING COMMENT 'CMP slurry formulation identifier (e.g., oxide slurry, tungsten slurry, copper slurry). Null for non-CMP recipes.',
    `cmp_table_speed_rpm` DECIMAL(18,2) COMMENT 'Platen rotation speed in RPM during CMP. Null for non-CMP recipes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipe record was first created in the manufacturing execution system.',
    `deposition_method` STRING COMMENT 'Thin film deposition technique: LPCVD (low pressure chemical vapor deposition), PECVD (plasma enhanced CVD), ALD (atomic layer deposition), PVD (physical vapor deposition), EPI (epitaxy), MOCVD (metal-organic CVD), or MBE (molecular beam epitaxy). Null for non-deposition recipes. [ENUM-REF-CANDIDATE: lpcvd|pecvd|ald|pvd|epi|mocvd|mbe — 7 candidates stripped; promote to reference product]',
    `deposition_pressure_torr` DECIMAL(18,2) COMMENT 'Process chamber pressure in Torr during deposition. Null for non-deposition recipes.',
    `deposition_rf_power_w` DECIMAL(18,2) COMMENT 'Radio frequency power in Watts for plasma-enhanced deposition processes (PECVD). Null for non-plasma deposition recipes.',
    `deposition_target_thickness_nm` DECIMAL(18,2) COMMENT 'Target film thickness in nanometers for deposition processes. Null for non-deposition recipes.',
    `deposition_temperature_c` DECIMAL(18,2) COMMENT 'Process chamber temperature in degrees Celsius during deposition. Null for non-deposition recipes.',
    `effective_end_date` DATE COMMENT 'Date when this recipe version is no longer valid for production use. Null for currently active recipes.',
    `effective_start_date` DATE COMMENT 'Date when this recipe version becomes effective and available for production use.',
    `etch_chemistry` STRING COMMENT 'Primary etchant chemistry or gas mixture (e.g., CF4/O2, HBr/Cl2, SF6, HF/HNO3). Null for non-etch recipes.',
    `etch_pressure_mtorr` DECIMAL(18,2) COMMENT 'Process chamber pressure in milliTorr during dry etch. Null for non-dry-etch recipes.',
    `etch_rf_bias_power_w` DECIMAL(18,2) COMMENT 'RF bias power in Watts controlling ion bombardment energy in reactive ion etch. Null for non-plasma-etch recipes.',
    `etch_rf_source_power_w` DECIMAL(18,2) COMMENT 'RF source power in Watts for plasma generation in reactive ion etch. Null for non-plasma-etch recipes.',
    `etch_selectivity_ratio` DECIMAL(18,2) COMMENT 'Ratio of etch rate of target material to etch rate of mask or underlying material, indicating process selectivity. Null for non-etch recipes.',
    `etch_type` STRING COMMENT 'Etch process category: dry (gas-phase), wet (liquid chemical), plasma, reactive ion etch (RIE), or deep reactive ion etch (DRIE). Null for non-etch recipes.. Valid values are `dry|wet|plasma|reactive_ion|deep_reactive_ion`',
    `implant_dose_cm2` DECIMAL(18,2) COMMENT 'Ion implantation dose in ions per square centimeter controlling dopant concentration. Null for non-implant recipes.',
    `implant_energy_kev` DECIMAL(18,2) COMMENT 'Ion implantation energy in kilo-electron volts (keV) controlling implant depth. Null for non-implant recipes.',
    `implant_species` STRING COMMENT 'Dopant species for ion implantation processes (e.g., Boron, Phosphorus, Arsenic, BF2, Germanium). Null for non-implant recipes.',
    `implant_tilt_angle_deg` DECIMAL(18,2) COMMENT 'Wafer tilt angle in degrees during ion implantation to control channeling effects. Null for non-implant recipes.',
    `implant_twist_angle_deg` DECIMAL(18,2) COMMENT 'Wafer twist (rotation) angle in degrees during ion implantation to control channeling effects. Null for non-implant recipes.',
    `litho_exposure_dose_mj_cm2` DECIMAL(18,2) COMMENT 'Exposure energy dose in mJ/cm² for photoresist exposure. Null for non-lithography recipes.',
    `litho_focus_offset_nm` DECIMAL(18,2) COMMENT 'Focus offset in nanometers from best focus position for process window optimization. Null for non-lithography recipes.',
    `litho_illumination_mode` STRING COMMENT 'Illumination source configuration (e.g., conventional, annular, dipole, quadrupole, freeform). Null for non-lithography recipes.',
    `litho_numerical_aperture` DECIMAL(18,2) COMMENT 'Numerical aperture of the lithography lens system controlling resolution. Null for non-lithography recipes.',
    `litho_scanner_model` STRING COMMENT 'Photolithography scanner tool model (e.g., ASML NXT:2000i, Nikon NSR-S630D). Null for non-lithography recipes.',
    `litho_wavelength_nm` DECIMAL(18,2) COMMENT 'Exposure wavelength in nanometers (e.g., 193 for ArF DUV, 13.5 for EUV). Null for non-lithography recipes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recipe record was last modified or updated.',
    `process_type` STRING COMMENT 'Primary process category that this recipe executes: implant (ion implantation), deposition (CVD/PVD/ALD/EPI), etch (dry/wet), CMP (chemical mechanical planarization), lithography (photolithography), anneal (thermal treatment), clean (wafer cleaning), or metrology (measurement). [ENUM-REF-CANDIDATE: implant|deposition|etch|cmp|lithography|anneal|clean|metrology — 8 candidates stripped; promote to reference product]',
    `recipe_name` STRING COMMENT 'Human-readable name of the process recipe used for identification and reference in manufacturing execution systems.',
    `tool_class` STRING COMMENT 'Equipment tool class or model family for which this recipe is designed (e.g., Applied Materials Centura, LAM 2300, ASML NXT).',
    `version` STRING COMMENT 'Version identifier of the recipe indicating revision level. Follows semantic versioning or sequential numbering per fab standards.',
    CONSTRAINT pk_recipe PRIMARY KEY(`recipe_id`)
) COMMENT 'Detailed equipment-level process recipe defining all controllable parameters for a specific unit process step on a specific tool class. Captures recipe name, version, tool class, chamber configuration, and all process parameter setpoints organized by process type: implant conditions (species, energy, dose, tilt, twist, beam current, anneal recipe), deposition conditions (method such as LPCVD/PECVD/ALD/PVD/EPI, target material, thickness, temperature, pressure, precursor flows, RF power, deposition rate, uniformity spec), etch conditions (type, chemistry, gas flows, pressure, RF source/bias power, etch rate, selectivity, CD bias, endpoint detection), CMP conditions (slurry, pad, platen pressure, carrier speed, table speed, endpoint detection, removal target, post-CMP clean, uniformity spec), and lithography conditions (scanner, wavelength, NA, sigma, illumination mode, resist type/thickness, exposure dose, focus offset, develop process, bake temperatures, OPC rule set reference). Includes recipe approval status, effective date range, qualification linkage, and full revision history. Sourced from Applied Materials SmartFactory MES and Camstar MES recipe management modules. SSOT for ALL equipment-level process parameters and conditions; no separate condition products exist — all process-type-specific parameters are attributes within this unified recipe entity.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`lot_process_run` (
    `lot_process_run_id` BIGINT COMMENT 'Unique identifier for the lot process run record. Primary key for this transactional event capturing a wafer lot executing a specific process step on specific equipment.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Needed for Order Traceability: lot process runs are executed for a specific customer account, enabling billing, compliance, and yield reporting per customer.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Tracks actual supplier of consumables/materials used in each lot run. Critical for yield correlation analysis (e.g., "all lots with Supplier X batch Y showed 5% yield drop"), defect root cause, and su',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: MES cost accounting assigns each lot run to a cost center for budgeting and variance analysis, required for daily production cost reporting.',
    `customer_design_registration_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_registration. Business justification: Engineering and qualification lots are run specifically to support a customers design registration (prototype, characterization, or qualification lots). Fab operations teams track which lot runs were',
    `delivery_schedule_id` BIGINT COMMENT 'Foreign key linking to order.delivery_schedule. Business justification: Lot process runs must be traceable to customer delivery schedule commitments for on-time delivery management. Fab planners use this link to assess whether in-progress lots will meet confirmed delivery',
    `fab_tool_id` BIGINT COMMENT 'Reference to the specific fabrication equipment tool that processed this lot. Critical for equipment performance analysis, utilization tracking, and SPC (Statistical Process Control) correlation.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Every wafer lot run manufactures a specific IC product. Yield tracking, cost accounting, and customer order fulfillment reports aggregate at the IC catalog level. lot_process_run has sku_id but IC-lev',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Lot process runs execute on wafer lots tracked in inventory system. Critical MES-to-inventory bridge for WIP tracking, cycle time analysis, and inventory valuation of in-process material in semiconduc',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Required for Order Fulfillment Tracking report that ties each production run to the sales order it fulfills.',
    `recipe_id` BIGINT COMMENT 'Reference to the actual recipe executed for this process step. May differ from the planned recipe if engineering overrides or recipe revisions occurred. Links to the recipe master in the fabrication domain.',
    `process_step_id` BIGINT COMMENT 'Reference to the specific process step in the technology node process flow that this lot executed. Defines the operation type (photolithography, etch, deposition, implant, CMP, metrology, etc.).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Production runs generate revenue and margin tracked by profit centers for product line P&L. Essential for profitability analysis by technology node, customer, or product family in semiconductor manufa',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Lot Traceability report ties each run to the SKU being produced, enabling yield and compliance tracking.',
    `step_id` BIGINT COMMENT 'FK to process.process_process_step.process_process_step_id — Every lot process run is an execution of a specific process step. This FK is essential for WIP tracking and SPC data collection context.',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific chamber or module within the equipment tool where the lot was processed. Critical for multi-chamber tools to isolate chamber-specific process variation and matching.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the lot processing completed on the equipment. Used to calculate actual process duration and equipment throughput.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the lot processing began on the equipment. Captured from MES equipment interface for cycle time analysis and equipment utilization tracking.',
    `control_chart_rule_violated` STRING COMMENT 'Specific SPC rule violated if control_chart_violation_flag is true (e.g., Western Electric Rule 1: Point beyond 3-sigma, Nelson Rule 2: Nine points in a row on same side of centerline). Null if no violation.',
    `control_chart_violation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this process run violated SPC control chart rules (e.g., out-of-control limits, run rules, trend rules). True indicates a violation requiring engineering investigation.',
    `defect_count` STRING COMMENT 'Total number of defects detected on the lot at this process step by in-line inspection tools. Used for defect density calculation and yield prediction.',
    `defect_density_per_cm2` DECIMAL(18,2) COMMENT 'Calculated defect density in defects per square centimeter for this lot at this process step. Key yield predictor and process health indicator.',
    `hold_reason_code` STRING COMMENT 'Standardized code indicating the reason for lot hold if lot_disposition is hold. Examples include out-of-spec measurement, equipment alarm, material shortage, engineering investigation. Null if lot not on hold.',
    `lot_disposition` STRING COMMENT 'Outcome disposition of the lot after completing this process step. Pass indicates the lot met all specifications and proceeds to the next step; hold indicates engineering review required; scrap indicates lot rejected; rework indicates lot requires reprocessing; conditional_pass indicates lot passed with waiver or deviation.. Valid values are `pass|hold|scrap|rework|conditional_pass`',
    `measurement_result_value` DECIMAL(18,2) COMMENT 'Primary in-line measurement result collected at this process step (e.g., film thickness, CD (Critical Dimension), overlay, resistivity). The specific measurement type is defined by the process step. Used for real-time SPC and process control.',
    `measurement_site_count` STRING COMMENT 'Number of measurement sites sampled on the wafer(s) for this in-line measurement. Used to assess measurement sampling adequacy and statistical confidence.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the in-line measurement result. Common units include nm (nanometers) for thickness and CD, angstrom for thin films, um (micrometers) for overlay, ohm_per_square for sheet resistance, percent for uniformity, ppm (parts per million) for defect density, degree for angular measurements. [ENUM-REF-CANDIDATE: nm|angstrom|um|ohm_per_square|percent|ppm|degree — 7 candidates stripped; promote to reference product]',
    `process_duration_seconds` STRING COMMENT 'Actual elapsed time in seconds for this process run, calculated from start to end timestamp. Used for cycle time analysis, equipment performance monitoring, and throughput optimization.',
    `process_gas_flow_sccm` DECIMAL(18,2) COMMENT 'Total process gas flow rate in standard cubic centimeters per minute (SCCM) for this run. Aggregated flow for multi-gas processes; individual gas flows tracked in separate metrology records.',
    `process_notes` STRING COMMENT 'Free-text notes entered by the operator or process engineer documenting any anomalies, deviations, or special conditions during this process run. Used for root cause analysis and process improvement.',
    `process_power_watts` DECIMAL(18,2) COMMENT 'Actual RF or DC power in watts applied during this process run. Key parameter for plasma-based processes including etch, PVD, and PECVD (Plasma-Enhanced Chemical Vapor Deposition).',
    `process_pressure_torr` DECIMAL(18,2) COMMENT 'Actual process chamber pressure in Torr recorded during this run. Critical parameter for vacuum processes including PVD (Physical Vapor Deposition), CVD, etch, and implant.',
    `process_qualification_status` STRING COMMENT 'Qualification status of the process step execution. Qualified indicates the process met all capability and stability requirements; not_qualified indicates process failed qualification criteria; pending_qualification indicates qualification in progress; requalification_required indicates process drift detected requiring re-qualification.. Valid values are `qualified|not_qualified|pending_qualification|requalification_required`',
    `process_temperature_c` DECIMAL(18,2) COMMENT 'Actual process temperature in degrees Celsius recorded during this run. Key process parameter for thermal processes such as CVD (Chemical Vapor Deposition), diffusion, annealing, and oxidation.',
    `recipe_version` STRING COMMENT 'Version identifier of the recipe executed. Critical for process change control and correlation of recipe revisions to yield and quality outcomes.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process run record was first created in the source MES system. Used for data lineage and audit trail purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this process run record was last updated in the source MES system. Tracks modifications to disposition, measurements, or other attributes after initial creation.',
    `rework_count` STRING COMMENT 'Number of times this lot has been reworked at this process step. Tracks process stability and identifies chronic problem areas. Zero indicates first-pass processing.',
    `run_number` STRING COMMENT 'Business identifier for this process run event. Typically a sequential or timestamp-based identifier assigned by the MES (Manufacturing Execution System) for traceability and audit purposes.',
    `scrap_reason_code` STRING COMMENT 'Standardized code indicating the reason for lot scrap if lot_disposition is scrap. Examples include catastrophic defect, process excursion, contamination, equipment failure. Null if lot not scrapped.',
    `source_system` STRING COMMENT 'Identifies the source MES (Manufacturing Execution System) that captured this process run record. Camstar MES and Applied SmartFactory MES are the primary operational systems of record for lot process tracking.. Valid values are `camstar_mes|smartfactory_mes|manual_entry`',
    `wafer_count` STRING COMMENT 'Number of wafers in the lot that were processed in this run. May differ from the original lot size if wafers were scrapped or held at prior steps.',
    CONSTRAINT pk_lot_process_run PRIMARY KEY(`lot_process_run_id`)
) COMMENT 'Transactional record of a wafer lot executing a specific process step on a specific piece of equipment. Captures lot ID reference, process step reference, equipment ID, operator ID, actual start and end timestamps, actual recipe used, chamber ID, lot disposition (pass/hold/scrap), and any in-line measurement results collected at that step. This is the core WIP tracking event for process engineering analysis. SSOT boundary: process domain owns the process-step-level execution record for engineering analysis; fabrication domain owns the lot lifecycle (lot creation, split, merge, hold, scrap, ship) and overall WIP status. Sourced from Camstar MES and Applied SmartFactory MES lot history.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`spc_control_chart` (
    `spc_control_chart_id` BIGINT COMMENT 'Primary key for spc_control_chart',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: SPC charts are owned by a cost center; linking enables process‑control budgeting and cost‑center performance dashboards.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the metrology tool or equipment used to take the measurement (e.g., KLA ICOS tool ID, inline metrology tool ID). Enables tool-to-tool variation analysis.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this SPC chart is defined. Links to the technology node master data.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the fabrication wafer lot from which the measurement was taken. Links to the wafer lot master data for traceability.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Product‑specific SPC charts are defined per IC; used in the Product SPC Dashboard.',
    `process_step_id` BIGINT COMMENT 'Reference to the specific process step (e.g., photolithography, etch, deposition, implant) being monitored by this SPC chart.',
    `quality_spec_id` BIGINT COMMENT 'Foreign key linking to quality.quality_spec. Business justification: SPC control charts monitor process parameters against quality specifications. The quality_spec defines the specification limits that determine control limit calculations and out-of-spec flags on the s',
    `step_id` BIGINT COMMENT 'FK to process.process_step.process_step_id — Every SPC control chart monitors a parameter at a specific process step. This FK is essential for SPC chart setup and process monitoring workflows.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Control charts often maintained per chamber for tighter process control. Chamber qualification, baseline establishment, and production release require chamber-specific SPC in semiconductor manufacturi',
    `baseline_data_points` STRING COMMENT 'Number of data points collected during the baseline period to establish initial control limits. Typically 25-30 subgroups are required for reliable limit calculation.',
    `chart_activation_date` DATE COMMENT 'Date when the SPC chart was first activated for production monitoring. Marks the beginning of the charts operational lifecycle.',
    `chart_name` STRING COMMENT 'Business-friendly name of the SPC control chart for identification and reporting purposes.',
    `chart_owner` STRING COMMENT 'Name or identifier of the process engineer or team responsible for monitoring and maintaining this SPC chart.',
    `chart_retirement_date` DATE COMMENT 'Date when the SPC chart was retired from active monitoring. Nullable for active charts. Retired charts are preserved for historical analysis.',
    `chart_status` STRING COMMENT 'Current lifecycle status of the SPC chart. Active charts are in production monitoring; suspended charts are temporarily paused; retired charts are no longer used; under review charts are being evaluated for limit adjustments; baseline collection charts are gathering initial data to establish control limits.. Valid values are `active|suspended|retired|under_review|baseline_collection`',
    `chart_type` STRING COMMENT 'Type of SPC control chart used for monitoring. Xbar-R (average and range), Xbar-S (average and standard deviation), EWMA (exponentially weighted moving average), CUSUM (cumulative sum), IMR (individual and moving range), P-chart (proportion defective), NP-chart (number defective), C-chart (count of defects), U-chart (defects per unit). [ENUM-REF-CANDIDATE: xbar_r|xbar_s|ewma|cusum|imr|p_chart|np_chart|c_chart|u_chart — 9 candidates stripped; promote to reference product]',
    `control_limit_calculation_method` STRING COMMENT 'Method used to calculate the control limits for this SPC chart. Three sigma uses standard deviation-based limits; six sigma uses tighter limits; Cpk-based derives limits from process capability index; historical baseline uses past performance data; engineering specification uses design requirements.. Valid values are `three_sigma|six_sigma|cpk_based|historical_baseline|engineering_specification`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SPC control chart record was first created in the system. Audit trail for record creation.',
    `data_source_system` STRING COMMENT 'Name of the source system that provided the measurement data (e.g., KLA ICOS, Camstar MES, inline metrology tool). Enables data lineage tracking.',
    `last_limit_revision_date` DATE COMMENT 'Date when the control limits were last revised or recalculated. Control limits should be periodically reviewed and updated as process capability improves.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this SPC control chart record was last modified. Audit trail for record changes.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Lower control limit (LCL) for the SPC chart. Typically set at -3 sigma from the target value. Measurements below this limit indicate an out-of-control process.',
    `lower_warning_limit` DECIMAL(18,2) COMMENT 'Lower warning limit (LWL) for the SPC chart. Typically set at -2 sigma from the target value. Measurements below this limit trigger a warning but do not necessarily indicate an out-of-control process.',
    `measured_value` DECIMAL(18,2) COMMENT 'Actual measured value of the monitored parameter at the time of measurement. This is the primary data point plotted on the SPC chart.',
    `measurement_sequence_number` STRING COMMENT 'Sequential number of this measurement within the SPC chart history. Used for time-series analysis and trend detection.',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was taken by the metrology tool. Represents the actual measurement event time.',
    `monitored_parameter_name` STRING COMMENT 'Name of the process parameter being monitored by this SPC chart (e.g., critical dimension, film thickness, overlay, etch rate, resistivity).',
    `ocap_reference_number` STRING COMMENT 'Reference number of the Out-of-Control Action Plan (OCAP) triggered by this measurement, if applicable. Links to the OCAP tracking system for root cause analysis and corrective action.',
    `parameter_unit_of_measure` STRING COMMENT 'Unit of measure for the monitored parameter (e.g., nm, angstrom, ohm-cm, percent, degrees Celsius).',
    `process_action_taken` STRING COMMENT 'Action taken in response to the measurement and any rule violations. None indicates no action required; warning issued indicates notification sent; OCAP triggered indicates Out-of-Control Action Plan initiated; lot hold indicates lot placed on hold; equipment hold indicates equipment taken offline; process adjustment indicates recipe or parameter adjustment made; engineering review indicates escalation to process engineering. [ENUM-REF-CANDIDATE: none|warning_issued|ocap_triggered|lot_hold|equipment_hold|process_adjustment|engineering_review — 7 candidates stripped; promote to reference product]',
    `process_capability_index_cp` DECIMAL(18,2) COMMENT 'Process capability index Cp, calculated as (USL - LSL) / (6 * sigma). Measures the potential capability of the process to meet specifications, assuming the process is centered. Values > 1.33 are typically considered acceptable.',
    `process_capability_index_cpk` DECIMAL(18,2) COMMENT 'Process capability index Cpk, calculated as min[(USL - mean) / (3 * sigma), (mean - LSL) / (3 * sigma)]. Measures the actual capability of the process to meet specifications, accounting for process centering. Values > 1.33 are typically considered acceptable.',
    `rule_violations_triggered` STRING COMMENT 'Comma-separated list of SPC rule violations detected for this measurement (e.g., Western Electric rules 1-4, Nelson rules 1-8). Examples: Rule 1 (one point beyond 3 sigma), Rule 2 (nine points in a row on same side of center line), Rule 3 (six points in a row steadily increasing or decreasing).',
    `sample_size` STRING COMMENT 'Number of measurements or observations taken per sampling event for this SPC chart (e.g., 5 wafers per lot, 9 sites per wafer).',
    `sampling_frequency` STRING COMMENT 'Frequency at which measurements are taken for this SPC chart (e.g., every lot, every 5 lots, every 8 hours, per wafer).',
    `site_x_coordinate` DECIMAL(18,2) COMMENT 'X-axis coordinate of the measurement site on the wafer surface. Used for spatial analysis and mapping of process uniformity.',
    `site_y_coordinate` DECIMAL(18,2) COMMENT 'Y-axis coordinate of the measurement site on the wafer surface. Used for spatial analysis and mapping of process uniformity.',
    `specification_lower_limit` DECIMAL(18,2) COMMENT 'Lower specification limit (LSL) defined by the process design or customer requirements. Represents the minimum acceptable value for the parameter. Used in capability index calculations.',
    `specification_upper_limit` DECIMAL(18,2) COMMENT 'Upper specification limit (USL) defined by the process design or customer requirements. Represents the maximum acceptable value for the parameter. Used in capability index calculations.',
    `target_value` DECIMAL(18,2) COMMENT 'Target or nominal value for the monitored parameter. Represents the ideal process center line.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Upper control limit (UCL) for the SPC chart. Typically set at +3 sigma from the target value. Measurements exceeding this limit indicate an out-of-control process.',
    `upper_warning_limit` DECIMAL(18,2) COMMENT 'Upper warning limit (UWL) for the SPC chart. Typically set at +2 sigma from the target value. Measurements exceeding this limit trigger a warning but do not necessarily indicate an out-of-control process.',
    CONSTRAINT pk_spc_control_chart PRIMARY KEY(`spc_control_chart_id`)
) COMMENT 'Statistical Process Control (SPC) control chart definition and complete measurement history for a monitored process parameter at a specific process step. Chart definition captures chart type (Xbar-R, Xbar-S, EWMA, CUSUM, IMR), monitored parameter name, control limits (UCL, LCL, UWL, LWL), target value, sample size, sampling frequency, chart owner, and current chart status. Measurement detail (header+line pattern) captures all individual data points: measured value, measurement timestamp, lot reference, wafer number, site coordinates, measurement tool ID, chart rule violations triggered (Western Electric rules, Nelson rules), and resulting process action (none, warning, OCAP triggered). Implements SEMI E10 and JEDEC SPC guidelines. Sourced from KLA ICOS and in-line metrology tools. SSOT for all SPC monitoring definitions and measurement data in the process domain.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`spc_measurement` (
    `spc_measurement_id` BIGINT COMMENT 'Unique identifier for the SPC measurement data point. Primary key for the SPC measurement record.',
    `fab_tool_id` BIGINT COMMENT 'Reference to the metrology or inspection equipment that captured this measurement. Links to the KLA ICOS or in-line metrology tool used for data collection.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (process generation) for which this measurement was taken. Links to the semiconductor technology node (e.g., 7nm, 5nm, 3nm) being manufactured.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot being measured. Links to the fabrication lot that was sampled for this SPC measurement.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: SPC measurements are recorded per product for quality analysis; required by the SPC Data Analysis process.',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: An SPC measurement is taken during a specific lot process run. Linking spc_measurement to lot_process_run provides direct traceability from the measurement to the exact run conditions (equipment, reci',
    `metrology_run_id` BIGINT COMMENT 'The identifier of the measurement run or batch that this data point belongs to. Groups multiple measurements taken during a single metrology session or sampling event.',
    `process_step_id` BIGINT COMMENT 'Reference to the process step at which this measurement was taken. Identifies the specific fabrication operation (photolithography, etch, deposition, implant, etc.) being monitored.',
    `recipe_id` BIGINT COMMENT 'The identifier of the process recipe that was active when this measurement was taken. Links the measurement to the specific process parameters and settings used during fabrication.',
    `spc_control_chart_id` BIGINT COMMENT 'Reference to the SPC control chart against which this measurement is plotted. Links to the control chart configuration defining control limits, chart type, and monitoring rules.',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: An SPC measurement is recorded at a specific process step. While spc_measurement already has spc_control_chart_id (which links to a chart that monitors a process_step), a direct FK to process_step ena',
    `wafer_id` BIGINT COMMENT 'Reference to the specific wafer within the lot that was measured. Identifies the individual wafer substrate on which the measurement was taken.',
    `comments` STRING COMMENT 'Free-text field for operator or engineer comments regarding this measurement. Used to capture contextual information, anomalies, or special conditions observed during measurement.',
    `control_limit_lower` DECIMAL(18,2) COMMENT 'The lower control limit of the SPC chart at the time of measurement. Represents the lower boundary of acceptable process variation (typically mean - 3 sigma).',
    `control_limit_upper` DECIMAL(18,2) COMMENT 'The upper control limit of the SPC chart at the time of measurement. Represents the upper boundary of acceptable process variation (typically mean + 3 sigma).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SPC measurement record was first created in the system. Represents the audit trail of when the data was captured into the lakehouse.',
    `deviation_from_target` DECIMAL(18,2) COMMENT 'The calculated difference between the measured value and the target value. Positive values indicate measurements above target; negative values indicate measurements below target.',
    `measured_value` DECIMAL(18,2) COMMENT 'The numeric value of the process parameter measured at this data point. Represents the actual measurement result (e.g., film thickness, critical dimension, overlay, resistivity) captured by the metrology tool.',
    `measurement_on_chart` BIGINT COMMENT 'FK to process.process_spc_control_chart.process_spc_control_chart_id — Every SPC measurement data point belongs to a specific control chart. This is the fundamental transaction-to-master relationship for SPC.',
    `measurement_status` STRING COMMENT 'The quality status of the measurement data point. Indicates whether the measurement is valid for SPC analysis or requires review, retest, or exclusion due to equipment errors or data quality issues.. Valid values are `valid|invalid|suspect|retest_required|equipment_error`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was captured by the metrology tool. Represents the real-world event time of the SPC data point collection.',
    `measurement_type` STRING COMMENT 'The category of measurement based on when and how it was taken. Distinguishes between inline production measurements, offline lab measurements, final inspection, process qualification runs, and dedicated monitor wafer measurements.. Valid values are `inline|offline|final_inspection|qualification|monitor_wafer`',
    `out_of_control_flag` BOOLEAN COMMENT 'Boolean indicator of whether this measurement triggered an out-of-control condition. True if the measurement violated control limits or SPC rules requiring corrective action.',
    `out_of_spec_flag` BOOLEAN COMMENT 'Boolean indicator of whether this measurement exceeded specification limits. True if the measured value fell outside the upper or lower specification limits defined by engineering.',
    `parameter_code` STRING COMMENT 'The standardized code or abbreviation for the measured parameter. Used for system integration and cross-tool correlation (e.g., CD_GATE, THICK_OXIDE, OVL_X, RS_POLY).',
    `parameter_name` STRING COMMENT 'The name of the process parameter being measured. Examples include critical dimension (CD), film thickness, overlay, sheet resistance, particle count, or other process-specific metrics.',
    `process_action_taken` STRING COMMENT 'The immediate process action triggered by this measurement result. Indicates the response to out-of-control or out-of-spec conditions, ranging from no action to lot holds, equipment stops, or engineering escalation. [ENUM-REF-CANDIDATE: none|warning_issued|lot_hold|equipment_hold|rework_initiated|scrap_initiated|engineering_review|corrective_action_plan — 8 candidates stripped; promote to reference product]',
    `rule_violation_flags` STRING COMMENT 'Comma-separated list of SPC rule violations triggered by this measurement. Includes Western Electric rules (e.g., WE1, WE2, WE3, WE4) and Nelson rules (e.g., N1, N2, N3) that detected out-of-control conditions or trends.',
    `sigma_level` DECIMAL(18,2) COMMENT 'The number of standard deviations the measured value is from the process mean. Used to assess process capability and identify outliers.',
    `site_number` STRING COMMENT 'The sequential identifier of the measurement site within the wafer sampling plan. Corresponds to the predefined site map used for metrology sampling.',
    `site_x_coordinate` DECIMAL(18,2) COMMENT 'The X-axis coordinate of the measurement site on the wafer surface. Used for spatial mapping and within-wafer uniformity analysis.',
    `site_y_coordinate` DECIMAL(18,2) COMMENT 'The Y-axis coordinate of the measurement site on the wafer surface. Used for spatial mapping and within-wafer uniformity analysis.',
    `specification_limit_lower` DECIMAL(18,2) COMMENT 'The lower specification limit defined by the process design. Represents the minimum acceptable value for the parameter as defined by engineering requirements.',
    `specification_limit_upper` DECIMAL(18,2) COMMENT 'The upper specification limit defined by the process design. Represents the maximum acceptable value for the parameter as defined by engineering requirements.',
    `target_value` DECIMAL(18,2) COMMENT 'The nominal or target value for the measured parameter as defined by the process recipe. Represents the ideal center point for process control.',
    `unit_of_measure` STRING COMMENT 'The unit in which the measured value is expressed. Common units include nanometers (nm) for critical dimensions, angstroms for film thickness, ohms per square for sheet resistance, and percent for uniformity metrics. [ENUM-REF-CANDIDATE: nm|um|mm|angstrom|ohm|ohm_per_sq|percent|degree|mV|mA — 10 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this SPC measurement record was last modified. Used for tracking data corrections, status updates, or reanalysis events.',
    CONSTRAINT pk_spc_measurement PRIMARY KEY(`spc_measurement_id`)
) COMMENT 'Individual SPC data point recorded against a control chart for a specific lot or wafer at a process step. Captures the measured value, measurement timestamp, lot reference, wafer number, site coordinates, measurement tool ID, chart rule violations triggered (Western Electric rules, Nelson rules), and resulting process action (none, warning, out-of-control action plan triggered). Primary transactional feed for real-time SPC monitoring sourced from KLA ICOS and in-line metrology tools.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`capability` (
    `capability_id` BIGINT COMMENT 'Unique identifier for the process capability record.',
    `customer_design_win_id` BIGINT COMMENT 'Foreign key linking to customer.customer_design_win. Business justification: Process capability (Cpk) data packages are generated and submitted to customers as part of design win qualification approval. Semiconductor process engineers link capability studies to the specific de',
    `fab_tool_id` BIGINT COMMENT 'Reference to the specific fabrication equipment or tool on which the process capability was assessed.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node for which this capability assessment applies.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Capability data (Cp, Cpk) is tracked per IC product for the Process Capability Review.',
    `inventory_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_wafer_lot. Business justification: Process capability studies (Cp/Cpk analysis) performed on specific wafer lots in inventory. Essential for process qualification, customer qualification data packages, and inventory release decisions b',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Process capability studies (Cp/Cpk) are always node-scoped. Capability dashboards and customer qualification packages aggregate Cpk by product process_node. capability has fabrication_technology_node_',
    `process_step_id` BIGINT COMMENT 'Reference to the specific process step being monitored for capability.',
    `product_spec_id` BIGINT COMMENT 'Foreign key linking to product.product_spec. Business justification: Capability studies (Cp/Cpk) are evaluated against specification limits defined in product_spec. Process engineers pull product_spec upper/lower limits into capability analysis to compute indices. Cust',
    `recipe_id` BIGINT COMMENT 'Identifier of the process recipe or fabrication process recipe used during the evaluation period.',
    `spc_control_chart_id` BIGINT COMMENT 'Foreign key linking to process.spc_control_chart. Business justification: Process capability indices (Cp, Cpk, Pp, Ppk) are computed from the same measurement data that populates SPC control charts. Linking capability to its source spc_control_chart enables traceability fro',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: A capability index record measures a specific parameter at a specific process step. Without a direct FK to process_step, the capability record cannot be directly associated with the step it characteri',
    `tool_chamber_id` BIGINT COMMENT 'Identifier of the specific process chamber within multi-chamber equipment where measurements were taken.',
    `analysis_timestamp` TIMESTAMP COMMENT 'Date and time when the capability analysis was performed and this record was generated.',
    `assessment_method` STRING COMMENT 'Method used for capability assessment: short-term (initial process qualification), long-term (ongoing production monitoring), initial (pre-production), or ongoing (continuous monitoring).. Valid values are `short_term|long_term|initial|ongoing`',
    `capability_status` STRING COMMENT 'Overall assessment of process capability status based on Cpk threshold criteria. Typically capable (Cpk >= 1.33), marginal (1.0 <= Cpk < 1.33), incapable (Cpk < 1.0).. Valid values are `capable|marginal|incapable|not_assessed`',
    `comments` STRING COMMENT 'Additional notes, observations, or context regarding the capability assessment, including any special causes identified or improvement actions planned.',
    `control_chart_type` STRING COMMENT 'Type of Statistical Process Control (SPC) control chart used for monitoring this parameter (e.g., X-bar R, X-bar S, Individuals, P-chart, C-chart, U-chart).. Valid values are `xbar_r|xbar_s|individuals|p_chart|c_chart|u_chart`',
    `corrective_action_required` BOOLEAN COMMENT 'Flag indicating whether corrective action is required based on capability assessment results falling below acceptable thresholds.',
    `cp_index` DECIMAL(18,2) COMMENT 'Process capability index Cp measuring the potential capability of the process assuming it is centered on target. Calculated as (USL - LSL) / (6 * standard deviation).',
    `cpk_index` DECIMAL(18,2) COMMENT 'Process capability index Cpk measuring the actual capability of the process accounting for centering. Calculated as minimum of [(USL - mean) / (3 * standard deviation), (mean - LSL) / (3 * standard deviation)].',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this process capability record was first created in the system.',
    `evaluation_period_end_date` DATE COMMENT 'End date of the time window over which process capability was calculated.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the time window over which process capability was calculated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this process capability record was last updated or modified.',
    `lower_specification_limit` DECIMAL(18,2) COMMENT 'Lower specification limit defining the minimum acceptable value for the parameter.',
    `mean_value` DECIMAL(18,2) COMMENT 'Arithmetic mean of the parameter measurements over the evaluation period.',
    `measurement_method` STRING COMMENT 'Metrology technique or measurement method used to collect parameter data (e.g., optical CD, SEM, ellipsometry, XRF, electrical test).',
    `normality_test_result` STRING COMMENT 'Result of statistical normality test (e.g., Anderson-Darling, Shapiro-Wilk) to validate that data follows normal distribution, a prerequisite for capability index calculation.. Valid values are `normal|non_normal|not_tested`',
    `out_of_control_points` STRING COMMENT 'Number of data points that violated SPC control rules during the evaluation period, indicating special cause variation.',
    `parameter_code` STRING COMMENT 'Standardized code or identifier for the process parameter in the Manufacturing Execution System (MES).',
    `parameter_name` STRING COMMENT 'Name of the monitored process parameter for which capability is being assessed (e.g., etch rate, film thickness, overlay error, critical dimension).',
    `pp_index` DECIMAL(18,2) COMMENT 'Process performance index Pp measuring the overall performance of the process over time. Calculated as (USL - LSL) / (6 * overall standard deviation).',
    `ppk_index` DECIMAL(18,2) COMMENT 'Process performance index Ppk measuring the actual performance of the process accounting for centering over time. Calculated as minimum of [(USL - mean) / (3 * overall standard deviation), (mean - LSL) / (3 * overall standard deviation)].',
    `process_area` STRING COMMENT 'Major process area classification: FEOL (Front End of Line), MOL (Middle of Line), or BEOL (Back End of Line).. Valid values are `feol|mol|beol`',
    `process_layer` STRING COMMENT 'Specific process layer or mask level in the fabrication flow where this capability assessment applies (e.g., poly gate, metal 1, contact).',
    `product_family` STRING COMMENT 'Product family or device type for which this capability assessment applies (e.g., logic, memory, analog, mixed-signal).',
    `qualification_status` STRING COMMENT 'Qualification status of the process step for production release based on capability assessment results and technology node readiness criteria.. Valid values are `qualified|conditional|not_qualified|pending`',
    `sample_count` STRING COMMENT 'Number of measurement samples included in the capability calculation.',
    `standard_deviation` DECIMAL(18,2) COMMENT 'Standard deviation of the parameter measurements, representing process variation.',
    `subgroup_size` STRING COMMENT 'Number of measurements per subgroup used in the SPC control chart analysis.',
    `target_value` DECIMAL(18,2) COMMENT 'Nominal or target value for the process parameter as specified in the process recipe or design requirements.',
    `trend_direction` STRING COMMENT 'Directional trend of capability indices compared to previous evaluation periods, indicating process improvement or degradation.. Valid values are `improving|stable|degrading|insufficient_data`',
    `unit_of_measure` STRING COMMENT 'Unit of measurement for the parameter values (e.g., nanometers, angstroms, degrees Celsius, torr, sccm).',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'Upper specification limit defining the maximum acceptable value for the parameter.',
    `wafer_size_mm` STRING COMMENT 'Wafer diameter in millimeters for which this capability assessment applies (e.g., 200mm, 300mm, 450mm).',
    CONSTRAINT pk_capability PRIMARY KEY(`capability_id`)
) COMMENT 'Process capability index record for a monitored parameter at a specific process step over a defined evaluation period. Captures Cp, Cpk, Pp, Ppk indices, mean, standard deviation, sample count, evaluation window start/end dates, specification limits (USL, LSL), target value, capability status (capable/marginal/incapable), and trend direction. Used for technology node readiness assessments and continuous improvement tracking per IATF 16949 and ISO 9001 requirements.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`opc_rule_set` (
    `opc_rule_set_id` BIGINT COMMENT 'Unique identifier for the OPC rule set record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: OPC rule set development requires significant EDA tool licenses, engineering time, and computational resources that must be allocated to design or process engineering cost centers for NRE tracking.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: OPC models and lithography IP require ECCN classification for export control. Shipping OPC rule sets to foreign fabs, partners, or customers requires ECCN determination and potential export license. R',
    `process_technology_node_id` BIGINT COMMENT 'FK to process.process_technology_node.process_technology_node_id — OPC rule sets are defined per technology node and layer. Node reference is essential for OPC management.',
    `assist_feature_rules` STRING COMMENT 'Description or reference to the sub-resolution assist feature (SRAF) placement rules included in this OPC rule set.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this OPC rule set record was first created in the system.',
    `eda_tool_name` STRING COMMENT 'Name of the specific EDA tool product used for OPC processing (e.g., Proteus, Calibre nmOPC).',
    `eda_tool_vendor` STRING COMMENT 'Vendor of the EDA tool used to generate and apply this OPC rule set (e.g., Synopsys, Cadence, Mentor Graphics).',
    `eda_tool_version` STRING COMMENT 'Version of the EDA tool used to generate this OPC rule set.',
    `illumination_mode` STRING COMMENT 'Illumination configuration used in the scanner (e.g., conventional, annular, dipole, quadrupole, freeform).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this OPC rule set is currently active and available for use in production flows.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this OPC rule set record was last modified or updated.',
    `lithography_type` STRING COMMENT 'Type of lithography technology used (EUV = Extreme Ultraviolet, DUV = Deep Ultraviolet).. Valid values are `EUV|DUV|i-line|g-line`',
    `lithography_wavelength_nm` DECIMAL(18,2) COMMENT 'Wavelength of the lithography exposure light in nanometers (e.g., 193 for DUV, 13.5 for EUV).',
    `meef_feature_type` STRING COMMENT 'Type of feature for which the MEEF value was characterized (e.g., line, space, contact, via, dense, isolated).',
    `meef_measurement_methodology` STRING COMMENT 'Methodology used to measure and characterize MEEF (e.g., wafer metrology, simulation, focus-exposure matrix).',
    `meef_pitch_nm` DECIMAL(18,2) COMMENT 'Feature pitch in nanometers at which the MEEF value was measured.',
    `meef_target_cd_nm` DECIMAL(18,2) COMMENT 'Target critical dimension in nanometers for the MEEF characterization measurement.',
    `meef_value` DECIMAL(18,2) COMMENT 'Primary MEEF value characterizing the mask-to-wafer CD error amplification for this layer and process. MEEF = (wafer CD change) / (mask CD change).',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this OPC rule set.',
    `opc_model_type` STRING COMMENT 'Type of OPC correction methodology employed in this rule set.. Valid values are `rule_based|model_based|hybrid|inverse_lithography`',
    `owner_engineer_name` STRING COMMENT 'Name of the process engineer or lithography engineer responsible for this OPC rule set.',
    `owner_organization` STRING COMMENT 'Organization or department responsible for maintaining this OPC rule set (e.g., Lithography Engineering, Process Integration).',
    `process_bias_table_reference` STRING COMMENT 'Reference identifier to the process bias lookup tables used for CD correction in this OPC rule set.',
    `process_window_dof_nm` DECIMAL(18,2) COMMENT 'Depth of focus in nanometers defining the usable focus range for this OPC rule set and layer.',
    `process_window_el_percent` DECIMAL(18,2) COMMENT 'Exposure latitude as a percentage defining the usable dose range for this OPC rule set and layer.',
    `qualification_date` DATE COMMENT 'Date when this OPC rule set was qualified and approved for production use.',
    `qualification_status` STRING COMMENT 'Current qualification and approval status of this OPC rule set for production use.. Valid values are `draft|under_qualification|qualified|production|deprecated`',
    `rule_set_file_format` STRING COMMENT 'File format of the OPC rule set (e.g., proprietary Synopsys format, Cadence format, industry standard).',
    `rule_set_file_path` STRING COMMENT 'File system path or repository location of the OPC rule set file used by EDA tools (Synopsys, Cadence).',
    `rule_set_name` STRING COMMENT 'Business name or identifier for this OPC rule set, typically including layer and node information.',
    `rule_set_version` STRING COMMENT 'Version identifier for this OPC rule set, tracking revisions and updates to the correction algorithms.',
    `scanner_numerical_aperture` DECIMAL(18,2) COMMENT 'Numerical aperture of the lithography scanner lens system, defining the light-gathering capability and resolution.',
    `sigma_inner` DECIMAL(18,2) COMMENT 'Inner sigma value defining the illumination pupil fill for off-axis illumination modes.',
    `sigma_outer` DECIMAL(18,2) COMMENT 'Outer sigma value defining the illumination pupil fill for off-axis illumination modes.',
    `target_layer_name` STRING COMMENT 'Name of the lithography layer (e.g., Metal1, Poly, Contact) for which this OPC rule set applies.',
    CONSTRAINT pk_opc_rule_set PRIMARY KEY(`opc_rule_set_id`)
) COMMENT 'Optical Proximity Correction (OPC) rule set and MEEF characterization record for a specific lithography layer and technology node. Captures OPC model version, target layer name, technology node, lithography wavelength (EUV/DUV), scanner NA, illumination mode, rule set file reference, process bias tables, assist feature rules, qualification status, and complete MEEF characterization (MEEF value per feature type, pitch, CD target, process window DOF/EL, sigma illumination, NA, wavelength, measurement methodology). MEEF parameters are integral attributes of the OPC rule set as they characterize mask-to-wafer CD transfer fidelity within the OPC model context. Managed in conjunction with Synopsys and Cadence EDA OPC flows. SSOT for all OPC, MEEF, and lithography proximity correction data used in mask data preparation and CD tolerance specification.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`qualification` (
    `qualification_id` BIGINT COMMENT 'Unique identifier for the process qualification program record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer-specific qualification: certain process qualifications are performed for a particular customer, required for compliance reports and customer approval tracking.',
    `certification_id` BIGINT COMMENT 'Foreign key linking to compliance.certification. Business justification: Process qualification must be backed by a certification (e.g., ISO, ISO‑9001) to satisfy customer and regulatory requirements.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Process qualification activities (wafer runs, metrology, analysis) incur significant costs that must be tracked to R&D or process engineering cost centers for NRE accounting and capitalization decisio',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Qualification runs are executed on a specific fab tool; the FK records which tool was qualified, supporting qualification history and tool eligibility checks.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Qualification records are tied to the specific IC they qualify; needed for the Qualification Status Report.',
    `obligation_register_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation_register. Business justification: Process qualifications may be required to meet regulatory obligations (automotive IATF, aerospace AS9100, medical ISO 13485). Compliance tracking requires linking qualification status to obligation fu',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: A qualification is scoped to a specific process flow; linking directly avoids cross‑domain indirection.',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Process qualification programs are scoped to a specific product technology node (e.g., 5nm, 7nm). AEC-Q100/JEDEC qualification reports and customer data packages require linking the process qual to th',
    `qualification_flow_id` BIGINT COMMENT 'FK to process.process_process_flow.process_process_flow_id — Process qualifications are conducted against specific process flows or steps. The flow reference establishes what is being qualified.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Process qualifications include supplier-specific material qualifications (e.g., qualifying 5nm EUV process with Supplier As photoresist). Required for customer approval documentation, supply chain ri',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Process qualifications often chamber-specific (chamber matching studies). Production release, recipe transfer, and capacity planning require chamber-level qualification status in semiconductor fabs.',
    `quality_qualification_program_id` BIGINT COMMENT 'Foreign key linking to quality.quality_qualification_program. Business justification: Process qualifications in semiconductor fabs are governed by quality qualification programs (JEDEC, AEC-Q100, customer-specific). The process_qualification record must reference the quality program de',
    `acceptance_criteria_summary` STRING COMMENT 'High-level summary of the key acceptance criteria that must be met for qualification to pass (e.g., yield > 95%, Cpk > 1.33, defect density < 0.1/cm²).',
    `actual_completion_date` DATE COMMENT 'Actual date when the qualification program was completed. Populated when status transitions to passed, failed, waived, or cancelled.',
    `actual_cpk` DECIMAL(18,2) COMMENT 'Actual process capability index (Cpk) achieved during qualification testing. Populated upon completion of qualification runs.',
    `actual_yield_percent` DECIMAL(18,2) COMMENT 'Actual wafer yield percentage achieved during qualification testing. Populated upon completion of qualification runs.',
    `corrective_action_plan` STRING COMMENT 'Description of corrective actions planned or taken to address issues identified during qualification. Applicable for failed qualifications or qualifications requiring follow-up.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_approval_status` STRING COMMENT 'Status of customer approval for this qualification: not_required (no customer approval needed), pending (awaiting customer review), approved (customer approved), rejected (customer rejected).. Valid values are `not_required|pending|approved|rejected`',
    `disposition` STRING COMMENT 'Final disposition or outcome of the qualification program. Detailed explanation of pass/fail decision, waiver justification, or cancellation reason.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility where the qualification is being conducted. Format: 3 letters + 2 digits (e.g., FAB01, SJC02).. Valid values are `^[A-Z]{3}[0-9]{2}$`',
    `failure_mode_summary` STRING COMMENT 'Summary of failure modes observed during qualification testing, if applicable. Used for failed or waived qualifications to document issues encountered.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last modified or updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `lot_count` STRING COMMENT 'Total number of fabrication lots planned or executed for the qualification program.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the qualification program. Free-text field for supplementary information.',
    `owner_engineer_name` STRING COMMENT 'Name of the process engineer responsible for managing and executing the qualification program.',
    `owner_organization` STRING COMMENT 'Organizational unit or department responsible for the qualification program (e.g., Process Engineering, Integration, Module Development).',
    `plan_reference` STRING COMMENT 'Document reference or identifier for the formal qualification plan that defines acceptance criteria, test methodology, and success metrics. May reference PLM document number or file path.',
    `plm_system_source` STRING COMMENT 'Source PLM system from which this qualification record was extracted: oracle_agile (Oracle Agile PLM), siemens_teamcenter (Siemens Teamcenter PLM), other.. Valid values are `oracle_agile|siemens_teamcenter|other`',
    `plm_workflow_reference` STRING COMMENT 'Workflow or change order identifier in the source PLM system that tracks the qualification approval process.',
    `qualification_name` STRING COMMENT 'Descriptive name of the qualification program, identifying the process or change being qualified.',
    `qualification_number` STRING COMMENT 'Business identifier for the qualification program, typically assigned by PLM system. Format: PQ-XXXXXX.. Valid values are `^PQ-[A-Z0-9]{6,12}$`',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification program: planned (not yet started), in_progress (active qualification), on_hold (temporarily suspended), passed (met all acceptance criteria), failed (did not meet criteria), waived (approved without full completion), cancelled (terminated). [ENUM-REF-CANDIDATE: planned|in_progress|on_hold|passed|failed|waived|cancelled — 7 candidates stripped; promote to reference product]',
    `qualification_type` STRING COMMENT 'Category of qualification program: new_process (entirely new process flow), process_change (modification to existing process), tool_qualification (new equipment or chamber), node_readiness (technology node transition), recipe_qualification (new process recipe), material_qualification (new consumable or chemical).. Valid values are `new_process|process_change|tool_qualification|node_readiness|recipe_qualification|material_qualification`',
    `requires_customer_approval` BOOLEAN COMMENT 'Flag indicating whether this qualification requires formal customer approval before production deployment. True for customer-specific processes or foundry qualifications.',
    `risk_assessment` STRING COMMENT 'Risk level associated with deploying the qualified process to production: low (minimal risk), medium (moderate risk with mitigation), high (significant risk requiring close monitoring), critical (severe risk requiring executive approval).. Valid values are `low|medium|high|critical`',
    `sign_off_date` DATE COMMENT 'Date when the qualification results were formally signed off and approved.',
    `sign_off_engineer_name` STRING COMMENT 'Name of the process engineer or technical authority who signed off on the qualification results.',
    `start_date` DATE COMMENT 'Date when the qualification program officially started or is planned to start.',
    `target_completion_date` DATE COMMENT 'Planned or target date for completion of the qualification program.',
    `target_cpk` DECIMAL(18,2) COMMENT 'Target process capability index (Cpk) that must be achieved for qualification to pass. Typical semiconductor requirement is Cpk >= 1.33.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Target wafer yield percentage that must be achieved for qualification to pass.',
    `wafer_count` STRING COMMENT 'Total number of wafers planned or executed for the qualification program.',
    CONSTRAINT pk_qualification PRIMARY KEY(`qualification_id`)
) COMMENT 'Process qualification program record tracking the formal qualification of a new process flow, process step, or process change against defined acceptance criteria. Captures qualification type (new process, process change, tool qualification, node readiness), qualification plan reference, start date, target completion date, actual completion date, qualification status (in-progress, passed, failed, waived), sign-off engineer, and disposition. Sourced from Oracle Agile PLM and Siemens Teamcenter PLM qualification workflows.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`change_notification` (
    `change_notification_id` BIGINT COMMENT 'Primary key for change_notification',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: PCNs track affected equipment for change impact analysis, customer notification, and requalification planning. Critical for semiconductor change control and regulatory compliance (automotive, aerospac',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: PCNs frequently originate from or impact suppliers (e.g., supplier changes chemical formulation requiring process requalification). Mandatory for supply chain change control, customer notification req',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PCN implementation costs (requalification, customer notification, inventory write-offs) must be allocated to responsible cost centers for change management accounting and cost impact analysis required',
    `customer_contract_id` BIGINT COMMENT 'Foreign key linking to sales.customer_contract. Business justification: Process Change Notifications (PCNs) must be issued per customer contract obligations under JEDEC/AEC-Q standards. The change_notification has affected_customer_list as plain text but needs a FK to cus',
    `fabrication_technology_node_id` BIGINT COMMENT 'Identifier of the technology node impacted by this change, such as 7nm, 5nm, or 3nm process technology.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Change notifications affect particular IC products; essential for the Product Change Impact Assessment.',
    `flow_id` BIGINT COMMENT 'Foreign key linking to process.process_process_flow. Business justification: Change notifications affect a specific process flow; an internal FK provides direct reference within the process domain.',
    `process_flow_id` BIGINT COMMENT 'Identifier of the primary process flow impacted by this change notification.',
    `actual_implementation_date` DATE COMMENT 'Actual date when the process change was implemented in production manufacturing.',
    `affected_customer_list` STRING COMMENT 'List of customer names or identifiers who have products affected by this change and require notification per contractual agreements.',
    `affected_equipment_list` STRING COMMENT 'List of manufacturing equipment tools or tool sets impacted by this process change, including tool IDs or model numbers.',
    `affected_material_list` STRING COMMENT 'List of raw materials, chemicals, gases, or consumables that are being changed or affected by this process modification.',
    `affected_product_list` STRING COMMENT 'Comma-separated list or description of product families, part numbers, or device types impacted by this process change.',
    `approval_date` DATE COMMENT 'Date when the process change notification received final internal approval to proceed.',
    `approval_status` STRING COMMENT 'Internal approval status from engineering, quality, and management stakeholders for proceeding with the process change.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who provided final approval for the process change notification.',
    `attachments` STRING COMMENT 'References to supporting documentation such as technical specifications, test reports, FMEA analyses, customer communications, or qualification data associated with this PCN.',
    `change_classification` STRING COMMENT 'Impact classification of the change: major (requires customer approval and qualification), minor (notification required but no requalification), or notification_only (informational, no customer action required).. Valid values are `major|minor|notification_only`',
    `change_description` STRING COMMENT 'Detailed description of the process change including what is being changed, why the change is necessary, and the technical details of the modification.',
    `change_reason` STRING COMMENT 'Business or technical justification for the change, such as yield improvement, cost reduction, obsolescence mitigation, reliability enhancement, or regulatory compliance.',
    `change_status` STRING COMMENT 'Current lifecycle status of the process change notification in the approval and implementation workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|customer_notified|implemented|cancelled|rejected — 7 candidates stripped; promote to reference product]',
    `change_title` STRING COMMENT 'Brief descriptive title summarizing the nature of the process change.',
    `change_type` STRING COMMENT 'Category of change being notified: process (recipe or flow modification), material (raw material or chemical change), equipment (tool or configuration change), design (mask or layout change), facility (fab site or cleanroom change), or supplier (vendor or subcontractor change).. Valid values are `process|material|equipment|design|facility|supplier`',
    `cost_impact` STRING COMMENT 'Assessment of the financial impact of the process change including implementation costs, ongoing cost savings or increases, and return on investment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the process change notification record was first created in the system.',
    `customer_approval_required` BOOLEAN COMMENT 'Indicates whether explicit customer approval is required before implementing the change, typically for major changes affecting form, fit, function, or reliability.',
    `customer_notification_required` BOOLEAN COMMENT 'Indicates whether customer notification is required per contractual agreements, regulatory requirements, or change impact assessment.',
    `cycle_time_impact_hours` DECIMAL(18,2) COMMENT 'Expected change in manufacturing cycle time resulting from the process change, measured in hours (positive for increase, negative for reduction).',
    `environmental_impact` STRING COMMENT 'Description of any environmental, health, or safety impacts resulting from the process change, including changes to hazardous material usage or waste generation.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility or site where the process change will be implemented.. Valid values are `^[A-Z0-9]{2,6}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the process change notification record was last updated or modified.',
    `last_time_buy_date` DATE COMMENT 'Final date for customers to place orders for products manufactured using the old process before the change is implemented.',
    `last_time_ship_date` DATE COMMENT 'Final date for shipping products manufactured using the old process before transitioning to the new process.',
    `notes` STRING COMMENT 'Additional comments, observations, or context related to the process change notification.',
    `notification_date` DATE COMMENT 'Date when affected customers were formally notified of the pending process change.',
    `owner_engineer_name` STRING COMMENT 'Name of the process engineer or technical owner responsible for managing this change notification through implementation.',
    `owner_organization` STRING COMMENT 'Department or organizational unit responsible for the process change, such as Process Engineering, Equipment Engineering, or Quality Assurance.',
    `pcn_number` STRING COMMENT 'Business identifier for the process change notification, typically formatted as PCN-NNNNNN. Used for external communication and tracking.. Valid values are `^PCN-[0-9]{6,10}$`',
    `planned_implementation_date` DATE COMMENT 'Target date for implementing the process change in production manufacturing.',
    `qualification_completion_date` DATE COMMENT 'Date when all qualification and validation activities for the process change were successfully completed.',
    `qualification_status` STRING COMMENT 'Status of the qualification and validation activities required to verify that the process change does not adversely affect product quality or reliability.. Valid values are `not_started|in_progress|completed|failed|waived`',
    `regulatory_impact` STRING COMMENT 'Assessment of whether the process change affects compliance with regulatory requirements such as RoHS, REACH, ITAR, EAR, or automotive quality standards (IATF 16949).',
    `risk_assessment` STRING COMMENT 'Evaluation of potential risks associated with the change including impact on product performance, reliability, quality, and manufacturability. May reference Failure Mode and Effects Analysis (FMEA) results.',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to this change based on potential impact to product quality, reliability, and customer operations.. Valid values are `low|medium|high|critical`',
    `yield_impact_percent` DECIMAL(18,2) COMMENT 'Expected or measured change in manufacturing yield resulting from the process change, expressed as a percentage point change (positive for improvement, negative for degradation).',
    CONSTRAINT pk_change_notification PRIMARY KEY(`change_notification_id`)
) COMMENT 'Process Change Notification (PCN) record documenting a planned or executed change to a qualified process flow, recipe, material, or equipment configuration that may affect product performance or reliability. Captures PCN number, change type (process, material, equipment, design), affected products, change description, risk assessment, customer notification requirements, implementation date, and approval status. Managed through Oracle Agile PLM and SAP QM change management workflows.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`yield_loss_event` (
    `yield_loss_event_id` BIGINT COMMENT 'Unique identifier for the yield loss event record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer for whom the affected wafer lot is being fabricated. Used for customer-specific yield reporting and quality metrics.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: Yield loss events directly impact committed customer bookings — delivery risk assessment and customer notification require linking yield excursions to affected bookings. Semiconductor operations teams',
    `capa_record_id` BIGINT COMMENT 'Reference to the corrective action or OCAP (Out of Control Action Plan) initiated in response to this yield loss event. Links to corrective action tracking system.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Yield loss events are charged to the responsible cost center to quantify financial impact in loss‑analysis reports.',
    `excursion_id` BIGINT COMMENT 'Foreign key linking to process.excursion. Business justification: A yield loss event is often associated with a process excursion — the excursion is the out-of-control event, and the yield loss event captures the yield impact. Linking yield_loss_event to excursion e',
    `fab_tool_id` BIGINT COMMENT 'Reference to the fabrication equipment or tool associated with the process step where the yield loss occurred. Used for equipment-specific yield trending and FMEA.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (process generation) for the affected wafer lot. Used for node-specific yield trending and benchmarking.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot in which the yield loss event was detected. Links to fabrication wafer lot master data.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Yield loss events are reported and tracked at the IC product level for customer impact assessment and product-level yield dashboards. yield_loss_event has sku_id→sku but IC-level yield loss reporting ',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: A yield loss event occurs during the execution of a wafer lot through a process step, which is precisely what lot_process_run records. Linking yield_loss_event to lot_process_run provides direct trace',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Yield loss often triggers corrective maintenance investigation. 8D problem solving, CAPA closure, and maintenance effectiveness tracking require linking yield loss to corrective maintenance events.',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: Yield loss events trigger nonconformance reports in semiconductor quality systems. While yield_loss_event already links to capa_record, the direct link to NCR is distinct — NCRs capture the formal qua',
    `process_step_id` BIGINT COMMENT 'Reference to the specific process step at which the yield loss was identified. Links to process step master data.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Yield losses directly impact profit center P&L through scrap costs and lost revenue. Required for financial impact reporting of yield excursions and profit center variance analysis in semiconductor op',
    `recipe_id` BIGINT COMMENT 'Reference to the process recipe or run card that was active when the yield loss event occurred. Used for recipe-specific yield correlation and optimization.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Yield loss root cause often traces to supplier material issues (e.g., contaminated chemical batch, out-of-spec wafer substrate). Essential for triggering supplier corrective action requests (SCAR), co',
    `sku_id` BIGINT COMMENT 'Reference to the IC design product or device family being fabricated on the affected wafer lot. Used for product-specific yield analysis and customer impact assessment.',
    `spc_control_chart_id` BIGINT COMMENT 'Foreign key linking to process.spc_control_chart. Business justification: yield_loss_event has spc_rule_violation: STRING which is a denormalized reference to an SPC violation. Adding spc_control_chart_id as a proper FK links the yield loss event to the specific SPC control',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: A yield loss event is identified at a specific process step or inspection point (per the product description). Without a direct FK to process_step, the yield loss event cannot be directly associated w',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Yield loss often isolated to specific chamber. Disposition decisions, 8D problem solving, and corrective action (chamber PM, requalification) require chamber-level attribution in semiconductor fabs.',
    `affected_die_count` STRING COMMENT 'Number of individual die on the wafer affected by this yield loss event. Used to calculate yield impact and prioritize corrective actions.',
    `assigned_to` STRING COMMENT 'Name or identifier of the engineer or team assigned to investigate and resolve the yield loss event. Used for workload management and escalation.',
    `cpk_value` DECIMAL(18,2) COMMENT 'Process capability index (Cpk) calculated at the time of the yield loss event. Indicates how well the process is centered and controlled relative to specification limits. Values below 1.33 typically indicate process capability issues.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this yield loss event record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `defect_density_per_cm2` DECIMAL(18,2) COMMENT 'Measured defect density for this yield loss event, expressed as defects per square centimeter of wafer area. Used for SPC trending and yield modeling.',
    `defect_size_nm` DECIMAL(18,2) COMMENT 'Measured or estimated size of the defect in nanometers. Critical for determining defect criticality and kill ratio at advanced technology nodes.',
    `defect_type` STRING COMMENT 'Specific defect type or signature identified during inspection or test. Examples include scratch, particle, void, short, open, bridging, residue, etc. May reference defect classification taxonomy.',
    `detection_method` STRING COMMENT 'Method or technique used to detect the yield loss event. Indicates whether detected via inline inspection, offline inspection, electrical test, parametric test, visual inspection, or metrology measurement.. Valid values are `inline_inspection|offline_inspection|electrical_test|parametric_test|visual_inspection|metrology`',
    `disposition_action` STRING COMMENT 'Disposition decision for the affected wafer lot following yield loss event investigation. Continue indicates lot proceeds to next step; rework indicates reprocessing required; scrap indicates lot rejected; quarantine indicates lot held pending further analysis; use as is indicates lot accepted with deviation; return to vendor indicates supplier material issue.. Valid values are `continue|rework|scrap|quarantine|use_as_is|return_to_vendor`',
    `estimated_yield_impact_percent` DECIMAL(18,2) COMMENT 'Estimated percentage point impact on wafer yield attributable to this event. Calculated from affected die count and total die per wafer. Used for yield loss Pareto analysis.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the yield loss event was detected or recorded. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility where the yield loss event occurred. Used for multi-site yield benchmarking and site-specific trending.',
    `investigation_start_timestamp` TIMESTAMP COMMENT 'Date and time when root cause investigation of the yield loss event was initiated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this yield loss event record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `layer_name` STRING COMMENT 'Name of the process layer or mask level at which the yield loss event occurred. Examples include M1, M2, POLY, CONTACT, VIA1, etc. Aligns with GDS layer naming convention.',
    `lot_hold_applied` BOOLEAN COMMENT 'Indicates whether a lot hold was placed on the affected wafer lot as a result of this yield loss event. True if hold applied; false if no hold applied.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, observations, or context related to the yield loss event. May include investigation findings, lessons learned, or special handling instructions.',
    `reported_by` STRING COMMENT 'Name or identifier of the engineer, operator, or automated system that reported or logged the yield loss event. Used for accountability and follow-up.',
    `resolution_status` STRING COMMENT 'Current status of the yield loss event resolution workflow. Open indicates newly detected; under investigation indicates active RCA; root cause identified indicates RCA complete; corrective action implemented indicates fix deployed; closed indicates event resolved; deferred indicates event accepted or postponed.. Valid values are `open|under_investigation|root_cause_identified|corrective_action_implemented|closed|deferred`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the yield loss event was resolved and closed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used to calculate mean time to resolution (MTTR) for yield events.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause of the yield loss event. Equipment indicates tool-related issues; material indicates incoming material defects; process indicates recipe or parameter issues; human indicates operator error; environmental indicates cleanroom or facility issues; design indicates layout or design rule issues.. Valid values are `equipment|material|process|human|environmental|design`',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the identified or suspected root cause of the yield loss event. Populated during root cause analysis and investigation.',
    `severity_level` STRING COMMENT 'Business severity classification of the yield loss event based on yield impact, affected volume, and customer impact. Critical indicates immediate action required; major indicates significant yield impact; minor indicates localized impact; negligible indicates minimal business impact.. Valid values are `critical|major|minor|negligible`',
    `wafer_position_x_mm` DECIMAL(18,2) COMMENT 'X-coordinate position on the wafer where the yield loss event was detected, in millimeters from wafer center. Used for spatial yield analysis and wafer mapping.',
    `wafer_position_y_mm` DECIMAL(18,2) COMMENT 'Y-coordinate position on the wafer where the yield loss event was detected, in millimeters from wafer center. Used for spatial yield analysis and wafer mapping.',
    `yield_loss_mode` STRING COMMENT 'Classification of the yield loss mechanism. Parametric indicates out-of-spec electrical parameters; systematic indicates repeatable defect patterns; random indicates sporadic defects; electrical indicates functional failures; particle indicates contamination; pattern indicates lithography or etch issues; edge indicates wafer edge exclusion. [ENUM-REF-CANDIDATE: parametric|systematic|random|electrical|particle|pattern|edge — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_yield_loss_event PRIMARY KEY(`yield_loss_event_id`)
) COMMENT 'Transactional record of a yield loss event identified at a specific process step or inspection point for a wafer lot. Captures lot reference, process step, yield loss mode (parametric, systematic, random, electrical), defect density, affected die count, estimated yield impact, root cause category, corrective action reference, and resolution status. Primary input to yield optimization workflows and SPC out-of-control action plans (OCAPs).';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` (
    `defect_inspection_result_id` BIGINT COMMENT 'Unique identifier for the defect inspection result record. Primary key.',
    `defect_record_id` BIGINT COMMENT 'Foreign key linking to quality.defect_record. Business justification: Defect inspection results in the process domain feed into formal defect records in the quality domain. This is a core process→quality data flow in semiconductor fabs — inspection results become qualit',
    `step_id` BIGINT COMMENT 'FK to process.process_process_step.process_process_step_id — Defect inspections occur at specific process steps in the flow. Step reference provides manufacturing context for defect analysis.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the inspection equipment used (e.g., KLA 29xx/39xx series, Applied Materials SEMVision). Tool asset identifier from equipment master.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (process generation) for which this inspection was performed, e.g., 7nm, 5nm, 3nm.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot that was inspected. Links to the fabrication wafer lot being monitored.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Defect inspection results are analyzed per IC product for the Defect Analysis per Product report.',
    `recipe_id` BIGINT COMMENT 'Identifier of the inspection recipe or program used to configure the tool for this inspection run. Defines sensitivity, scan area, and detection parameters.',
    `lot_process_run_id` BIGINT COMMENT 'FK to process.lot_process_run.lot_process_run_id — Defect inspection results are captured during or after a specific lot process run at an inspection step. This FK enables defect-to-process correlation.',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: Defect inspection results exceeding thresholds trigger nonconformance reports in semiconductor quality systems. Quality engineers must link inspection results to NCRs for disposition decisions, custom',
    `primary_defect_step_id` BIGINT COMMENT 'Foreign key linking to process.process_process_step. Business justification: Defect inspection results are tied to a specific process step; adding internal FK enables step‑level analysis.',
    `spc_control_chart_id` BIGINT COMMENT 'Foreign key linking to process.spc_control_chart. Business justification: Defect inspection results are monitored via SPC control charts (defect density, defect count per wafer). The defect_inspection_result table has spc_control_limit_lower and spc_control_limit_upper fiel',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Defect patterns often chamber-specific (particle sources, process drift). SPC monitoring, chamber matching studies, and maintenance prioritization require chamber-level defect attribution in semicondu',
    `wafer_id` BIGINT COMMENT 'Reference to the specific wafer within the lot that was inspected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this defect inspection result record was first created in the system.',
    `crystal_defect_count` STRING COMMENT 'Number of defects classified as crystal originated particles (COPs) or intrinsic silicon defects.',
    `defect_density_per_cm2` DECIMAL(18,2) COMMENT 'Calculated defect density expressed as defects per square centimeter of inspected wafer area. Key metric for process monitoring and Statistical Process Control (SPC).',
    `defect_map_file_format` STRING COMMENT 'Format of the defect map file: KLARF (KLA Results File), CSV, XML, or proprietary vendor format.. Valid values are `KLARF|CSV|XML|proprietary`',
    `defect_map_file_path` STRING COMMENT 'File system path or URI to the defect map file (typically KLARF or proprietary format) containing spatial coordinates and attributes of all detected defects.',
    `defect_size_bin_large_count` STRING COMMENT 'Number of defects in the large size bin (typically > 0.5 µm or tool-specific threshold).',
    `defect_size_bin_medium_count` STRING COMMENT 'Number of defects in the medium size bin (typically 0.1-0.5 µm or tool-specific threshold).',
    `defect_size_bin_small_count` STRING COMMENT 'Number of defects in the small size bin (typically < 0.1 µm or tool-specific threshold).',
    `disposition` STRING COMMENT 'Disposition decision based on inspection results: pass (within spec), fail (exceeds limits), review (requires engineering review), hold (lot placed on hold), or rework (requires reprocessing).. Valid values are `pass|fail|review|hold|rework`',
    `excursion_detected` BOOLEAN COMMENT 'Indicates whether a process excursion was detected based on defect density or count exceeding Statistical Process Control (SPC) limits.',
    `inspected_area_cm2` DECIMAL(18,2) COMMENT 'Total wafer surface area inspected, measured in square centimeters. Used to calculate defect density.',
    `inspection_mode` STRING COMMENT 'Inspection coverage mode: full wafer scan, die sampling, edge exclusion, or hot spot targeted inspection.. Valid values are `full_wafer|die_sampling|edge_exclusion|hot_spot`',
    `inspection_status` STRING COMMENT 'Current status of the inspection run: completed (inspection finished successfully), in_progress (inspection running), failed (tool error), or aborted (inspection cancelled).. Valid values are `completed|in_progress|failed|aborted`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the defect inspection was performed. Primary business event timestamp for this inspection result.',
    `inspection_type` STRING COMMENT 'Type of inspection technology used: brightfield scanner, darkfield scanner, e-beam inspection, optical inspection, or macro inspection.. Valid values are `brightfield|darkfield|e-beam|optical|macro`',
    `killer_defect_count` STRING COMMENT 'Number of defects classified as killer defects (defects large enough or critical enough to cause die failure).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this defect inspection result record was last modified or updated.',
    `layer_name` STRING COMMENT 'Name of the process layer being inspected (e.g., Metal1, Poly, Contact, Via2). Identifies the fabrication layer in the stack.',
    `notes` STRING COMMENT 'Free-text notes or comments about the inspection results, anomalies, or follow-up actions required.',
    `nuisance_defect_count` STRING COMMENT 'Number of defects classified as nuisance (false positives or non-yield-impacting detections filtered by nuisance filter).',
    `nuisance_filter_applied` BOOLEAN COMMENT 'Indicates whether a nuisance filter was applied to remove false positives or non-critical defects from the reported count.',
    `nuisance_filter_version` STRING COMMENT 'Version identifier of the nuisance filter algorithm or rule set applied during this inspection.',
    `particle_defect_count` STRING COMMENT 'Number of defects classified as particles (foreign material on wafer surface).',
    `pattern_defect_count` STRING COMMENT 'Number of defects classified as pattern defects (lithography or etch anomalies in the circuit pattern).',
    `residue_defect_count` STRING COMMENT 'Number of defects classified as residue (chemical or material residue remaining after processing).',
    `review_required` BOOLEAN COMMENT 'Indicates whether engineering review is required based on defect count, type, or pattern analysis.',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the engineering review was completed.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the engineer who reviewed the inspection results, if review was performed.',
    `scratch_defect_count` STRING COMMENT 'Number of defects classified as scratches (linear surface damage).',
    `spc_control_limit_lower` DECIMAL(18,2) COMMENT 'Lower control limit for defect density used in SPC monitoring.',
    `spc_control_limit_upper` DECIMAL(18,2) COMMENT 'Upper control limit for defect density used in SPC monitoring. Excursions above this limit trigger alerts.',
    `total_defect_count` STRING COMMENT 'Total number of defects detected on the wafer during this inspection, including all defect types and sizes.',
    CONSTRAINT pk_defect_inspection_result PRIMARY KEY(`defect_inspection_result_id`)
) COMMENT 'Wafer-level defect inspection result record from in-line inspection tools (KLA brightfield/darkfield scanners, e-beam inspection) captured at process engineering inspection steps for process monitoring and excursion detection. Captures wafer lot reference, inspection step, tool ID, inspection recipe, total defect count, defect density (defects/cm²), defect map file reference, defect classification breakdown by type and size, nuisance filter applied, and disposition. SSOT boundary: process domain owns in-line defect inspection results used for process monitoring, SPC, and excursion detection during manufacturing; quality domain owns outgoing quality inspection, reliability defect analysis, and customer-reported defect records. Sourced from KLA 29xx/39xx series and Applied Materials SEMVision.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`metrology_measurement` (
    `metrology_measurement_id` BIGINT COMMENT 'Unique identifier for the metrology_measurement data product.',
    `fab_tool_id` BIGINT COMMENT 'Identifier of the metrology equipment that performed the measurement (e.g., CD-SEM, ellipsometer, overlay tool).',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node (e.g., 7nm, 5nm, 3nm) for which this measurement was performed.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the wafer lot on which this measurement was performed.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Metrology measurements are linked to the IC product they verify; used in Metrology Compliance reporting.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Metrology measurements in semiconductor fabs are performed within the context of a quality inspection lot. The inspection_lot provides the sampling plan, AQL, and quality context for metrology runs, e',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: In-line metrology measurements are taken during or immediately after a specific lot process run. Linking process_metrology_measurement to lot_process_run provides direct traceability from the measurem',
    `process_step_id` BIGINT COMMENT 'Reference to the process step at which this metrology measurement was taken.',
    `recipe_id` BIGINT COMMENT 'Identifier of the metrology recipe or measurement program used for this measurement.',
    `spc_control_chart_id` BIGINT COMMENT 'Foreign key linking to process.spc_control_chart. Business justification: In-line metrology measurements feed directly into SPC control charts for process monitoring. Linking process_metrology_measurement to spc_control_chart enables traceability from individual metrology d',
    `step_id` BIGINT COMMENT 'FK to process.process_process_step.process_process_step_id — Metrology measurements are taken at specific process steps. Step context is essential for measurement interpretation and SPC feeding.',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Metrology measurements (CD, thickness, overlay) often chamber-specific. Process control, chamber matching, and qualification decisions require chamber-level measurement data in semiconductor fabs.',
    `wafer_id` BIGINT COMMENT 'Reference to the specific wafer within the lot that was measured.',
    `cp_value` DECIMAL(18,2) COMMENT 'Process capability index (Cp) calculated from this measurement, indicating the potential capability of the process without considering centering.',
    `cpk_value` DECIMAL(18,2) COMMENT 'Process capability index (Cpk) calculated from this measurement, indicating how well the process is centered and controlled within specification limits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this measurement record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Flag indicating the quality and reliability of the measurement data. Good indicates reliable data, Suspect indicates questionable data, Bad indicates invalid data, Uncalibrated indicates tool calibration issue.. Valid values are `Good|Suspect|Bad|Uncalibrated`',
    `disposition` STRING COMMENT 'Pass/fail disposition of the measurement against specification limits. Pass indicates within spec, Fail indicates out of spec, Marginal indicates near limits, Rework indicates corrective action required, Hold indicates pending review.. Valid values are `Pass|Fail|Marginal|Rework|Hold`',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility where the measurement was performed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this measurement record was last updated or modified.',
    `layer_name` STRING COMMENT 'Name of the process layer or mask level at which this measurement was taken (e.g., M1, POLY, CONTACT).',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Lower control limit for Statistical Process Control (SPC) monitoring. Values below this trigger investigation.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Lower specification limit for this measurement parameter. Values below this threshold fail specification.',
    `max_value` DECIMAL(18,2) COMMENT 'Maximum measured value across all sites on the wafer.',
    `mean_value` DECIMAL(18,2) COMMENT 'Arithmetic mean of all site measurements for this parameter.',
    `measurement_mode` STRING COMMENT 'Mode in which the measurement was performed. Inline indicates production flow measurement, Offline indicates lab measurement, Engineering indicates development measurement, Qualification indicates process qualification.. Valid values are `Inline|Offline|Engineering|Qualification`',
    `measurement_parameter` STRING COMMENT 'Specific physical parameter being measured (e.g., critical dimension, overlay X/Y, film thickness, resistivity, reflectivity).',
    `measurement_status` STRING COMMENT 'Status of the measurement execution. Completed indicates successful measurement, In Progress indicates measurement underway, Failed indicates measurement error, Aborted indicates user-terminated, Pending indicates queued.. Valid values are `Completed|In Progress|Failed|Aborted|Pending`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the metrology measurement was performed.',
    `measurement_type` STRING COMMENT 'Type of metrology measurement performed: CD-SEM (Critical Dimension Scanning Electron Microscopy), OCD (Optical Critical Dimension), XRF (X-Ray Fluorescence), Ellipsometry, Overlay, or Film Thickness.. Valid values are `CD-SEM|OCD|XRF|Ellipsometry|Overlay|Film Thickness`',
    `median_value` DECIMAL(18,2) COMMENT 'Median value of all site measurements for this parameter.',
    `min_value` DECIMAL(18,2) COMMENT 'Minimum measured value across all sites on the wafer.',
    `notes` STRING COMMENT 'Free-text notes or comments about the measurement, including any anomalies, special conditions, or operator observations.',
    `range_value` DECIMAL(18,2) COMMENT 'Difference between maximum and minimum site measurements (max - min).',
    `site_count` STRING COMMENT 'Total number of measurement sites sampled on the wafer.',
    `spc_rule_violation` STRING COMMENT 'Description of any SPC rule violations detected (e.g., Western Electric rules, Nelson rules) such as trend, shift, or out-of-control conditions.',
    `std_deviation` DECIMAL(18,2) COMMENT 'Standard deviation (1-sigma) of the site measurements, indicating within-wafer uniformity.',
    `target_value` DECIMAL(18,2) COMMENT 'Target or nominal value for this measurement parameter as defined by the process specification.',
    `three_sigma` DECIMAL(18,2) COMMENT 'Three times the standard deviation, representing the process variation range.',
    `uniformity_percent` DECIMAL(18,2) COMMENT 'Within-wafer uniformity expressed as a percentage, calculated as (range / mean) * 100 or (3-sigma / mean) * 100 depending on convention.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the measurement values (e.g., nm, angstrom, ohm-cm, percent).',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Upper control limit for Statistical Process Control (SPC) monitoring. Values above this trigger investigation.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Upper specification limit for this measurement parameter. Values above this threshold fail specification.',
    `wafer_slot_number` STRING COMMENT 'Position of the wafer within the lot carrier or cassette.',
    CONSTRAINT pk_metrology_measurement PRIMARY KEY(`metrology_measurement_id`)
) COMMENT 'In-line metrology measurement record capturing critical dimension (CD), overlay, film thickness, resistivity, or other physical parameter measurements taken on a wafer at a specific process step. Captures measurement type (CD-SEM, OCD, XRF, ellipsometry, overlay), tool ID, wafer lot reference, wafer number, measurement site map, per-site values, mean, 3-sigma, range, and pass/fail disposition against spec limits. Sourced from KLA ICOS and in-line metrology tools.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`process_technology_node` (
    `process_technology_node_id` BIGINT COMMENT 'Unique identifier for the semiconductor technology node record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Technology node development costs (R&D, process integration, PDK development) are tracked to specific cost centers for R&D capitalization decisions and technology roadmap financial planning in semicon',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Process nodes (7nm, 5nm, 3nm) are controlled technologies requiring ECCN classification under EAR. Technology licensing, fab equipment exports, and foundry partnerships require node-level ECCN for com',
    `process_node_id` BIGINT COMMENT 'Foreign key linking to product.process_node. Business justification: Technology Node Mapping aligns process nodes with product process nodes for the Technology Node Compatibility Matrix.',
    `application_scope` STRING COMMENT 'Primary application domains or product families this technology node is designed to support (e.g., High Performance Computing, Mobile, Automotive, IoT, AI/ML Accelerators).',
    `baseline_cpk` DECIMAL(18,2) COMMENT 'Baseline process capability index (Cpk) target for critical parameters in this technology node. Cpk measures process capability relative to specification limits.',
    `baseline_yield_target_percent` DECIMAL(18,2) COMMENT 'Target baseline yield percentage (good dies per wafer) for production qualification of this technology node.',
    `beol_layer_count` STRING COMMENT 'Number of process layers in the Back End of Line, covering metal interconnect formation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology node record was first created in the system.',
    `design_rule_complexity` STRING COMMENT 'Complexity level of design rules for this technology node. Higher complexity indicates more restrictive DFM (Design for Manufacturability) constraints and OPC (Optical Proximity Correction) requirements.. Valid values are `low|medium|high|very_high`',
    `device_architecture` STRING COMMENT 'Transistor architecture type used in this technology node. Planar for traditional flat transistors, FinFET (Fin Field-Effect Transistor) for 3D fin structures, GAA (Gate All Around) for next-generation wrap-around gates, nanowire or nanosheet for advanced GAA variants.. Valid values are `planar|finfet|gaa|nanowire|nanosheet`',
    `dram_half_pitch_nm` DECIMAL(18,2) COMMENT 'DRAM half-pitch in nanometers, a key metric for memory density and technology node classification per ITRS standards.',
    `effective_end_date` DATE COMMENT 'Date when this technology node is scheduled to be retired or phased out. Null for active nodes with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this technology node became effective and available for use in production or design activities.',
    `euv_layer_count` STRING COMMENT 'Number of critical layers that use EUV lithography in this technology node. Zero for nodes that do not use EUV.',
    `fab_site_code` STRING COMMENT 'Code identifying the fabrication facility (fab) where this technology node is implemented. Multiple fabs may support the same node.',
    `feol_layer_count` STRING COMMENT 'Number of process layers in the Front End of Line, covering transistor formation steps.',
    `gate_pitch_nm` DECIMAL(18,2) COMMENT 'Gate pitch in nanometers, representing the distance between adjacent transistor gates in the Front End of Line (FEOL). Key dimension for transistor density.',
    `introduction_year` STRING COMMENT 'Calendar year when this technology node was first introduced or qualified for production.',
    `is_baseline_node` BOOLEAN COMMENT 'Indicates whether this is the baseline or reference technology node for a given generation. Used for comparison and benchmarking purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this technology node record was last modified or updated.',
    `lithography_type` STRING COMMENT 'Primary lithography technology used for this node. DUV (Deep Ultraviolet), EUV (Extreme Ultraviolet Lithography), immersion lithography, dry lithography, or e-beam (electron beam) lithography.. Valid values are `duv|euv|immersion|dry|ebeam`',
    `metal_layer_count` STRING COMMENT 'Total number of metal interconnect layers in the Back End of Line (BEOL) stack for this technology node.',
    `minimum_metal_pitch_nm` DECIMAL(18,2) COMMENT 'Minimum metal interconnect pitch in nanometers, representing the smallest distance between adjacent metal lines in the Back End of Line (BEOL).',
    `node_code` STRING COMMENT 'Standardized alphanumeric code for the technology node used across systems and documentation.',
    `node_generation` STRING COMMENT 'Generation classification of the technology node (e.g., Gen 1, Gen 2, Gen 3, Advanced Node, Mature Node, Legacy Node).',
    `node_name` STRING COMMENT 'Human-readable name of the technology node (e.g., 5nm, 3nm, 7nm, 28nm, 65nm, 90nm). This is the primary business identifier for the process generation.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations related to this technology node.',
    `owner_engineer_name` STRING COMMENT 'Name of the process engineer or engineering manager responsible for this technology node definition and maintenance.',
    `owner_organization` STRING COMMENT 'Organization or department responsible for managing and maintaining this technology node (e.g., Process Engineering, Advanced Technology Development).',
    `pdk_version` STRING COMMENT 'Version identifier of the Process Design Kit (PDK) associated with this technology node. PDK contains design rules, device models, and libraries for IC design.',
    `process_technology_node_description` STRING COMMENT 'Detailed textual description of the technology node, including key features, capabilities, and differentiators.',
    `production_readiness_status` STRING COMMENT 'Current production readiness state of the technology node. Research: early R&D phase. Development: active development. Qualification: undergoing process qualification. Pilot: pilot production runs. Production: full production ready. Mature: established high-volume production. EOL (End of Life): being phased out. [ENUM-REF-CANDIDATE: research|development|qualification|pilot|production|mature|eol — 7 candidates stripped; promote to reference product]',
    `qualification_date` DATE COMMENT 'Date when the technology node successfully completed qualification and was approved for production use.',
    `qualification_status` STRING COMMENT 'Current qualification status of the technology node. Tracks progress through formal qualification and approval process.. Valid values are `not_started|in_progress|qualified|production_approved|failed|on_hold`',
    `supports_multi_patterning` BOOLEAN COMMENT 'Indicates whether this technology node requires or supports multi-patterning lithography techniques (e.g., double patterning, triple patterning, quadruple patterning) to achieve target dimensions.',
    `target_performance_improvement_percent` DECIMAL(18,2) COMMENT 'Target percentage improvement in performance (speed/frequency) compared to the previous technology node generation. Part of PPA (Power Performance Area) metrics.',
    `target_power_efficiency_improvement_percent` DECIMAL(18,2) COMMENT 'Target percentage improvement in power efficiency compared to the previous technology node generation. Part of PPA (Power Performance Area) metrics.',
    `target_transistor_density_per_mm2` DECIMAL(18,2) COMMENT 'Target transistor density in millions of transistors per square millimeter for this technology node. Key metric for comparing node scaling and integration capability.',
    `wavelength_nm` DECIMAL(18,2) COMMENT 'Primary lithography wavelength in nanometers (e.g., 193nm for DUV, 13.5nm for EUV). Critical parameter for resolution and patterning capability.',
    CONSTRAINT pk_process_technology_node PRIMARY KEY(`process_technology_node_id`)
) COMMENT 'Reference master for semiconductor technology nodes (process generations) supported by the fab. Captures node name (e.g., 5nm, 3nm, 28nm, 65nm), node generation, device architecture (planar, FinFET, GAA), minimum metal pitch, gate pitch, DRAM half-pitch, introduction year, production readiness status, and associated PDK version. Serves as the top-level classification anchor for process flows, OPC rule sets, and process capability records.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`process`.`excursion` (
    `excursion_id` BIGINT COMMENT 'Primary key for excursion',
    `capa_record_id` BIGINT COMMENT 'Foreign key linking to quality.capa_record. Business justification: Process excursions require formal corrective and preventive action (CAPA). Excursions are a primary trigger for CAPA records in semiconductor quality systems; linking excursion directly to capa_record',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Process excursions trigger investigation, containment, and corrective action costs that must be allocated to responsible cost centers for quality cost tracking and root cause financial impact analysis',
    `defect_inspection_result_id` BIGINT COMMENT 'Foreign key linking to process.defect_inspection_result. Business justification: An excursion can be triggered by a defect inspection result that shows an abnormal defect density or pattern. Linking excursion to defect_inspection_result provides traceability from the excursion inv',
    `fab_tool_id` BIGINT COMMENT 'Reference to the manufacturing equipment where the excursion occurred. Links to equipment master data.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Reference to the technology node of the affected product. Links to technology node master data.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Reference to the primary wafer lot affected by this excursion. Links to the fabrication wafer lot master data.',
    `ic_catalog_id` BIGINT COMMENT 'Foreign key linking to product.ic_catalog. Business justification: Excursions are recorded per IC product to assess impact; required for the Excursion Impact Report.',
    `lot_process_run_id` BIGINT COMMENT 'Foreign key linking to process.lot_process_run. Business justification: An excursion is triggered by an out-of-control condition detected during a specific lot process run. Linking excursion to lot_process_run provides direct traceability to the exact run conditions (equi',
    `nonconformance_report_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance_report. Business justification: Process excursions (out-of-control events) are the primary trigger for nonconformance reports in semiconductor quality systems. Quality engineers must link each excursion to its resulting NCR for IATF',
    `process_step_id` BIGINT COMMENT 'Reference to the specific process step where the excursion was detected. Links to process step master data.',
    `spc_control_chart_id` BIGINT COMMENT 'Foreign key linking to process.spc_control_chart. Business justification: excursion has spc_rule_violated: STRING which is a denormalized reference to an SPC violation. Adding spc_control_chart_id as a proper FK links the excursion to the specific SPC control chart that det',
    `step_id` BIGINT COMMENT 'Foreign key linking to process.process_step. Business justification: An excursion captures a significant out-of-spec or out-of-control event at a specific process step. The product description explicitly states out-of-spec, out-of-control, or yield-impacting events. ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Process excursions frequently caused by supplier material variation (e.g., resist viscosity drift, gas purity deviation). Critical for immediate containment actions, supplier notification per quality ',
    `tool_chamber_id` BIGINT COMMENT 'Foreign key linking to equipment.tool_chamber. Business justification: Process excursions often chamber-specific (plasma drift, contamination buildup). Root cause analysis, chamber qualification, and preventive maintenance decisions require chamber-level traceability for',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Excursions often triggered by maintenance activities (PM, calibration, part replacement). CAPA, root cause analysis, and maintenance procedure improvement require linking excursions to triggering main',
    `spc_measurement_id` BIGINT COMMENT 'Foreign key linking to process.spc_measurement. Business justification: An excursion is triggered by a specific out-of-control SPC measurement point. Linking excursion to the specific spc_measurement that triggered it provides point-level traceability — engineers can navi',
    `affected_die_count` STRING COMMENT 'Estimated total number of die units affected by this excursion. Used for financial impact assessment and customer notification.',
    `affected_lot_count` STRING COMMENT 'Total number of wafer lots affected by this excursion event. Used for impact assessment and containment scope determination.',
    `affected_wafer_count` STRING COMMENT 'Total number of individual wafers affected by this excursion across all lots. Used for yield impact calculation.',
    `containment_action_taken` STRING COMMENT 'Immediate containment actions taken upon excursion detection. Describes steps such as lot hold, equipment quarantine, process parameter adjustment, or rework initiation.',
    `containment_timestamp` TIMESTAMP COMMENT 'Date and time when containment actions were completed. Used to measure response time and containment effectiveness.',
    `corrective_action_reference` STRING COMMENT 'Reference number or identifier for the corrective action plan. Links to the formal corrective and preventive action (CAPA) system or Out-of-Control Action Plan (OCAP) record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this excursion record was first created in the system. Audit trail for record creation.',
    `customer_notification_required` BOOLEAN COMMENT 'Flag indicating whether customer notification is required for this excursion. True if the excursion impacts shipped product or customer-specific quality requirements.',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when customer was notified of the excursion. Used for compliance tracking and customer relationship management.',
    `defect_density_per_cm2` DECIMAL(18,2) COMMENT 'Measured defect density in defects per square centimeter for the affected wafers. Key metric for yield impact assessment.',
    `detection_source` STRING COMMENT 'Source system or method that detected the excursion event. Indicates whether the excursion was identified through Statistical Process Control (SPC), inspection, metrology measurement, electrical test, operator observation, or automated monitoring system.. Valid values are `SPC|inspection|metrology|electrical_test|operator|automated_system`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the excursion was first detected. Represents the business event time of excursion identification.',
    `disposition` STRING COMMENT 'Final disposition decision for the affected material. Determines whether lots are released, reworked, scrapped, returned, or require additional review.. Valid values are `use_as_is|rework|scrap|return_to_vendor|engineering_review|customer_notification`',
    `disposition_timestamp` TIMESTAMP COMMENT 'Date and time when the final disposition decision was made. Marks the completion of the excursion investigation and material release decision.',
    `estimated_financial_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact of the excursion in US dollars. Includes scrap cost, rework cost, yield loss, and potential customer claims.',
    `estimated_yield_impact_percent` DECIMAL(18,2) COMMENT 'Estimated percentage point impact on wafer yield due to this excursion. Calculated based on defect density, affected area, and historical correlation data.',
    `excursion_number` STRING COMMENT 'Business identifier for the excursion event. Human-readable reference number used for tracking and communication across engineering teams.',
    `excursion_type` STRING COMMENT 'Classification of the excursion event. Categorizes whether the excursion is due to out-of-specification parameters, out-of-control process conditions, yield loss, excessive defect density, parametric drift, or equipment fault.. Valid values are `out_of_spec|out_of_control|yield_loss|defect_density|parametric_drift|equipment_fault`',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the excursion investigation. Tracks progression from initial detection through root cause analysis to closure.. Valid values are `open|investigating|root_cause_identified|corrective_action_pending|closed|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this excursion record was last updated. Audit trail for tracking investigation progress and status changes.',
    `lower_control_limit` DECIMAL(18,2) COMMENT 'Lower control limit from the Statistical Process Control (SPC) chart at the time of excursion detection. Used to determine out-of-control conditions.',
    `measured_value` DECIMAL(18,2) COMMENT 'Actual measured value of the parameter that triggered the excursion. Used for root cause analysis and process capability assessment.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the excursion investigation. Captures engineering insights and lessons learned.',
    `owner_organization` STRING COMMENT 'Engineering organization or department responsible for this excursion. Examples include Process Integration, Lithography, Etch, Thin Films, or Metrology.',
    `parameter_name` STRING COMMENT 'Name of the process parameter that triggered the excursion. Examples include critical dimension (CD), film thickness, overlay, resistance, or other measured characteristics.',
    `root_cause_category` STRING COMMENT 'High-level classification of the root cause. Categories include equipment malfunction, material variation, process recipe issue, human error, environmental condition, or unknown pending investigation.. Valid values are `equipment|material|process|human|environmental|unknown`',
    `root_cause_description` STRING COMMENT 'Detailed description of the identified root cause. Captures engineering analysis findings and technical explanation of the excursion mechanism.',
    `severity_level` STRING COMMENT 'Severity classification of the excursion impact. Minor excursions require monitoring, major excursions require corrective action, and critical excursions require immediate containment and investigation.. Valid values are `minor|major|critical`',
    `specification_lower_limit` DECIMAL(18,2) COMMENT 'Lower specification limit for the parameter. Used to determine out-of-specification conditions and product quality impact.',
    `specification_upper_limit` DECIMAL(18,2) COMMENT 'Upper specification limit for the parameter. Used to determine out-of-specification conditions and product quality impact.',
    `target_value` DECIMAL(18,2) COMMENT 'Target specification value for the parameter. Used to calculate deviation magnitude and assess excursion severity.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the parameter values. Examples include nanometers (nm), angstroms, ohms, degrees Celsius, or other engineering units.',
    `upper_control_limit` DECIMAL(18,2) COMMENT 'Upper control limit from the Statistical Process Control (SPC) chart at the time of excursion detection. Used to determine out-of-control conditions.',
    `yield_loss_mode` STRING COMMENT 'Classification of the yield loss mechanism. Parametric indicates parameter drift, systematic indicates repeatable pattern defects, random indicates sporadic defects, electrical indicates functional test failures, none indicates no yield impact detected.. Valid values are `parametric|systematic|random|electrical|none`',
    CONSTRAINT pk_excursion PRIMARY KEY(`excursion_id`)
) COMMENT 'Process excursion record capturing any significant out-of-spec, out-of-control, or yield-impacting condition detected during wafer manufacturing that requires formal engineering investigation. Encompasses all yield loss events as a unified excursion type. Captures excursion detection source (SPC, inspection, metrology, electrical test), affected lot list, process step, excursion severity (minor/major/critical), yield loss mode (parametric, systematic, random, electrical), defect density, affected die count, estimated yield impact, detection timestamp, containment actions taken, root cause category, corrective action reference, investigation status, and final disposition. Serves as the single parent investigation record for all process-related yield and excursion events. Distinct from individual OCAP actions which are the immediate corrective responses. SSOT for process excursion and yield loss tracking; quality domain owns outgoing quality excursions and customer returns.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_opc_rule_set_id` FOREIGN KEY (`opc_rule_set_id`) REFERENCES `semiconductors_ecm`.`process`.`opc_rule_set`(`opc_rule_set_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ADD CONSTRAINT `fk_process_flow_primary_flow_process_technology_node_id` FOREIGN KEY (`primary_flow_process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`step` ADD CONSTRAINT `fk_process_step_opc_rule_set_id` FOREIGN KEY (`opc_rule_set_id`) REFERENCES `semiconductors_ecm`.`process`.`opc_rule_set`(`opc_rule_set_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`step` ADD CONSTRAINT `fk_process_step_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`step` ADD CONSTRAINT `fk_process_step_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`step` ADD CONSTRAINT `fk_process_step_step_flow_id` FOREIGN KEY (`step_flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ADD CONSTRAINT `fk_process_lot_process_run_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ADD CONSTRAINT `fk_process_spc_control_chart_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `semiconductors_ecm`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ADD CONSTRAINT `fk_process_spc_measurement_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `semiconductors_ecm`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ADD CONSTRAINT `fk_process_capability_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ADD CONSTRAINT `fk_process_opc_rule_set_process_technology_node_id` FOREIGN KEY (`process_technology_node_id`) REFERENCES `semiconductors_ecm`.`process`.`process_technology_node`(`process_technology_node_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ADD CONSTRAINT `fk_process_qualification_qualification_flow_id` FOREIGN KEY (`qualification_flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ADD CONSTRAINT `fk_process_change_notification_flow_id` FOREIGN KEY (`flow_id`) REFERENCES `semiconductors_ecm`.`process`.`flow`(`flow_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_excursion_id` FOREIGN KEY (`excursion_id`) REFERENCES `semiconductors_ecm`.`process`.`excursion`(`excursion_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `semiconductors_ecm`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ADD CONSTRAINT `fk_process_yield_loss_event_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_primary_defect_step_id` FOREIGN KEY (`primary_defect_step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ADD CONSTRAINT `fk_process_defect_inspection_result_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `semiconductors_ecm`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_recipe_id` FOREIGN KEY (`recipe_id`) REFERENCES `semiconductors_ecm`.`process`.`recipe`(`recipe_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `semiconductors_ecm`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ADD CONSTRAINT `fk_process_metrology_measurement_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_defect_inspection_result_id` FOREIGN KEY (`defect_inspection_result_id`) REFERENCES `semiconductors_ecm`.`process`.`defect_inspection_result`(`defect_inspection_result_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_lot_process_run_id` FOREIGN KEY (`lot_process_run_id`) REFERENCES `semiconductors_ecm`.`process`.`lot_process_run`(`lot_process_run_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_spc_control_chart_id` FOREIGN KEY (`spc_control_chart_id`) REFERENCES `semiconductors_ecm`.`process`.`spc_control_chart`(`spc_control_chart_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_step_id` FOREIGN KEY (`step_id`) REFERENCES `semiconductors_ecm`.`process`.`step`(`step_id`);
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ADD CONSTRAINT `fk_process_excursion_spc_measurement_id` FOREIGN KEY (`spc_measurement_id`) REFERENCES `semiconductors_ecm`.`process`.`spc_measurement`(`spc_measurement_id`);

-- ========= TAGS =========
ALTER SCHEMA `semiconductors_ecm`.`process` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `semiconductors_ecm`.`process` SET TAGS ('dbx_domain' = 'process');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` SET TAGS ('dbx_subdomain' = 'recipe_engineering');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow ID');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Default Material Storage Location Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `opc_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Opc Rule Set Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `pdk_id` SET TAGS ('dbx_business_glossary_term' = 'Process Design Kit (PDK) ID');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `primary_flow_process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `baseline_cpk` SET TAGS ('dbx_business_glossary_term' = 'Baseline Process Capability Index (Cpk)');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `beol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Back End of Line (BEOL) Step Count');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `critical_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Layer Count');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `cycle_time_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time (Days)');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `dfm_rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Design for Manufacturability (DFM) Rule Set Version');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `euv_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Extreme Ultraviolet (EUV) Layer Count');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `feol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Front End of Line (FEOL) Step Count');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `flow_code` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Code');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `flow_name` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Name');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `flow_type` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Type');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `is_baseline_flow` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Flow');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `lithography_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Lithography Layer Count');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `mol_step_count` SET TAGS ('dbx_business_glossary_term' = 'Middle of Line (MOL) Step Count');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Notes');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `process_flow_description` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Description');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'development|qualification|qualified|production|deprecated|obsolete');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `revision` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Revision');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `supports_multi_patterning` SET TAGS ('dbx_business_glossary_term' = 'Supports Multi-Patterning');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `semiconductors_ecm`.`process`.`flow` ALTER COLUMN `total_step_count` SET TAGS ('dbx_business_glossary_term' = 'Total Step Count');
ALTER TABLE `semiconductors_ecm`.`process`.`step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`process`.`step` SET TAGS ('dbx_subdomain' = 'recipe_engineering');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Material Storage Location Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `opc_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `cycle_time_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Target (Minutes)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `dose_target` SET TAGS ('dbx_business_glossary_term' = 'Dose Target');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `energy_target_kev` SET TAGS ('dbx_business_glossary_term' = 'Energy Target (keV)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `gas_flow_rate_sccm` SET TAGS ('dbx_business_glossary_term' = 'Gas Flow Rate (SCCM)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `is_critical_step` SET TAGS ('dbx_business_glossary_term' = 'Critical Step Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `is_rework_allowed` SET TAGS ('dbx_business_glossary_term' = 'Rework Allowed Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `meef_value` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Value');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `power_setpoint_watts` SET TAGS ('dbx_business_glossary_term' = 'Power Setpoint (Watts)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `pressure_setpoint_torr` SET TAGS ('dbx_business_glossary_term' = 'Pressure Setpoint (Torr)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `process_category` SET TAGS ('dbx_business_glossary_term' = 'Process Category (FEOL/MOL/BEOL)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `process_category` SET TAGS ('dbx_value_regex' = 'feol|mol|beol');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `process_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Process Time (Seconds)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|qualified|failed|waived');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Sequence Order');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `step_description` SET TAGS ('dbx_business_glossary_term' = 'Step Description');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `step_name` SET TAGS ('dbx_business_glossary_term' = 'Step Name');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `step_number` SET TAGS ('dbx_business_glossary_term' = 'Step Number');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `step_status` SET TAGS ('dbx_business_glossary_term' = 'Step Status');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `step_status` SET TAGS ('dbx_value_regex' = 'active|inactive|development|qualification|deprecated|obsolete');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `target_cd_nm` SET TAGS ('dbx_business_glossary_term' = 'Target Critical Dimension (CD) Nanometers (nm)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `target_layer` SET TAGS ('dbx_business_glossary_term' = 'Target Layer');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `target_thickness_angstrom` SET TAGS ('dbx_business_glossary_term' = 'Target Thickness (Angstrom)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `temperature_setpoint_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Setpoint (Celsius)');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `tool_class` SET TAGS ('dbx_business_glossary_term' = 'Tool Class');
ALTER TABLE `semiconductors_ecm`.`process`.`step` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` SET TAGS ('dbx_subdomain' = 'recipe_engineering');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe Identifier');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Baseline Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Default Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `reach_svhc_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Reach Svhc Declaration Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `substance_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Substance Inventory Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Recipe Approval Status');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|qualified|deprecated|obsolete');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `chamber_configuration` SET TAGS ('dbx_business_glossary_term' = 'Chamber Configuration');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `cmp_pad_type` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Pad Type');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `cmp_platen_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Platen Pressure (pounds per square inch)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `cmp_removal_target_nm` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Removal Target (nanometers)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `cmp_slurry_type` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Slurry Type');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `cmp_table_speed_rpm` SET TAGS ('dbx_business_glossary_term' = 'Chemical Mechanical Planarization (CMP) Table Speed (revolutions per minute)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recipe Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `deposition_method` SET TAGS ('dbx_business_glossary_term' = 'Deposition Method');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `deposition_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Deposition Pressure (Torr)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `deposition_rf_power_w` SET TAGS ('dbx_business_glossary_term' = 'Deposition Radio Frequency (RF) Power (Watts)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `deposition_target_thickness_nm` SET TAGS ('dbx_business_glossary_term' = 'Deposition Target Thickness (nanometers)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `deposition_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Deposition Temperature (Celsius)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recipe Effective End Date');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Recipe Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `etch_chemistry` SET TAGS ('dbx_business_glossary_term' = 'Etch Chemistry');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `etch_pressure_mtorr` SET TAGS ('dbx_business_glossary_term' = 'Etch Pressure (milliTorr)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `etch_rf_bias_power_w` SET TAGS ('dbx_business_glossary_term' = 'Etch Radio Frequency (RF) Bias Power (Watts)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `etch_rf_source_power_w` SET TAGS ('dbx_business_glossary_term' = 'Etch Radio Frequency (RF) Source Power (Watts)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `etch_selectivity_ratio` SET TAGS ('dbx_business_glossary_term' = 'Etch Selectivity Ratio');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `etch_type` SET TAGS ('dbx_business_glossary_term' = 'Etch Type');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `etch_type` SET TAGS ('dbx_value_regex' = 'dry|wet|plasma|reactive_ion|deep_reactive_ion');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `implant_dose_cm2` SET TAGS ('dbx_business_glossary_term' = 'Implant Dose (ions per square centimeter)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `implant_energy_kev` SET TAGS ('dbx_business_glossary_term' = 'Implant Energy (keV)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `implant_species` SET TAGS ('dbx_business_glossary_term' = 'Implant Species');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `implant_tilt_angle_deg` SET TAGS ('dbx_business_glossary_term' = 'Implant Tilt Angle (degrees)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `implant_twist_angle_deg` SET TAGS ('dbx_business_glossary_term' = 'Implant Twist Angle (degrees)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `litho_exposure_dose_mj_cm2` SET TAGS ('dbx_business_glossary_term' = 'Lithography Exposure Dose (millijoules per square centimeter)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `litho_focus_offset_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Focus Offset (nanometers)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `litho_illumination_mode` SET TAGS ('dbx_business_glossary_term' = 'Lithography Illumination Mode');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `litho_numerical_aperture` SET TAGS ('dbx_business_glossary_term' = 'Lithography Numerical Aperture (NA)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `litho_scanner_model` SET TAGS ('dbx_business_glossary_term' = 'Lithography Scanner Model');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `litho_wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Wavelength (nanometers)');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recipe Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `process_type` SET TAGS ('dbx_business_glossary_term' = 'Process Type');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `recipe_name` SET TAGS ('dbx_business_glossary_term' = 'Recipe Name');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `tool_class` SET TAGS ('dbx_business_glossary_term' = 'Tool Class');
ALTER TABLE `semiconductors_ecm`.`process`.`recipe` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` SET TAGS ('dbx_subdomain' = 'recipe_engineering');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run ID');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Consumable Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `customer_design_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Registration Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Process Recipe ID');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Process Chamber ID');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Process End Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Process Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `control_chart_rule_violated` SET TAGS ('dbx_business_glossary_term' = 'SPC (Statistical Process Control) Control Chart Rule Violated');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `control_chart_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'SPC (Statistical Process Control) Control Chart Violation Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `defect_density_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density per Square Centimeter');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_business_glossary_term' = 'Lot Disposition Status');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `lot_disposition` SET TAGS ('dbx_value_regex' = 'pass|hold|scrap|rework|conditional_pass');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `measurement_result_value` SET TAGS ('dbx_business_glossary_term' = 'In-Line Measurement Result Value');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `measurement_site_count` SET TAGS ('dbx_business_glossary_term' = 'Measurement Site Count');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `process_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Process Duration in Seconds');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `process_gas_flow_sccm` SET TAGS ('dbx_business_glossary_term' = 'Process Gas Flow in Standard Cubic Centimeters per Minute (SCCM)');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `process_notes` SET TAGS ('dbx_business_glossary_term' = 'Process Run Notes');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `process_power_watts` SET TAGS ('dbx_business_glossary_term' = 'Process Power in Watts');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `process_pressure_torr` SET TAGS ('dbx_business_glossary_term' = 'Process Pressure in Torr');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `process_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Status');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `process_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|not_qualified|pending_qualification|requalification_required');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `process_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Process Temperature in Celsius');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `recipe_version` SET TAGS ('dbx_business_glossary_term' = 'Recipe Version');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `rework_count` SET TAGS ('dbx_business_glossary_term' = 'Rework Count');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Process Run Number');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `scrap_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Scrap Reason Code');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'camstar_mes|smartfactory_mes|manual_entry');
ALTER TABLE `semiconductors_ecm`.`process`.`lot_process_run` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Wafer Count');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` SET TAGS ('dbx_subdomain' = 'quality_monitoring');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Chart Identifier');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Tool ID');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot ID');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `quality_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `baseline_data_points` SET TAGS ('dbx_business_glossary_term' = 'Baseline Data Points');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `chart_activation_date` SET TAGS ('dbx_business_glossary_term' = 'Chart Activation Date');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `chart_name` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Chart Name');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `chart_owner` SET TAGS ('dbx_business_glossary_term' = 'Chart Owner');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `chart_retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Chart Retirement Date');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `chart_status` SET TAGS ('dbx_business_glossary_term' = 'Chart Status');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `chart_status` SET TAGS ('dbx_value_regex' = 'active|suspended|retired|under_review|baseline_collection');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `chart_type` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Chart Type');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `control_limit_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Control Limit Calculation Method');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `control_limit_calculation_method` SET TAGS ('dbx_value_regex' = 'three_sigma|six_sigma|cpk_based|historical_baseline|engineering_specification');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `last_limit_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Limit Revision Date');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `lower_warning_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Warning Limit (LWL)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `measurement_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Measurement Sequence Number');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `monitored_parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Monitored Parameter Name');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `ocap_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Control Action Plan (OCAP) Reference Number');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `parameter_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Parameter Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `process_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Process Action Taken');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `process_capability_index_cp` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cp)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `process_capability_index_cpk` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `rule_violations_triggered` SET TAGS ('dbx_business_glossary_term' = 'Rule Violations Triggered');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `site_x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Site X Coordinate');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `site_y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Site Y Coordinate');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `specification_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Lower Limit (LSL)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `specification_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Upper Limit (USL)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_control_chart` ALTER COLUMN `upper_warning_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Warning Limit (UWL)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` SET TAGS ('dbx_subdomain' = 'quality_monitoring');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `spc_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Measurement ID');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology Tool ID');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot ID');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `metrology_run_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Run ID');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Control Chart ID');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer ID');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `control_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `control_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `deviation_from_target` SET TAGS ('dbx_business_glossary_term' = 'Deviation from Target');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|suspect|retest_required|equipment_error');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'inline|offline|final_inspection|qualification|monitor_wafer');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `out_of_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Control Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `out_of_spec_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `process_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Process Action Taken');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `rule_violation_flags` SET TAGS ('dbx_business_glossary_term' = 'Rule Violation Flags');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `sigma_level` SET TAGS ('dbx_business_glossary_term' = 'Sigma Level');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `site_number` SET TAGS ('dbx_business_glossary_term' = 'Site Number');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `site_x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Site X Coordinate');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `site_y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Site Y Coordinate');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `specification_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `specification_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`process`.`spc_measurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` SET TAGS ('dbx_subdomain' = 'quality_monitoring');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `capability_id` SET TAGS ('dbx_business_glossary_term' = 'Process Capability ID');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `customer_design_win_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Design Win Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `inventory_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `product_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product Spec Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Chart Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Chamber ID');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `analysis_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'short_term|long_term|initial|ongoing');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `capability_status` SET TAGS ('dbx_business_glossary_term' = 'Capability Status');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `capability_status` SET TAGS ('dbx_value_regex' = 'capable|marginal|incapable|not_assessed');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `control_chart_type` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Control Chart Type');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `control_chart_type` SET TAGS ('dbx_value_regex' = 'xbar_r|xbar_s|individuals|p_chart|c_chart|u_chart');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `cp_index` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cp)');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `cpk_index` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `lower_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `mean_value` SET TAGS ('dbx_business_glossary_term' = 'Mean Value');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `normality_test_result` SET TAGS ('dbx_business_glossary_term' = 'Normality Test Result');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `normality_test_result` SET TAGS ('dbx_value_regex' = 'normal|non_normal|not_tested');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `out_of_control_points` SET TAGS ('dbx_business_glossary_term' = 'Out of Control Points');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Parameter Code');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `pp_index` SET TAGS ('dbx_business_glossary_term' = 'Process Performance Index (Pp)');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `ppk_index` SET TAGS ('dbx_business_glossary_term' = 'Process Performance Index (Ppk)');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `process_area` SET TAGS ('dbx_value_regex' = 'feol|mol|beol');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `process_layer` SET TAGS ('dbx_business_glossary_term' = 'Process Layer');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification Status');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|conditional|not_qualified|pending');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `standard_deviation` SET TAGS ('dbx_business_glossary_term' = 'Standard Deviation');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `subgroup_size` SET TAGS ('dbx_business_glossary_term' = 'Subgroup Size');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'improving|stable|degrading|insufficient_data');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `semiconductors_ecm`.`process`.`capability` ALTER COLUMN `wafer_size_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Size (mm)');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` SET TAGS ('dbx_subdomain' = 'recipe_engineering');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `opc_rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set ID');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `assist_feature_rules` SET TAGS ('dbx_business_glossary_term' = 'Assist Feature Rules');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `eda_tool_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Name');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `eda_tool_vendor` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Vendor');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `eda_tool_version` SET TAGS ('dbx_business_glossary_term' = 'Electronic Design Automation (EDA) Tool Version');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `illumination_mode` SET TAGS ('dbx_business_glossary_term' = 'Illumination Mode');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Type');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `lithography_type` SET TAGS ('dbx_value_regex' = 'EUV|DUV|i-line|g-line');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `lithography_wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Wavelength (Nanometers)');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `meef_feature_type` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Feature Type');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `meef_measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Measurement Methodology');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `meef_pitch_nm` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Pitch (Nanometers)');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `meef_target_cd_nm` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Target Critical Dimension (CD) (Nanometers)');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `meef_value` SET TAGS ('dbx_business_glossary_term' = 'Mask Error Enhancement Factor (MEEF) Value');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `opc_model_type` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Model Type');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `opc_model_type` SET TAGS ('dbx_value_regex' = 'rule_based|model_based|hybrid|inverse_lithography');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `owner_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer Name');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `process_bias_table_reference` SET TAGS ('dbx_business_glossary_term' = 'Process Bias Table Reference');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `process_window_dof_nm` SET TAGS ('dbx_business_glossary_term' = 'Process Window Depth of Focus (DOF) (Nanometers)');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `process_window_el_percent` SET TAGS ('dbx_business_glossary_term' = 'Process Window Exposure Latitude (EL) (Percent)');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'draft|under_qualification|qualified|production|deprecated');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `rule_set_file_format` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set File Format');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `rule_set_file_path` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set File Path');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `rule_set_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `rule_set_name` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set Name');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Optical Proximity Correction (OPC) Rule Set Version');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `scanner_numerical_aperture` SET TAGS ('dbx_business_glossary_term' = 'Scanner Numerical Aperture (NA)');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `sigma_inner` SET TAGS ('dbx_business_glossary_term' = 'Sigma Inner Illumination Parameter');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `sigma_outer` SET TAGS ('dbx_business_glossary_term' = 'Sigma Outer Illumination Parameter');
ALTER TABLE `semiconductors_ecm`.`process`.`opc_rule_set` ALTER COLUMN `target_layer_name` SET TAGS ('dbx_business_glossary_term' = 'Target Lithography Layer Name');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` SET TAGS ('dbx_subdomain' = 'change_control');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Process Qualification ID');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `obligation_register_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Register Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Flow Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Qualified Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `quality_qualification_program_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Qualification Program Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `acceptance_criteria_summary` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Summary');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `actual_cpk` SET TAGS ('dbx_business_glossary_term' = 'Actual Process Capability Index (Cpk)');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `actual_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Yield Percent');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `customer_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Status');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `customer_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Qualification Disposition');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{2}$');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `failure_mode_summary` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Summary');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `lot_count` SET TAGS ('dbx_business_glossary_term' = 'Qualification Lot Count');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `owner_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer Name');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Qualification Plan Reference');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `plm_system_source` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) System Source');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `plm_system_source` SET TAGS ('dbx_value_regex' = 'oracle_agile|siemens_teamcenter|other');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `plm_workflow_reference` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Management (PLM) Workflow ID');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `qualification_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Name');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_value_regex' = '^PQ-[A-Z0-9]{6,12}$');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'new_process|process_change|tool_qualification|node_readiness|recipe_qualification|material_qualification');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `requires_customer_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Customer Approval');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `sign_off_date` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Date');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `sign_off_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Engineer Name');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Start Date');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `target_cpk` SET TAGS ('dbx_business_glossary_term' = 'Target Process Capability Index (Cpk)');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percent');
ALTER TABLE `semiconductors_ecm`.`process`.`qualification` ALTER COLUMN `wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Qualification Wafer Count');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` SET TAGS ('dbx_subdomain' = 'change_control');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `change_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Change Notification Identifier');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contract Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Technology Node ID');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `flow_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Process Flow Internal Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Process Flow ID');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `actual_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Date');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `affected_customer_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer List');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `affected_customer_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `affected_equipment_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Equipment List');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `affected_material_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Material List');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `affected_product_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Product List');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `attachments` SET TAGS ('dbx_business_glossary_term' = 'Attachments');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `change_classification` SET TAGS ('dbx_business_glossary_term' = 'Change Classification');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `change_classification` SET TAGS ('dbx_value_regex' = 'major|minor|notification_only');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Status');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `change_title` SET TAGS ('dbx_business_glossary_term' = 'Change Title');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `change_type` SET TAGS ('dbx_value_regex' = 'process|material|equipment|design|facility|supplier');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `cost_impact` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `cost_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `customer_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Required Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `cycle_time_impact_hours` SET TAGS ('dbx_business_glossary_term' = 'Cycle Time Impact Hours');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `environmental_impact` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `last_time_buy_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Buy (LTB) Date');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `last_time_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Last Time Ship Date');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `owner_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Engineer Name');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `pcn_number` SET TAGS ('dbx_business_glossary_term' = 'Process Change Notification (PCN) Number');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `pcn_number` SET TAGS ('dbx_value_regex' = '^PCN-[0-9]{6,10}$');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `planned_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Implementation Date');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `qualification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed|waived');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `regulatory_impact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `yield_impact_percent` SET TAGS ('dbx_business_glossary_term' = 'Yield Impact Percentage');
ALTER TABLE `semiconductors_ecm`.`process`.`change_notification` ALTER COLUMN `yield_impact_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` SET TAGS ('dbx_subdomain' = 'change_control');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `yield_loss_event_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Event ID');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action ID');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `excursion_id` SET TAGS ('dbx_business_glossary_term' = 'Excursion Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Related Maintenance Event Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Chart Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `affected_die_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Die Count');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `cpk_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk) Value');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `defect_density_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density per Square Centimeter');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `defect_size_nm` SET TAGS ('dbx_business_glossary_term' = 'Defect Size Nanometers');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'inline_inspection|offline_inspection|electrical_test|parametric_test|visual_inspection|metrology');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'continue|rework|scrap|quarantine|use_as_is|return_to_vendor');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `estimated_yield_impact_percent` SET TAGS ('dbx_business_glossary_term' = 'Estimated Yield Impact Percent');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `investigation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `layer_name` SET TAGS ('dbx_business_glossary_term' = 'Layer Name');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `lot_hold_applied` SET TAGS ('dbx_business_glossary_term' = 'Lot Hold Applied');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|root_cause_identified|corrective_action_implemented|closed|deferred');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment|material|process|human|environmental|design');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|negligible');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `wafer_position_x_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Position X Millimeters');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `wafer_position_y_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Position Y Millimeters');
ALTER TABLE `semiconductors_ecm`.`process`.`yield_loss_event` ALTER COLUMN `yield_loss_mode` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Mode');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` SET TAGS ('dbx_subdomain' = 'quality_monitoring');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `defect_inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Inspection Result Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Tool Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Recipe Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `primary_defect_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Chart Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `crystal_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Crystal Defect Count');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `defect_density_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density per Square Centimeter (cm²)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `defect_map_file_format` SET TAGS ('dbx_business_glossary_term' = 'Defect Map File Format');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `defect_map_file_format` SET TAGS ('dbx_value_regex' = 'KLARF|CSV|XML|proprietary');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `defect_map_file_path` SET TAGS ('dbx_business_glossary_term' = 'Defect Map File Path');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `defect_size_bin_large_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Size Bin Large Count');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `defect_size_bin_medium_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Size Bin Medium Count');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `defect_size_bin_small_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Size Bin Small Count');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Inspection Disposition');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'pass|fail|review|hold|rework');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `excursion_detected` SET TAGS ('dbx_business_glossary_term' = 'Excursion Detected Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `inspected_area_cm2` SET TAGS ('dbx_business_glossary_term' = 'Inspected Area in Square Centimeters (cm²)');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_mode` SET TAGS ('dbx_business_glossary_term' = 'Inspection Mode');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_mode` SET TAGS ('dbx_value_regex' = 'full_wafer|die_sampling|edge_exclusion|hot_spot');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|failed|aborted');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'brightfield|darkfield|e-beam|optical|macro');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `killer_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Killer Defect Count');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `layer_name` SET TAGS ('dbx_business_glossary_term' = 'Layer Name');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `nuisance_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Nuisance Defect Count');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `nuisance_filter_applied` SET TAGS ('dbx_business_glossary_term' = 'Nuisance Filter Applied Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `nuisance_filter_version` SET TAGS ('dbx_business_glossary_term' = 'Nuisance Filter Version');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `particle_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Particle Defect Count');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `pattern_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Pattern Defect Count');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `residue_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Residue Defect Count');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `review_required` SET TAGS ('dbx_business_glossary_term' = 'Review Required Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `scratch_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Scratch Defect Count');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `spc_control_limit_lower` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Lower Control Limit');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `spc_control_limit_upper` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Upper Control Limit');
ALTER TABLE `semiconductors_ecm`.`process`.`defect_inspection_result` ALTER COLUMN `total_defect_count` SET TAGS ('dbx_business_glossary_term' = 'Total Defect Count');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` SET TAGS ('dbx_subdomain' = 'quality_monitoring');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `metrology_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for metrology_measurement');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Metrology Tool ID');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Lot ID');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `recipe_id` SET TAGS ('dbx_business_glossary_term' = 'Recipe ID');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Chart Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `wafer_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer ID');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `cp_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cp)');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `cpk_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'Good|Suspect|Bad|Uncalibrated');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Marginal|Rework|Hold');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'Fabrication (FAB) Site Code');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `layer_name` SET TAGS ('dbx_business_glossary_term' = 'Layer Name');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit (LSL)');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `max_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Value');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `mean_value` SET TAGS ('dbx_business_glossary_term' = 'Mean Value');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_business_glossary_term' = 'Measurement Mode');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `measurement_mode` SET TAGS ('dbx_value_regex' = 'Inline|Offline|Engineering|Qualification');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `measurement_parameter` SET TAGS ('dbx_business_glossary_term' = 'Measurement Parameter');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Status');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `measurement_status` SET TAGS ('dbx_value_regex' = 'Completed|In Progress|Failed|Aborted|Pending');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'CD-SEM|OCD|XRF|Ellipsometry|Overlay|Film Thickness');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `median_value` SET TAGS ('dbx_business_glossary_term' = 'Median Value');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `min_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Value');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `range_value` SET TAGS ('dbx_business_glossary_term' = 'Range Value');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `site_count` SET TAGS ('dbx_business_glossary_term' = 'Site Count');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `spc_rule_violation` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control (SPC) Rule Violation');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `std_deviation` SET TAGS ('dbx_business_glossary_term' = 'Standard Deviation');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `three_sigma` SET TAGS ('dbx_business_glossary_term' = 'Three Sigma (3σ)');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `uniformity_percent` SET TAGS ('dbx_business_glossary_term' = 'Uniformity Percent');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit (USL)');
ALTER TABLE `semiconductors_ecm`.`process`.`metrology_measurement` ALTER COLUMN `wafer_slot_number` SET TAGS ('dbx_business_glossary_term' = 'Wafer Slot Number');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` SET TAGS ('dbx_subdomain' = 'recipe_engineering');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `process_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Process Technology Node ID');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `process_node_id` SET TAGS ('dbx_business_glossary_term' = 'Product Process Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `application_scope` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Application Scope');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `baseline_cpk` SET TAGS ('dbx_business_glossary_term' = 'Baseline Cpk (Process Capability Index)');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `baseline_yield_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Baseline Yield Target (%)');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `beol_layer_count` SET TAGS ('dbx_business_glossary_term' = 'BEOL (Back End of Line) Layer Count');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `design_rule_complexity` SET TAGS ('dbx_business_glossary_term' = 'Design Rule Complexity Level');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `design_rule_complexity` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `device_architecture` SET TAGS ('dbx_business_glossary_term' = 'Device Architecture Type');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `device_architecture` SET TAGS ('dbx_value_regex' = 'planar|finfet|gaa|nanowire|nanosheet');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `dram_half_pitch_nm` SET TAGS ('dbx_business_glossary_term' = 'DRAM (Dynamic Random-Access Memory) Half-Pitch (nm)');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Effective End Date');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `euv_layer_count` SET TAGS ('dbx_business_glossary_term' = 'EUV (Extreme Ultraviolet Lithography) Layer Count');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `fab_site_code` SET TAGS ('dbx_business_glossary_term' = 'FAB (Fabrication Facility) Site Code');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `feol_layer_count` SET TAGS ('dbx_business_glossary_term' = 'FEOL (Front End of Line) Layer Count');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `gate_pitch_nm` SET TAGS ('dbx_business_glossary_term' = 'Gate Pitch (nm)');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `introduction_year` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Introduction Year');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `is_baseline_node` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Technology Node Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `lithography_type` SET TAGS ('dbx_business_glossary_term' = 'Lithography Technology Type');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `lithography_type` SET TAGS ('dbx_value_regex' = 'duv|euv|immersion|dry|ebeam');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `metal_layer_count` SET TAGS ('dbx_business_glossary_term' = 'Metal Layer Count');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `minimum_metal_pitch_nm` SET TAGS ('dbx_business_glossary_term' = 'Minimum Metal Pitch (nm)');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Code');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `node_generation` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Generation');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Name');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Notes');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `owner_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Owner Engineer Name');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Owner Organization');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `pdk_version` SET TAGS ('dbx_business_glossary_term' = 'PDK (Process Design Kit) Version');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `process_technology_node_description` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Description');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `production_readiness_status` SET TAGS ('dbx_business_glossary_term' = 'Production Readiness Status');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Qualification Date');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Node Qualification Status');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|qualified|production_approved|failed|on_hold');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `supports_multi_patterning` SET TAGS ('dbx_business_glossary_term' = 'Supports Multi-Patterning Flag');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `target_performance_improvement_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Performance Improvement (%)');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `target_power_efficiency_improvement_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Power Efficiency Improvement (%)');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `target_transistor_density_per_mm2` SET TAGS ('dbx_business_glossary_term' = 'Target Transistor Density (per mm²)');
ALTER TABLE `semiconductors_ecm`.`process`.`process_technology_node` ALTER COLUMN `wavelength_nm` SET TAGS ('dbx_business_glossary_term' = 'Lithography Wavelength (nm)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` SET TAGS ('dbx_subdomain' = 'change_control');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `excursion_id` SET TAGS ('dbx_business_glossary_term' = 'Excursion Identifier');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `capa_record_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Record Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `defect_inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Inspection Result Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment ID');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Technology Node ID');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot ID');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `ic_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ic Catalog Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `lot_process_run_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Process Run Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `nonconformance_report_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Report Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `process_step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step ID');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `spc_control_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Control Chart Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `step_id` SET TAGS ('dbx_business_glossary_term' = 'Process Step Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Suspected Supplier Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `tool_chamber_id` SET TAGS ('dbx_business_glossary_term' = 'Tool Chamber Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Maintenance Event Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `spc_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Spc Measurement Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `affected_die_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Die Count');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `affected_lot_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot Count');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `affected_wafer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Wafer Count');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `containment_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Containment Action Taken');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `containment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Containment Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `corrective_action_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Reference');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `customer_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Required');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `defect_density_per_cm2` SET TAGS ('dbx_business_glossary_term' = 'Defect Density Per Square Centimeter');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'SPC|inspection|metrology|electrical_test|operator|automated_system');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'use_as_is|rework|scrap|return_to_vendor|engineering_review|customer_notification');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `disposition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `estimated_financial_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact (USD)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `estimated_financial_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `estimated_yield_impact_percent` SET TAGS ('dbx_business_glossary_term' = 'Estimated Yield Impact Percent');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `excursion_number` SET TAGS ('dbx_business_glossary_term' = 'Excursion Number');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `excursion_type` SET TAGS ('dbx_business_glossary_term' = 'Excursion Type');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `excursion_type` SET TAGS ('dbx_value_regex' = 'out_of_spec|out_of_control|yield_loss|defect_density|parametric_drift|equipment_fault');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|investigating|root_cause_identified|corrective_action_pending|closed|cancelled');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `lower_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Parameter Name');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment|material|process|human|environmental|unknown');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'minor|major|critical');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `specification_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Lower Limit (LSL)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `specification_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Upper Limit (USL)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `upper_control_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `yield_loss_mode` SET TAGS ('dbx_business_glossary_term' = 'Yield Loss Mode');
ALTER TABLE `semiconductors_ecm`.`process`.`excursion` ALTER COLUMN `yield_loss_mode` SET TAGS ('dbx_value_regex' = 'parametric|systematic|random|electrical|none');
