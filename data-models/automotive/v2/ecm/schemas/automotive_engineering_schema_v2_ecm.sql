-- Schema for Domain: engineering | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 03:51:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`engineering` COMMENT 'Manages the full product design and development lifecycle including CAD (Computer-Aided Design), CAE (Computer-Aided Engineering), PLM (Product Lifecycle Management), and digital twin modeling. Owns engineering BOM, design specifications, CFD (Computational Fluid Dynamics), FEA (Finite Element Analysis), NVH (Noise Vibration Harshness) testing, prototype validation, and engineering change orders (ECO/ECN). Integrates with Siemens Teamcenter, CATIA, and ENOVIA for collaborative engineering.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` (
    `vehicle_program_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `aftersales_nameplate_id` BIGINT COMMENT '',
    `profit_center_id` BIGINT COMMENT '',
    `bom_version` STRING COMMENT '',
    `budget_allocation` DECIMAL(18,2) COMMENT '',
    `cad_release_version` STRING COMMENT '',
    `cae_release_version` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `vehicle_program_description` STRING COMMENT '',
    `digital_twin_enabled` BOOLEAN COMMENT '',
    `drivetrain` STRING COMMENT '',
    `emission_standard` STRING COMMENT '',
    `end_date` DATE COMMENT '',
    `engineering_change_order_count` STRING COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `launch_date` DATE COMMENT '',
    `model_year_end` STRING COMMENT '',
    `model_year_start` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `ota_update_capability` BOOLEAN COMMENT '',
    `platform_architecture` STRING COMMENT '',
    `powertrain_type` STRING COMMENT '',
    `program_code` STRING COMMENT '',
    `program_name` STRING COMMENT '',
    `program_type` STRING COMMENT '',
    `regulatory_approval_status` STRING COMMENT '',
    `segment` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `start_date` DATE COMMENT '',
    `target_cost_per_vehicle` DECIMAL(18,2) COMMENT '',
    `target_emissions_g_per_km` DECIMAL(18,2) COMMENT '',
    `target_fuel_efficiency_mpg` DECIMAL(18,2) COMMENT '',
    `target_market` STRING COMMENT '',
    `target_production_volume` STRING COMMENT '',
    `target_range_km` STRING COMMENT '',
    `target_weight_kg` DECIMAL(18,2) COMMENT '',
    `total_simulation_result_count` STRING COMMENT 'Total number of R&D simulation results associated with this vehicle program.',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vehicle_class` STRING COMMENT '',
    `vehicle_program_status` STRING COMMENT '',
    CONSTRAINT pk_vehicle_program PRIMARY KEY(`vehicle_program_id`)
) COMMENT 'Master record for a vehicle development program (nameplate/platform program), capturing program code, program name, vehicle segment, platform architecture, SOP (Start of Production) target date, EOP (End of Production) date, MY (Model Year) scope, program phase (concept, development, validation, launch), program director, budget allocation, and program status. Serves as the top-level anchor for all engineering activities within a development cycle. Owned by Siemens Teamcenter PLM.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`bom` (
    `bom_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `change_id` BIGINT COMMENT '',
    `cost_center_id` BIGINT COMMENT '',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: Engineering BOMs are owned by specific engineering teams responsible for their content and accuracy. This FK enables BOM ownership tracking and supports team-level BOM review and release processes.',
    `vehicle_program_id` BIGINT COMMENT '',
    `bom_number` STRING COMMENT '',
    `bom_status` STRING COMMENT '',
    `bom_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `effective_from_date` DATE COMMENT '',
    `effective_to_date` DATE COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `model_year` STRING COMMENT '',
    `plant_code` STRING COMMENT '',
    `revision_level` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `standard_cost_amount` DECIMAL(18,2) COMMENT '',
    `total_component_count` STRING COMMENT '',
    `total_weight_kg` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_bom PRIMARY KEY(`bom_id`)
) COMMENT 'Engineering Bill of Materials (eBOM) header record representing the complete structured parts list for a vehicle program or variant at a specific revision level. Captures BOM type (eBOM, mBOM, sBOM), program reference, model year, configuration context, effectivity dates, release status, BOM owner, and PLM system source. The eBOM is the authoritative design-intent parts structure managed in Siemens Teamcenter and ENOVIA before handoff to manufacturing BOM.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` (
    `engineering_bom_line_id` BIGINT COMMENT '',
    `bom_id` BIGINT COMMENT '',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: BOM line items are created or modified under specific engineering change orders. The existing change_number text field is a denormalized reference to the change record. Adding change_id FK normalizes ',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: Each BOM line item has a design-responsible engineering team. The existing design_responsible_team text field is a denormalized reference to the engineering team. Adding engineering_team_id FK normali',
    `part_master_id` BIGINT COMMENT '',
    `assembly_level` STRING COMMENT '',
    `cad_reference` STRING COMMENT 'Reference to CAD model in PLM system (Teamcenter/ENOVIA)',
    `component_description` STRING COMMENT '',
    `cost_target_amount` DECIMAL(18,2) COMMENT 'Cost target for this BOM line item',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `engineering_bom_line_description` STRING COMMENT 'Description of the entity',
    `effective_from_date` DATE COMMENT '',
    `effective_to_date` DATE COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `find_number` STRING COMMENT '',
    `is_critical_path` BOOLEAN COMMENT '',
    `line_number` STRING COMMENT '',
    `line_status` STRING COMMENT '',
    `make_buy_indicator` STRING COMMENT 'Indicates whether component is made in-house or purchased',
    `material_code` STRING COMMENT 'Material specification code',
    `quantity_per_assembly` DECIMAL(18,2) COMMENT '',
    `revision_level` STRING COMMENT 'Current revision level of the component',
    `scrap_factor_pct` DECIMAL(18,2) COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `supplier_nomination_status` STRING COMMENT 'Status of supplier nomination for this component',
    `tolerance_spec` STRING COMMENT 'Dimensional tolerance specification',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `validation_status` STRING COMMENT 'Design validation status',
    `weight_kg` DECIMAL(18,2) COMMENT 'Component weight in kilograms',
    CONSTRAINT pk_engineering_bom_line PRIMARY KEY(`engineering_bom_line_id`)
) COMMENT 'Individual line item within an engineering BOM, representing a single part-to-parent relationship in the BOM hierarchy. Captures parent assembly reference, child part number, find number, quantity, unit of measure, effectivity start/end dates, variant applicability, substitution flags, BOM level, and engineering change reference. Supports multi-level BOM explosion and where-used analysis. Sourced from Siemens Teamcenter BOM Management.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`part_master` (
    `part_master_id` BIGINT COMMENT '',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: Parts in the engineering part master are owned by specific engineering teams (e.g., body team owns body panels, powertrain team owns engine parts). This FK enables part ownership tracking and supports',
    `patent_record_id` BIGINT COMMENT 'FK to patent protecting this part design',
    `vehicle_program_id` BIGINT COMMENT '',
    `commodity_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `drawing_number` STRING COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `lifecycle_status` STRING COMMENT '',
    `make_or_buy` STRING COMMENT '',
    `material_type` STRING COMMENT '',
    `part_description` STRING COMMENT '',
    `part_name` STRING COMMENT '',
    `part_number` STRING COMMENT '',
    `part_status` STRING COMMENT '',
    `part_type` STRING COMMENT '',
    `revision_level` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `test_bench_validated_flag` BOOLEAN COMMENT 'Whether this part has been validated on a physical test bench.',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `weight_kg` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_part_master PRIMARY KEY(`part_master_id`)
) COMMENT 'Engineering part master record representing a unique part or component managed within the PLM system. Captures part number, part name, part classification, material type, weight, dimensions, drawing number, CAD model reference, lifecycle state (in-work, released, obsolete), revision level, owning engineer, supplier part number, REACH/RoHS compliance flag, and part family. Authoritative source for engineering part identity in Siemens Teamcenter / PTC Windchill.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`design_specification` (
    `design_specification_id` BIGINT COMMENT '',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: Design specifications are owned by specific engineering teams. The existing owner_name text field is a denormalized reference to the team. Adding engineering_team_id FK normalizes this relationship. o',
    `patent_record_id` BIGINT COMMENT 'FK to related patent if applicable',
    `vehicle_program_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data catalog entry for lineage and governance',
    `design_specification_description` STRING COMMENT '',
    `document_url` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `requirements_traceability_coverage_pct` DECIMAL(18,2) COMMENT 'Percentage of requirements traced to this design specification.',
    `revision_level` STRING COMMENT '',
    `spec_name` STRING COMMENT '',
    `spec_number` STRING COMMENT '',
    `spec_status` STRING COMMENT '',
    `spec_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_design_specification PRIMARY KEY(`design_specification_id`)
) COMMENT 'Engineering design specification document record capturing the technical requirements and design intent for a vehicle system, subsystem, or component. Includes specification number, title, specification type (system, subsystem, component, interface), applicable program, revision history, author, approval status, linked requirements, target performance values, and regulatory references (FMVSS, UNECE, NCAP). Managed in Teamcenter or ENOVIA document management.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`cad_model` (
    `cad_model_id` BIGINT COMMENT '',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: CAD models are updated as part of engineering change orders. This FK links each CAD model revision to the ECO/ECN that authorized the change, enabling change-to-CAD traceability and ensuring CAD model',
    `design_specification_id` BIGINT COMMENT '',
    `part_master_id` BIGINT COMMENT '',
    `cad_file_name` STRING COMMENT '',
    `cad_system` STRING COMMENT '',
    `checksum` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data catalog entry for lineage and governance',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `file_format` STRING COMMENT '',
    `file_size_bytes` BIGINT COMMENT '',
    `model_status` STRING COMMENT '',
    `revision_level` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `created_by` STRING COMMENT '',
    CONSTRAINT pk_cad_model PRIMARY KEY(`cad_model_id`)
) COMMENT 'CAD (Computer-Aided Design) model record representing a 3D digital geometry asset created in CATIA or equivalent tool. Captures model file reference, part or assembly association, CAD tool version, coordinate system, model maturity level, digital mock-up (DMU) inclusion flag, last published date, file size, configuration context, and owning designer. Supports digital twin construction and downstream CAE simulation setup. Sourced from Dassault Systèmes CATIA and ENOVIA.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`change` (
    `change_id` BIGINT COMMENT '',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: Engineering change orders are owned by specific engineering teams responsible for implementing the change. This FK enables change workload tracking per team and supports change board review processes.',
    `employee_id` BIGINT COMMENT '',
    `vehicle_program_id` BIGINT COMMENT '',
    `approved_date` DATE COMMENT '',
    `change_number` STRING COMMENT '',
    `change_status` STRING COMMENT '',
    `change_type` STRING COMMENT '',
    `cost_impact_amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `change_description` STRING COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `impact_assessment` STRING COMMENT '',
    `implementation_date` DATE COMMENT '',
    `priority` STRING COMMENT '',
    `reason_code` STRING COMMENT '',
    `requested_date` DATE COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_change PRIMARY KEY(`change_id`)
) COMMENT 'Engineering Change Order/Notice (ECO/ECN) record capturing a formal request to modify a part, assembly, design specification, or BOM. Includes change number, change type (ECR/ECO/ECN), title, reason for change (cost reduction, quality, regulatory, customer request), affected parts list, affected programs, initiator, approver chain, priority, implementation date, cost impact estimate, and change status (draft, under review, approved, implemented, rejected). Managed in Siemens Teamcenter Change Management.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` (
    `cae_simulation_id` BIGINT COMMENT '',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: CAE simulations validate specific design specifications (e.g., FEA against structural spec, CFD against thermal spec). This FK links each simulation run to the design spec it is validating, enabling r',
    `dvp_plan_id` BIGINT COMMENT 'Foreign key linking to engineering.dvp_plan. Business justification: CAE simulations are planned activities within the DVP. Linking cae_simulation to dvp_plan enables tracking of virtual test completion against the overall DVP test plan, supporting hybrid physical/virt',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: CAE simulations are executed by specific engineering teams (e.g., CAE/FEA team, NVH team, CFD team). This FK enables simulation workload tracking and team capacity planning.',
    `ml_model_metadata_id` BIGINT COMMENT 'FK to ML surrogate model used for simulation acceleration',
    `part_master_id` BIGINT COMMENT '',
    `vehicle_program_id` BIGINT COMMENT '',
    `completed_timestamp` TIMESTAMP COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data catalog entry for lineage and governance',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `mesh_element_count` STRING COMMENT '',
    `pass_fail_flag` BOOLEAN COMMENT '',
    `rd_result_count` STRING COMMENT 'Number of detailed R&D simulation result records linked to this simulation run.',
    `result_summary` STRING COMMENT '',
    `run_duration_hours` DECIMAL(18,2) COMMENT '',
    `simulation_name` STRING COMMENT '',
    `simulation_status` STRING COMMENT '',
    `simulation_type` STRING COMMENT '',
    `solver_software` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `submitted_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_cae_simulation PRIMARY KEY(`cae_simulation_id`)
) COMMENT 'CAE (Computer-Aided Engineering) simulation record capturing a virtual analysis run performed on a vehicle component or system. Includes simulation ID, simulation type (FEA — Finite Element Analysis, CFD — Computational Fluid Dynamics, NVH — Noise Vibration Harshness, crash, thermal, fatigue), associated part or assembly, solver used, load cases, boundary conditions, mesh parameters, run date, analyst, result summary (pass/fail against targets), and linked design specification. Supports virtual validation before physical prototype build.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` (
    `prototype_build_id` BIGINT COMMENT '',
    `dvp_plan_id` BIGINT COMMENT 'Foreign key linking to engineering.dvp_plan. Business justification: Prototype builds are executed under a Design Verification Plan (DVP). Linking prototype_build to dvp_plan establishes the formal test planning context for each physical build event, enabling traceabil',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: Prototype builds are executed by a specific engineering team responsible for the build phase. This FK enables accountability tracking and resource allocation reporting per team.',
    `vehicle_program_id` BIGINT COMMENT '',
    `actual_start_date` DATE COMMENT '',
    `build_location` STRING COMMENT '',
    `build_number` STRING COMMENT '',
    `build_phase` STRING COMMENT '',
    `build_status` STRING COMMENT '',
    `completion_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `notes` STRING COMMENT '',
    `planned_start_date` DATE COMMENT '',
    `quantity_built` STRING COMMENT '',
    `quantity_planned` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_prototype_build PRIMARY KEY(`prototype_build_id`)
) COMMENT 'Prototype vehicle or component build record capturing the physical build event for validation purposes. Includes build number, build phase (mule, alpha, beta, pre-production), program reference, build date, build location, VIN or prototype identifier, configuration description, build purpose (durability, crash, NVH, emissions, homologation), responsible engineer, and build status. Tracks the physical instantiation of engineering designs for testing and validation activities.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`validation_test` (
    `validation_test_id` BIGINT COMMENT '',
    `dvp_plan_id` BIGINT COMMENT '',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: Validation tests are conducted by specific engineering teams (e.g., NVH team, powertrain validation team). This FK enables workload tracking and test ownership accountability per team.',
    `homologation_requirement_id` BIGINT COMMENT 'Foreign key linking to engineering.homologation_requirement. Business justification: Validation tests are conducted to satisfy specific homologation and regulatory requirements. This FK links each test event to the regulatory requirement it is intended to verify, enabling compliance g',
    `prototype_build_id` BIGINT COMMENT 'Foreign key linking to engineering.prototype_build. Business justification: Validation tests are performed on specific prototype builds. This FK provides direct traceability from a test event to the physical prototype being tested, which is essential for DVP reporting and reg',
    `test_bench_id` BIGINT COMMENT 'Foreign key linking to engineering.test_bench. Business justification: Validation tests are executed on specific test benches. The existing test_facility text field is a denormalized reference to the bench location; replacing it with a FK to test_bench enables proper ass',
    `vehicle_program_id` BIGINT COMMENT '',
    `actual_start_date` DATE COMMENT '',
    `completion_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `iot_data_collection_flag` BOOLEAN COMMENT 'Whether IoT sensor data was collected during test',
    `pass_fail_result` STRING COMMENT '',
    `planned_start_date` DATE COMMENT '',
    `regulatory_compliance_flag` BOOLEAN COMMENT '',
    `requirements_coverage_pct` DECIMAL(18,2) COMMENT 'Percentage of linked requirements covered by this validation test.',
    `sample_size` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `test_name` STRING COMMENT '',
    `test_standard` STRING COMMENT '',
    `test_status` STRING COMMENT '',
    `test_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_validation_test PRIMARY KEY(`validation_test_id`)
) COMMENT 'Engineering validation test record capturing a physical or virtual test event performed on a prototype or production-intent part/vehicle. Includes test ID, test type (DVP — Design Verification Plan, PVP — Process Validation Plan, PPAP, durability, emissions, NCAP/WLTP, FMVSS), test name, test standard reference, test facility, test date, test engineer, test result (pass/fail/conditional), measured values vs. targets, and disposition. Supports DVP&R (Design Verification Plan and Report) tracking.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` (
    `engineering_test_result_id` BIGINT COMMENT '',
    `prototype_build_id` BIGINT COMMENT 'Foreign key linking to engineering.prototype_build. Business justification: Engineering test results are generated from testing specific prototype builds. While the chain validation_test → prototype_build exists, direct FK on engineering_test_result enables efficient querying',
    `test_sample_id` BIGINT COMMENT 'Identifier of the test sample or specimen',
    `test_bench_id` BIGINT COMMENT 'Identifier of the test bench used',
    `validation_test_id` BIGINT COMMENT '',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT '',
    `approval_engineer_name` STRING COMMENT 'Name of engineer who approved the result',
    `confidence_level_pct` DECIMAL(18,2) COMMENT 'Statistical confidence level of the result',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `engineering_test_result_description` STRING COMMENT 'Description of the entity',
    `deviation_from_target` DECIMAL(18,2) COMMENT 'Deviation from target value',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `humidity_percent` DECIMAL(18,2) COMMENT 'Ambient humidity during test',
    `measured_value` DECIMAL(18,2) COMMENT '',
    `notes` STRING COMMENT '',
    `pass_fail_status` STRING COMMENT '',
    `pass_flag` BOOLEAN COMMENT '',
    `result_code` STRING COMMENT '',
    `result_date` DATE COMMENT '',
    `result_unit` STRING COMMENT '',
    `result_value` DECIMAL(18,2) COMMENT '',
    `retest_required_flag` BOOLEAN COMMENT 'Whether a retest is required',
    `sensor_data_ref` STRING COMMENT 'Reference to IoT sensor data used during test',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `target_value` DECIMAL(18,2) COMMENT '',
    `test_date` DATE COMMENT '',
    `test_duration_hours` DECIMAL(18,2) COMMENT 'Duration of the test in hours',
    `test_engineer` STRING COMMENT '',
    `test_facility` STRING COMMENT '',
    `test_standard` STRING COMMENT 'Test standard or protocol followed',
    `test_status` STRING COMMENT '',
    `test_type` STRING COMMENT 'Type of test (durability, performance, safety, emissions)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_engineering_test_result PRIMARY KEY(`engineering_test_result_id`)
) COMMENT 'Detailed test result record capturing individual measurement data points from a validation test event. Includes result ID, parent test reference, measurement parameter name, unit of measure, measured value, target value, tolerance band (min/max), pass/fail status, test condition description, channel or sensor ID, timestamp of measurement, and data file reference. Enables granular traceability of test outcomes against engineering targets and regulatory thresholds. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` (
    `digital_twin_id` BIGINT COMMENT '',
    `ecu_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.ecu_specification. Business justification: Digital twins for software-defined vehicles model ECU behavior and software configurations. This FK links the digital twin to the ECU specification it simulates, enabling hardware-in-the-loop (HIL) an',
    `ml_model_metadata_id` BIGINT COMMENT 'FK to AI/ML model used for twin predictions',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Digital twins can represent specific parts or assemblies (not just full vehicles). This FK links a digital twin to the part it models, enabling part-level simulation and predictive maintenance use cas',
    `prototype_build_id` BIGINT COMMENT 'Foreign key linking to engineering.prototype_build. Business justification: Digital twins are synchronized with physical prototype builds to calibrate and validate the virtual model. This FK links the digital twin to the prototype build it mirrors, enabling last_sync_timestam',
    `vehicle_program_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `fidelity_level` STRING COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `iot_sensor_count` STRING COMMENT 'Number of IoT sensors feeding this digital twin',
    `last_sync_timestamp` TIMESTAMP COMMENT '',
    `model_version` STRING COMMENT '',
    `sensor_dataset_count` STRING COMMENT 'Number of AD sensor datasets linked to this digital twin.',
    `simulation_platform` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `twin_name` STRING COMMENT '',
    `twin_status` STRING COMMENT '',
    `twin_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_digital_twin PRIMARY KEY(`digital_twin_id`)
) COMMENT 'Digital twin model record representing the virtual counterpart of a physical vehicle, system, or component. Captures twin ID, twin type (vehicle-level, powertrain, chassis, body), associated program and part references, simulation model version, real-world asset linkage (VIN or prototype ID), synchronization status, last updated timestamp, fidelity level, and owning engineering team. Enables continuous correlation between virtual models and physical test/field data for predictive engineering.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`milestone` (
    `milestone_id` BIGINT COMMENT '',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.project. Business justification: Engineering milestones belong to specific projects within a vehicle program. While milestone already has vehicle_program_id, the project_id FK provides finer-grained project-level milestone tracking, ',
    `vehicle_program_id` BIGINT COMMENT '',
    `actual_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `deliverables` STRING COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `gate_number` STRING COMMENT '',
    `milestone_status` STRING COMMENT '',
    `milestone_type` STRING COMMENT '',
    `milestone_name` STRING COMMENT '',
    `owner_name` STRING COMMENT '',
    `planned_date` DATE COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Engineering program milestone record capturing key gate reviews and decision points in the vehicle development process. Includes milestone ID, milestone name (P0 concept freeze, P1 design freeze, P2 prototype release, P3 pilot build, SOP), program reference, planned date, actual date, milestone owner, gate review outcome (approved, conditional, deferred), open action items count, and sign-off authority. Supports APQP (Advanced Product Quality Planning) phase gate management.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` (
    `fmea_record_id` BIGINT COMMENT '',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: FMEA findings with high RPN scores trigger engineering change orders. This FK links the FMEA record to the resulting ECO/ECN, enabling closed-loop corrective action tracking from risk identification t',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: FMEA (Failure Mode and Effects Analysis) is performed against specific design specifications to identify failure modes in the design intent. This FK links each FMEA record to the design spec it analyz',
    `dvp_plan_id` BIGINT COMMENT 'Foreign key linking to engineering.dvp_plan. Business justification: FMEA records feed directly into DVP plans — the detection controls identified in FMEA become test cases in the DVP. This FK enables bidirectional traceability between risk analysis and test planning.',
    `part_master_id` BIGINT COMMENT '',
    `vehicle_program_id` BIGINT COMMENT '',
    `action_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `detection_rating` STRING COMMENT '',
    `failure_cause` STRING COMMENT '',
    `failure_effect` STRING COMMENT '',
    `failure_mode` STRING COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `fmea_type` STRING COMMENT '',
    `occurrence_rating` STRING COMMENT '',
    `recommended_action` STRING COMMENT '',
    `rpn` STRING COMMENT '',
    `severity_rating` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_fmea_record PRIMARY KEY(`fmea_record_id`)
) COMMENT 'FMEA (Failure Mode and Effects Analysis) record capturing the systematic risk analysis of a design or process. Includes FMEA ID, FMEA type (DFMEA — Design FMEA, PFMEA — Process FMEA), associated part or process, failure mode description, potential effect of failure, severity rating, potential cause, occurrence rating, current controls, detection rating, RPN (Risk Priority Number), recommended actions, responsible engineer, and completion date. Managed per IATF 16949 and AIAG-VDA FMEA methodology.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`dvp_plan` (
    `dvp_plan_id` BIGINT COMMENT '',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.project. Business justification: DVP plans are created and managed within the context of specific engineering projects. This FK links each DVP plan to its governing project, enabling project-level test planning oversight and resource',
    `vehicle_program_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `effective_date` DATE COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `owner_name` STRING COMMENT '',
    `plan_name` STRING COMMENT '',
    `plan_number` STRING COMMENT '',
    `plan_status` STRING COMMENT '',
    `revision_level` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `test_bench_data_available_flag` BOOLEAN COMMENT 'Whether test bench measurement data is available for tests in this DVP plan.',
    `tests_completed` STRING COMMENT '',
    `tests_passed` STRING COMMENT '',
    `total_tests_planned` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_dvp_plan PRIMARY KEY(`dvp_plan_id`)
) COMMENT 'Design Verification Plan (DVP) record defining the complete test plan for validating a vehicle system or component against its design specifications. Captures DVP ID, plan title, associated part or system, program reference, total test count, completion percentage, responsible engineer, approval status, linked specification, and planned vs. actual completion dates. Acts as the master test planning document that governs all validation_test records for a given scope.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`homologation_requirement` (
    `homologation_requirement_id` BIGINT COMMENT '',
    `dvp_plan_id` BIGINT COMMENT 'Foreign key linking to engineering.dvp_plan. Business justification: Homologation requirements are addressed through specific DVP plans. This FK links each regulatory requirement to the DVP plan that covers it, enabling regulatory coverage tracking and type-approval re',
    `vehicle_program_id` BIGINT COMMENT '',
    `compliance_status` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `market_region` STRING COMMENT '',
    `regulation_reference` STRING COMMENT '',
    `requirement_code` STRING COMMENT '',
    `requirement_name` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `test_method` STRING COMMENT '',
    `threshold_value` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_homologation_requirement PRIMARY KEY(`homologation_requirement_id`)
) COMMENT 'Homologation and regulatory requirement record capturing the specific regulatory standards and type-approval requirements that a vehicle or component must satisfy for a target market. Includes requirement ID, regulation name (FMVSS, ECE-R, CARB, Euro NCAP, WLTP, EPA), regulation number, market/region applicability, requirement description, compliance method (test, calculation, declaration), linked validation tests, compliance status, and submission deadline. Supports regulatory compliance and homologation engineering activities.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` (
    `ecu_specification_id` BIGINT COMMENT '',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: ECU specifications are derived from and must comply with higher-level design specifications (system architecture specs, functional safety specs). This FK establishes the requirements traceability chai',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: ECU specifications correspond to physical ECU hardware parts managed in the engineering BOM. This FK links the ECU spec to its part master record, enabling hardware-software co-management and BOM inte',
    `vehicle_program_id` BIGINT COMMENT '',
    `communication_protocol` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `ecu_name` STRING COMMENT '',
    `ecu_type` STRING COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `functional_safety_asil` STRING COMMENT '',
    `hardware_version` STRING COMMENT '',
    `operating_voltage_range` STRING COMMENT '',
    `ota_capable_flag` BOOLEAN COMMENT '',
    `power_consumption_watts` DECIMAL(18,2) COMMENT '',
    `software_version` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `spec_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_ecu_specification PRIMARY KEY(`ecu_specification_id`)
) COMMENT 'ECU (Electronic Control Unit) software and hardware specification record capturing the technical definition of an automotive electronic control module. Includes ECU ID, ECU name, ECU type (engine control, transmission, ADAS, body control, battery management), hardware part number, software version, calibration dataset reference, communication protocol (CAN, LIN, Ethernet, FlexRay), functional safety level (ASIL rating per ISO 26262), supplier reference, and release status. Critical for EV, HEV, and ADAS program engineering.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` (
    `powertrain_spec_id` BIGINT COMMENT '',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Powertrain specifications are derived from vehicle-level design specifications (performance targets, emissions targets). This FK establishes the requirements cascade from vehicle design spec to powert',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Powertrain specifications correspond to powertrain assembly parts (engine, transmission, e-motor) in the engineering BOM. This FK links the powertrain spec to its part master record, enabling BOM-to-s',
    `vehicle_program_id` BIGINT COMMENT '',
    `battery_capacity_kwh` DECIMAL(18,2) COMMENT '',
    `co2_target_g_per_km` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `drive_type` STRING COMMENT '',
    `electric_range_km` STRING COMMENT '',
    `engine_displacement_cc` STRING COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `fuel_type` STRING COMMENT '',
    `max_power_kw` DECIMAL(18,2) COMMENT '',
    `max_torque_nm` DECIMAL(18,2) COMMENT '',
    `powertrain_type` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `spec_status` STRING COMMENT '',
    `transmission_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_powertrain_spec PRIMARY KEY(`powertrain_spec_id`)
) COMMENT 'Powertrain engineering specification record capturing the technical definition of an ICE, HEV, PHEV, or EV powertrain system. Includes spec ID, powertrain type (ICE, HEV, PHEV, BEV, FCEV), engine or motor displacement/power rating, torque output, transmission type, battery capacity (kWh) for electrified variants, fuel type, emissions standard compliance (Euro 6, EPA Tier 3, CARB LEV III), WLTP/EPA range rating, thermal management approach, and target program applicability. Supports R&D and powertrain engineering teams.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`weight_report` (
    `weight_report_id` BIGINT COMMENT '',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: Weight reports are produced by specific engineering teams (e.g., body-in-white team, chassis team) responsible for their system weight budgets. This FK enables weight accountability tracking per team ',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Weight reports can be generated at the part or assembly level, not just at the vehicle program level. This FK links weight reports to specific parts, enabling granular mass budget tracking and part-le',
    `vehicle_program_id` BIGINT COMMENT '',
    `actual_weight_kg` DECIMAL(18,2) COMMENT '',
    `compliance_flag` BOOLEAN COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `report_date` DATE COMMENT '',
    `report_status` STRING COMMENT '',
    `report_version` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `target_weight_kg` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `variance_kg` DECIMAL(18,2) COMMENT '',
    `weight_category` STRING COMMENT '',
    CONSTRAINT pk_weight_report PRIMARY KEY(`weight_report_id`)
) COMMENT 'Vehicle or component weight tracking record capturing mass budget allocations and actual measured weights throughout the development program. Includes report ID, program reference, reporting date, system or component scope, target weight (kg), current estimated weight, actual measured weight, weight delta vs. target, weight reduction actions, responsible engineer, and report status. Supports mass management — a critical engineering discipline for fuel economy (CAFE), EV range, and performance targets.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`action` (
    `action_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Engineering action items frequently arise from engineering change orders (ECO/ECN). This FK links each action to the triggering change, enabling change impact tracking and ensuring all required action',
    `design_review_id` BIGINT COMMENT 'Foreign key linking to engineering.design_review. Business justification: Design reviews generate action items (action_items_count field on design_review). This FK links each action to the design review that generated it, enabling tracking of design review closure criteria ',
    `field_quality_investigation_id` BIGINT COMMENT 'FK to field quality investigation that triggered this action',
    `fmea_record_id` BIGINT COMMENT 'Foreign key linking to engineering.fmea_record. Business justification: Engineering actions arise from FMEA recommended actions (action_status field on fmea_record). This FK links the action item to the FMEA record that generated it, enabling closed-loop FMEA action track',
    `vehicle_program_id` BIGINT COMMENT '',
    `action_number` STRING COMMENT '',
    `action_status` STRING COMMENT '',
    `action_type` STRING COMMENT '',
    `completion_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `action_description` STRING COMMENT '',
    `due_date` DATE COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `priority` STRING COMMENT '',
    `source_reference` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_action PRIMARY KEY(`action_id`)
) COMMENT 'Engineering action item record capturing a specific task or corrective action arising from a design review, test failure, FMEA finding, or milestone gate review. Includes action ID, action title, action type (design change, test rerun, analysis, supplier engagement), source event (test failure, FMEA, gate review), assigned engineer, due date, priority, completion status, resolution description, and linked parent record (validation test, FMEA, milestone). Enables systematic tracking of open engineering issues to closure.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`design_review` (
    `design_review_id` BIGINT COMMENT '',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: Design reviews are conducted by specific engineering teams. This FK links each design review to the team that owns it, enabling team-level design review scheduling and action item tracking.',
    `milestone_id` BIGINT COMMENT '',
    `vehicle_program_id` BIGINT COMMENT '',
    `action_items_count` STRING COMMENT '',
    `attendees` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `notes` STRING COMMENT '',
    `outcome` STRING COMMENT '',
    `review_date` DATE COMMENT '',
    `review_name` STRING COMMENT '',
    `review_status` STRING COMMENT '',
    `review_type` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_design_review PRIMARY KEY(`design_review_id`)
) COMMENT 'Formal design review event record capturing structured peer reviews of engineering designs at key program stages. Includes review ID, review type (PDR — Preliminary Design Review, CDR — Critical Design Review, system design review, supplier design review), program reference, review date, reviewed system or component, review chair, attendees count, findings count, open actions count, review outcome (approved, conditional, rejected), and minutes document reference. Supports APQP and PLM governance processes.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`material_specification` (
    `material_specification_id` BIGINT COMMENT '',
    `material_id` BIGINT COMMENT '',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Material specifications define the approved materials for specific parts. This FK links each material specification to the part it applies to, enabling part-level material compliance tracking (REACH, ',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `grade` STRING COMMENT '',
    `material_type` STRING COMMENT '',
    `regulatory_compliance` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `spec_name` STRING COMMENT '',
    `spec_number` STRING COMMENT '',
    `spec_status` STRING COMMENT '',
    `tensile_strength_mpa` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `yield_strength_mpa` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_material_specification PRIMARY KEY(`material_specification_id`)
) COMMENT 'Engineering material specification record defining the approved materials for use in vehicle components. Captures spec ID, material name, material class (steel, aluminum, polymer, composite, glass), grade or alloy designation, mechanical properties (tensile strength, yield strength, elongation), thermal properties, density, surface treatment requirements, applicable standards (SAE, ASTM, DIN), REACH/RoHS compliance status, approved supplier list, and application restrictions. Supports part design and supplier qualification.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`configuration_rule` (
    `configuration_rule_id` BIGINT COMMENT '',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Configuration rules constrain specific parts and options in the vehicle configurator (e.g., if part A is selected, part B is mandatory). This FK links configuration rules to the specific parts they ',
    `vehicle_program_id` BIGINT COMMENT '',
    `constraint_type` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `effective_date` DATE COMMENT '',
    `expiry_date` DATE COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `is_active` BOOLEAN COMMENT '',
    `rule_code` STRING COMMENT '',
    `rule_expression` STRING COMMENT '',
    `rule_name` STRING COMMENT '',
    `rule_type` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_configuration_rule PRIMARY KEY(`configuration_rule_id`)
) COMMENT 'Vehicle configuration rule record defining the valid combinations of options, packages, and features for a vehicle program. Captures rule ID, rule type (include, exclude, requires, incompatible), applicable program and model year, option code A, option code B, rule description, market applicability, effective date, and rule source (commercial, engineering, regulatory). Managed in ENOVIA Configuration Management and supports order-to-build feasibility validation and BOM variant management.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`ota_release` (
    `ota_release_id` BIGINT COMMENT '',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: OTA software releases are triggered by engineering change orders (ECO/ECN) for software modifications. This FK links the OTA release to the engineering change that authorized it, enabling change-to-re',
    `ecu_specification_id` BIGINT COMMENT '',
    `engineering_document_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_document. Business justification: OTA software releases are accompanied by engineering documents (release notes, validation reports, regulatory compliance documents). This FK links the OTA release to its primary engineering document, ',
    `ml_model_metadata_id` BIGINT COMMENT 'Foreign key linking to engineering.ml_model_metadata. Business justification: OTA releases can include updates to AI/ML models deployed in the vehicle (ADAS perception models, predictive maintenance models). This FK links the OTA release to the ML model metadata it deploys, ena',
    `vehicle_program_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `package_size_mb` DECIMAL(18,2) COMMENT '',
    `regulatory_compliance_flag` BOOLEAN COMMENT '',
    `release_date` DATE COMMENT '',
    `release_name` STRING COMMENT '',
    `release_notes` STRING COMMENT '',
    `release_status` STRING COMMENT '',
    `release_type` STRING COMMENT '',
    `release_version` STRING COMMENT '',
    `rollback_version` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `target_ecu_list` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_ota_release PRIMARY KEY(`ota_release_id`)
) COMMENT 'OTA (Over-the-Air) software release engineering record capturing the definition and approval of a software update package for connected vehicle ECUs. Includes release ID, release version, target ECU or system, software delta description, release type (feature, security patch, calibration, regulatory), compatible vehicle configurations (VIN range or model/MY), validation test references, cybersecurity assessment status, rollout strategy, and release approval date. Bridges engineering and connected mobility domains for software-defined vehicle programs.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` (
    `engineering_document_id` BIGINT COMMENT '',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Engineering documents are created or revised as part of engineering change orders. This FK links each document to the ECO/ECN that triggered its creation or revision, enabling change package completen',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Engineering documents (drawings, test reports, analysis reports) support specific design specifications. This FK links documents to the spec they implement or verify, enabling requirements-to-document',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: Engineering documents are owned and authored by specific engineering teams. The author_name text field is a denormalized reference; replacing with engineering_team_id enables proper document ownership',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Engineering documents (drawings, material certs, inspection reports) are associated with specific parts. This FK links documents to the part they describe, enabling complete document package retrieval',
    `vehicle_program_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `document_number` STRING COMMENT '',
    `document_status` STRING COMMENT '',
    `document_title` STRING COMMENT '',
    `document_type` STRING COMMENT '',
    `effective_date` DATE COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `file_format` STRING COMMENT '',
    `file_url` STRING COMMENT '',
    `revision_level` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_engineering_document PRIMARY KEY(`engineering_document_id`)
) COMMENT 'Engineering document record serving as the metadata catalog for all controlled engineering documents managed in the PLM system. Includes document ID, document number, title, document type (drawing, specification, test report, analysis report, FMEA, DVP, meeting minutes), revision level, author, approval status, release date, associated program and part references, document format, storage location reference, and retention policy. Supports document control per IATF 16949 and ISO 9001 requirements. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` (
    `engineering_adas_feature_id` BIGINT COMMENT '',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: ADAS features are defined by and must comply with design specifications (functional requirements, safety requirements, performance targets). This FK establishes requirements traceability from design s',
    `dvp_plan_id` BIGINT COMMENT 'Foreign key linking to engineering.dvp_plan. Business justification: ADAS features require extensive validation through DVP plans (simulation, HIL, track testing, public road testing). This FK links each ADAS feature to its DVP plan, enabling validation coverage tracki',
    `ecu_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.ecu_specification. Business justification: ADAS features are hosted on specific ECUs (domain controllers, ADAS compute platforms). This FK links each ADAS feature to its primary ECU specification, enabling hardware-software co-design tracking ',
    `ml_model_metadata_id` BIGINT COMMENT 'FK to AI/ML perception model for this ADAS feature',
    `vehicle_program_id` BIGINT COMMENT '',
    `ad_scenario_count` STRING COMMENT 'Number of autonomous driving scenarios in the library for this ADAS feature.',
    `adas_level` STRING COMMENT '',
    `camera_count` STRING COMMENT 'Number of cameras required',
    `compute_platform` STRING COMMENT 'Compute platform required (e.g., NVIDIA Drive, Mobileye EyeQ)',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `engineering_adas_feature_description` STRING COMMENT 'Description of the entity',
    `development_status` STRING COMMENT '',
    `feature_code` STRING COMMENT '',
    `feature_name` STRING COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `field_test_miles` DECIMAL(18,2) COMMENT 'Total field test miles accumulated',
    `functional_safety_status` STRING COMMENT 'Functional safety assessment status',
    `lidar_required_flag` BOOLEAN COMMENT 'Whether LiDAR sensor is required',
    `radar_count` STRING COMMENT 'Number of radar sensors required',
    `regulatory_approval_status` STRING COMMENT '',
    `sae_level` STRING COMMENT '',
    `safety_integrity_level` STRING COMMENT 'ASIL rating (A, B, C, D) per ISO 26262',
    `scenario_library_ref` STRING COMMENT 'Reference to autonomous driving scenario library',
    `sensor_fusion_algorithm_version` STRING COMMENT 'Version of the sensor fusion algorithm',
    `sensor_suite_requirements` STRING COMMENT '',
    `simulation_pass_rate_pct` DECIMAL(18,2) COMMENT 'Simulation test pass rate percentage',
    `software_module` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `target_release_date` DATE COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `validation_status` STRING COMMENT '',
    CONSTRAINT pk_engineering_adas_feature PRIMARY KEY(`engineering_adas_feature_id`)
) COMMENT 'ADAS (Advanced Driver Assistance Systems) feature engineering record capturing the definition, requirements, and validation status of an autonomous or assisted driving feature. Includes feature ID, feature name, SAE automation level (L1–L5), feature category (ACC, AEB, LKA, parking assist, highway pilot), applicable program, sensor suite requirements (camera, radar, lidar, ultrasonic), ODD (Operational Design Domain) definition, functional safety ASIL rating, regulatory approval status, and SOP readiness. Supports autonomous driving R&D programs.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`cost_target` (
    `cost_target_id` DECIMAL(18,2) COMMENT '',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: Cost targets are assigned to and owned by specific engineering teams responsible for achieving design-to-cost objectives. This FK enables cost target accountability tracking per team and supports prog',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Cost targets are set at the part or system level within a vehicle program. This FK links each cost target to the specific part it governs, enabling part-level cost tracking and variance analysis again',
    `vehicle_program_id` BIGINT COMMENT '',
    `actual_amount` DECIMAL(18,2) COMMENT '',
    `cost_category` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `effective_date` DATE COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `notes` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `target_amount` DECIMAL(18,2) COMMENT '',
    `target_status` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `variance_amount` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_cost_target PRIMARY KEY(`cost_target_id`)
) COMMENT 'Engineering cost target record capturing the design-to-cost objectives assigned to vehicle systems, subsystems, or components during the development program. Includes target ID, program reference, system or component scope, target cost (material cost, manufacturing cost, total cost), current estimated cost, cost gap vs. target, cost reduction ideas count, responsible engineer, target freeze date, and approval status. Supports design-to-cost (DTC) and value engineering disciplines critical to program profitability.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_component` (
    `engineering_bom_component_id` BIGINT COMMENT '',
    `engineering_bom_line_id` BIGINT COMMENT '',
    `part_master_id` BIGINT COMMENT '',
    `component_type` STRING COMMENT '',
    `cost_per_unit` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `is_safety_critical` BOOLEAN COMMENT '',
    `lead_time_days` STRING COMMENT '',
    `material_code` STRING COMMENT '',
    `quantity` DECIMAL(18,2) COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `supplier_part_number` STRING COMMENT '',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `weight_kg` DECIMAL(18,2) COMMENT '',
    CONSTRAINT pk_engineering_bom_component PRIMARY KEY(`engineering_bom_component_id`)
) COMMENT 'This association product represents the BOM Component relationship between part_master and production_bom. It captures the quantity of the part per vehicle, the unit of measure, the type of component, and the installation sequence within the manufacturing BOM.. Existence Justification: A part_master can be used in many production_bom records (different vehicle models, configurations) and each production_bom contains many part_master entries. The link is managed as BOM component lines that capture quantity, unit of measure, component type, and installation sequence. This relationship is actively created, updated, and deleted by engineering/manufacturing teams as part of the BOM management process.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`dealer_part_inventory` (
    `dealer_part_inventory_id` BIGINT COMMENT '',
    `dealership_id` BIGINT COMMENT '',
    `part_master_id` BIGINT COMMENT '',
    `average_daily_demand` DECIMAL(18,2) COMMENT '',
    `bin_location` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `days_of_supply` STRING COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `inventory_status` STRING COMMENT '',
    `last_count_date` DATE COMMENT '',
    `last_replenishment_date` DATE COMMENT '',
    `quantity_on_hand` STRING COMMENT '',
    `reorder_point` STRING COMMENT '',
    `reorder_quantity` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `unit_cost` DECIMAL(18,2) COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_dealer_part_inventory PRIMARY KEY(`dealer_part_inventory_id`)
) COMMENT 'This association product represents the stocking relationship between engineering part_master records and dealer locations. It captures per‑dealer part quantities, pricing, reorder thresholds, and lead‑time information that are specific to each part‑dealership pairing.. Existence Justification: Dealerships maintain inventory of engineering parts; a single part can be stocked at many dealership locations and each dealership stocks many different parts. The stocking relationship is actively managed through inventory records that capture quantities, pricing, and lead‑time per dealer‑part combination.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`engineering_team` (
    `engineering_team_id` BIGINT COMMENT '',
    `employee_id` BIGINT COMMENT '',
    `vehicle_program_id` BIGINT COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `is_active` BOOLEAN COMMENT '',
    `member_count` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `specialization` STRING COMMENT '',
    `team_code` STRING COMMENT '',
    `team_name` STRING COMMENT '',
    `team_type` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_engineering_team PRIMARY KEY(`engineering_team_id`)
) COMMENT 'Master reference table for engineering_team. Referenced by team_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`material` (
    `material_id` BIGINT COMMENT '',
    `commodity_group_id` BIGINT COMMENT 'FK to the supply commodity group for procurement and hedging context.',
    `base_unit_of_measure` STRING COMMENT '',
    `commodity_hedging_eligible_flag` BOOLEAN COMMENT 'Whether this material is eligible for commodity price hedging.',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `density_kg_per_m3` DECIMAL(18,2) COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `is_hazardous` BOOLEAN COMMENT '',
    `lifecycle_status` STRING COMMENT '',
    `material_group` STRING COMMENT '',
    `material_number` STRING COMMENT '',
    `material_type` STRING COMMENT '',
    `material_name` STRING COMMENT '',
    `price_index_code` DECIMAL(18,2) COMMENT 'Reference price index code for commodity price tracking.',
    `reach_compliant_flag` BOOLEAN COMMENT '',
    `rohs_compliant_flag` BOOLEAN COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_material PRIMARY KEY(`material_id`)
) COMMENT 'Master reference table for material. Referenced by material_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`packaging_specification` (
    `packaging_specification_id` BIGINT COMMENT '',
    `part_master_id` BIGINT COMMENT '',
    `container_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `dimensions_lxwxh_mm` STRING COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `is_returnable` BOOLEAN COMMENT '',
    `material_type` STRING COMMENT '',
    `max_weight_kg` DECIMAL(18,2) COMMENT '',
    `packaging_type` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `spec_status` STRING COMMENT '',
    `stacking_limit` STRING COMMENT '',
    `units_per_container` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_packaging_specification PRIMARY KEY(`packaging_specification_id`)
) COMMENT 'Master reference table for packaging_specification. Referenced by packaging_specification_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`project` (
    `project_id` BIGINT COMMENT '',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: Engineering projects are executed by specific engineering teams. This FK links each project to its primary owning team, enabling team workload and project portfolio management. Note: M:N project-team ',
    `employee_id` BIGINT COMMENT '',
    `vehicle_program_id` BIGINT COMMENT '',
    `actual_cost_amount` DECIMAL(18,2) COMMENT '',
    `actual_end_date` DATE COMMENT '',
    `actual_start_date` DATE COMMENT '',
    `budget_amount` DECIMAL(18,2) COMMENT '',
    `project_code` STRING COMMENT '',
    `completion_pct` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `project_name` STRING COMMENT '',
    `planned_end_date` DATE COMMENT '',
    `planned_start_date` DATE COMMENT '',
    `project_status` STRING COMMENT '',
    `project_type` STRING COMMENT '',
    `source_system_code` STRING COMMENT 'Identifier of the originating system of record (e.g., PLM, SAP, MES)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_project PRIMARY KEY(`project_id`)
) COMMENT 'Master reference table for project. Referenced by project_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`patent_record` (
    `patent_record_id` BIGINT COMMENT 'Unique identifier for the patent record',
    `patent_family_id` BIGINT COMMENT 'Identifier grouping related patents across jurisdictions',
    `vehicle_program_id` BIGINT COMMENT 'FK to the vehicle program this patent relates to',
    `abstract_text` STRING COMMENT 'Brief abstract or summary of the patent claims',
    `annual_maintenance_fee` DECIMAL(18,2) COMMENT 'Annual fee to maintain the patent in force',
    `assignee_organization` STRING COMMENT 'Organization that owns the patent rights',
    `claims_count` STRING COMMENT 'Number of claims in the patent application',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency of the maintenance fee',
    `data_governance_ref` STRING COMMENT 'Reference to data catalog entry for lineage and governance',
    `document_url` STRING COMMENT 'Link to the patent document in the PLM/IP system',
    `expiry_date` DATE COMMENT 'Date the patent protection expires',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `filing_date` DATE COMMENT 'Date the patent application was filed',
    `grant_date` DATE COMMENT 'Date the patent was granted',
    `inventor_names` STRING COMMENT 'Names of the inventors listed on the patent',
    `jurisdiction` STRING COMMENT 'Country or region where patent is filed (e.g., US, EU, CN, JP)',
    `licensing_status` STRING COMMENT 'Whether the patent is licensed out, licensed in, or internal only',
    `part_master_id` BIGINT COMMENT 'FK to the part this patent protects, if applicable',
    `patent_number` STRING COMMENT 'Official patent application or grant number',
    `patent_status` STRING COMMENT 'Current status: draft, filed, pending, granted, expired, abandoned',
    `patent_title` STRING COMMENT 'Title of the patent filing',
    `patent_type` STRING COMMENT 'Type of IP protection: utility, design, provisional, trade secret',
    `priority_date` DATE COMMENT 'Earliest priority date for the patent family',
    `technology_area` STRING COMMENT 'Technology domain: powertrain, ADAS, battery, materials, connectivity, etc.',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_patent_record PRIMARY KEY(`patent_record_id`)
) COMMENT 'Tracks patents and intellectual property filings associated with engineering innovations, designs, and inventions across vehicle programs.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` (
    `ml_model_metadata_id` BIGINT COMMENT 'Unique identifier for the ML model metadata record',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: ML models are owned and maintained by specific engineering teams (e.g., ADAS team, predictive quality team). The existing owner_team text field is a denormalized reference to the engineering team. Add',
    `vehicle_program_id` BIGINT COMMENT 'FK to the vehicle program this model supports',
    `accuracy_metric` DECIMAL(18,2) COMMENT 'Primary accuracy metric value (e.g., F1, RMSE, mAP)',
    `accuracy_metric_name` STRING COMMENT 'Name of the accuracy metric reported',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data catalog entry for lineage and governance',
    `deployment_status` STRING COMMENT 'Status: development, staging, production, retired',
    `deployment_target` STRING COMMENT 'Where the model runs: cloud, edge, ecu, hpc',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `framework` STRING COMMENT 'ML framework used: TensorFlow, PyTorch, ONNX, Scikit-learn',
    `inference_latency_ms` DECIMAL(18,2) COMMENT 'Average inference latency in milliseconds',
    `input_features_count` STRING COMMENT 'Number of input features the model consumes',
    `last_retrained_timestamp` TIMESTAMP COMMENT 'When the model was last retrained',
    `model_artifact_url` STRING COMMENT 'Storage location of the serialized model artifact',
    `model_name` STRING COMMENT 'Human-readable name of the ML model',
    `model_type` STRING COMMENT 'Type: classification, regression, object_detection, surrogate, reinforcement_learning',
    `model_version` STRING COMMENT 'Semantic version of the deployed model',
    `training_dataset_ref` STRING COMMENT 'Reference/URI to the training dataset in the data lake',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `use_case` STRING COMMENT 'Application area: predictive_quality, cae_surrogate, adas_perception, nvh_prediction, defect_detection',
    CONSTRAINT pk_ml_model_metadata PRIMARY KEY(`ml_model_metadata_id`)
) COMMENT 'Metadata registry for AI/ML models used in engineering (predictive quality, CAE surrogates, ADAS perception, computer vision inspection). Supports Industry 4.0 digitalization.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`test_sample` (
    `test_sample_id` BIGINT COMMENT 'Primary key for test_sample',
    `dvp_plan_id` BIGINT COMMENT 'Foreign key linking to engineering.dvp_plan. Business justification: Test samples are allocated to specific DVP plans for testing. The existing dvp_reference text field is a denormalized reference to the DVP plan. Adding dvp_plan_id FK normalizes this relationship. dvp',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Test samples are physical instances of engineering parts. The existing part_number and drawing_number text fields are denormalized references to part_master attributes. Adding part_master_id FK normal',
    `quality_ppap_submission_id` BIGINT COMMENT 'Reference to the PPAP submission for which this sample serves as evidence. Connects sample-level test data to the formal supplier approval process.',
    `prototype_build_id` BIGINT COMMENT 'Foreign key linking to engineering.prototype_build. Business justification: Test samples are extracted from or associated with specific prototype builds. This FK links each sample to the prototype build it came from, enabling build-to-sample traceability and supporting protot',
    `test_program_id` BIGINT COMMENT 'Reference to the engineering test program or validation plan under which this sample is being evaluated. Links the sample to the broader test execution context.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Test samples belong to specific vehicle programs. The existing program_code text field is a denormalized reference to vehicle_program. Adding vehicle_program_id FK normalizes this relationship and ena',
    `parent_test_sample_id` BIGINT COMMENT 'Self-referencing FK on test_sample (parent_test_sample_id)',
    `accreditation_standard` STRING COMMENT 'Accreditation standard under which the test facility is certified to perform tests on this sample (e.g., ISO/IEC 17025:2017, A2LA). Required for regulatory submissions and customer-approved source testing.',
    `adas_related_flag` BOOLEAN COMMENT 'Indicates whether this test sample is associated with an ADAS feature (e.g., radar sensor, camera module, LiDAR unit), triggering additional ISO 21448 SOTIF and ISO 26262 validation requirements.',
    `apqp_phase` STRING COMMENT 'APQP phase (1–5) associated with this sample, per the AIAG APQP framework: Phase 1=Plan & Define, Phase 2=Product Design & Development, Phase 3=Process Design & Development, Phase 4=Product & Process Validation, Phase 5=Launch.',
    `batch_number` STRING COMMENT 'Manufacturers batch or lot number assigned to the group of samples produced in the same production run. Essential for traceability in the event of a quality escape or recall.',
    `chain_of_custody_reference` STRING COMMENT 'Unique identifier for the chain-of-custody record tracking the samples handling history from production through testing and final disposition. Required for legal and regulatory submissions.',
    `condition_on_receipt` STRING COMMENT 'Assessment of the samples physical condition at the time of receipt at the test facility. Non-conforming or damaged samples are quarantined pending disposition decision.',
    `cost_center_code` STRING COMMENT 'SAP cost center code to which the procurement and testing costs of this sample are charged. Enables engineering program cost tracking and budget variance analysis.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the sample was manufactured. Required for customs declarations, trade compliance, and supply chain risk assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test sample record was first created in the engineering data system. Provides audit trail for data governance and PLM integration reconciliation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the unit cost (e.g., USD, EUR, GBP). Required for multi-currency program cost consolidation.',
    `destruction_required_flag` BOOLEAN COMMENT 'Indicates whether the sample must be destroyed as part of the test protocol (e.g., crash test, burst pressure test, fatigue-to-failure). Drives sample quantity planning and disposal procedures.',
    `eco_number` STRING COMMENT 'Engineering Change Order number from the PLM system (Teamcenter/ENOVIA) that authorized the design change reflected in this sample. Enables change impact traceability.',
    `emissions_related_flag` BOOLEAN COMMENT 'Indicates whether this sample is part of an emissions-related system (e.g., catalytic converter, EGR valve, OBD sensor), requiring compliance with EPA, Euro 6/7, or CARB emissions regulations.',
    `expiry_date` DATE COMMENT 'Date after which the test sample is no longer considered valid for testing, typically due to material aging, shelf-life limits, or supersession by a newer revision. Null if no expiry applies.',
    `fmea_reference` STRING COMMENT 'Reference to the Design FMEA (DFMEA) document number that identifies the failure modes this sample is intended to validate or mitigate. Supports risk-based test prioritization.',
    `hazmat_classification` STRING COMMENT 'UN hazardous material classification code if the sample contains regulated substances (e.g., lithium battery cells, fuel, refrigerants). Governs packaging, labeling, and transport requirements.',
    `homologation_required_flag` BOOLEAN COMMENT 'Indicates whether test results from this sample are required as evidence for vehicle type approval or component homologation submissions to a regulatory authority.',
    `hs_tariff_code` STRING COMMENT 'Harmonized System (HS) tariff classification code for the sample, required for import/export customs declarations when samples are shipped across international borders.',
    `manufacturing_plant_code` STRING COMMENT 'Code identifying the manufacturing plant or facility where the test sample was produced. Used to correlate test results with production location for quality and process capability analysis.',
    `material_specification` STRING COMMENT 'Material specification or grade code (e.g., SAE 1045, AA6061-T6, PA66-GF30) defining the raw material composition of the test sample, used for material traceability and failure analysis.',
    `non_conformance_number` STRING COMMENT 'Reference number of the Non-Conformance Report (NCR) raised if the sample was found to be non-conforming on receipt or during testing. Links to the quality corrective action process.',
    `notes` STRING COMMENT 'Free-text field for engineering notes, special handling instructions, or observations recorded by the responsible engineer regarding this test sample. Not used for structured data.',
    `owning_department` STRING COMMENT 'Engineering department or cost center that owns and is accountable for this test sample (e.g., Chassis Engineering, Powertrain NVH, Body Structures). Used for resource allocation and cost tracking.',
    `part_revision` STRING COMMENT 'Engineering revision or release level of the part at the time the sample was produced (e.g., A, B1, 03). Critical for ensuring test results are attributed to the correct design iteration.',
    `production_date` DATE COMMENT 'Date on which the test sample was physically manufactured or assembled. Used for age-related degradation analysis and correlation with production process parameters.',
    `quantity_available` STRING COMMENT 'Current count of sample units available for testing, accounting for units already consumed, destroyed in destructive tests, or allocated to other test programs.',
    `quantity_received` STRING COMMENT 'Number of individual sample units received in the shipment or batch. Supports sample allocation planning across multiple concurrent test programs.',
    `reach_svhc_flag` BOOLEAN COMMENT 'Indicates whether the sample contains any Substance of Very High Concern (SVHC) as defined under EU REACH Regulation (EC) No 1907/2006. Triggers mandatory disclosure and potential substitution requirements.',
    `receipt_date` DATE COMMENT 'Date the test sample was received at the engineering test facility or laboratory. Marks the start of the sample custody chain and is used for scheduling and lead-time tracking.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether testing of this sample is mandated by a regulatory authority (e.g., UNECE, EPA, NHTSA, EU type approval) as opposed to being an internal engineering validation requirement.',
    `responsible_engineer` STRING COMMENT 'Name or employee ID of the lead engineer responsible for this test sample and its associated test activities. Used for accountability, escalation, and PLM workflow routing.',
    `rohs_compliant_flag` BOOLEAN COMMENT 'Indicates whether the sample complies with EU RoHS Directive 2011/65/EU restricting the use of hazardous substances (lead, mercury, cadmium, etc.) in electrical and electronic equipment.',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether this sample is classified as a safety-critical component (e.g., braking, steering, airbag, fuel system) requiring enhanced traceability, witness testing, and regulatory sign-off.',
    `sample_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the physical or virtual test sample, used in PLM systems such as Siemens Teamcenter and ENOVIA for traceability across engineering programs.',
    `sample_name` STRING COMMENT 'Human-readable descriptive name of the test sample, typically reflecting the component, assembly, or system under evaluation (e.g., Front Suspension Knuckle – Prototype A).',
    `sample_status` STRING COMMENT 'Current lifecycle status of the test sample, tracking its progression from initial request through preparation, active testing, hold, completion, and final disposition or archival. [ENUM-REF-CANDIDATE: requested|prepared|in-test|on-hold|completed|disposed|archived — promote to reference product]',
    `sample_type` STRING COMMENT 'Classification of the sample by its engineering maturity stage. Prototype samples are early-stage; production-intent samples mirror final manufacturing intent; reference samples are retained as benchmarks. [ENUM-REF-CANDIDATE: prototype|pre-production|production-intent|validation|reference|destructive — promote to reference product if additional types are needed]',
    `serial_number` STRING COMMENT 'Unique serial number assigned to an individual sample unit, enabling unit-level traceability for high-value or safety-critical components where batch-level traceability is insufficient.',
    `storage_condition` STRING COMMENT 'Required environmental storage condition for the sample to maintain its integrity prior to testing. Ensures samples are not degraded by improper storage. [ENUM-REF-CANDIDATE: ambient|temperature-controlled|humidity-controlled|cleanroom|frozen|hazmat — promote to reference product]',
    `storage_location` STRING COMMENT 'Physical storage location identifier within the test facility (e.g., rack, shelf, room, or warehouse bin code) where the sample is currently stored. Supports sample retrieval and inventory management.',
    `supplier_code` STRING COMMENT 'Unique supplier identifier for the organization that manufactured or provided the test sample. Enables traceability back to the supply chain for PPAP and corrective action purposes.',
    `test_category` STRING COMMENT 'Primary engineering test discipline category applied to this sample. Drives test method selection, equipment requirements, and specialist assignment. [ENUM-REF-CANDIDATE: mechanical|thermal|NVH|EMC|corrosion|fatigue|chemical|dimensional|functional — promote to reference product]',
    `test_facility_code` STRING COMMENT 'Code identifying the internal or external test facility (laboratory, proving ground, or test rig) where the sample is being or will be tested. Supports capacity planning and accreditation tracking.',
    `test_phase` STRING COMMENT 'Engineering development phase during which this sample is being tested, aligned with the APQP (Advanced Product Quality Planning) gate structure. [ENUM-REF-CANDIDATE: concept|feasibility|design-validation|process-validation|production-validation|PPAP — promote to reference product]',
    `test_standard` STRING COMMENT 'Governing test standard or specification number (e.g., SAE J2380, ISO 16750-3, ASTM E8) that defines the test method, acceptance criteria, and reporting requirements for this sample.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Procurement cost per individual sample unit in the transaction currency. Used for engineering program cost tracking and make-vs-buy analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test sample record. Used for incremental data pipeline processing and change detection in the Databricks Silver Layer.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Measured mass of the test sample in kilograms at the time of receipt or preparation. Used for mass budget compliance, shipping logistics, and comparison against nominal design weight.',
    CONSTRAINT pk_test_sample PRIMARY KEY(`test_sample_id`)
) COMMENT 'Master reference table for test_sample. Referenced by sample_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`test_bench` (
    `test_bench_id` BIGINT COMMENT 'Primary key for test_bench',
    `digital_twin_id` BIGINT COMMENT 'Identifier linking this test bench to its digital twin model in the simulation or IoT platform. Supports Industry 4.0 predictive maintenance and virtual commissioning use cases.',
    `engineering_team_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_team. Business justification: Test benches are owned and operated by specific engineering teams. The existing owning_department text field is a denormalized reference to the engineering team. Adding engineering_team_id FK normaliz',
    `calibration_reference_test_bench_id` BIGINT COMMENT 'Self-referencing FK on test_bench (calibration_reference_test_bench_id)',
    `adas_validation_capable` BOOLEAN COMMENT 'Indicates whether the test bench is configured to support Advanced Driver Assistance Systems (ADAS) validation, including sensor fusion, camera, radar, and LiDAR signal injection.',
    `annual_capacity_hours` DECIMAL(18,2) COMMENT 'Total planned available hours per year for the test bench after accounting for scheduled maintenance, calibration, and planned downtime. Used for capacity planning and program scheduling.',
    `asset_tag` STRING COMMENT 'Internal fixed-asset tag or barcode label affixed to the test bench for asset register tracking and physical inventory audits.',
    `automation_level` STRING COMMENT 'Degree of automation of the test bench: manual (operator-driven), semi-automated (partial automation with operator oversight), or fully automated (unattended 24/7 operation). Impacts scheduling efficiency and staffing requirements.',
    `bay_number` STRING COMMENT 'Specific bay or cell number within the building where the test bench is installed. Used for precise physical location tracking and scheduling.',
    `bench_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the test bench within the engineering facility. Used in PLM systems (Siemens Teamcenter, ENOVIA) and test management systems to reference the physical or virtual bench.',
    `bench_name` STRING COMMENT 'Human-readable descriptive name of the test bench (e.g., NVH Chassis Dyno Bay 3, Powertrain HIL Bench 12). Used in engineering reports and scheduling systems.',
    `bench_status` STRING COMMENT 'Current operational status of the test bench indicating whether it is available for scheduling, actively in use, undergoing maintenance or calibration, reserved for a specific program, or decommissioned.',
    `bench_type` STRING COMMENT 'Classification of the test bench by its primary testing capability. Examples include engine dynamometer, chassis dynamometer, Hardware-in-the-Loop (HIL), Software-in-the-Loop (SIL), NVH, EMI/EMC, climatic chamber, fatigue rig, crash sled, or endurance bench. [ENUM-REF-CANDIDATE: engine_dyno|chassis_dyno|hil|sil|mil|nvh|emi_emc|climatic|fatigue|crash|endurance|calibration|other — promote to reference product]',
    `building_code` STRING COMMENT 'Identifier of the specific building or laboratory block within the facility where the test bench is physically located. Supports asset management and maintenance routing.',
    `calibration_certificate_number` STRING COMMENT 'Reference number of the most recent calibration certificate issued for the test bench. Provides traceability to the accredited calibration body and measurement standards.',
    `calibration_interval_days` STRING COMMENT 'Defined interval in calendar days between mandatory calibrations of the test bench, as specified by the calibration plan or manufacturer recommendation.',
    `channel_count` STRING COMMENT 'Total number of measurement channels (sensor inputs) available on the test bench data acquisition system. Determines the number of simultaneous parameters that can be monitored during a test run.',
    `commissioning_date` DATE COMMENT 'Date on which the test bench was formally commissioned and accepted into service following installation qualification (IQ) and operational qualification (OQ). Marks the start of the asset lifecycle.',
    `control_system_type` STRING COMMENT 'Type or brand of the automation and control system used to operate the test bench (e.g., AVL PUMA Open, Horiba STARS, National Instruments VeriStand, dSPACE ControlDesk). Used for software compatibility and integration planning.',
    `coolant_flow_rate_lpm` DECIMAL(18,2) COMMENT 'Required coolant water flow rate in litres per minute for the test bench cooling system. Used for facility water usage tracking and ESG sustainability reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test bench master record was first created in the data platform. Used for data lineage, audit trail, and governance purposes.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the hourly rate and cost fields for this test bench (e.g., EUR, USD, GBP).',
    `data_acquisition_system` STRING COMMENT 'Name or type of the data acquisition system (DAS) integrated with the test bench for capturing measurement signals (e.g., HBK QuantumX, National Instruments cDAQ, AVL IndiCom). Relevant for data lineage and IoT sensor data flows.',
    `decommissioning_date` DATE COMMENT 'Date on which the test bench was formally decommissioned and removed from active service. Null if the bench is still in service.',
    `emissions_measurement_capable` BOOLEAN COMMENT 'Indicates whether the test bench is equipped with a certified exhaust emissions measurement system (e.g., CVS dilution tunnel, FTIR analyser) for regulatory homologation testing.',
    `facility_location` STRING COMMENT 'Physical location or site where the test bench is installed (e.g., plant name, building, bay number). Used for resource scheduling and logistics planning.',
    `hil_capable` BOOLEAN COMMENT 'Indicates whether the test bench supports Hardware-in-the-Loop (HIL) simulation, enabling ECU and embedded software validation against real-time vehicle models without a physical vehicle.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Internal charge-back rate per hour for use of the test bench, used for program cost allocation and engineering budget tracking. Expressed in the local facility currency.',
    `iso_accreditation_number` STRING COMMENT 'Accreditation number issued by the national accreditation body (e.g., DAkkS, UKAS, A2LA) confirming the test bench meets ISO 17025 requirements for measurement traceability. Required for regulatory homologation test results.',
    `last_calibration_date` DATE COMMENT 'Date of the most recent calibration performed on the test bench. Critical for ensuring measurement traceability and compliance with ISO 17025 accreditation requirements.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive or corrective maintenance activity performed on the test bench. Used to track maintenance history and schedule future work orders.',
    `maintenance_interval_days` STRING COMMENT 'Defined interval in calendar days between scheduled preventive maintenance activities, as specified in the maintenance plan for this test bench.',
    `manufacturer` STRING COMMENT 'Name of the original equipment manufacturer (OEM) of the test bench hardware (e.g., AVL, Horiba, FEV, MTS Systems). Used for maintenance contracts and spare parts sourcing.',
    `max_power_kw` DECIMAL(18,2) COMMENT 'Maximum power absorption or generation capacity of the test bench in kilowatts. Determines which powertrain configurations and test profiles can be executed on this bench.',
    `max_speed_rpm` DECIMAL(18,2) COMMENT 'Maximum rotational speed in revolutions per minute (RPM) that the test bench can accommodate. Constrains the test profiles and engine/motor configurations that can be tested.',
    `max_torque_nm` DECIMAL(18,2) COMMENT 'Maximum torque capacity of the test bench in Newton-metres. Used to validate compatibility with the powertrain or drivetrain under test.',
    `model_number` STRING COMMENT 'Manufacturers model or part number for the test bench hardware. Used for maintenance, calibration, and procurement of compatible components.',
    `network_segment` STRING COMMENT 'IT/OT network segment or VLAN to which the test bench data acquisition and control systems are connected. Used for cybersecurity zoning and IoT edge computing data flow management.',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date by which the next calibration must be completed to maintain measurement traceability and regulatory compliance. Drives preventive maintenance scheduling.',
    `next_maintenance_due_date` DATE COMMENT 'Scheduled date for the next planned preventive maintenance activity on the test bench. Supports maintenance planning and minimizes unplanned downtime.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, known limitations, special configurations, or engineering remarks about the test bench that do not fit structured fields.',
    `plm_asset_code` STRING COMMENT 'Identifier of the test bench record in the PLM system (e.g., Siemens Teamcenter, ENOVIA, PTC Windchill). Enables traceability between the physical asset and its digital representation in the product lifecycle management system.',
    `power_consumption_kw` DECIMAL(18,2) COMMENT 'Rated electrical power consumption of the test bench in kilowatts under typical operating conditions. Used for energy management, ESG CO2 tracking, and facility capacity planning.',
    `responsible_engineer` STRING COMMENT 'Name or employee identifier of the lead engineer responsible for the test bench, its calibration, and its operational readiness. Used for accountability and escalation.',
    `safety_classification` STRING COMMENT 'Automotive Safety Integrity Level (ASIL) classification of the test bench environment per ISO 26262, indicating the functional safety requirements applicable to tests conducted on this bench.',
    `sampling_rate_hz` DECIMAL(18,2) COMMENT 'Maximum data acquisition sampling rate in Hertz (samples per second) supported by the test bench instrumentation. Determines the resolution of time-series test data captured.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number uniquely identifying the physical test bench unit. Used for warranty tracking, calibration records, and asset management.',
    `supported_fuel_types` STRING COMMENT 'Comma-separated list of fuel or energy types the test bench is configured to support (e.g., gasoline, diesel, hydrogen, CNG, LPG, BEV/electric). Determines which powertrain programs can use this bench.',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum ambient or controlled temperature in degrees Celsius that the test bench environment can achieve. Used to validate thermal performance and high-temperature durability.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum ambient or controlled temperature in degrees Celsius that the test bench environment can achieve. Relevant for climatic chambers and cold-start validation tests.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test bench master record. Used for change tracking, data lineage, and synchronisation with source PLM systems.',
    `utilization_target_pct` DECIMAL(18,2) COMMENT 'Target utilization rate of the test bench expressed as a percentage of available capacity. Used as a KPI benchmark for engineering resource management.',
    CONSTRAINT pk_test_bench PRIMARY KEY(`test_bench_id`)
) COMMENT 'Master reference table for test_bench. Referenced by test_bench_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`patent_family` (
    `patent_family_id` BIGINT COMMENT 'Primary key for patent_family',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Patent families are associated with specific vehicle programs (the innovations they protect are developed within a program context). The existing vehicle_program_relevance text field is a denormalized',
    `continuation_patent_family_id` BIGINT COMMENT 'Self-referencing FK on patent_family (continuation_patent_family_id)',
    `abstract_text` STRING COMMENT 'Official abstract text of the invention as published in the priority application, providing a concise summary of the technical problem solved and the solution claimed. Used for search and classification purposes.',
    `annual_maintenance_cost` DECIMAL(18,2) COMMENT 'Total annualized cost of maintaining the patent family across all active jurisdictions, including renewal fees, annuities, and agent fees. Used for IP portfolio cost management and ROI analysis.',
    `book_value` DECIMAL(18,2) COMMENT 'Capitalized intangible asset value of the patent family as recorded on the balance sheet, net of accumulated amortization. Relevant for IFRS 38 intangible asset reporting.',
    `citation_count_backward` STRING COMMENT 'Number of prior art references cited by the patent familys applications (backward citations). Indicates the depth of prior art search and the novelty positioning of the invention.',
    `citation_count_forward` STRING COMMENT 'Number of times patents in this family have been cited by subsequent patent applications (forward citations). A key indicator of the patent familys technological influence and value.',
    `claim_count` STRING COMMENT 'Total number of claims in the lead application of the patent family, including independent and dependent claims. Claim count is an indicator of the breadth and depth of IP protection.',
    `cn_application_number` STRING COMMENT 'Application number assigned by the China National Intellectual Property Administration (CNIPA) for the Chinese national phase or direct Chinese application within this family. China is a critical automotive market jurisdiction.',
    `cpc_classification_code` STRING COMMENT 'Primary Cooperative Patent Classification code assigned by the USPTO or EPO, providing finer-grained technology categorization than IPC. Used for competitive landscape analysis and freedom-to-operate assessments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the patent family record was first created in the engineering data lakehouse, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports data lineage and audit trail requirements.',
    `cumulative_prosecution_cost` DECIMAL(18,2) COMMENT 'Total accumulated cost of prosecuting the patent family from initial filing through current status, including attorney fees, filing fees, translation costs, and examination fees across all jurisdictions.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts recorded on this patent family record (e.g., EUR, USD, JPY).',
    `de_application_number` STRING COMMENT 'Application number assigned by the German Patent and Trade Mark Office (DPMA) for the German national application within this family. Germany is the primary automotive manufacturing jurisdiction in Europe.',
    `earliest_filing_date` DATE COMMENT 'The actual calendar date on which the first application in the family was filed with a patent office. May coincide with or differ from the priority date when provisional applications are involved.',
    `earliest_grant_date` DATE COMMENT 'Date on which the first granted patent within the family was issued by a patent office. Marks the start of enforceable IP rights for the family.',
    `earliest_publication_date` DATE COMMENT 'Date on which the earliest member of the patent family was first published by a patent office, making the invention publicly disclosed. Relevant for prior-art and freedom-to-operate analyses.',
    `ecn_reference` STRING COMMENT 'Reference to the Engineering Change Notice (ECN) or Engineering Change Order (ECO) that triggered or is associated with this patent family, linking IP protection to specific design changes.',
    `ep_application_number` STRING COMMENT 'Application number assigned by the European Patent Office (EPO) for the European regional phase application within this family. Used for tracking EPO prosecution and validation in EPC member states.',
    `expected_expiry_date` DATE COMMENT 'Projected date on which the last surviving granted patent in the family will expire, calculated as 20 years from the earliest filing date (utility) or 15 years from grant (design), subject to patent term extensions. Used for IP portfolio lifecycle planning.',
    `external_counsel_firm` STRING COMMENT 'Name of the external law firm or patent attorney firm responsible for prosecuting and maintaining this patent family. Used for outside counsel management and cost allocation.',
    `family_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned to the patent family by the IP management system or patent office (e.g., INPADOC family number). Used for cross-referencing across jurisdictions.',
    `family_status` STRING COMMENT 'Current lifecycle status of the patent family reflecting the overall prosecution and enforcement state across all member applications.',
    `family_title` STRING COMMENT 'Official title of the invention as filed, representing the primary human-readable label for the patent family. Typically derived from the earliest priority application.',
    `family_type` STRING COMMENT 'Classification of the patent family by the nature of the intellectual property protection sought. Utility covers functional inventions; design covers ornamental aspects; plant covers new plant varieties; utility_model covers petty patents in applicable jurisdictions; divisional covers child applications split from a parent.',
    `frand_declared_flag` BOOLEAN COMMENT 'Indicates whether a FRAND licensing commitment has been formally declared to a standards body for this patent family. Triggers specific licensing obligations and royalty rate constraints.',
    `freedom_to_operate_status` STRING COMMENT 'Result of the most recent Freedom-to-Operate (FTO) analysis for the technology covered by this patent family, indicating whether the company can commercialize the invention without infringing third-party rights.',
    `fto_assessment_date` DATE COMMENT 'Date on which the most recent Freedom-to-Operate assessment was completed. Used to determine whether the FTO analysis is current and requires refresh.',
    `independent_claim_count` STRING COMMENT 'Number of independent claims in the lead application, each defining a distinct scope of protection. Independent claims are the primary measure of patent breadth.',
    `internal_ip_counsel_name` STRING COMMENT 'Full name of the internal IP attorney or patent engineer responsible for managing this patent family. Used for workload management and accountability tracking.',
    `invention_disclosure_number` STRING COMMENT 'Internal reference number of the Invention Disclosure Record (IDR) submitted by the inventor(s) to the IP department, linking the patent family back to the original R&D disclosure. Enables traceability from invention to granted patent.',
    `inventor_count` STRING COMMENT 'Total number of named inventors across all applications in the patent family. Used for inventor recognition reporting and royalty distribution calculations.',
    `ip_owner_legal_entity` STRING COMMENT 'Legal name of the corporate entity that holds title to the patent family (assignee of record). May differ from the operating business unit when IP is held by a holding company or subsidiary.',
    `ipc_classification_code` STRING COMMENT 'Primary International Patent Classification code assigned to the invention, structured per WIPO IPC hierarchy (Section/Class/Subclass/Group/Subgroup). Enables cross-jurisdictional technology benchmarking and prior-art searches.',
    `jp_application_number` STRING COMMENT 'Application number assigned by the Japan Patent Office (JPO) for the Japanese national phase or direct Japanese application within this family.',
    `jurisdiction_count` STRING COMMENT 'Number of distinct national or regional jurisdictions in which patent protection has been sought or granted for this family. Indicates the geographic breadth of IP coverage.',
    `lead_inventor_name` STRING COMMENT 'Full name of the primary inventor listed on the patent familys priority application. Used for inventor recognition programs, royalty sharing, and legal correspondence.',
    `licensing_revenue_ytd` DECIMAL(18,2) COMMENT 'Cumulative licensing revenue received for this patent family in the current fiscal year, expressed in the reporting currency. Used for IP monetization performance tracking.',
    `licensing_status` STRING COMMENT 'Current licensing disposition of the patent family, indicating whether the IP is being actively licensed to third parties, subject to cross-licensing arrangements, or available for licensing.',
    `litigation_case_reference` STRING COMMENT 'Internal or court-assigned case reference number for active litigation involving this patent family. Populated only when litigation_flag is TRUE. Used for legal matter management and e-discovery.',
    `litigation_flag` BOOLEAN COMMENT 'Indicates whether the patent family is currently involved in active litigation, including infringement suits, inter partes review (IPR), opposition proceedings, or invalidity challenges.',
    `owning_business_unit` STRING COMMENT 'Name of the internal business unit or R&D division that owns the patent family and is responsible for its prosecution costs and commercialization strategy (e.g., Powertrain Engineering, ADAS Systems, Vehicle Safety).',
    `patent_portfolio_category` STRING COMMENT 'Strategic classification of the patent family within the companys IP portfolio. Core patents protect key product differentiators; standard_essential patents (SEPs) are essential to industry standards (e.g., V2X, LTE-V); defensive patents deter litigation; blocking patents prevent competitor entry; licensing and cross_license patents are managed for revenue or reciprocal access.',
    `pct_application_number` STRING COMMENT 'Application number assigned under the WIPO Patent Cooperation Treaty (PCT) international phase, if the family includes a PCT filing. Enables tracking of the international phase prosecution and national phase entries.',
    `plm_document_code` STRING COMMENT 'Reference identifier linking this patent family to the corresponding technical disclosure or design document in the PLM system (e.g., Siemens Teamcenter, ENOVIA, PTC Windchill). Enables traceability between IP assets and engineering design artifacts.',
    `priority_application_number` STRING COMMENT 'Application number of the earliest priority filing (the root application) from which the familys priority date is derived. Establishes the legal priority date under the Paris Convention.',
    `priority_date` DATE COMMENT 'The earliest filing date claimed by the patent family, establishing the legal priority date under the Paris Convention. Critical for determining novelty and inventive step against prior art.',
    `product_relevance_flag` BOOLEAN COMMENT 'Indicates whether the patent family is currently embodied in or relevant to a production vehicle or component. Distinguishes patents protecting current products from purely defensive or future-oriented filings.',
    `prosecution_status` STRING COMMENT 'Detailed current stage in the patent prosecution workflow for the lead application in the family. Tracks progress through examination, allowance, grant, and post-grant proceedings.',
    `standard_essential_flag` BOOLEAN COMMENT 'Indicates whether the patent family has been declared as potentially essential to an industry standard (e.g., ISO 26262, SAE J3016, 3GPP V2X, IEEE 802.11p). SEPs carry FRAND licensing obligations.',
    `strategic_importance_rating` STRING COMMENT 'Internal rating of the patent familys strategic importance to the companys product roadmap and competitive position. Used to prioritize prosecution investment and maintenance decisions.',
    `technology_domain` STRING COMMENT 'High-level technology area to which the invention belongs (e.g., powertrain, ADAS, battery management, chassis, infotainment, connectivity). Used for portfolio analytics and R&D investment reporting. [ENUM-REF-CANDIDATE: powertrain|adas|battery_management|chassis|infotainment|connectivity|body_electronics|safety_systems|manufacturing_process|software — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the patent family record in the engineering data lakehouse. Used for change tracking, incremental data loads, and audit compliance.',
    `us_application_number` STRING COMMENT 'Application number assigned by the United States Patent and Trademark Office (USPTO) for the US national phase or direct US application within this family.',
    CONSTRAINT pk_patent_family PRIMARY KEY(`patent_family_id`)
) COMMENT 'Master reference table for patent_family. Referenced by patent_family_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ADD CONSTRAINT `fk_engineering_part_master_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ADD CONSTRAINT `fk_engineering_part_master_patent_record_id` FOREIGN KEY (`patent_record_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`patent_record`(`patent_record_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ADD CONSTRAINT `fk_engineering_part_master_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` ADD CONSTRAINT `fk_engineering_design_specification_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` ADD CONSTRAINT `fk_engineering_design_specification_patent_record_id` FOREIGN KEY (`patent_record_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`patent_record`(`patent_record_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` ADD CONSTRAINT `fk_engineering_design_specification_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` ADD CONSTRAINT `fk_engineering_cad_model_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` ADD CONSTRAINT `fk_engineering_cad_model_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` ADD CONSTRAINT `fk_engineering_cad_model_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ADD CONSTRAINT `fk_engineering_change_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ADD CONSTRAINT `fk_engineering_change_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` ADD CONSTRAINT `fk_engineering_cae_simulation_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` ADD CONSTRAINT `fk_engineering_cae_simulation_dvp_plan_id` FOREIGN KEY (`dvp_plan_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`dvp_plan`(`dvp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` ADD CONSTRAINT `fk_engineering_cae_simulation_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` ADD CONSTRAINT `fk_engineering_cae_simulation_ml_model_metadata_id` FOREIGN KEY (`ml_model_metadata_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`ml_model_metadata`(`ml_model_metadata_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` ADD CONSTRAINT `fk_engineering_cae_simulation_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` ADD CONSTRAINT `fk_engineering_cae_simulation_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` ADD CONSTRAINT `fk_engineering_prototype_build_dvp_plan_id` FOREIGN KEY (`dvp_plan_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`dvp_plan`(`dvp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` ADD CONSTRAINT `fk_engineering_prototype_build_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` ADD CONSTRAINT `fk_engineering_prototype_build_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_dvp_plan_id` FOREIGN KEY (`dvp_plan_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`dvp_plan`(`dvp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_homologation_requirement_id` FOREIGN KEY (`homologation_requirement_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`homologation_requirement`(`homologation_requirement_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_prototype_build_id` FOREIGN KEY (`prototype_build_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`prototype_build`(`prototype_build_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_test_bench_id` FOREIGN KEY (`test_bench_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`test_bench`(`test_bench_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` ADD CONSTRAINT `fk_engineering_engineering_test_result_prototype_build_id` FOREIGN KEY (`prototype_build_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`prototype_build`(`prototype_build_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` ADD CONSTRAINT `fk_engineering_engineering_test_result_test_sample_id` FOREIGN KEY (`test_sample_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`test_sample`(`test_sample_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` ADD CONSTRAINT `fk_engineering_engineering_test_result_test_bench_id` FOREIGN KEY (`test_bench_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`test_bench`(`test_bench_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` ADD CONSTRAINT `fk_engineering_engineering_test_result_validation_test_id` FOREIGN KEY (`validation_test_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`validation_test`(`validation_test_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` ADD CONSTRAINT `fk_engineering_digital_twin_ecu_specification_id` FOREIGN KEY (`ecu_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`ecu_specification`(`ecu_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` ADD CONSTRAINT `fk_engineering_digital_twin_ml_model_metadata_id` FOREIGN KEY (`ml_model_metadata_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`ml_model_metadata`(`ml_model_metadata_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` ADD CONSTRAINT `fk_engineering_digital_twin_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` ADD CONSTRAINT `fk_engineering_digital_twin_prototype_build_id` FOREIGN KEY (`prototype_build_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`prototype_build`(`prototype_build_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` ADD CONSTRAINT `fk_engineering_digital_twin_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` ADD CONSTRAINT `fk_engineering_milestone_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` ADD CONSTRAINT `fk_engineering_milestone_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_dvp_plan_id` FOREIGN KEY (`dvp_plan_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`dvp_plan`(`dvp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dvp_plan` ADD CONSTRAINT `fk_engineering_dvp_plan_project_id` FOREIGN KEY (`project_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`project`(`project_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dvp_plan` ADD CONSTRAINT `fk_engineering_dvp_plan_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`homologation_requirement` ADD CONSTRAINT `fk_engineering_homologation_requirement_dvp_plan_id` FOREIGN KEY (`dvp_plan_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`dvp_plan`(`dvp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`homologation_requirement` ADD CONSTRAINT `fk_engineering_homologation_requirement_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` ADD CONSTRAINT `fk_engineering_ecu_specification_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` ADD CONSTRAINT `fk_engineering_ecu_specification_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` ADD CONSTRAINT `fk_engineering_ecu_specification_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` ADD CONSTRAINT `fk_engineering_powertrain_spec_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` ADD CONSTRAINT `fk_engineering_powertrain_spec_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` ADD CONSTRAINT `fk_engineering_powertrain_spec_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`weight_report` ADD CONSTRAINT `fk_engineering_weight_report_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`weight_report` ADD CONSTRAINT `fk_engineering_weight_report_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`weight_report` ADD CONSTRAINT `fk_engineering_weight_report_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` ADD CONSTRAINT `fk_engineering_action_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` ADD CONSTRAINT `fk_engineering_action_design_review_id` FOREIGN KEY (`design_review_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_review`(`design_review_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` ADD CONSTRAINT `fk_engineering_action_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` ADD CONSTRAINT `fk_engineering_action_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_review` ADD CONSTRAINT `fk_engineering_design_review_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_review` ADD CONSTRAINT `fk_engineering_design_review_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_review` ADD CONSTRAINT `fk_engineering_design_review_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material_specification` ADD CONSTRAINT `fk_engineering_material_specification_material_id` FOREIGN KEY (`material_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`material`(`material_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material_specification` ADD CONSTRAINT `fk_engineering_material_specification_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`configuration_rule` ADD CONSTRAINT `fk_engineering_configuration_rule_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`configuration_rule` ADD CONSTRAINT `fk_engineering_configuration_rule_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` ADD CONSTRAINT `fk_engineering_ota_release_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` ADD CONSTRAINT `fk_engineering_ota_release_ecu_specification_id` FOREIGN KEY (`ecu_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`ecu_specification`(`ecu_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` ADD CONSTRAINT `fk_engineering_ota_release_engineering_document_id` FOREIGN KEY (`engineering_document_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_document`(`engineering_document_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` ADD CONSTRAINT `fk_engineering_ota_release_ml_model_metadata_id` FOREIGN KEY (`ml_model_metadata_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`ml_model_metadata`(`ml_model_metadata_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` ADD CONSTRAINT `fk_engineering_ota_release_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` ADD CONSTRAINT `fk_engineering_engineering_document_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` ADD CONSTRAINT `fk_engineering_engineering_document_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` ADD CONSTRAINT `fk_engineering_engineering_document_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` ADD CONSTRAINT `fk_engineering_engineering_document_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` ADD CONSTRAINT `fk_engineering_engineering_document_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` ADD CONSTRAINT `fk_engineering_engineering_adas_feature_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` ADD CONSTRAINT `fk_engineering_engineering_adas_feature_dvp_plan_id` FOREIGN KEY (`dvp_plan_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`dvp_plan`(`dvp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` ADD CONSTRAINT `fk_engineering_engineering_adas_feature_ecu_specification_id` FOREIGN KEY (`ecu_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`ecu_specification`(`ecu_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` ADD CONSTRAINT `fk_engineering_engineering_adas_feature_ml_model_metadata_id` FOREIGN KEY (`ml_model_metadata_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`ml_model_metadata`(`ml_model_metadata_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` ADD CONSTRAINT `fk_engineering_engineering_adas_feature_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ADD CONSTRAINT `fk_engineering_cost_target_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ADD CONSTRAINT `fk_engineering_cost_target_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ADD CONSTRAINT `fk_engineering_cost_target_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_component` ADD CONSTRAINT `fk_engineering_engineering_bom_component_engineering_bom_line_id` FOREIGN KEY (`engineering_bom_line_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_bom_line`(`engineering_bom_line_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_component` ADD CONSTRAINT `fk_engineering_engineering_bom_component_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dealer_part_inventory` ADD CONSTRAINT `fk_engineering_dealer_part_inventory_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_team` ADD CONSTRAINT `fk_engineering_engineering_team_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`packaging_specification` ADD CONSTRAINT `fk_engineering_packaging_specification_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` ADD CONSTRAINT `fk_engineering_project_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ADD CONSTRAINT `fk_engineering_patent_record_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`patent_family`(`patent_family_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ADD CONSTRAINT `fk_engineering_patent_record_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ADD CONSTRAINT `fk_engineering_ml_model_metadata_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ADD CONSTRAINT `fk_engineering_ml_model_metadata_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ADD CONSTRAINT `fk_engineering_test_sample_dvp_plan_id` FOREIGN KEY (`dvp_plan_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`dvp_plan`(`dvp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ADD CONSTRAINT `fk_engineering_test_sample_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ADD CONSTRAINT `fk_engineering_test_sample_prototype_build_id` FOREIGN KEY (`prototype_build_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`prototype_build`(`prototype_build_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ADD CONSTRAINT `fk_engineering_test_sample_test_program_id` FOREIGN KEY (`test_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ADD CONSTRAINT `fk_engineering_test_sample_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ADD CONSTRAINT `fk_engineering_test_sample_parent_test_sample_id` FOREIGN KEY (`parent_test_sample_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`test_sample`(`test_sample_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_bench` ADD CONSTRAINT `fk_engineering_test_bench_digital_twin_id` FOREIGN KEY (`digital_twin_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`digital_twin`(`digital_twin_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_bench` ADD CONSTRAINT `fk_engineering_test_bench_engineering_team_id` FOREIGN KEY (`engineering_team_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`engineering_team`(`engineering_team_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_bench` ADD CONSTRAINT `fk_engineering_test_bench_calibration_reference_test_bench_id` FOREIGN KEY (`calibration_reference_test_bench_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`test_bench`(`test_bench_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ADD CONSTRAINT `fk_engineering_patent_family_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ADD CONSTRAINT `fk_engineering_patent_family_continuation_patent_family_id` FOREIGN KEY (`continuation_patent_family_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`patent_family`(`patent_family_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`engineering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_automotive_v1`.`engineering` SET TAGS ('dbx_domain' = 'engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` SET TAGS ('dbx_subdomain' = 'program_governance');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` ALTER COLUMN `total_simulation_result_count` SET TAGS ('dbx_business_glossary_term' = 'Total Simulation Result Count');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ALTER COLUMN `patent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Record');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ALTER COLUMN `test_bench_validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Test Bench Validated Flag');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` ALTER COLUMN `patent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Record');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` ALTER COLUMN `requirements_traceability_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Requirements Traceability Coverage Pct');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` SET TAGS ('dbx_subdomain' = 'simulation_validation');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` ALTER COLUMN `dvp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Dvp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` ALTER COLUMN `ml_model_metadata_id` SET TAGS ('dbx_business_glossary_term' = 'ML Surrogate Model');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` ALTER COLUMN `rd_result_count` SET TAGS ('dbx_business_glossary_term' = 'RD Result Count');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cae_simulation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` SET TAGS ('dbx_subdomain' = 'simulation_validation');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` ALTER COLUMN `dvp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Dvp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`prototype_build` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` SET TAGS ('dbx_subdomain' = 'simulation_validation');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `homologation_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `prototype_build_id` SET TAGS ('dbx_business_glossary_term' = 'Prototype Build Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `test_bench_id` SET TAGS ('dbx_business_glossary_term' = 'Test Bench Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `iot_data_collection_flag` SET TAGS ('dbx_business_glossary_term' = 'IoT Data Collection');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `requirements_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Requirements Coverage Percent');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` SET TAGS ('dbx_subdomain' = 'simulation_validation');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` SET TAGS ('dbx_ssot_owner' = 'engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` SET TAGS ('dbx_ssot_concept' = 'test_result');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` ALTER COLUMN `prototype_build_id` SET TAGS ('dbx_business_glossary_term' = 'Prototype Build Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` ALTER COLUMN `sensor_data_ref` SET TAGS ('dbx_business_glossary_term' = 'Sensor Data Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_test_result` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` SET TAGS ('dbx_subdomain' = 'simulation_validation');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` ALTER COLUMN `ecu_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Ecu Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` ALTER COLUMN `ml_model_metadata_id` SET TAGS ('dbx_business_glossary_term' = 'ML Model');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` ALTER COLUMN `prototype_build_id` SET TAGS ('dbx_business_glossary_term' = 'Prototype Build Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` ALTER COLUMN `iot_sensor_count` SET TAGS ('dbx_business_glossary_term' = 'IoT Sensor Count');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` ALTER COLUMN `sensor_dataset_count` SET TAGS ('dbx_business_glossary_term' = 'Sensor Dataset Count');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`digital_twin` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` SET TAGS ('dbx_subdomain' = 'program_governance');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ALTER COLUMN `dvp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Dvp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dvp_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dvp_plan` SET TAGS ('dbx_subdomain' = 'simulation_validation');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dvp_plan` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dvp_plan` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dvp_plan` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dvp_plan` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dvp_plan` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dvp_plan` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dvp_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dvp_plan` ALTER COLUMN `test_bench_data_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Test Bench Data Available Flag');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`homologation_requirement` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`homologation_requirement` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`homologation_requirement` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`homologation_requirement` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`homologation_requirement` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`homologation_requirement` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`homologation_requirement` ALTER COLUMN `dvp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Dvp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`homologation_requirement` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`homologation_requirement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ecu_specification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`powertrain_spec` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`weight_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`weight_report` SET TAGS ('dbx_subdomain' = 'program_governance');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`weight_report` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`weight_report` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`weight_report` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`weight_report` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`weight_report` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`weight_report` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`weight_report` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`weight_report` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` SET TAGS ('dbx_subdomain' = 'program_governance');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` ALTER COLUMN `design_review_id` SET TAGS ('dbx_business_glossary_term' = 'Design Review Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fmea Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`action` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_review` SET TAGS ('dbx_subdomain' = 'program_governance');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_review` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_review` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_review` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_review` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_review` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_review` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_review` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material_specification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material_specification` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material_specification` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material_specification` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material_specification` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material_specification` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material_specification` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material_specification` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material_specification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`configuration_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`configuration_rule` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`configuration_rule` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`configuration_rule` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`configuration_rule` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`configuration_rule` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`configuration_rule` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`configuration_rule` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`configuration_rule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` ALTER COLUMN `engineering_document_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Document Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` ALTER COLUMN `ml_model_metadata_id` SET TAGS ('dbx_business_glossary_term' = 'Ml Model Metadata Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ota_release` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` SET TAGS ('dbx_subdomain' = 'program_governance');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` SET TAGS ('dbx_ssot_owner' = 'engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` SET TAGS ('dbx_ssot_concept' = 'document');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` SET TAGS ('dbx_ssot_authoritative' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_document` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` ALTER COLUMN `dvp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Dvp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` ALTER COLUMN `ecu_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Ecu Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` ALTER COLUMN `ml_model_metadata_id` SET TAGS ('dbx_business_glossary_term' = 'ML Model');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` ALTER COLUMN `ad_scenario_count` SET TAGS ('dbx_business_glossary_term' = 'AD Scenario Count');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_adas_feature` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` SET TAGS ('dbx_subdomain' = 'program_governance');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_component` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_component` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_component` SET TAGS ('dbx_association_edges' = 'engineering.part_master,manufacturing.production_bom');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_component` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_component` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_component` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_component` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_component` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_component` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dealer_part_inventory` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dealer_part_inventory` SET TAGS ('dbx_subdomain' = 'parts_management');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dealer_part_inventory` SET TAGS ('dbx_association_edges' = 'engineering.part_master,dealer.dealership');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dealer_part_inventory` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dealer_part_inventory` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dealer_part_inventory` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dealer_part_inventory` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dealer_part_inventory` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`dealer_part_inventory` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_team` SET TAGS ('dbx_subdomain' = 'program_governance');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_team` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_team` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_team` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_team` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_team` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_team` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_team` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material` SET TAGS ('dbx_subdomain' = 'design_engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material` ALTER COLUMN `commodity_group_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Group Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material` ALTER COLUMN `commodity_hedging_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Commodity Hedging Eligible');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material` ALTER COLUMN `price_index_code` SET TAGS ('dbx_business_glossary_term' = 'Price Index Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`material` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`packaging_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`packaging_specification` SET TAGS ('dbx_subdomain' = 'parts_management');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`packaging_specification` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`packaging_specification` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`packaging_specification` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`packaging_specification` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`packaging_specification` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`packaging_specification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` SET TAGS ('dbx_subdomain' = 'program_governance');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` SET TAGS ('dbx_system_of_record' = 'Siemens Teamcenter');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` SET TAGS ('dbx_CATIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` SET TAGS ('dbx_ENOVIA' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` SET TAGS ('dbx_PTC_Windchill' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` SET TAGS ('dbx_source_system' = 'Teamcenter/CATIA/ENOVIA/Windchill');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`project` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` SET TAGS ('dbx_domain' = 'engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` SET TAGS ('dbx_subdomain' = 'intellectual_property');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `patent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Record ID');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family ID');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program ID');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `abstract_text` SET TAGS ('dbx_business_glossary_term' = 'Abstract');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `annual_maintenance_fee` SET TAGS ('dbx_business_glossary_term' = 'Annual Maintenance Fee');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `assignee_organization` SET TAGS ('dbx_business_glossary_term' = 'Assignee Organization');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `claims_count` SET TAGS ('dbx_business_glossary_term' = 'Claims Count');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `grant_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Date');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `inventor_names` SET TAGS ('dbx_business_glossary_term' = 'Inventor Names');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `inventor_names` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `licensing_status` SET TAGS ('dbx_business_glossary_term' = 'Licensing Status');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master ID');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `patent_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Number');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `patent_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Status');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `patent_title` SET TAGS ('dbx_business_glossary_term' = 'Patent Title');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `patent_type` SET TAGS ('dbx_business_glossary_term' = 'Patent Type');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `priority_date` SET TAGS ('dbx_business_glossary_term' = 'Priority Date');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `technology_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Area');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` SET TAGS ('dbx_subdomain' = 'simulation_validation');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` SET TAGS ('dbx_domain' = 'engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` SET TAGS ('dbx_subdomain' = 'digitalization');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` SET TAGS ('dbx_industry4_0' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `ml_model_metadata_id` SET TAGS ('dbx_business_glossary_term' = 'ML Model Metadata ID');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program ID');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `accuracy_metric` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Metric');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `accuracy_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Metric Name');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `deployment_target` SET TAGS ('dbx_business_glossary_term' = 'Deployment Target');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `framework` SET TAGS ('dbx_business_glossary_term' = 'Framework');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `inference_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Inference Latency');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `input_features_count` SET TAGS ('dbx_business_glossary_term' = 'Input Features Count');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `last_retrained_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Retrained Timestamp');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `model_artifact_url` SET TAGS ('dbx_business_glossary_term' = 'Model Artifact URL');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Model Name');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Model Type');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `training_dataset_ref` SET TAGS ('dbx_business_glossary_term' = 'Training Dataset Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`ml_model_metadata` ALTER COLUMN `use_case` SET TAGS ('dbx_business_glossary_term' = 'Use Case');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` SET TAGS ('dbx_subdomain' = 'simulation_validation');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ALTER COLUMN `test_sample_id` SET TAGS ('dbx_business_glossary_term' = 'Test Sample Identifier');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ALTER COLUMN `dvp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Dvp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ALTER COLUMN `prototype_build_id` SET TAGS ('dbx_business_glossary_term' = 'Prototype Build Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ALTER COLUMN `parent_test_sample_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ALTER COLUMN `responsible_engineer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_sample` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_bench` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_bench` SET TAGS ('dbx_subdomain' = 'simulation_validation');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_bench` ALTER COLUMN `test_bench_id` SET TAGS ('dbx_business_glossary_term' = 'Test Bench Identifier');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_bench` ALTER COLUMN `engineering_team_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Team Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_bench` ALTER COLUMN `calibration_reference_test_bench_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_bench` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Identifier');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `continuation_patent_family_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `annual_maintenance_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `cn_application_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `cumulative_prosecution_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `de_application_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `ep_application_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `external_counsel_firm` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `family_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `family_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `freedom_to_operate_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `internal_ip_counsel_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `internal_ip_counsel_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `invention_disclosure_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `ip_owner_legal_entity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `jp_application_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `lead_inventor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `lead_inventor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `licensing_revenue_ytd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `licensing_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `litigation_case_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `litigation_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `pct_application_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `plm_document_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `priority_application_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`patent_family` ALTER COLUMN `us_application_number` SET TAGS ('dbx_confidential' = 'true');
