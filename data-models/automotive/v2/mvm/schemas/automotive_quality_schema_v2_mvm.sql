-- Schema for Domain: quality | Business: Automotive | Version: v2_mvm
-- Generated on: 2026-06-23 06:00:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`quality` COMMENT 'End-to-end quality assurance and control across design, manufacturing, and field operations. Owns APQP plans, FMEA (Failure Mode and Effects Analysis), SPC (Statistical Process Control) data, inspection plans, quality audits, defect tracking, and PPM rates. Includes incoming material inspection, in-process quality gates, final vehicle PDI (Pre-Delivery Inspection), NCAP/WLTP test results, and corrective action (8D, 5-Why) processes. Supports IATF 16949 compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` (
    `apqp_plan_id` BIGINT COMMENT 'System-generated unique identifier for the APQP plan record.',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: APQP gate reviews in IATF 16949 require traceability to the specific BOM revision in scope. Quality engineers need to know which BOM configuration (variant, model year, emissions standard) the APQP pl',
    `homologation_record_id` BIGINT COMMENT 'Foreign key linking to compliance.homologation_record. Business justification: APQP planning requires referencing the homologation approval to align release dates with regulatory clearance.',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to engineering.milestone. Business justification: APQP gate completion is tracked against engineering program milestones in launch readiness reviews. Quality teams must confirm engineering milestone dates align with APQP phase gates — a standard APQP',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: APQP planning is defined per vehicle model; linking APQP plan to model enables model‑specific quality goals and gate tracking.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: APQP plans in automotive are plant-specific launch quality plans — each plant runs its own APQP for a new model launch. This link enables plant-level APQP status reporting, launch readiness tracking p',
    `platform_id` BIGINT COMMENT 'Foreign key linking to vehicle.platform. Business justification: Platform-level APQP plans govern quality gates for all models on a shared architecture. Quality engineers run platform APQP gate reviews independently of individual models. A domain expert expects apq',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: New powertrain introductions require dedicated APQP plans (PPAP submission, SOP gate). Powertrain APQP plans are managed separately from body/model plans. Quality engineers need to retrieve all APQP p',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: APQP plans explicitly require identification of applicable regulatory requirements as a Phase 1 input. Direct linkage enables regulatory requirement coverage tracking across APQP gates, supports homol',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: APQP planning is executed per vehicle program; linking aligns plans with program metadata and eliminates program_name duplication.',
    `actual_ppm` DECIMAL(18,2) COMMENT 'Measured parts-per-million defect rate observed after validation.',
    `actual_release_date` DATE COMMENT 'Actual date when the product was released to production.',
    `ai_inspection_flag` BOOLEAN COMMENT 'Whether AI/ML computer vision was used in this quality process',
    `apqp_phase` STRING COMMENT 'Current phase of the APQP process for the plan.. Valid values are `concept|design|process|validation|launch`',
    `classification_type` STRING COMMENT 'Category of the APQP plan based on product scope.. Valid values are `new_model|refresh|component|system`',
    `compliance_status` STRING COMMENT 'Current IATF 16949 compliance status of the APQP plan.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the APQP plan record was created in the system.',
    `documentation_link` STRING COMMENT 'URL or path to the primary APQP documentation repository.',
    `effective_from` DATE COMMENT 'Date when the APQP plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the APQP plan expires or is superseded (nullable).',
    `eop_date` DATE COMMENT 'Date when series production ended for the vehicle/program.',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `gate_completion_date` DATE COMMENT 'Actual date when the milestone gate was completed.',
    `gate_due_date` DATE COMMENT 'Planned due date for the milestone gate.',
    `gate_status` STRING COMMENT 'Current status of the milestone gate.. Valid values are `open|closed|delayed|approved|rejected`',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the APQP plan.. Valid values are `draft|active|suspended|completed|archived`',
    `milestone_gate` STRING COMMENT 'Specific APQP milestone gate associated with the plan.. Valid values are `gate1|gate2|gate3|gate4|gate5`',
    `mitigation_plan` STRING COMMENT 'Description of actions taken to mitigate identified risks.',
    `model_year` STRING COMMENT 'Model year (calendar year) of the vehicle model associated with the APQP plan.',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations.',
    `owner_name` STRING COMMENT 'Name of the internal owner or manager of the APQP plan.',
    `part_number` STRING COMMENT 'Identifier of the part or component covered by the APQP plan (e.g., OEM part number).',
    `plan_number` STRING COMMENT 'External business identifier assigned to the APQP plan, often used in documentation and reporting.',
    `quality_goal_ppm` DECIMAL(18,2) COMMENT 'Target parts-per-million defect rate defined for the APQP plan.',
    `responsible_team` STRING COMMENT 'Team or department accountable for executing the APQP plan.',
    `risk_assessment_date` DATE COMMENT 'Date when the risk assessment for the APQP plan was performed.',
    `risk_level` STRING COMMENT 'Overall risk classification for the APQP plan.. Valid values are `low|medium|high|critical`',
    `sop_date` DATE COMMENT 'Date when series production started for the vehicle/program.',
    `target_ppm` DECIMAL(18,2) COMMENT 'Planned PPM level to achieve during the APQP process.',
    `target_release_date` DATE COMMENT 'Planned date for the product release associated with the APQP plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the APQP plan record.',
    `version_number` STRING COMMENT 'Version identifier for the APQP plan record.',
    CONSTRAINT pk_apqp_plan PRIMARY KEY(`apqp_plan_id`)
) COMMENT 'Advanced Product Quality Planning master record governing the structured quality planning process for new vehicle programs and components. Tracks APQP phases (concept, design, process, validation, launch), milestone gates, responsible teams, and completion status per program/part. Aligns with IATF 16949 requirements and links to engineering change and SOP timelines.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`quality`.`control_plan` (
    `control_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the quality control plan.',
    `apqp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.apqp_plan. Business justification: In APQP methodology, the Control Plan is a key deliverable output of the APQP process. A control_plan belongs to a specific apqp_plan governing the product quality planning lifecycle. This FK normaliz',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: IATF 16949 and PPAP require control plans to be tied to a specific product BOM revision. When a BOM changes (ECN), the control plan must be reviewed and updated. This FK enables change impact analysis',
    `design_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.design_specification. Business justification: Control plans are derived from design specifications; FK enables automatic extraction of spec requirements for quality control.',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: Control plans in automotive are authored per vehicle model as part of APQP/PPAP. Quality engineers retrieve all control plans for a model during model-year changeover audits and customer-specific qual',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Control plans are authored per part to define inspection and control methods — a core PPAP element. Linking to part_master replaces the denormalized part_number column and enables part-level control p',
    `inspection_plan_id` BIGINT COMMENT 'Link to the detailed inspection plan referenced by this control plan.',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: Control plans are line‑specific for process control; required for the Production Control Review report.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: IATF 16949 and APQP mandate that control plans reference applicable regulatory requirements. Control plans define process controls that must satisfy specific regulations (e.g., emissions process contr',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: IATF 16949 control plans are defined at the work center/process step level, specifying what to measure and how at each station. Linking control_plan to work_center enables station-specific SPC setup a',
    `ai_inspection_flag` BOOLEAN COMMENT 'Whether AI/ML computer vision was used in this quality process',
    `approval_date` DATE COMMENT 'Date when the control plan received final approval.',
    `approval_status` STRING COMMENT 'Current approval state of the control plan.. Valid values are `pending|approved|rejected|revoked`',
    `approved_by` STRING COMMENT 'Employee identifier who approved the control plan.',
    `change_control_number` STRING COMMENT 'Reference number for the change control record associated with this plan.',
    `control_method` STRING COMMENT 'Statistical or inspection method used to control the characteristic.. Valid values are `spc|attribute|visual|functional|dimensional`',
    `control_plan_status` STRING COMMENT 'Current lifecycle status of the control plan per IATF 16949.. Valid values are `draft|active|suspended|retired|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control plan record was first created in the system.',
    `control_plan_description` STRING COMMENT 'Free‑text description of the purpose, scope, and key characteristics of the control plan.',
    `effective_end_date` DATE COMMENT 'Date when the control plan is retired or superseded (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the control plan becomes effective for production.',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the control plan is mandatory for the operation.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the characteristic.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the control characteristic (e.g., mm, psi). [ENUM-REF-CANDIDATE: mm|cm|inch|mm2|g|kg|psi|kpa|percent — 9 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `plan_name` STRING COMMENT 'Human‑readable name of the control plan.',
    `plan_number` STRING COMMENT 'Business identifier or code assigned to the control plan (e.g., CP‑2024‑001).',
    `plan_type` STRING COMMENT 'Category of manufacturing operation the plan applies to.. Valid values are `assembly|paint|engine|chassis|electrical|final`',
    `reaction_plan` STRING COMMENT 'Defined corrective actions if a measurement falls outside specification limits.',
    `responsible_function` STRING COMMENT 'Organizational function accountable for the control plan.. Valid values are `assembly_line|quality_engineering|process_engineering|manufacturing|test_lab`',
    `revision_date` DATE COMMENT 'Date when the current revision was released.',
    `revision_number` STRING COMMENT 'Sequential revision number of the control plan.',
    `sample_frequency` STRING COMMENT 'Frequency at which sampling is performed.. Valid values are `per_shift|per_batch|per_hour|per_day`',
    `sample_size` STRING COMMENT 'Number of units inspected per sampling event as defined by the plan.',
    `target_value` DECIMAL(18,2) COMMENT 'Desired nominal value for the controlled characteristic.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the control plan record.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the characteristic.',
    `created_by` STRING COMMENT 'Name or identifier of the employee who authored the control plan.',
    CONSTRAINT pk_control_plan PRIMARY KEY(`control_plan_id`)
) COMMENT 'Quality control plan defining the process controls, inspection methods, measurement systems, reaction plans, and control characteristics for each manufacturing operation or assembly step. Links to PFMEA and inspection plans. Specifies sample sizes, frequencies, control methods (SPC, attribute, visual), and responsible functions per IATF 16949 requirements.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` (
    `inspection_plan_id` BIGINT COMMENT 'Unique identifier for the inspection plan.',
    `apqp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.apqp_plan. Business justification: Inspection plans are developed as part of the APQP structured quality planning process. Linking inspection_plan to its governing apqp_plan enables full APQP deliverable traceability. The inspection_pl',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: Inspection plans in automotive are written for specific product configurations (BOM revision, variant, model year). The inspection_plan currently stores part_number, vehicle_model, and model_year as d',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: Inspection plans are authored per vehicle model in automotive quality systems. The plain-text vehicle_model column is a denormalization of vehicle.model. A proper FK enables model-specific inspection ',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Inspection plans are created per part to specify measurement methods and acceptance criteria. Linking to part_master replaces the denormalized part_number and enables part-level inspection plan tracea',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: Inspection plans are defined per production line to meet line‑specific quality standards; used in the Line Inspection Planning process.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Inspection plans are designed to verify conformance to specific regulatory requirements (emissions measurement procedures, safety inspection criteria per FMVSS/UNECE). Compliance auditors verify inspe',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: IATF 16949 requires inspection plans to be defined per part/material. inspection_plan.part_number is a plain string denormalization of the SKU master. Linking to sku_master enables retrieval of all in',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: Inspection plans specify inspection activities at specific work centers/stations in automotive manufacturing. This link supports assignment of inspection plans to stations for in-process quality contr',
    `acceptance_criteria` STRING COMMENT 'Textual definition of pass/fail conditions.',
    `ai_inspection_flag` BOOLEAN COMMENT 'Whether AI/ML computer vision was used in this quality process',
    `applicable_process` STRING COMMENT 'Manufacturing process to which the inspection plan applies.. Valid values are `IQC|IPQC|PDI|Final`',
    `approval_date` DATE COMMENT 'Date when the inspection plan was approved.',
    `approved_by` STRING COMMENT 'User identifier of the approver.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection plan record was first created.',
    `criticality_level` STRING COMMENT 'Risk level associated with the inspection characteristic.. Valid values are `low|medium|high|critical`',
    `department_responsible` STRING COMMENT 'Organizational department owning the inspection plan.',
    `inspection_plan_description` STRING COMMENT 'Detailed description of the purpose and scope of the inspection plan.',
    `effective_end_date` DATE COMMENT 'Date when the inspection plan expires or is superseded (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the inspection plan becomes effective.',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `frequency` STRING COMMENT 'How often the inspection is performed.. Valid values are `per_batch|per_shift|per_vehicle|per_day`',
    `gauge_type` STRING COMMENT 'Specific gauge or instrument type used.. Valid values are `dial|digital|laser|micrometer`',
    `inspection_category` STRING COMMENT 'Broad category of the inspection activity.. Valid values are `dimensional|functional|visual|electrical`',
    `inspection_plan_status` STRING COMMENT 'Current lifecycle status of the inspection plan.. Valid values are `draft|active|inactive|retired`',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the inspection is performed by automated equipment.',
    `last_review_date` DATE COMMENT 'Date of the most recent plan review.',
    `measurement_method` STRING COMMENT 'Technique used to perform the measurement.. Valid values are `CMM|Gauge|Visual|Automated|Manual`',
    `measurement_unit` STRING COMMENT 'Unit of measure for tolerances and results.. Valid values are `mm|cm|inch|mm^2|psi`',
    `notes` STRING COMMENT 'Free‑form comments or special instructions.',
    `plan_name` STRING COMMENT 'Human‑readable name of the inspection plan.',
    `plan_number` STRING COMMENT 'Business identifier assigned to the inspection plan.',
    `plan_type` STRING COMMENT 'Classification of the plan (e.g., incoming material, in‑process, final vehicle).. Valid values are `incoming_material|in_process|final_vehicle|custom`',
    `plant_location` STRING COMMENT 'Code of the manufacturing plant where the plan is executed.',
    `requires_approval` BOOLEAN COMMENT 'True if the inspection results must be formally approved.',
    `review_cycle_days` STRING COMMENT 'Number of days between mandatory reviews.',
    `revision_number` STRING COMMENT 'Sequential revision number for change tracking.',
    `sample_size` STRING COMMENT 'Number of units to be inspected per batch.',
    `tolerance_lower` DECIMAL(18,2) COMMENT 'Minimum acceptable measurement value.',
    `tolerance_upper` DECIMAL(18,2) COMMENT 'Maximum acceptable measurement value.',
    `updated_by` STRING COMMENT 'Identifier of the user who last modified the inspection plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection plan.',
    `version` STRING COMMENT 'Version label of the inspection plan (e.g., v1.0, v2.1).',
    `created_by` STRING COMMENT 'Identifier of the user who created the inspection plan.',
    CONSTRAINT pk_inspection_plan PRIMARY KEY(`inspection_plan_id`)
) COMMENT 'Detailed inspection plan specifying the characteristics to be measured, measurement methods, gauges/instruments, tolerances, sample sizes, and acceptance criteria for incoming material, in-process, and final vehicle inspections. Supports incoming material inspection (IQC), in-process quality gates, and PDI (Pre-Delivery Inspection). Linked to SAP QM inspection lots.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` (
    `inspection_lot_id` BIGINT COMMENT 'System-generated unique identifier for the inspection lot record.',
    `control_plan_id` BIGINT COMMENT 'Foreign key linking to quality.control_plan. Business justification: An inspection lot is executed in accordance with a specific control plan that defines the inspection methods, sample sizes, and acceptance criteria. This FK links the transactional inspection event to',
    `inbound_part_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_part. Business justification: Required for the Inbound Part Inspection Lot report that ties each inspection lot to the specific inbound part received.',
    `inspection_plan_id` BIGINT COMMENT 'Reference to the inspection plan governing this lot.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Inspection lots are created for specific parts during incoming inspection and in-process quality checks. Linking to part_master enables part-level quality history, defect rate trending, and supplier q',
    `vehicle_compound_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle_compound. Business justification: PDI inspection lots are performed at specific vehicle compounds. Compound quality audits, PDI capability assessments, and compound performance KPIs require knowing which compound executed each inspect',
    `ppap_submission_id` BIGINT COMMENT 'Foreign key linking to supply.supply_ppap_submission. Business justification: PPAP sample inspection: incoming inspection lots are created specifically to inspect PPAP sample parts submitted by suppliers. Linking the inspection lot to the PPAP submission enables PPAP dispositio',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: In-process and final inspection lots in automotive manufacturing are created against specific production orders (SAP QM standard). This link enables production-order-level quality traceability, PPAP d',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: REQUIRED: Inspection lots are executed per part; adding sku_master_id supports the Lot Traceability Report linking lots to the specific SKU.',
    `stock_balance_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_balance. Business justification: Automotive quality inspection directly manages stock in quality inspection status. stock_balance has quality_inspection_stock_qty and quality_status fields. Linking inspection_lot to the specific st',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supply_supplier. Business justification: Needed for the Supplier Inspection Summary dashboard aggregating inspection lots per supplier.',
    `vehicle_transport_order_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle_transport_order. Business justification: PDI (Pre-Delivery Inspection) lots in automotive are directly triggered by vehicle transport orders upon compound arrival. The transport order is the operational trigger document for PDI inspection lo',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: Inspection lots are performed at specific work centers/stations. The existing plain-text work_center column is a denormalization. A proper FK enables work-center-level defect rate KPIs and station q',
    `ai_inspection_flag` BOOLEAN COMMENT 'Whether AI/ML computer vision was used in this quality process',
    `batch_number` STRING COMMENT 'Batch identifier associated with the material or component.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the corrective action must be completed.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a corrective action must be initiated for the identified defect.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection lot record was first created in the system.',
    `decision` STRING COMMENT 'Final usage decision for the lot after inspection.. Valid values are `accept|reject|conditional_release`',
    `defect_code` STRING COMMENT 'Standardized code for any defect identified during inspection.',
    `defect_description` STRING COMMENT 'Narrative description of the defect.',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `inspection_lot_status` STRING COMMENT 'Current lifecycle status of the inspection lot.. Valid values are `open|in_progress|closed|rejected|released`',
    `inspection_method` STRING COMMENT 'Technique used to perform the inspection.. Valid values are `visual|dimensional|functional|non_destructive|automated`',
    `inspection_reason_code` STRING COMMENT 'Code indicating why the inspection was triggered (e.g., SOP, PPAP, random sampling).',
    `inspection_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection activity was performed.',
    `lot_closure_date` DATE COMMENT 'Date when the inspection lot was closed after final decision.',
    `lot_number` STRING COMMENT 'Business identifier assigned to the inspection lot, often matching the SAP lot number.',
    `lot_origin` STRING COMMENT 'Origin of the lot (e.g., goods receipt, production order).. Valid values are `goods_receipt|production_order|delivery|return`',
    `lot_type` STRING COMMENT 'Classification of the lot being inspected (e.g., incoming material, work‑in‑process assembly, finished vehicle, prototype).. Valid values are `incoming_material|wip_assembly|finished_vehicle|prototype`',
    `measurement_result_status` STRING COMMENT 'Result of the measurement against specification limits.. Valid values are `pass|fail|out_of_spec`',
    `measurement_unit` STRING COMMENT 'Unit of measure associated with the measured value (e.g., mm, V).',
    `measurement_value` DECIMAL(18,2) COMMENT 'Quantitative measurement recorded during inspection (e.g., dimension, voltage).',
    `quantity_accepted` STRING COMMENT 'Number of units/items that passed inspection criteria.',
    `quantity_inspected` STRING COMMENT 'Total number of units/items examined in this inspection lot.',
    `quantity_rejected` STRING COMMENT 'Number of units/items that failed inspection criteria.',
    `remarks` STRING COMMENT 'Free‑form comments or notes captured by the inspector.',
    `serial_number` STRING COMMENT 'Serial number of the inspected unit, if applicable.',
    `source_document_number` STRING COMMENT 'Reference number of the originating document such as goods receipt, production order, or delivery.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection lot record.',
    CONSTRAINT pk_inspection_lot PRIMARY KEY(`inspection_lot_id`)
) COMMENT 'Transactional record of a quality inspection event triggered for a batch of incoming materials, WIP assemblies, or finished vehicles. Captures lot origin (goods receipt, production order, delivery), inspection type, quantity inspected, inspection start/end timestamps, assigned inspector, and overall usage decision (accept, reject, conditional release). Sourced from SAP QM inspection lot management.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`quality`.`inspection_result` (
    `inspection_result_id` BIGINT COMMENT 'Unique identifier for the inspection result record.',
    `characteristic_id` BIGINT COMMENT 'Identifier of the inspected characteristic or measurement point.',
    `inspection_lot_id` BIGINT COMMENT 'Identifier of the inspection lot (header) to which this result belongs.',
    `ai_inspection_flag` BOOLEAN COMMENT 'Whether AI/ML computer vision was used in this quality process',
    `comments` STRING COMMENT 'Free-text notes or observations recorded by the inspector.',
    `cp_value` DECIMAL(18,2) COMMENT 'Cp value calculated for the characteristic.',
    `cpk_value` DECIMAL(18,2) COMMENT 'Cpk value calculated for the characteristic.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection result record was created.',
    `deviation_amount` DECIMAL(18,2) COMMENT 'Numeric difference between measured value and nearest specification limit.',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the measurement was taken.',
    `is_critical` BOOLEAN COMMENT 'Indicates if the characteristic is critical to vehicle safety or compliance.',
    `line_sequence` STRING COMMENT 'Sequential order of the characteristic within the inspection lot.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for the characteristic.',
    `measurement_accuracy` DECIMAL(18,2) COMMENT 'Accuracy specification of the measurement instrument.',
    `measurement_condition` STRING COMMENT 'Environmental condition during measurement.. Valid values are `normal|high_temp|low_temp|vibration`',
    `measurement_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity percentage at time of measurement.',
    `measurement_location` STRING COMMENT 'Physical location on the vehicle or part where measurement was taken.',
    `measurement_method` STRING COMMENT 'Method used to capture the measurement.. Valid values are `manual|automated|sensor`',
    `measurement_resolution` DECIMAL(18,2) COMMENT 'Resolution of the measurement instrument.',
    `measurement_source` STRING COMMENT 'Origin of the measurement data (e.g., internal sensor, external lab).. Valid values are `internal|external`',
    `measurement_temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature in Celsius at time of measurement.',
    `measurement_tool` STRING COMMENT 'Tool or equipment used for the measurement.',
    `measurement_uncertainty` DECIMAL(18,2) COMMENT 'Estimated uncertainty of the measurement.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the measured value (e.g., millimeter, kilogram).. Valid values are `mm|cm|in|mmHg|psi|kg`',
    `measurement_value` DECIMAL(18,2) COMMENT 'Numeric value recorded for the characteristic.',
    `record_status` STRING COMMENT 'Current lifecycle status of the record (e.g., active, archived).. Valid values are `active|inactive|archived`',
    `result_status` STRING COMMENT 'Pass/fail outcome of the measurement.. Valid values are `pass|fail|na`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for the characteristic.',
    CONSTRAINT pk_inspection_result PRIMARY KEY(`inspection_result_id`)
) COMMENT 'Individual characteristic measurement result recorded during an inspection lot. Captures the measured value or attribute outcome, tolerance limits, pass/fail status, measurement instrument used, and inspector ID for each characteristic within an inspection plan. Supports SPC data collection and statistical analysis of process capability (Cp, Cpk).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`quality`.`defect_record` (
    `defect_record_id` BIGINT COMMENT 'System-generated unique identifier for the defect record.',
    `apqp_plan_id` BIGINT COMMENT 'Reference to the quality plan or inspection plan associated with the defect.',
    `case_id` BIGINT COMMENT 'Foreign key linking to customer.case. Business justification: Field quality reporting process: automotive OEMs link defect records to customer cases (warranty complaints) for 8D reporting and warranty cost tracking. A quality engineer would immediately expect to',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Defects resolved through engineering change orders (ECOs) must be linked to the implementing change — standard 8D Step 5 (permanent corrective action). Quality managers track which ECO closed a defect',
    `control_plan_id` BIGINT COMMENT 'Foreign key linking to quality.control_plan. Business justification: A defect record should reference the control plan under which the defect was detected. This enables analysis of which control plans are failing to prevent defects, supporting IATF 16949 control plan e',
    `dealer_repair_order_id` BIGINT COMMENT 'Foreign key linking to dealer.dealer_repair_order. Business justification: Warranty defect analysis and repeat repair tracking (8D investigations) require linking defect records to the dealer repair order that surfaced the defect. Core automotive warranty quality process — O',
    `dealership_id` BIGINT COMMENT 'Foreign key linking to dealer.dealership. Business justification: Defect records are frequently generated from dealer warranty claims; linking enables root‑cause analysis and dealer‑specific defect trends.',
    `fmea_record_id` BIGINT COMMENT 'Foreign key linking to engineering.fmea_record. Business justification: Detected defects are traced to FMEA failure modes for 8D root cause analysis and RPN recalculation — a mandatory AIAG FMEA/APQP requirement. Quality engineers must link defect occurrences to the origi',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A defect record is frequently raised as a result of a failed inspection lot. Linking defect_record to the originating inspection_lot provides full traceability from defect discovery back to the inspec',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: Model-level defect tracking supports recall analysis, warranty cost reporting by model, and field service bulletins. Defects may be identified at model level before individual VINs are implicated. Qua',
    `ncap_test_result_id` BIGINT COMMENT 'Foreign key linking to quality.ncap_test_result. Business justification: A defect record can be raised as a result of a failed NCAP or regulatory safety test. Linking defect_record to the originating ncap_test_result enables traceability from safety test failures to the de',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: Defect records must reference the canonical part master for root‑cause analysis; removes redundant part_number/name.',
    `powertrain_variant_id` BIGINT COMMENT 'Foreign key linking to vehicle.powertrain_variant. Business justification: Powertrain-specific defect campaigns (e.g., engine oil consumption, transmission shudder) require defect records scoped to a powertrain variant. Field service engineering teams issue technical service',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Defect records are tied to the specific production order where the defect was detected, essential for the Defect Tracking Dashboard.',
    `root_cause_analysis_id` BOOLEAN COMMENT 'Foreign key linking to quality.root_cause_analysis. Business justification: A defect record should directly reference its root cause analysis record. Currently defect_record has a free-text root_cause STRING column which is a denormalized representation of what should be a st',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to logistics.shipment_leg. Business justification: Carrier liability claims for transport damage require attributing defects to the specific shipment leg (e.g., sea vs. final truck delivery). Automotive damage claim processes and carrier scorecards de',
    `sku_master_id` BIGINT COMMENT 'Identifier of the part or component associated with the defect.',
    `spc_chart_id` BIGINT COMMENT 'Foreign key linking to quality.spc_chart. Business justification: A defect record can be triggered by an SPC out-of-control signal. Linking defect_record to the spc_chart that detected the process deviation enables SPC-driven defect traceability and supports OCAP (O',
    `vehicle_build_id` BIGINT COMMENT 'Foreign key linking to manufacturing.vehicle_build. Business justification: Defect records in automotive manufacturing must trace to the specific vehicle build where the defect was found. This enables build-level quality history, end-of-line defect traceability, and VIN-speci',
    `vehicle_compound_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle_compound. Business justification: Defects originating during compound storage (weather damage, handling damage, vandalism) must be attributed to the specific compound for insurance claims, compound operator accountability, and compoun',
    `vehicle_handover_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle_handover. Business justification: Defects discovered at vehicle handover (PDI punch list, delivery damage) are a core automotive quality process. Linking defect records to the handover event enables PDI defect rate KPIs, handover qual',
    `vin_registry_id` BIGINT COMMENT 'Foreign key linking to vehicle.vin_registry. Business justification: Defect records are tied to a specific VIN; FK to vin_registry allows traceability from defect to exact vehicle for warranty and recall actions.',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: Defects are detected and attributed to specific work centers/stations. This enables station-level defect rate analysis, Pareto charts by work center, and targeted process improvement — a standard auto',
    `ai_inspection_flag` BOOLEAN COMMENT 'Whether AI/ML computer vision was used in this quality process',
    `containment_action` STRING COMMENT 'Immediate action taken to contain the defect and prevent further impact.',
    `corrective_action` STRING COMMENT 'Planned or executed action to eliminate the root cause of the defect.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the corrective action must be completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the defect record was initially created in the system.',
    `defect_category` STRING COMMENT 'Stage of the product lifecycle where the defect was detected.. Valid values are `incoming|in_process|final|field`',
    `defect_code` STRING COMMENT 'Business identifier code assigned to the defect for tracking and reporting.',
    `defect_description` STRING COMMENT 'Detailed textual description of the non‑conformance or quality issue.',
    `defect_record_status` STRING COMMENT 'Current lifecycle status of the defect record.. Valid values are `open|investigating|closed|rejected|deferred`',
    `defect_type` STRING COMMENT 'Classification of the defect by its origin or nature.. Valid values are `material|process|design|supplier|assembly|software`',
    `detected_timestamp` TIMESTAMP COMMENT 'Date and time when the defect was first observed.',
    `detection_method` STRING COMMENT 'Method or channel through which the defect was discovered.. Valid values are `inspection|test|audit|customer_complaint|sensor|automated`',
    `disposition` STRING COMMENT 'Final disposition of the defective item after evaluation.. Valid values are `rework|scrap|use_as_is|return_to_supplier|deferred`',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `investigation_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation was concluded.',
    `investigation_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the root‑cause investigation began.',
    `is_repeat_defect` BOOLEAN COMMENT 'Flag indicating whether this defect has been observed previously.',
    `location_zone` STRING COMMENT 'Vehicle zone or assembly area where the defect was identified (e.g., body, powertrain).',
    `ppm_rate` DECIMAL(18,2) COMMENT 'Defect rate expressed in parts per million for quality metrics.',
    `quantity_affected` STRING COMMENT 'Number of units or parts impacted by the defect.',
    `severity` STRING COMMENT 'Severity level indicating impact on safety, performance, or compliance.. Valid values are `critical|major|minor|warning|info`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the defect record.',
    `vin` STRING COMMENT 'VIN of the vehicle in which the defect was found.',
    CONSTRAINT pk_defect_record PRIMARY KEY(`defect_record_id`)
) COMMENT 'Operational record of a quality defect or non-conformance identified at any stage — incoming material, in-process assembly, final inspection, or field. Captures defect code, defect description, location on vehicle (zone/component), severity classification, detection method, quantity affected, containment action taken, and disposition (rework, scrap, use-as-is). Sourced from Apriso/Dassault MES quality control module.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`quality`.`spc_chart` (
    `spc_chart_id` BIGINT COMMENT 'System‑generated unique identifier for the SPC chart configuration record.',
    `characteristic_id` BIGINT COMMENT 'Foreign key linking to quality.characteristic. Business justification: An SPC chart monitors a specific Critical-to-Quality (CTQ) characteristic. Currently spc_chart has a ctq_characteristic STRING column which is a denormalized text reference to what should be a structu',
    `control_plan_id` BIGINT COMMENT 'Foreign key linking to quality.control_plan. Business justification: An SPC chart is defined and governed within the context of a control plan. The control plan specifies which characteristics require SPC monitoring, the control limits, and the sampling frequency. Link',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to engineering.part_master. Business justification: SPC charts monitor process variation for specific parts. Linking spc_chart to part_master enables part-level SPC history retrieval for PPAP submissions, supplier quality scorecards, and process capabi',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_center. Business justification: SPC charts monitor key characteristics of each work center; required for the Work Center SPC Dashboard.',
    `ai_inspection_flag` BOOLEAN COMMENT 'Whether AI/ML computer vision was used in this quality process',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the SPC chart configuration was formally approved.',
    `center_line` DECIMAL(18,2) COMMENT 'Target center line (mean) for the SPC chart.',
    `chart_name` STRING COMMENT 'Human‑readable name identifying the SPC chart for a specific CTQ characteristic.',
    `chart_type` STRING COMMENT 'Type of SPC chart used to monitor the characteristic (e.g., X‑bar/R, p‑chart).. Valid values are `X-bar/R|X-bar/S|p-chart|c-chart|u-chart|np-chart`',
    `confidence_level` DECIMAL(18,2) COMMENT 'Statistical confidence level applied when setting control limits, expressed as a percentage.',
    `control_limit_lcl` DECIMAL(18,2) COMMENT 'Statistical lower control limit for the chart, calculated from process data.',
    `control_limit_ucl` DECIMAL(18,2) COMMENT 'Statistical upper control limit for the chart, calculated from process data.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the SPC chart record was first created in the system.',
    `data_source_system` STRING COMMENT 'System of record that supplies the raw measurement data for the SPC chart.. Valid values are `SAP QM|MES|Teamcenter|Custom`',
    `spc_chart_description` STRING COMMENT 'Free‑form description providing additional context for the chart.',
    `effective_from` DATE COMMENT 'Date from which the SPC chart configuration becomes valid.',
    `effective_until` DATE COMMENT 'Date after which the SPC chart configuration is no longer valid (null if open‑ended).',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the monitored characteristic (e.g., mm, psi). [ENUM-REF-CANDIDATE: mm|cm|mmHg|psi|rpm|kg|%|mm/s — 8 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Optional free‑text field for any extra information or remarks.',
    `ocap` STRING COMMENT 'Defined actions to be taken when the chart signals an out‑of‑control condition.',
    `process_step` STRING COMMENT 'Descriptive name of the manufacturing process step where the SPC chart is applied.',
    `process_step_code` STRING COMMENT 'Internal code identifying the process step (e.g., ASSEMBLY_01).',
    `sample_count` STRING COMMENT 'Total number of samples used to compute the charts control limits.',
    `sampling_frequency` STRING COMMENT 'Frequency at which samples are taken for the SPC chart.. Valid values are `per_shift|per_hour|per_day|per_batch|per_lot`',
    `spc_chart_status` STRING COMMENT 'Current lifecycle status of the SPC chart configuration.. Valid values are `active|inactive|deprecated|pending`',
    `statistical_method` STRING COMMENT 'Statistical technique used to calculate control limits (e.g., Shewhart, EWMA).. Valid values are `Shewhart|EWMA|CUSUM|XMR`',
    `subgroup_size` STRING COMMENT 'Number of units in each sampling subgroup used for chart calculations.',
    `target_value` DECIMAL(18,2) COMMENT 'Desired target value for the characteristic (center line target).',
    `tolerance_lower` DECIMAL(18,2) COMMENT 'Lower acceptable tolerance bound for the characteristic.',
    `tolerance_upper` DECIMAL(18,2) COMMENT 'Upper acceptable tolerance bound for the characteristic.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the SPC chart record.',
    `version_number` STRING COMMENT 'Version identifier for the chart configuration, incremented on changes.',
    CONSTRAINT pk_spc_chart PRIMARY KEY(`spc_chart_id`)
) COMMENT 'Statistical Process Control chart master record defining the SPC monitoring configuration for a critical-to-quality (CTQ) characteristic at a specific process step. Specifies chart type (X-bar/R, X-bar/S, p-chart, c-chart), control limits (UCL, LCL), center line, subgroup size, sampling frequency, and out-of-control action plan (OCAP). Supports IATF 16949 SPC requirements.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`quality`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'Primary key',
    `apqp_plan_id` BIGINT COMMENT '',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Corrective actions (8D reports) are formally issued to carriers for transport damage in automotive. quality_corrective_action has supply_supplier_id for supplier CAPAs but no carrier_id for carrier CA',
    `case_id` BIGINT COMMENT 'Foreign key linking to customer.case. Business justification: Customer complaint resolution process: corrective actions raised in response to customer cases must be traceable to the originating case for warranty cost reporting, customer satisfaction tracking, an',
    `change_id` BIGINT COMMENT 'Foreign key linking to engineering.change. Business justification: Permanent corrective actions in 8D are implemented via engineering change orders. Linking quality_corrective_action to the engineering change that executes the fix is required for closed-loop quality ',
    `control_plan_id` BIGINT COMMENT '',
    `dealership_id` BIGINT COMMENT 'Foreign key linking to dealer.dealership. Business justification: OEM dealer quality audits and PDI non-conformance management require corrective actions issued directly to specific dealerships. Dealer-specific corrective action reporting and franchise compliance tr',
    `defect_record_id` BIGINT COMMENT 'FK to defect record',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A corrective action is frequently triggered by a failed inspection lot. Linking quality_corrective_action to the originating inspection_lot provides the operational context for the corrective action —',
    `ncap_test_result_id` BIGINT COMMENT 'Foreign key linking to quality.ncap_test_result. Business justification: A corrective action can be initiated in response to a failed NCAP or regulatory safety test result. Linking quality_corrective_action to ncap_test_result enables traceability from safety test failures',
    `recall_campaign_id` BIGINT COMMENT 'Foreign key linking to compliance.recall_campaign. Business justification: Recall campaigns mandate specific corrective actions as the remedy. Compliance teams track which corrective actions fulfill recall remedy obligations to report completion rates to regulatory bodies (N',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Corrective actions in automotive are frequently triggered by regulatory non-conformance findings (e.g., emissions exceedance, safety standard violation). Linking corrective actions to the specific reg',
    `root_cause_analysis_id` BOOLEAN COMMENT '',
    `spc_chart_id` BIGINT COMMENT 'Foreign key linking to quality.spc_chart. Business justification: A corrective action can be triggered by an SPC out-of-control condition. Linking quality_corrective_action to the spc_chart that triggered the OCAP enables SPC-driven corrective action traceability. T',
    `supplier_id` BIGINT COMMENT '',
    `supplier_scorecard_id` BIGINT COMMENT 'Foreign key linking to supply.supplier_scorecard. Business justification: Supplier development process: poor scorecard performance (low PPM, OTD, quality scores) formally triggers corrective action requests. Linking the corrective action to the scorecard that triggered it e',
    `action_description` STRING COMMENT '',
    `action_number` STRING COMMENT 'Corrective action number',
    `action_status` STRING COMMENT 'Action status',
    `action_type` STRING COMMENT 'Action type (8D, CAPA, etc.)',
    `ai_inspection_flag` BOOLEAN COMMENT 'Whether AI/ML computer vision was used in this quality process',
    `closed_date` DATE COMMENT '',
    `closure_date` DATE COMMENT 'Closure date',
    `completion_date` DATE COMMENT '',
    `containment_action` STRING COMMENT 'Containment action taken',
    `corrective_action` STRING COMMENT '',
    `corrective_action_number` STRING COMMENT '',
    `cost_of_action` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `corrective_action_description` STRING COMMENT 'Corrective action description',
    `due_date` DATE COMMENT 'Due date',
    `effectiveness_check_date` DATE COMMENT '',
    `effectiveness_status` STRING COMMENT '',
    `effectiveness_verification` STRING COMMENT '',
    `effectiveness_verified` BOOLEAN COMMENT 'Effectiveness verified flag',
    `effectiveness_verified_flag` BOOLEAN COMMENT '',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `is_effective` BOOLEAN COMMENT '',
    `is_eight_d_flag` BOOLEAN COMMENT '',
    `is_recurring` BOOLEAN COMMENT '',
    `notes` STRING COMMENT '',
    `opened_date` DATE COMMENT '',
    `preventive_action` STRING COMMENT '',
    `preventive_action_description` STRING COMMENT 'Preventive action description',
    `priority` STRING COMMENT '',
    `problem_description` STRING COMMENT '',
    `quality_corrective_action_status` STRING COMMENT '',
    `raised_date` DATE COMMENT '',
    `root_cause` STRING COMMENT '',
    `root_cause_description` STRING COMMENT 'Root cause description',
    `severity` STRING COMMENT '',
    `title` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `verification_date` DATE COMMENT '',
    `verification_method` STRING COMMENT '',
    `verification_status` STRING COMMENT '',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Corrective and Preventive Action (CAPA) record managing the structured problem-solving process for quality escapes and non-conformances. Supports 8D (Eight Disciplines) and 5-Why methodologies. Captures problem statement, containment actions (D3), root cause analysis (D4/5-Why), permanent corrective actions (D5), verification of effectiveness (D6), and preventive action deployment (D7). Tracks open/closed status and due dates.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` (
    `ncap_test_result_id` BIGINT COMMENT 'System-generated unique identifier for the NCAP test result record.',
    `apqp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.apqp_plan. Business justification: NCAP test results are directly tied to the APQP plan governing the vehicle programs quality planning. NCAP testing is a key validation gate in the APQP process, and linking ncap_test_result to the go',
    `bom_header_id` BIGINT COMMENT 'Foreign key linking to product.bom_header. Business justification: NCAP and homologation testing (Euro NCAP, NHTSA) is conducted on a specific vehicle BOM configuration. Regulators require traceability between test results and the exact product configuration tested. ',
    `change_id` BIGINT COMMENT 'Identifier of the engineering change (ECN) associated with the vehicle configuration.',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to vehicle.configuration. Business justification: NCAP homologation tests are conducted on a specific vehicle configuration (exact powertrain, trim, market spec). Regulatory submissions require traceability from test result to the exact configuration',
    `fmvss_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.fmvss_certification. Business justification: FMVSS certifications (US market) require crash and safety test evidence. NCAP test results are the specific test records that substantiate FMVSS certification filings. Compliance engineers reference e',
    `homologation_record_id` BIGINT COMMENT 'Foreign key linking to compliance.homologation_record. Business justification: NCAP test results are primary evidence in the homologation dossier for type-approval. Compliance and quality teams jointly manage the homologation submission using NCAP data. A quality engineer and ho',
    `model_id` BIGINT COMMENT 'Foreign key linking to vehicle.model. Business justification: NCAP ratings are published and tracked per vehicle model for marketing, homologation, and regulatory compliance reporting. Quality and product teams query NCAP results by model to support safety certi',
    `vin_registry_id` BIGINT COMMENT 'Internal surrogate key for the vehicle under test.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: NCAP tests are conducted to satisfy specific regulatory requirements (UNECE R94, FMVSS 208, etc.). Linking each test result to the regulatory requirement it validates is standard homologation traceabi',
    `ai_inspection_flag` BOOLEAN COMMENT 'Whether AI/ML computer vision was used in this quality process',
    `compliance_status` STRING COMMENT 'Overall compliance determination against applicable safety regulations.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result record was first created in the data lake.',
    `data_source_system` STRING COMMENT 'Source system that supplied the test result data.. Valid values are `SAP|Teamcenter|MES|Custom`',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `homologation_status` STRING COMMENT 'Regulatory approval status of the vehicle based on the test outcome.. Valid values are `passed|failed|pending|exempt`',
    `rating_scale` STRING COMMENT 'Scale definition used for the star rating (e.g., 5‑star).',
    `raw_score_front` DECIMAL(18,2) COMMENT 'Raw numeric score for the frontal offset impact test.',
    `raw_score_pole` DECIMAL(18,2) COMMENT 'Raw numeric score for the pole impact test.',
    `raw_score_side` DECIMAL(18,2) COMMENT 'Raw numeric score for the side impact test.',
    `star_rating` STRING COMMENT 'Overall star rating assigned by the NCAP program (0‑5).',
    `test_comments` STRING COMMENT 'Free‑text notes captured by the test team.',
    `test_condition` STRING COMMENT 'Environmental and operational conditions during the test (e.g., temperature, humidity).',
    `test_configuration` STRING COMMENT 'Detailed configuration of the vehicle for the test (e.g., seat position, restraint settings).',
    `test_date` DATE COMMENT 'Calendar date on which the crash test was performed.',
    `test_facility` STRING COMMENT 'Name of the laboratory or proving ground where the test took place.',
    `test_observer` STRING COMMENT 'Name of the independent observer or auditor present during testing.',
    `test_program` STRING COMMENT 'The NCAP program under which the vehicle was tested.. Valid values are `Euro NCAP|NHTSA|ANCAP|Global NCAP`',
    `test_report_number` STRING COMMENT 'External reference number assigned by the testing authority for the test report.',
    `test_result_status` STRING COMMENT 'Lifecycle status of the test result record.. Valid values are `draft|final|approved|rejected`',
    `test_type` STRING COMMENT 'Category of crash test performed.. Valid values are `frontal_offset|side_impact|pole|pedestrian|aeb`',
    `test_version` STRING COMMENT 'Version identifier of the test protocol used.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the test result record.',
    `vehicle_vin` STRING COMMENT 'Globally unique vehicle identifier used to link the test result to a specific vehicle.',
    CONSTRAINT pk_ncap_test_result PRIMARY KEY(`ncap_test_result_id`)
) COMMENT 'New Car Assessment Programme (NCAP) and regulatory crash/safety test result record for a vehicle model variant. Captures test program (Euro NCAP, NHTSA, ANCAP), test date, test facility, vehicle configuration tested, test type (frontal offset, side impact, pole test, pedestrian, AEB), raw scores, star ratings, and homologation status. Supports regulatory compliance and product safety reporting.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`quality`.`characteristic` (
    `characteristic_id` BIGINT COMMENT 'Primary key for characteristic',
    `parent_characteristic_id` BIGINT COMMENT 'Self-referencing FK on characteristic (parent_characteristic_id)',
    `product_bom_line_id` BIGINT COMMENT 'Foreign key linking to product.product_bom_line. Business justification: APQP/PPAP requires critical and significant characteristics to be assigned to specific BOM component positions. Linking characteristic to product_bom_line enables the quality team to identify which BO',
    `ai_inspection_flag` BOOLEAN COMMENT 'Whether AI/ML computer vision was used in this quality process',
    `characteristic_category` STRING COMMENT 'Broad classification of the characteristic within quality domains.',
    `characteristic_status` STRING COMMENT 'Current lifecycle status of the characteristic.',
    `created_by_user` STRING COMMENT 'User identifier who initially created the characteristic record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the characteristic record was first created.',
    `criticality_level` STRING COMMENT 'Business impact rating of the characteristic on product quality.',
    `data_type` STRING COMMENT 'Data type of the characteristics measured value.',
    `characteristic_description` STRING COMMENT 'Detailed description of what the characteristic measures or represents.',
    `effective_from` DATE COMMENT 'Date when the characteristic becomes valid for use.',
    `effective_until` DATE COMMENT 'Date when the characteristic is retired or superseded (nullable).',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `frequency` STRING COMMENT 'How often the characteristic is measured or evaluated.',
    `measurement_method` STRING COMMENT 'Technique used to capture the characteristic value.',
    `measurement_unit` STRING COMMENT 'Unit of measure associated with the characteristic (e.g., mm, kg, sec).',
    `characteristic_name` STRING COMMENT 'Human‑readable name of the quality characteristic.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the characteristic.',
    `target_value` DECIMAL(18,2) COMMENT 'Target or nominal value that the characteristic should achieve.',
    `tolerance_lower` DECIMAL(18,2) COMMENT 'Maximum acceptable deviation below the target value.',
    `tolerance_upper` DECIMAL(18,2) COMMENT 'Maximum acceptable deviation above the target value.',
    `updated_by_user` STRING COMMENT 'User identifier who last modified the characteristic record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the characteristic record.',
    CONSTRAINT pk_characteristic PRIMARY KEY(`characteristic_id`)
) COMMENT 'Master reference table for characteristic. Referenced by characteristic_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` (
    `root_cause_analysis_id` BOOLEAN COMMENT 'Primary key for root_cause_analysis',
    `fmea_record_id` BIGINT COMMENT 'Foreign key linking to engineering.fmea_record. Business justification: Root cause analyses reference FMEA failure modes as input and feed back updated RPN scores — explicitly required by AIAG FMEA 4th edition and IATF 16949. Quality engineers must link RCA findings to th',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: A root cause analysis is frequently initiated based on findings from an inspection lot (e.g., incoming material rejection, in-process quality gate failure). Linking root_cause_analysis directly to the',
    `parent_root_cause_analysis_id` BOOLEAN COMMENT 'Self-referencing FK on root_cause_analysis (related_root_cause_analysis_id)',
    `actual_resolution_date` DATE COMMENT 'Date on which the corrective action was actually completed.',
    `ai_inspection_flag` BOOLEAN COMMENT 'Whether AI/ML computer vision was used in this quality process',
    `root_cause_analysis_category` STRING COMMENT 'High‑level classification of the root cause source.',
    `root_cause_analysis_code` STRING COMMENT 'Business identifier or code used to reference the root cause in reports and work orders.',
    `corrective_action_owner` STRING COMMENT 'Person or team accountable for executing the corrective action plan.',
    `corrective_action_plan` STRING COMMENT 'Planned corrective actions to eliminate or mitigate the root cause.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the root cause analysis record was first created.',
    `root_cause_analysis_description` STRING COMMENT 'Detailed narrative describing the root cause, its symptoms, and context.',
    `detection_phase` STRING COMMENT 'Process phase in which the root cause was first detected.',
    `effective_from` DATE COMMENT 'Date from which the root cause analysis definition becomes active.',
    `effective_until` DATE COMMENT 'Date after which the root cause analysis definition is retired (nullable).',
    `failure_mode` STRING COMMENT 'Specific failure mode linked to the root cause (e.g., "Crack in chassis").',
    `field_service_info` STRING COMMENT 'Field service related information, consolidating field service concepts.',
    `impact_description` STRING COMMENT 'Narrative of the business or safety impact caused by the root cause.',
    `root_cause_analysis_name` STRING COMMENT 'Human‑readable name of the root cause (e.g., "Incorrect Torque Specification").',
    `occurrence_phase` STRING COMMENT 'Process phase where the root cause actually occurred.',
    `owner` STRING COMMENT 'Name of the person or team responsible for investigating and resolving the root cause.',
    `priority` STRING COMMENT 'Business priority assigned to address the root cause.',
    `risk_rating` STRING COMMENT 'Overall risk rating associated with the root cause.',
    `root_cause_analysis_status` STRING COMMENT 'Current lifecycle status of the root cause analysis.',
    `root_cause_analysis_type` STRING COMMENT 'Indicates whether the cause is systemic, occasional, or a one‑off event.',
    `severity_level` STRING COMMENT 'Numeric rating (1‑5) of the impact severity of the root cause on product quality.',
    `target_resolution_date` DATE COMMENT 'Planned date by which the corrective action should be completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the root cause analysis record.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action resolved the root cause.',
    `verification_result` STRING COMMENT 'Outcome of the verification activity.',
    CONSTRAINT pk_root_cause_analysis PRIMARY KEY(`root_cause_analysis_id`)
) COMMENT 'Master reference table for root_cause_analysis. Referenced by root_cause_analysis_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` (
    `control_plan_characteristic_id` BIGINT COMMENT 'Primary key for the control_plan_characteristic association',
    `characteristic_id` BIGINT COMMENT 'Foreign key linking to the quality characteristic being controlled by this line item.',
    `control_plan_id` BIGINT COMMENT 'Foreign key linking to the parent quality control plan that contains this line item.',
    `control_method` STRING COMMENT 'Statistical or inspection method used to control this characteristic within this specific control plan (e.g., SPC, attribute gauge, visual, CMM). Varies per plan-characteristic combination.',
    `lower_spec_limit` DECIMAL(18,2) COMMENT 'Minimum acceptable value for this characteristic as enforced by this control plan. May be tightened relative to the engineering drawing limit at intermediate process stages.',
    `measurement_system` STRING COMMENT 'The measurement system or gauge type used to evaluate this characteristic within this control plan (e.g., CMM, go/no-go gauge, vision system). Varies by process stage.',
    `measurement_unit` STRING COMMENT 'Unit of measure for this characteristic measurement within this control plan context (e.g., mm, psi, Nm). Moved from control_plan header as it is characteristic-specific.',
    `process_step_sequence` BIGINT COMMENT 'Ordinal position of this characteristic within the control plan, representing the process step sequence number as defined in the APQP control plan document.',
    `reaction_plan` STRING COMMENT 'Defined corrective actions to be taken if this characteristic falls outside specification limits within this control plan context. Stage-specific reaction plans differ across manufacturing stages.',
    `sample_frequency` STRING COMMENT 'Frequency at which this characteristic is sampled within this control plan (e.g., every 2 hours, every 50 parts). Stage-specific and may differ across plans for the same characteristic.',
    `sample_size` BIGINT COMMENT 'Number of units inspected per sampling event for this characteristic as defined within this control plan. May differ from the plan-level default.',
    `target_value` DECIMAL(18,2) COMMENT 'Desired nominal value for this characteristic as specified within this control plan. Moved from control_plan header as it is characteristic-specific within each plan.',
    `upper_spec_limit` DECIMAL(18,2) COMMENT 'Maximum acceptable value for this characteristic as enforced by this control plan. May be tightened relative to the engineering drawing limit at intermediate process stages.',
    CONSTRAINT pk_control_plan_characteristic PRIMARY KEY(`control_plan_characteristic_id`)
) COMMENT 'This association product represents the Control Plan Line Item — the operational record defined by AIAG APQP that links a specific quality control plan to a specific characteristic at a given process step. Each record captures how that characteristic is controlled within the context of that plan, including the control method, sampling regime, specification limits, and reaction plan applicable to that plan-characteristic combination. This is a core IATF 16949 deliverable actively created, reviewed, and updated by quality engineers during APQP and production launches.. Existence Justification: In automotive APQP/IATF 16949 practice, a control plan is explicitly a characteristic-level document where each line item represents a specific characteristic monitored at a specific process step. One control plan covers many characteristics (e.g., a door assembly control plan monitors torque, gap, flush, paint thickness), and one characteristic (e.g., a critical weld diameter) is actively controlled by multiple control plans across different manufacturing stages (e.g., sub-assembly CP, final assembly CP, outgoing inspection CP). The business actively creates, updates, and deletes these plan-characteristic line items as part of APQP deliverables, and each combination carries its own control method, sample size, reaction plan, and spec limits that differ per plan-characteristic pairing.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ADD CONSTRAINT `fk_quality_control_plan_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ADD CONSTRAINT `fk_quality_inspection_plan_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ADD CONSTRAINT `fk_quality_inspection_lot_inspection_plan_id` FOREIGN KEY (`inspection_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`inspection_plan`(`inspection_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_characteristic_id` FOREIGN KEY (`characteristic_id`) REFERENCES `vibe_automotive_v1`.`quality`.`characteristic`(`characteristic_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ADD CONSTRAINT `fk_quality_inspection_result_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_automotive_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_automotive_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_ncap_test_result_id` FOREIGN KEY (`ncap_test_result_id`) REFERENCES `vibe_automotive_v1`.`quality`.`ncap_test_result`(`ncap_test_result_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_root_cause_analysis_id` FOREIGN KEY (`root_cause_analysis_id`) REFERENCES `vibe_automotive_v1`.`quality`.`root_cause_analysis`(`root_cause_analysis_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ADD CONSTRAINT `fk_quality_defect_record_spc_chart_id` FOREIGN KEY (`spc_chart_id`) REFERENCES `vibe_automotive_v1`.`quality`.`spc_chart`(`spc_chart_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_characteristic_id` FOREIGN KEY (`characteristic_id`) REFERENCES `vibe_automotive_v1`.`quality`.`characteristic`(`characteristic_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ADD CONSTRAINT `fk_quality_spc_chart_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`control_plan`(`control_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_defect_record_id` FOREIGN KEY (`defect_record_id`) REFERENCES `vibe_automotive_v1`.`quality`.`defect_record`(`defect_record_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_automotive_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_ncap_test_result_id` FOREIGN KEY (`ncap_test_result_id`) REFERENCES `vibe_automotive_v1`.`quality`.`ncap_test_result`(`ncap_test_result_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_root_cause_analysis_id` FOREIGN KEY (`root_cause_analysis_id`) REFERENCES `vibe_automotive_v1`.`quality`.`root_cause_analysis`(`root_cause_analysis_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ADD CONSTRAINT `fk_quality_corrective_action_spc_chart_id` FOREIGN KEY (`spc_chart_id`) REFERENCES `vibe_automotive_v1`.`quality`.`spc_chart`(`spc_chart_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ADD CONSTRAINT `fk_quality_ncap_test_result_apqp_plan_id` FOREIGN KEY (`apqp_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`apqp_plan`(`apqp_plan_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ADD CONSTRAINT `fk_quality_characteristic_parent_characteristic_id` FOREIGN KEY (`parent_characteristic_id`) REFERENCES `vibe_automotive_v1`.`quality`.`characteristic`(`characteristic_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_inspection_lot_id` FOREIGN KEY (`inspection_lot_id`) REFERENCES `vibe_automotive_v1`.`quality`.`inspection_lot`(`inspection_lot_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ADD CONSTRAINT `fk_quality_root_cause_analysis_parent_root_cause_analysis_id` FOREIGN KEY (`parent_root_cause_analysis_id`) REFERENCES `vibe_automotive_v1`.`quality`.`root_cause_analysis`(`root_cause_analysis_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ADD CONSTRAINT `fk_quality_control_plan_characteristic_characteristic_id` FOREIGN KEY (`characteristic_id`) REFERENCES `vibe_automotive_v1`.`quality`.`characteristic`(`characteristic_id`);
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ADD CONSTRAINT `fk_quality_control_plan_characteristic_control_plan_id` FOREIGN KEY (`control_plan_id`) REFERENCES `vibe_automotive_v1`.`quality`.`control_plan`(`control_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`quality` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_automotive_v1`.`quality` SET TAGS ('dbx_domain' = 'quality');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` SET TAGS ('dbx_subdomain' = 'quality_planning');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'APQP Plan ID');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `homologation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `platform_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `actual_ppm` SET TAGS ('dbx_business_glossary_term' = 'Actual PPM');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `ai_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'AI Inspection Flag');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `apqp_phase` SET TAGS ('dbx_business_glossary_term' = 'APQP Phase');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `apqp_phase` SET TAGS ('dbx_value_regex' = 'concept|design|process|validation|launch');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `classification_type` SET TAGS ('dbx_business_glossary_term' = 'Classification Type');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `classification_type` SET TAGS ('dbx_value_regex' = 'new_model|refresh|component|system');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `documentation_link` SET TAGS ('dbx_business_glossary_term' = 'Documentation Link');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `eop_date` SET TAGS ('dbx_business_glossary_term' = 'End of Production (EOP) Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `gate_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Gate Completion Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `gate_due_date` SET TAGS ('dbx_business_glossary_term' = 'Gate Due Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `gate_status` SET TAGS ('dbx_business_glossary_term' = 'Gate Status');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `gate_status` SET TAGS ('dbx_value_regex' = 'open|closed|delayed|approved|rejected');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|completed|archived');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `milestone_gate` SET TAGS ('dbx_business_glossary_term' = 'Milestone Gate');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `milestone_gate` SET TAGS ('dbx_value_regex' = 'gate1|gate2|gate3|gate4|gate5');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `model_year` SET TAGS ('dbx_business_glossary_term' = 'Model Year');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Name');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `owner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `owner_name` SET TAGS ('dbx_mask_non_prod' = 'true');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'APQP Plan Number');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `quality_goal_ppm` SET TAGS ('dbx_business_glossary_term' = 'Quality Goal (PPM)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `sop_date` SET TAGS ('dbx_business_glossary_term' = 'Start of Production (SOP) Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `target_ppm` SET TAGS ('dbx_business_glossary_term' = 'Target PPM');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `target_release_date` SET TAGS ('dbx_business_glossary_term' = 'Target Release Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`apqp_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` SET TAGS ('dbx_subdomain' = 'quality_planning');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan ID');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Apqp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `design_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Design Specification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Inspection Plan ID');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `ai_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'AI Inspection Flag');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revoked');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `control_method` SET TAGS ('dbx_business_glossary_term' = 'Control Method');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `control_method` SET TAGS ('dbx_value_regex' = 'spc|attribute|visual|functional|dimensional');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `control_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Status');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `control_plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|archived');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `control_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Description');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Name');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Number');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Type');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'assembly|paint|engine|chassis|electrical|final');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `reaction_plan` SET TAGS ('dbx_business_glossary_term' = 'Reaction Plan');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `responsible_function` SET TAGS ('dbx_business_glossary_term' = 'Responsible Function');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `responsible_function` SET TAGS ('dbx_value_regex' = 'assembly_line|quality_engineering|process_engineering|manufacturing|test_lab');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `sample_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sample Frequency');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `sample_frequency` SET TAGS ('dbx_value_regex' = 'per_shift|per_batch|per_hour|per_day');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` SET TAGS ('dbx_subdomain' = 'quality_planning');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Identifier (ID)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Apqp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria Description (ACC_CRIT)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `ai_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'AI Inspection Flag');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `applicable_process` SET TAGS ('dbx_business_glossary_term' = 'Applicable Process for Inspection (PROCESS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `applicable_process` SET TAGS ('dbx_value_regex' = 'IQC|IPQC|PDI|Final');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DATE)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (APPROVED_BY)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level (CRIT_LEVEL)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `criticality_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `department_responsible` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department (DEPT_RESP)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Description (DESC)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency (FREQ)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'per_batch|per_shift|per_vehicle|per_day');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `gauge_type` SET TAGS ('dbx_business_glossary_term' = 'Gauge Type (GAUGE_TYPE)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `gauge_type` SET TAGS ('dbx_value_regex' = 'dial|digital|laser|micrometer');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_category` SET TAGS ('dbx_business_glossary_term' = 'Inspection Category (INS_CAT)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_category` SET TAGS ('dbx_value_regex' = 'dimensional|functional|visual|electrical');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Status (STATUS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `inspection_plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|retired');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Inspection Automated (IS_AUTOMATED)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW_DATE)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method (MEAS_METHOD)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'CMM|Gauge|Visual|Automated|Manual');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit (MEAS_UNIT)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'mm|cm|inch|mm^2|psi');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Name (PLAN_NAME)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Number (PLAN_NO)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Type (TYPE)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'incoming_material|in_process|final_vehicle|custom');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `plant_location` SET TAGS ('dbx_business_glossary_term' = 'Plant Location Code (PLANT_LOC)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `requires_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Approval Flag (REQ_APPROVAL)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle in Days (REVIEW_CYCLE_DAYS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number (REV_NO)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size (SAMPLE_SZ)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `tolerance_lower` SET TAGS ('dbx_business_glossary_term' = 'Lower Tolerance Limit (TOL_LOWER)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `tolerance_upper` SET TAGS ('dbx_business_glossary_term' = 'Upper Tolerance Limit (TOL_UPPER)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (UPDATED_BY)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Version (VER)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CREATED_BY)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `inbound_part_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Part Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Identifier');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `vehicle_compound_id` SET TAGS ('dbx_business_glossary_term' = 'Pdi Vehicle Compound Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `ppap_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Ppap Submission Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `stock_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Balance Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Supplier Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `vehicle_transport_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Transport Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `ai_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'AI Inspection Flag');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Overall Inspection Decision');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'accept|reject|conditional_release');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code (Quality Defect Identifier)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Status');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_lot_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|rejected|released');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'visual|dimensional|functional|non_destructive|automated');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Reason Code');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Event Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Lot Closure Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number (LOT_NO)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_origin` SET TAGS ('dbx_business_glossary_term' = 'Lot Origin Source');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_origin` SET TAGS ('dbx_value_regex' = 'goods_receipt|production_order|delivery|return');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Type');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'incoming_material|wip_assembly|finished_vehicle|prototype');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `measurement_result_status` SET TAGS ('dbx_business_glossary_term' = 'Measurement Result Status');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `measurement_result_status` SET TAGS ('dbx_value_regex' = 'pass|fail|out_of_spec');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `quantity_accepted` SET TAGS ('dbx_business_glossary_term' = 'Quantity Accepted');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `quantity_inspected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Inspected');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `quantity_rejected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Rejected');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks / Comments');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `source_document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_lot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_result_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result ID');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Characteristic ID');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot ID');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `ai_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'AI Inspection Flag');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `cp_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability (Cp)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `cpk_value` SET TAGS ('dbx_business_glossary_term' = 'Process Capability Index (Cpk)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `deviation_amount` SET TAGS ('dbx_business_glossary_term' = 'Deviation Amount');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Flag');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_accuracy` SET TAGS ('dbx_business_glossary_term' = 'Measurement Accuracy');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_condition` SET TAGS ('dbx_business_glossary_term' = 'Measurement Condition');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_condition` SET TAGS ('dbx_value_regex' = 'normal|high_temp|low_temp|vibration');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Measurement Humidity (%)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_location` SET TAGS ('dbx_business_glossary_term' = 'Measurement Location');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'manual|automated|sensor');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_resolution` SET TAGS ('dbx_business_glossary_term' = 'Measurement Resolution');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Measurement Temperature (°C)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_tool` SET TAGS ('dbx_business_glossary_term' = 'Measurement Tool');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_uncertainty` SET TAGS ('dbx_business_glossary_term' = 'Measurement Uncertainty');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'mm|cm|in|mmHg|psi|kg');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'pass|fail|na');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`inspection_result` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `defect_record_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Record Identifier');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Plan Identifier');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `dealer_repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Dealer Repair Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealership Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fmea Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `ncap_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Ncap Test Result Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `powertrain_variant_id` SET TAGS ('dbx_business_glossary_term' = 'Powertrain Variant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `root_cause_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Component Identifier (COMPONENT_ID)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `spc_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Chart Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `vehicle_build_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Build Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `vehicle_compound_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Compound Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `vehicle_handover_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Handover Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vin Registry Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `ai_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'AI Inspection Flag');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `defect_category` SET TAGS ('dbx_business_glossary_term' = 'Defect Category (CATEGORY)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `defect_category` SET TAGS ('dbx_value_regex' = 'incoming|in_process|final|field');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code (DEFECT_CODE)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `defect_record_status` SET TAGS ('dbx_business_glossary_term' = 'Defect Status (STATUS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `defect_record_status` SET TAGS ('dbx_value_regex' = 'open|investigating|closed|rejected|deferred');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type (DEFECT_TYPE)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `defect_type` SET TAGS ('dbx_value_regex' = 'material|process|design|supplier|assembly|software');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Defect Detection Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method (DETECTION_METHOD)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'inspection|test|audit|customer_complaint|sensor|automated');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Defect Disposition (DISPOSITION)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'rework|scrap|use_as_is|return_to_supplier|deferred');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `investigation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `investigation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `is_repeat_defect` SET TAGS ('dbx_business_glossary_term' = 'Repeat Defect Indicator');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `location_zone` SET TAGS ('dbx_business_glossary_term' = 'Location Zone');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `ppm_rate` SET TAGS ('dbx_business_glossary_term' = 'Parts Per Million Rate (PPM)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `quantity_affected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Affected');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity (SEVERITY)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning|info');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`defect_record` ALTER COLUMN `vin` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` SET TAGS ('dbx_subdomain' = 'quality_planning');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `spc_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control Chart ID');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `ai_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'AI Inspection Flag');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `center_line` SET TAGS ('dbx_business_glossary_term' = 'Center Line');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `chart_name` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control Chart Name');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `chart_type` SET TAGS ('dbx_business_glossary_term' = 'Statistical Process Control Chart Type');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `chart_type` SET TAGS ('dbx_value_regex' = 'X-bar/R|X-bar/S|p-chart|c-chart|u-chart|np-chart');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `confidence_level` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level (%)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `control_limit_lcl` SET TAGS ('dbx_business_glossary_term' = 'Lower Control Limit (LCL)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `control_limit_ucl` SET TAGS ('dbx_business_glossary_term' = 'Upper Control Limit (UCL)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System for SPC Data');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP QM|MES|Teamcenter|Custom');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `spc_chart_description` SET TAGS ('dbx_business_glossary_term' = 'SPC Chart Description');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `ocap` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Control Action Plan');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `process_step` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Process Step');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `process_step_code` SET TAGS ('dbx_business_glossary_term' = 'Process Step Code');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `sample_count` SET TAGS ('dbx_business_glossary_term' = 'Sample Count');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_business_glossary_term' = 'Sampling Frequency');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `sampling_frequency` SET TAGS ('dbx_value_regex' = 'per_shift|per_hour|per_day|per_batch|per_lot');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `spc_chart_status` SET TAGS ('dbx_business_glossary_term' = 'SPC Chart Status');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `spc_chart_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `statistical_method` SET TAGS ('dbx_business_glossary_term' = 'Statistical Method');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `statistical_method` SET TAGS ('dbx_value_regex' = 'Shewhart|EWMA|CUSUM|XMR');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `subgroup_size` SET TAGS ('dbx_business_glossary_term' = 'Subgroup Size');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `tolerance_lower` SET TAGS ('dbx_business_glossary_term' = 'Lower Tolerance Limit');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `tolerance_upper` SET TAGS ('dbx_business_glossary_term' = 'Upper Tolerance Limit');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`spc_chart` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'SPC Chart Version Number');
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Change Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ALTER COLUMN `dealership_id` SET TAGS ('dbx_business_glossary_term' = 'Dealership Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ALTER COLUMN `ncap_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Ncap Test Result Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ALTER COLUMN `recall_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Campaign Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ALTER COLUMN `spc_chart_id` SET TAGS ('dbx_business_glossary_term' = 'Spc Chart Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ALTER COLUMN `supplier_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Scorecard Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`corrective_action` ALTER COLUMN `ai_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'AI Inspection Flag');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `ncap_test_result_id` SET TAGS ('dbx_business_glossary_term' = 'NCAP Test Result ID');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Apqp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `bom_header_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Header Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `change_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change ID (ECID)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `fmvss_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Fmvss Certification Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `homologation_record_id` SET TAGS ('dbx_business_glossary_term' = 'Homologation Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Model Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `vin_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `ai_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'AI Inspection Flag');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System (DSS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'SAP|Teamcenter|MES|Custom');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `homologation_status` SET TAGS ('dbx_business_glossary_term' = 'Homologation Status (HS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `homologation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|exempt');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `rating_scale` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale (RS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `raw_score_front` SET TAGS ('dbx_business_glossary_term' = 'Front Impact Raw Score (FIRS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `raw_score_pole` SET TAGS ('dbx_business_glossary_term' = 'Pole Impact Raw Score (PIRS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `raw_score_side` SET TAGS ('dbx_business_glossary_term' = 'Side Impact Raw Score (SIRS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `star_rating` SET TAGS ('dbx_business_glossary_term' = 'Star Rating (SR)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_comments` SET TAGS ('dbx_business_glossary_term' = 'Test Comments (TCMT)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_condition` SET TAGS ('dbx_business_glossary_term' = 'Test Condition (TCND)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_configuration` SET TAGS ('dbx_business_glossary_term' = 'Test Configuration (TC)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Test Date (TD)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_facility` SET TAGS ('dbx_business_glossary_term' = 'Test Facility (TF)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_observer` SET TAGS ('dbx_business_glossary_term' = 'Test Observer (TOB)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_program` SET TAGS ('dbx_business_glossary_term' = 'Test Program (TP)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_program` SET TAGS ('dbx_value_regex' = 'Euro NCAP|NHTSA|ANCAP|Global NCAP');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Test Report Number (TRN)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_result_status` SET TAGS ('dbx_business_glossary_term' = 'Test Result Status (TRS)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_result_status` SET TAGS ('dbx_value_regex' = 'draft|final|approved|rejected');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type (TT)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'frontal_offset|side_impact|pole|pedestrian|aeb');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `test_version` SET TAGS ('dbx_business_glossary_term' = 'Test Version (TV)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`ncap_test_result` ALTER COLUMN `vehicle_vin` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification Number (VIN)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` SET TAGS ('dbx_subdomain' = 'quality_planning');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Characteristic Identifier');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `parent_characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Characteristic Id');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `parent_characteristic_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `product_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Product Bom Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `ai_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'AI Inspection Flag');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `characteristic_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `characteristic_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `data_type` SET TAGS ('dbx_business_glossary_term' = 'Data Type');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `characteristic_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `characteristic_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `tolerance_lower` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Lower');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `tolerance_upper` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Upper');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_automotive_v1`.`quality`.`characteristic` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` SET TAGS ('dbx_subdomain' = 'defect_control');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `root_cause_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Identifier');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `fmea_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fmea Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `parent_root_cause_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Related Root Cause Analysis Id');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `parent_root_cause_analysis_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `ai_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'AI Inspection Flag');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `root_cause_analysis_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `root_cause_analysis_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `corrective_action_owner` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `root_cause_analysis_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `detection_phase` SET TAGS ('dbx_business_glossary_term' = 'Detection Phase');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `impact_description` SET TAGS ('dbx_business_glossary_term' = 'Impact Description');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `root_cause_analysis_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `occurrence_phase` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Phase');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Owner');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `root_cause_analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `root_cause_analysis_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_automotive_v1`.`quality`.`root_cause_analysis` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` SET TAGS ('dbx_subdomain' = 'quality_planning');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` SET TAGS ('dbx_association_edges' = 'quality.control_plan,quality.characteristic');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ALTER COLUMN `control_plan_characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Characteristic - Control Plan Characteristic Id');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ALTER COLUMN `characteristic_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Characteristic - Characteristic Id');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ALTER COLUMN `control_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Characteristic - Control Plan Id');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ALTER COLUMN `control_method` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Characteristic - Control Method');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ALTER COLUMN `lower_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Characteristic - Lower Spec Limit');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ALTER COLUMN `measurement_system` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Characteristic - Measurement System');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Characteristic - Measurement Unit');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ALTER COLUMN `process_step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Characteristic - Process Step Sequence');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ALTER COLUMN `reaction_plan` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Characteristic - Reaction Plan');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ALTER COLUMN `sample_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Characteristic - Sample Frequency');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Characteristic - Sample Size');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Characteristic - Target Value');
ALTER TABLE `vibe_automotive_v1`.`quality`.`control_plan_characteristic` ALTER COLUMN `upper_spec_limit` SET TAGS ('dbx_business_glossary_term' = 'Control Plan Characteristic - Upper Spec Limit');
