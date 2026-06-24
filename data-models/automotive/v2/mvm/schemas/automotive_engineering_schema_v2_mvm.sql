-- Schema for Domain: engineering | Business: Automotive | Version: v2_mvm
-- Generated on: 2026-06-23 06:00:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`engineering` COMMENT 'Manages the full product design and development lifecycle including CAD (Computer-Aided Design), CAE (Computer-Aided Engineering), PLM (Product Lifecycle Management), and digital twin modeling. Owns engineering BOM, design specifications, CFD (Computational Fluid Dynamics), FEA (Finite Element Analysis), NVH (Noise Vibration Harshness) testing, prototype validation, and engineering change orders (ECO/ECN). Integrates with Siemens Teamcenter, CATIA, and ENOVIA for collaborative engineering.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` (
    `vehicle_program_id` BIGINT COMMENT '',
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
    `change_id` BIGINT COMMENT '',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: An engineering BOM is the physical realization of a design specification — the BOM is built to satisfy the requirements defined in the design spec. Linking bom to design_specification establishes whic',
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
    `cad_model_id` BIGINT COMMENT 'Foreign key linking to engineering.cad_model. Business justification: Each BOM line references a specific CAD model geometry asset. The existing cad_reference field on engineering_bom_line is a free-text string reference to a CAD file — this is a classic denormalization',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: BOM line items are created or modified under specific engineering change orders. The existing change_number text field is a denormalized reference to the change record. Adding change_id FK normalizes ',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Each BOM line item (part-to-parent relationship) is governed by a design specification that defines the technical requirements for that part in context. Linking engineering_bom_line to design_specific',
    `part_master_id` BIGINT COMMENT '',
    `assembly_level` STRING COMMENT '',
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
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: A part master record is designed to meet a governing design specification. While cad_model already links part_master → design_specification indirectly, many parts exist in the PLM system before a CAD ',
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
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Design specifications in automotive are authored to satisfy specific regulatory requirements (e.g., FMVSS 208 drives airbag deployment specs). Requirements traceability coverage reporting (requirement',
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
    `milestone_id` BIGINT COMMENT 'Foreign key linking to engineering.milestone. Business justification: Engineering changes (ECO/ECN) are often gated by program milestones — a change must be implemented and validated before a specific gate review (e.g., Design Freeze, Job 1). Linking change to milestone',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to the part master record that is affected by this change',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Engineering change orders in automotive are frequently initiated by new or updated regulatory requirements (e.g., new emission limits, updated crash standards). Linking change to regulatory_requiremen',
    `vehicle_program_id` BIGINT COMMENT '',
    `affected_revision_level` STRING COMMENT 'The specific revision level of the part that is targeted by this change. Belongs to the relationship because it identifies which version of the part is being modified, not a property of the part or the change in isolation.',
    `approved_date` DATE COMMENT '',
    `change_number` STRING COMMENT '',
    `change_status` STRING COMMENT '',
    `change_type` STRING COMMENT '',
    `cost_impact_amount` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage tracking',
    `change_description` STRING COMMENT '',
    `effective_date` DATE COMMENT 'The date on which this change becomes effective for this specific part. Belongs to the relationship because the effective date can differ across parts within the same ECO (e.g., phased rollout across production lines).',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `impact_assessment` STRING COMMENT '',
    `impact_type` STRING COMMENT 'Classifies the nature of how this specific change affects this specific part (e.g., design change, material change, drawing update). Belongs to the relationship because the same ECO can affect different parts in different ways.',
    `implementation_date` DATE COMMENT '',
    `implementation_status` STRING COMMENT 'Per-part tracking of whether this change has been implemented for this specific part. Belongs to the relationship because different parts within the same ECO can be at different stages of implementation.',
    `priority` STRING COMMENT '',
    `reason_code` STRING COMMENT '',
    `requested_date` DATE COMMENT '',
    `source_system_code` STRING COMMENT 'Identifies the source PLM/CAD system (e.g., Teamcenter, ENOVIA, Windchill)',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_change PRIMARY KEY(`change_id`)
) COMMENT 'Engineering Change Order/Notice (ECO/ECN) record capturing a formal request to modify a part, assembly, design specification, or BOM. Includes change number, change type (ECR/ECO/ECN), title, reason for change (cost reduction, quality, regulatory, customer request), affected parts list, affected programs, initiator, approver chain, priority, implementation date, cost impact estimate, and change status (draft, under review, approved, implemented, rejected). Managed in Siemens Teamcenter Change Management.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`validation_test` (
    `validation_test_id` BIGINT COMMENT '',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Engineering changes (ECO/ECN) require re-validation testing to confirm the change does not introduce new failure modes or degrade performance. Linking validation_test to change establishes which tests',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Validation tests are executed to verify compliance against a design specification. The test_standard field on validation_test is a free-text code, but a proper FK to design_specification normalizes th',
    `fmea_record_id` BIGINT COMMENT 'Foreign key linking to engineering.fmea_record. Business justification: Validation tests are frequently triggered by FMEA findings — when an FMEA identifies a failure mode with high RPN, a validation test is mandated to verify the recommended corrective action. Linking va',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: A validation test (NVH, FEA, CFD, physical prototype) is performed on a specific part or assembly. Linking validation_test to part_master establishes which part is under test, enabling traceability fr',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Automotive validation tests (FMVSS, ECE, Euro NCAP, OBD) are designed to demonstrate compliance with specific regulatory requirements. Engineering teams must trace each test to the requirement it sati',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`test_result` (
    `test_result_id` BIGINT COMMENT '',
    `validation_test_id` BIGINT COMMENT '',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT '',
    `approval_engineer_name` STRING COMMENT 'Name of engineer who approved the result',
    `confidence_level_pct` DECIMAL(18,2) COMMENT 'Statistical confidence level of the result',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `deviation_from_target` DECIMAL(18,2) COMMENT 'Deviation from target value',
    `engineering_test_result_description` STRING COMMENT 'Description of the entity',
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
    CONSTRAINT pk_test_result PRIMARY KEY(`test_result_id`)
) COMMENT 'Detailed test result record capturing individual measurement data points from a validation test event. Includes result ID, parent test reference, measurement parameter name, unit of measure, measured value, target value, tolerance band (min/max), pass/fail status, test condition description, channel or sensor ID, timestamp of measurement, and data file reference. Enables granular traceability of test outcomes against engineering targets and regulatory thresholds. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`milestone` (
    `milestone_id` BIGINT COMMENT '',
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

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`engineering`.`cost_target` (
    `cost_target_id` DECIMAL(18,2) COMMENT '',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Engineering changes have a cost_impact_amount field, and cost targets are directly affected by engineering changes. When an ECO/ECN is issued, cost targets for the affected parts or systems must be re',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Cost targets in automotive engineering are set at the system or subsystem level, often tied directly to design specifications that define the functional requirements. A design-to-cost objective is mea',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ADD CONSTRAINT `fk_engineering_bom_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_bom_id` FOREIGN KEY (`bom_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`bom`(`bom_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_cad_model_id` FOREIGN KEY (`cad_model_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`cad_model`(`cad_model_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ADD CONSTRAINT `fk_engineering_engineering_bom_line_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ADD CONSTRAINT `fk_engineering_part_master_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ADD CONSTRAINT `fk_engineering_part_master_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` ADD CONSTRAINT `fk_engineering_design_specification_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` ADD CONSTRAINT `fk_engineering_cad_model_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` ADD CONSTRAINT `fk_engineering_cad_model_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` ADD CONSTRAINT `fk_engineering_cad_model_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ADD CONSTRAINT `fk_engineering_change_milestone_id` FOREIGN KEY (`milestone_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`milestone`(`milestone_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ADD CONSTRAINT `fk_engineering_change_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ADD CONSTRAINT `fk_engineering_change_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_fmea_record_id` FOREIGN KEY (`fmea_record_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`fmea_record`(`fmea_record_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ADD CONSTRAINT `fk_engineering_validation_test_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_result` ADD CONSTRAINT `fk_engineering_test_result_validation_test_id` FOREIGN KEY (`validation_test_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`validation_test`(`validation_test_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` ADD CONSTRAINT `fk_engineering_milestone_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ADD CONSTRAINT `fk_engineering_fmea_record_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ADD CONSTRAINT `fk_engineering_cost_target_change_id` FOREIGN KEY (`change_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`change`(`change_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ADD CONSTRAINT `fk_engineering_cost_target_design_specification_id` FOREIGN KEY (`design_specification_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`design_specification`(`design_specification_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ADD CONSTRAINT `fk_engineering_cost_target_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`part_master`(`part_master_id`);
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ADD CONSTRAINT `fk_engineering_cost_target_vehicle_program_id` FOREIGN KEY (`vehicle_program_id`) REFERENCES `vibe_automotive_v1`.`engineering`.`vehicle_program`(`vehicle_program_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`engineering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_automotive_v1`.`engineering` SET TAGS ('dbx_domain' = 'engineering');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`vehicle_program` ALTER COLUMN `total_simulation_result_count` SET TAGS ('dbx_business_glossary_term' = 'Total Simulation Result Count');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` SET TAGS ('dbx_subdomain' = 'parts_design');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`bom` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` SET TAGS ('dbx_subdomain' = 'parts_design');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `cad_model_id` SET TAGS ('dbx_business_glossary_term' = 'Cad Model Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`engineering_bom_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` SET TAGS ('dbx_subdomain' = 'parts_design');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`part_master` ALTER COLUMN `test_bench_validated_flag` SET TAGS ('dbx_business_glossary_term' = 'Test Bench Validated Flag');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` SET TAGS ('dbx_subdomain' = 'parts_design');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`design_specification` ALTER COLUMN `requirements_traceability_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Requirements Traceability Coverage Pct');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` SET TAGS ('dbx_subdomain' = 'parts_design');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cad_model` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Change Affected Part - Part Master Id');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `affected_revision_level` SET TAGS ('dbx_business_glossary_term' = 'Affected Revision Level');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `impact_type` SET TAGS ('dbx_business_glossary_term' = 'Impact Type');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`change` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` SET TAGS ('dbx_subdomain' = 'validation_testing');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fmea Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `iot_data_collection_flag` SET TAGS ('dbx_business_glossary_term' = 'IoT Data Collection');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `requirements_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Requirements Coverage Percent');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`validation_test` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_result` SET TAGS ('dbx_subdomain' = 'validation_testing');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_result` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_result` ALTER COLUMN `sensor_data_ref` SET TAGS ('dbx_business_glossary_term' = 'Sensor Data Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`test_result` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`milestone` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` SET TAGS ('dbx_subdomain' = 'validation_testing');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`fmea_record` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` SET TAGS ('dbx_subdomain' = 'program_management');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`engineering`.`cost_target` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
