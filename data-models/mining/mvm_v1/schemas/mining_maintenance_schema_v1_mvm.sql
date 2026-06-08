-- Schema for Domain: maintenance | Business: Mining | Version: v1_mvm
-- Generated on: 2026-05-05 14:20:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`maintenance` COMMENT 'Manages the full asset maintenance lifecycle including preventive, predictive, and corrective maintenance work orders, BOM, spare parts consumption, shutdown planning, and equipment downtime tracking via CMMS (Infor EAM). Owns work execution and cost history against each asset.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the maintenance work order. Primary key.',
    `asset_id` BIGINT COMMENT 'Reference to the asset or equipment unit against which this maintenance work order is executed.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Every work order is charged to a cost centre for OPEX tracking and period-end budget variance reporting in SAP CO. Mining finance teams require this FK for maintenance cost centre reporting. Replaces ',
    `drill_program_id` BIGINT COMMENT 'Foreign key linking to exploration.drill_program. Business justification: Maintenance work orders raised for drill rig breakdowns during exploration campaigns must be attributed to the drill program for schedule impact analysis, cost variance reporting, and statutory explor',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Capital work orders (major overhauls, component replacements) result in fixed asset additions or modifications requiring capitalisation. Mining finance teams require this link for IFRS asset capitalis',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: work_order should reference the functional_location where the work is performed. One functional_location can have many work_orders. This link enables location-based work order reporting, cost allocati',
    `geological_domain_id` BIGINT COMMENT 'Foreign key linking to geology.geological_domain. Business justification: Geotechnical work orders (ground support installation, slope remediation, rock bolt programs) are scoped to specific geological domains. Mining geotechnical engineers raise and track work orders by ge',
    `geotechnical_instrument_id` BIGINT COMMENT 'Foreign key linking to tailings.geotechnical_instrument. Business justification: Work orders for instrument maintenance, calibration, repair, and replacement. Essential for maintaining instrument reliability, tracking calibration compliance, and ensuring data quality for dam safet',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to hse.hazard. Business justification: Work orders in mining are raised specifically to eliminate or control identified hazards (hazard close-out work orders). Linking work_order to hazard supports hazard register close-out reporting and d',
    `heritage_clearance_id` BIGINT COMMENT 'Foreign key linking to tenement.heritage_clearance. Business justification: Work orders involving ground disturbance within a tenement require a valid heritage clearance reference before work can be approved. This is a direct regulatory requirement — maintenance supervisors m',
    `audit_id` BIGINT COMMENT 'Foreign key linking to hse.audit. Business justification: Audit findings generating corrective work orders (install missing guarding, repair damaged safety equipment, implement engineering controls). Essential for audit closure workflow and compliance tracki',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Work orders raised to remediate HSE incidents (spill cleanup, post-incident equipment repairs, safety hazard elimination). Critical for incident closure workflow and cost attribution in Mining operati',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to laboratory.instrument. Business justification: Laboratory instruments require maintenance work orders for repair, calibration, and servicing. This link supports instrument maintenance history reporting, downtime tracking for accreditation complian',
    `mining_block_id` BIGINT COMMENT 'FK to mine.mining_block.mining_block_id — Enables determination of WHERE maintenance occurred in the mine — essential for spatial maintenance analytics and pit-level cost allocation',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Mining operations allocate maintenance costs and track equipment performance by orebody for mine-to-mill optimization, production reconciliation, and orebody-specific AISC calculation. Essential for c',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_schedule. Business justification: work_order should optionally reference the pm_schedule that generated it (for PM-originated work orders). One pm_schedule generates many work_orders over time. This link enables PM compliance tracking',
    `production_drillhole_id` BIGINT COMMENT 'Foreign key linking to geology.production_drillhole. Business justification: Drill rig maintenance work orders are raised against specific production drillholes when equipment failures occur mid-hole (stuck drill, bit failure, rod breakage). Linking the work order to the drill',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: When maintenance work requires materials or services not in stock, work orders trigger purchase orders. Mining operations track this link for cost reconciliation, delivery coordination, and budget var',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Work orders for activities subject to licence conditions (environmental controls, operating restrictions, statutory inspections) must reference the specific regulatory condition driving the work. Main',
    `requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.requisition. Business justification: Work orders in mining frequently originate procurement requisitions for non-stocked parts or contractor services. Linking work_order to requisition provides end-to-end traceability from maintenance de',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Mining work orders track which product grade was being processed during equipment failure or maintenance. Essential for product quality root cause analysis, production loss attribution by product type',
    `standard_job_id` BIGINT COMMENT 'Foreign key linking to maintenance.standard_job. Business justification: work_order should optionally reference the standard_job (job plan template) that was used to create it. One standard_job can be instantiated into many work_orders. This link enables traceability from ',
    `surface_right_id` BIGINT COMMENT 'Foreign key linking to tenement.surface_right. Business justification: Work orders for maintenance of surface infrastructure (roads, pipelines, processing facilities, camps) require confirmation of valid surface access rights. Maintenance planners must verify the applica',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Mining work orders (drilling, exploration, infrastructure maintenance) occur on specific tenement land. Required for regulatory reporting, access rights verification, and expenditure commitment tracki',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Maintenance work orders are routinely raised for TSF infrastructure (pumps, pipelines, decant systems, spillways). Essential for TSF maintenance planning, regulatory compliance tracking, and cost allo',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Work orders for dump infrastructure maintenance (drainage systems, haul roads, compaction equipment, erosion control). Critical for dump operational integrity, cost tracking, and maintenance history f',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Capital maintenance work orders (major overhauls, equipment rebuilds, plant modifications) are charged to WBS elements for capex tracking, asset capitalization, and project cost control in mining oper',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when maintenance work execution was completed on site.',
    `actual_labour_hours` DECIMAL(18,2) COMMENT 'Actual total labour hours consumed during work order execution, captured from timesheets.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when maintenance work execution commenced on site.',
    `approval_status` STRING COMMENT 'Approval status of the work order for execution, particularly for high-value or critical work requiring management authorization.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the work order for execution.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was approved for execution.',
    `completion_code` STRING COMMENT 'Standardized code indicating the outcome or reason for work order closure (e.g., completed as planned, partially completed, deferred, cancelled, unable to complete).',
    `completion_notes` STRING COMMENT 'Technician notes and observations recorded upon work order completion, documenting work performed, findings, and recommendations.',
    `contractor_cost` DECIMAL(18,2) COMMENT 'Total cost of external contractor services engaged for the work order execution.',
    `cost_variance` DECIMAL(18,2) COMMENT 'Variance between estimated and actual total cost (actual minus estimated). Positive values indicate cost overrun, negative values indicate cost savings.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was first created in the CMMS system.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total equipment downtime hours caused by this maintenance work order, impacting asset availability and OEE (Overall Equipment Effectiveness).',
    `equipment_hire_cost` DECIMAL(18,2) COMMENT 'Total cost of hired equipment, tools, or machinery used during work order execution (e.g., crane hire, specialist tooling).',
    `estimated_labour_hours` DECIMAL(18,2) COMMENT 'Planned total labour hours required to complete the work order, estimated during planning phase.',
    `failure_mode` STRING COMMENT 'Description of the failure mode or defect that triggered the corrective or breakdown work order (e.g., bearing seizure, hydraulic leak, electrical fault).',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting work order costs in the financial system.',
    `labour_cost` DECIMAL(18,2) COMMENT 'Total labour cost incurred for the work order, calculated from actual hours and labour rates. Contributes to OPEX and AISC/C1 cost allocation.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified the work order record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was last modified in the CMMS system.',
    `originating_source` STRING COMMENT 'System or process that initiated the work order: CMMS scheduled PM, SCADA alert, operator request, inspection finding, condition monitoring system, or breakdown event. [ENUM-REF-CANDIDATE: cmms|scada_alert|operator_request|inspection|condition_monitoring|pm_schedule|breakdown — 7 candidates stripped; promote to reference product]',
    `parts_materials_cost` DECIMAL(18,2) COMMENT 'Total cost of spare parts, consumables, and materials consumed during work order execution. Sourced from inventory transactions and purchase orders.',
    `planned_finish_date` DATE COMMENT 'Scheduled date when the maintenance work is planned to be completed.',
    `planned_start_date` DATE COMMENT 'Scheduled date when the maintenance work is planned to commence.',
    `priority` STRING COMMENT 'Business priority level assigned to the work order indicating urgency and impact on operations.. Valid values are `critical|high|medium|low`',
    `safety_permit_reference` STRING COMMENT 'Reference number of the safety work permit or isolation certificate required before work can commence (e.g., hot work permit, confined space entry, electrical isolation).',
    `sap_co_order_reference` STRING COMMENT 'Reference to the SAP CO internal order used for detailed cost tracking and allocation of the work order.',
    `shutdown_flag` BOOLEAN COMMENT 'Indicates whether this work order is part of a planned shutdown or turnaround event requiring asset downtime.',
    `total_actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred for the work order upon completion, sum of all cost components. Classified as Operating Expenditure (OPEX). Used for AISC and C1 cash cost calculations.',
    `total_estimated_cost` DECIMAL(18,2) COMMENT 'Total estimated cost for the work order calculated during planning phase, including all cost components. Classified as Operating Expenditure (OPEX).',
    `trade_craft_required` STRING COMMENT 'Primary trade or craft skill required for the work order execution (e.g., fitter, electrician, boilermaker, diesel mechanic, instrumentation technician).',
    `work_centre` STRING COMMENT 'Maintenance work centre or shop responsible for executing the work order (e.g., mechanical workshop, electrical shop, mobile maintenance crew).',
    `work_description` STRING COMMENT 'Detailed description of the maintenance work to be performed, including scope, tasks, and special instructions.',
    `work_order_number` STRING COMMENT 'Externally visible unique work order number assigned by the CMMS (Infor EAM). Format: WO-YYYYNNNN where YYYY is year and NNNN is sequence.. Valid values are `^WO-[0-9]{8}$`',
    `work_order_status` STRING COMMENT 'Current lifecycle status of the work order in the CMMS workflow. [ENUM-REF-CANDIDATE: draft|planned|approved|released|in_progress|on_hold|completed|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `work_order_type` STRING COMMENT 'Classification of the maintenance work order: preventive (PM), corrective (CM), predictive (PdM), condition-based (CBM), breakdown, or project work.. Valid values are `preventive|corrective|predictive|condition_based|breakdown|project`',
    `created_by` STRING COMMENT 'User or system identifier of the person or process that created the work order.',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Core transactional entity representing a maintenance work order in Infor EAM. Captures all types of maintenance activities — preventive (PM), corrective (CM), predictive (PdM), and condition-based — against a specific asset. Tracks work order number, type, priority, status, originating source (CMMS, SCADA alert, operator request), planned vs actual start/finish dates, estimated vs actual labour hours, work centre, trade/craft required, safety permit references, shutdown flag, and completion codes. Includes full cost summary: labour cost, parts/materials cost, contractor cost, equipment hire cost, total estimated vs actual cost (OPEX), cost centre, GL account code, SAP CO order reference, cost variance, and approval status. SSOT for work execution history and maintenance cost reporting against each asset. Supports AISC/C1 cost allocation. Sourced from Infor EAM and SAP CO.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`work_order_task` (
    `work_order_task_id` BIGINT COMMENT 'Unique identifier for the work order task. Primary key.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.corrective_action. Business justification: Granular tracking of which specific maintenance task implements which HSE corrective action. Required for HSE action verification, sign-off, and effectiveness review in Mining operations.',
    `standard_job_id` BIGINT COMMENT 'Foreign key linking to maintenance.standard_job. Business justification: work_order_task has standard_job_code (STRING) but no FK to standard_job. One standard_job can be used by many work_order_tasks. Adding standard_job_id FK enables linking task execution back to the st',
    `work_order_id` BIGINT COMMENT 'Foreign key reference to the parent maintenance work order. Each task belongs to exactly one work order.',
    `action_code` STRING COMMENT 'Standardized code identifying the corrective action taken to address the failure. Used for maintenance history analysis and spare parts forecasting.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Actual date and time when task execution was completed. Used for cycle time analysis and Mean Time To Repair (MTTR) calculation.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for this task including labour, materials, and services. Captured from cost transactions and used for financial reporting.',
    `actual_labour_hours` DECIMAL(18,2) COMMENT 'Actual number of labour hours consumed to complete this task. Captured from timesheet entries and used for cost tracking and performance analysis.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when task execution commenced. Captured from work order task status transitions and used for performance tracking.',
    `cause_code` STRING COMMENT 'Standardized code identifying the root cause of the failure addressed by this task. Supports reliability-centered maintenance and continuous improvement.',
    `completion_notes` STRING COMMENT 'Free-text notes entered by technicians upon task completion. Documents findings, issues encountered, corrective actions taken, and recommendations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this task record was first created in the system. Used for audit trail and data lineage.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Number of hours the equipment was unavailable for production due to this maintenance task. Critical for Overall Equipment Effectiveness (OEE) calculation.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Planned or estimated total cost for this task including labour, materials, and services. Used for budgeting and cost control.',
    `estimated_labour_hours` DECIMAL(18,2) COMMENT 'Planned or estimated number of labour hours required to complete this task. Used for scheduling and resource planning.',
    `failure_code` STRING COMMENT 'Standardized code identifying the type of failure or defect addressed by this task. Used for failure mode analysis and reliability engineering.',
    `isolation_required_flag` BOOLEAN COMMENT 'Indicates whether equipment isolation (lockout/tagout) is required for safe execution of this task.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this task record was last updated. Used for audit trail and change tracking.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether a work permit (e.g., hot work permit, confined space permit, isolation permit) is required before task execution can commence.',
    `priority_code` STRING COMMENT 'Priority level assigned to this task. Determines execution sequence and resource allocation when multiple tasks compete for resources.. Valid values are `critical|high|medium|low`',
    `safety_instructions` STRING COMMENT 'Specific safety procedures, precautions, and Personal Protective Equipment (PPE) requirements for this task. Critical for Health Safety and Environment (HSE) compliance.',
    `scheduled_completion_date` DATE COMMENT 'Planned date when task execution is scheduled to be completed. Used for maintenance planning and shutdown coordination.',
    `scheduled_start_date` DATE COMMENT 'Planned date when task execution is scheduled to begin. Used for maintenance planning and resource scheduling.',
    `sequence_number` STRING COMMENT 'Ordinal position of this task within the parent work order. Defines the execution order for multi-step maintenance procedures.',
    `task_description` STRING COMMENT 'Detailed description of the maintenance task or operation step to be performed, including specific instructions and procedures.',
    `task_number` STRING COMMENT 'Business identifier for the task, typically a combination of work order number and task sequence. Used for external reference and reporting.',
    `task_status` STRING COMMENT 'Current lifecycle status of the maintenance task. Tracks progression through planning, execution, and completion stages. [ENUM-REF-CANDIDATE: planned|ready|in_progress|on_hold|completed|cancelled|deferred — 7 candidates stripped; promote to reference product]',
    `task_type` STRING COMMENT 'Classification of the maintenance task by operation type. Defines the nature of work to be performed. [ENUM-REF-CANDIDATE: isolation|inspection|replacement|repair|lubrication|calibration|testing|recommissioning|cleaning|adjustment — 10 candidates stripped; promote to reference product]',
    `trade_code` STRING COMMENT 'Code identifying the craft or trade skill required to perform this task (e.g., mechanical, electrical, instrumentation, boilermaker).',
    `trade_description` STRING COMMENT 'Full description of the trade or craft skill required for task execution.',
    CONSTRAINT pk_work_order_task PRIMARY KEY(`work_order_task_id`)
) COMMENT 'Individual task or operation step within a maintenance work order, derived from Infor EAM task plans. Each task has its own sequence number, description, trade/craft, estimated and actual labour hours, standard job reference, safety instructions, and completion status. Enables granular tracking of multi-step maintenance procedures such as isolations, inspections, replacements, and recommissioning steps within a single work order.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record. Primary key.',
    `asset_class_id` BIGINT COMMENT 'Reference to the asset class or equipment category to which this PM schedule applies. Used when the schedule is defined at the class level rather than individual asset level.',
    `asset_id` BIGINT COMMENT 'Reference to the specific asset or equipment unit to which this PM schedule applies. Links to the asset register in the equipment domain.',
    `component_register_id` BIGINT COMMENT 'Foreign key linking to equipment.component_register. Business justification: Component-level PM schedules (oil analysis intervals, tread depth checks, hydraulic seal inspections) are tied to specific registered components by serial number. Mining EAM systems require this link ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: PM schedules have budgeted costs allocated to cost centres for preventive maintenance planning, annual budget preparation, and maintenance cost forecasting in mining operations.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Environmental permits in mining specify mandatory inspection and maintenance frequencies for pollution control equipment (e.g., dust suppression systems, water treatment plants, tailings monitoring). ',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: pm_schedule should reference the functional_location for the preventive maintenance plan. One functional_location can have many PM schedules. This link enables location-based PM planning and supports ',
    `geotechnical_instrument_id` BIGINT COMMENT 'Foreign key linking to tailings.geotechnical_instrument. Business justification: Calibration and maintenance schedules for geotechnical instruments. Regulatory requirement for demonstrating systematic instrument maintenance. Ensures data quality and compliance with dam safety moni',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to laboratory.instrument. Business justification: Analytical instruments have mandatory PM schedules for calibration and servicing (ISO/IEC 17025 requirement). Linking pm_schedule to instrument enables automated calibration due-date tracking, complia',
    `opex_budget_id` BIGINT COMMENT 'Foreign key linking to finance.opex_budget. Business justification: PM schedules drive maintenance OPEX budgets — scheduled maintenance frequency and estimated costs directly feed annual OPEX budget preparation. Mining finance planners require this link to validate th',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Preventive maintenance schedules for statutory inspections (e.g., pressure vessel inspections, electrical safety checks, TSF inspections) are directly mandated by specific regulatory conditions on the',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: PM schedules designed to mitigate specific hazards identified in risk assessments (guarding inspections, LOTO verification, safety-critical equipment checks). Core to risk-based maintenance planning i',
    `standard_job_id` BIGINT COMMENT 'Reference to the standard job plan that defines the detailed task list, labor requirements, spare parts, tools, and safety procedures for this PM schedule. Ensures consistency and standardization of maintenance execution.',
    `strategy_id` BIGINT COMMENT 'FK to maintenance.maintenance_strategy',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Preventive maintenance schedules for TSF infrastructure (pumps, valves, spillways, pipelines). Regulatory requirement for demonstrating systematic maintenance of critical tailings infrastructure. Driv',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: PM schedules for dump infrastructure (drainage inspections, road grading, erosion control). Required for demonstrating systematic maintenance of waste rock facilities and compliance with geotechnical ',
    `auto_generate_flag` BOOLEAN COMMENT 'Indicates whether work orders should be automatically generated from this PM schedule when the next_due_date is reached. If false, work orders must be manually created.',
    `compliance_target_percentage` DECIMAL(18,2) COMMENT 'The target compliance percentage for on-time completion of PM work orders generated from this schedule. Typically set at 95% or higher for critical assets. Used for KPI tracking and performance management.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated_cost. Supports multi-currency operations for global mining companies.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this PM schedule record was first created in the source system. Supports audit trail and data lineage requirements.',
    `effective_end_date` DATE COMMENT 'The date on which this PM schedule expires and stops generating work orders. Nullable for open-ended schedules. Used for temporary or project-specific PM plans.',
    `effective_start_date` DATE COMMENT 'The date from which this PM schedule becomes active and begins generating work orders. Supports future-dated schedule activation.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether this PM schedule is required for environmental compliance purposes. Environmental compliance PM schedules are subject to regulatory audit and reporting requirements.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'The estimated total cost to execute one instance of this PM schedule, including labor, materials, and contractor costs. Used for maintenance budgeting and OPEX planning.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'The estimated time in hours required to complete the preventive maintenance activities defined in this schedule. Used for resource planning and downtime scheduling.',
    `frequency_type` STRING COMMENT 'The type of frequency trigger that determines when the PM work order is generated. Calendar-based uses fixed time intervals, runtime-hours uses equipment operating hours, cycles uses production cycles, condition-triggered uses sensor thresholds, meter-based uses equipment meter readings, and event-based uses specific operational events.. Valid values are `calendar|runtime-hours|cycles|condition-triggered|meter-based|event-based`',
    `interval_unit` STRING COMMENT 'The unit of measure for the interval_value. Must align with the frequency_type selected. [ENUM-REF-CANDIDATE: days|weeks|months|years|hours|cycles|units|threshold — 8 candidates stripped; promote to reference product]',
    `interval_value` DECIMAL(18,2) COMMENT 'The numeric value of the maintenance interval. Interpretation depends on frequency_type: days for calendar, hours for runtime-hours, count for cycles, threshold value for condition-triggered.',
    `isolation_required_flag` BOOLEAN COMMENT 'Indicates whether the asset requires isolation (lockout/tagout) to perform the PM activities safely. Critical for worker safety and regulatory compliance.',
    `last_completion_date` DATE COMMENT 'The date when this PM schedule was last completed. Used to calculate the next due date for calendar-based schedules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this PM schedule record was last modified in the source system. Supports change tracking and audit trail requirements.',
    `last_review_date` DATE COMMENT 'The date when this PM schedule was last reviewed and validated by the reliability engineering team. Used to track compliance with review_cycle_months requirements.',
    `lead_time_days` STRING COMMENT 'The number of days in advance of the next_due_date that the PM work order should be generated. Allows time for planning, parts procurement, and resource scheduling.',
    `next_due_date` DATE COMMENT 'The calculated date when the next preventive maintenance work order is due to be generated and executed. Automatically calculated based on last_completion_date and interval_value.',
    `next_review_date` DATE COMMENT 'The calculated date when this PM schedule is due for its next review. Automatically calculated based on last_review_date and review_cycle_months.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context about this PM schedule. May include historical information, change rationale, or operational considerations.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether a work permit (e.g., hot work permit, confined space permit, electrical isolation permit) is required to perform the PM activities. Critical for safety compliance.',
    `plan_description` STRING COMMENT 'Detailed description of the preventive maintenance plan, including scope of work, objectives, and key activities to be performed.',
    `pm_plan_code` STRING COMMENT 'Business identifier for the PM schedule plan. Unique code used in operational systems and work order generation.. Valid values are `^[A-Z0-9]{4,20}$`',
    `priority_code` STRING COMMENT 'The priority classification for work orders generated from this PM schedule. Critical priority is typically assigned to safety-critical or production-critical assets.. Valid values are `critical|high|medium|low`',
    `review_cycle_months` STRING COMMENT 'The frequency in months at which this PM schedule should be reviewed and updated by the reliability engineering team. Ensures continuous improvement and alignment with asset performance data.',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether this PM schedule is classified as safety-critical. Safety-critical PM schedules have higher compliance requirements and may be subject to regulatory reporting.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the PM schedule. Active schedules generate work orders automatically. Suspended schedules are temporarily paused. Inactive schedules are permanently disabled. Under-review schedules are being evaluated for changes. Obsolete schedules are retained for historical reference only.. Valid values are `active|suspended|inactive|under-review|obsolete`',
    `shutdown_required_flag` BOOLEAN COMMENT 'Indicates whether the asset must be shut down to perform the PM activities. Used for production planning and downtime scheduling.',
    `source_system` STRING COMMENT 'The name or code of the source CMMS system from which this PM schedule record originated. Typically Infor EAM for mining operations.',
    `source_system_code` STRING COMMENT 'The unique identifier of this PM schedule record in the source CMMS system. Used for data lineage and reconciliation.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Preventive maintenance schedule master defining the recurring maintenance strategy and plan for an asset or asset class. Stores PM plan code, description, maintenance strategy classification (run-to-failure, time-based, condition-based, reliability-centred maintenance), frequency type (calendar, runtime hours, cycles, condition-triggered), interval value, last completion date, next due date, lead time, assigned work centre, estimated duration, associated standard job plan, compliance percentage target, review cycle, and responsible reliability engineer. Sourced from Infor EAM PM module. Drives automatic generation of PM work orders, supports LOM maintenance planning, RCM programs, and enables PM compliance reporting per ISO 55001.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`asset_bom` (
    `asset_bom_id` BIGINT COMMENT 'Unique identifier for the asset bill of materials record. Primary key for the asset BOM entity.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Asset BOMs define which materials are required for equipment maintenance. Linking asset_bom directly to material_master enables BOM-driven procurement planning and MRP in mining operations, allowing p',
    `asset_id` BIGINT COMMENT 'Reference to the parent maintainable asset that this BOM line belongs to. Links to the equipment asset master.',
    `primary_component_asset_id` BIGINT COMMENT 'Reference to the child component or sub-assembly asset that is part of the parent asset structure. Links to the equipment asset master or component register.',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to maintenance.spare_part. Business justification: asset_bom has part_number (STRING) but no FK to spare_part master. One spare_part can appear in many asset BOMs. Adding spare_part_id FK enables linking BOM components to the authoritative spare_part ',
    `bom_level` STRING COMMENT 'Hierarchical level of this component within the BOM structure. Level 1 represents top-level assemblies, with increasing numbers for deeper sub-assemblies.',
    `bom_status` STRING COMMENT 'Current lifecycle status of this BOM record. Active=currently in use, Superseded=replaced by newer version, Obsolete=no longer applicable, Pending=awaiting approval.. Valid values are `active|inactive|superseded|obsolete|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM record was first created in the system. Used for audit trail and data lineage tracking.',
    `criticality_rating` STRING COMMENT 'Business criticality classification of the component based on impact to asset availability, safety, and production. Critical components require priority spare parts stocking and expedited maintenance.. Valid values are `critical|high|medium|low`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the component unit cost. Standard codes include USD, AUD, CAD, ZAR.. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'Date from which this BOM configuration becomes effective. Supports engineering change management and as-built configuration tracking.',
    `effective_to_date` DATE COMMENT 'Date until which this BOM configuration remains effective. Null for current active configurations. Used for historical BOM version tracking.',
    `engineering_change_number` STRING COMMENT 'Reference number for the engineering change order that introduced or modified this BOM line. Used for change traceability and configuration management.. Valid values are `^ECN-[0-9]{6,10}$`',
    `environmental_critical_flag` BOOLEAN COMMENT 'Indicates whether failure of this component could result in environmental incidents such as spills, emissions, or contamination. Requires enhanced monitoring per ISO 14001 Environmental Management Systems.',
    `interchangeable_flag` BOOLEAN COMMENT 'Indicates whether this component can be substituted with alternative parts from different manufacturers or specifications without affecting asset performance.',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this BOM record. Used for audit trail and change management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this BOM record was last updated. Used for audit trail, data quality monitoring, and incremental data processing.',
    `material_specification` STRING COMMENT 'Technical specification of materials used in the component, including grades, alloys, and compliance standards. Critical for mining equipment operating in harsh environments.',
    `mean_time_between_failures` DECIMAL(18,2) COMMENT 'Average operating time in hours between component failures. Key reliability metric used for preventive maintenance scheduling and spare parts planning.',
    `mean_time_to_repair` DECIMAL(18,2) COMMENT 'Average time in hours required to repair or replace this component. Used for shutdown planning and downtime estimation.',
    `part_number` STRING COMMENT 'Manufacturer or internal part number for the component. Used for procurement, inventory management, and spare parts identification.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `position_tag_number` STRING COMMENT 'Physical location identifier or tag number for the component within the parent asset assembly. Used for maintenance work instructions and field identification.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `quantity_required` DECIMAL(18,2) COMMENT 'Number of units of this component required per parent asset assembly. Supports fractional quantities for consumables and bulk materials.',
    `rotable_flag` BOOLEAN COMMENT 'Indicates whether the component is a rotable spare that can be repaired, refurbished, and reused across multiple parent assets. True for high-value repairable components, False for consumables.',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether failure of this component poses a direct safety risk to personnel or operations. Safety critical components require enhanced inspection and maintenance protocols per Mine Safety and Health Administration (MSHA) regulations.',
    `sequence_number` STRING COMMENT 'Sequential ordering of components within the same BOM level and parent asset. Used for assembly instructions and kitting sequences.',
    `serialized_flag` BOOLEAN COMMENT 'Indicates whether individual instances of this component are tracked by unique serial numbers for warranty, maintenance history, and lifecycle management.',
    `source_system` STRING COMMENT 'Operational system of record that originated this BOM data. Infor EAM and SAP PM are primary Computerized Maintenance Management System (CMMS) sources.. Valid values are `Infor EAM|SAP PM|Manual Entry|Data Migration`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the component quantity. EA=Each, M=Meter, KG=Kilogram, L=Liter, M2=Square Meter, M3=Cubic Meter. [ENUM-REF-CANDIDATE: EA|M|KG|L|M2|M3|SET|PAIR|BOX|ROLL — 10 candidates stripped; promote to reference product]',
    `warranty_period_months` STRING COMMENT 'Standard warranty period in months provided by the manufacturer for this component. Used for warranty claim management and lifecycle costing.',
    `created_by` STRING COMMENT 'User identifier or system account that created this BOM record. Used for audit trail and data quality accountability.',
    CONSTRAINT pk_asset_bom PRIMARY KEY(`asset_bom_id`)
) COMMENT 'Bill of Materials (BOM) for a maintainable asset, defining the hierarchical assembly structure of components and sub-assemblies. Each BOM line captures parent asset, child component, part number, quantity, unit of measure, position/tag number, criticality rating, and whether the component is a rotable spare. Sourced from Infor EAM and SAP PM. Supports spare parts planning, kitting for shutdowns, and failure mode analysis. Distinct from the equipment master (owned by equipment domain) — this entity owns the maintainable component structure.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`spare_part` (
    `spare_part_id` BIGINT COMMENT 'Unique identifier for the spare part record. Primary key for the spare part master data.',
    `asset_class_id` BIGINT COMMENT 'Reference to the asset class or equipment type that this spare part is primarily used for (e.g., haul trucks, crushers, conveyors).',
    `chemical_register_id` BIGINT COMMENT 'Foreign key linking to hse.chemical_register. Business justification: Spare parts containing hazardous chemicals (lubricants, hydraulic fluids, solvents, batteries). Required for chemical inventory management, SDS tracking, and regulatory reporting (NOHSC, GHS) in Minin',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Spare parts inventory is valued and posted to specific GL accounts for inventory accounting, balance sheet reporting, and inventory valuation - required for SAP MM-FI integration.',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to hse.hazard. Business justification: Spare parts in mining include hazardous items beyond chemical hazards (e.g., radioactive level sensors, asbestos-containing legacy gaskets, high-pressure hydraulic components). Linking to the hazard r',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Spare parts must map to procurement material master records for purchasing, MRP-driven replenishment, and price valuation. In mining, every stocked spare part (crusher liners, pump seals) has a materi',
    `vendor_id` BIGINT COMMENT 'Reference to the preferred or primary supplier for procurement of this spare part.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Spare parts are physically stocked in warehouse locations managed by procurement/stores. Mining maintenance planners must know the exact storage location for rapid retrieval during breakdowns. Replace',
    `bill_of_materials_flag` BOOLEAN COMMENT 'Indicates whether this spare part is itself composed of sub-components tracked as a BOM structure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the spare part master record was first created in the system.',
    `criticality_classification` STRING COMMENT 'Classification of spare part criticality based on impact to operations: insurance (strategic stock for catastrophic failure), critical (required for production continuity), non-critical (routine consumables).. Valid values are `insurance|critical|non-critical`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard unit cost. [ENUM-REF-CANDIDATE: AUD|USD|CAD|GBP|EUR|ZAR|CLP|BRL — 8 candidates stripped; promote to reference product]',
    `dimensions` STRING COMMENT 'Physical dimensions of the spare part (length x width x height) in standard units. Supports storage planning and handling logistics.',
    `economic_order_quantity` DECIMAL(18,2) COMMENT 'Optimal order quantity that minimizes total inventory costs including ordering costs and holding costs.',
    `hazard_class` STRING COMMENT 'Classification of hazardous material type (e.g., flammable, corrosive, toxic, explosive) per regulatory standards. Populated only if hazardous_material_flag is true.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the spare part is classified as hazardous material requiring special handling, storage, and disposal procedures.',
    `interchangeable_part_number` STRING COMMENT 'Reference to alternative or substitute part numbers that can be used interchangeably. Supports obsolescence management and supply chain flexibility.',
    `last_issue_date` DATE COMMENT 'Date when this spare part was last issued from inventory for maintenance work. Used for consumption pattern analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the spare part master record was last updated or modified.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent procurement transaction for this spare part. Used for usage analysis and obsolescence detection.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from order placement to delivery. Used for reorder point calculations and planning.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer (OEM) or supplier who produces the spare part.',
    `material_specification` STRING COMMENT 'Technical specification of material composition or grade (e.g., steel grade, alloy type, polymer specification). Critical for quality assurance and compatibility.',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Maximum inventory quantity allowed to avoid overstocking, obsolescence risk, and excessive capital tie-up.',
    `minimum_stock_level` DECIMAL(18,2) COMMENT 'Minimum inventory quantity to be maintained at all times to prevent stockouts and ensure operational continuity.',
    `obsolescence_status` STRING COMMENT 'Current lifecycle status indicating availability and support: active (fully supported), obsolete (no longer available), phase-out (limited availability), discontinued (manufacturer ceased production).. Valid values are `active|obsolete|phase-out|discontinued`',
    `oem_part_number` STRING COMMENT 'Manufacturers original part number as specified by the OEM. Used for cross-referencing and procurement.',
    `part_category` STRING COMMENT 'High-level categorization of the spare part (e.g., mechanical, electrical, hydraulic, structural, consumable, lubricant, wear part).',
    `part_description` STRING COMMENT 'Detailed textual description of the spare part including its function, specifications, and application context.',
    `part_number` STRING COMMENT 'Internal part number assigned by the organization for inventory and maintenance tracking. Unique business identifier for the spare part.',
    `part_status` STRING COMMENT 'Current operational status of the spare part master record: active (available for use), inactive (not in use), pending (awaiting approval), blocked (restricted from use).. Valid values are `active|inactive|pending|blocked`',
    `part_type` STRING COMMENT 'Type classification indicating lifecycle management approach: rotable (reusable after repair), repairable (can be refurbished), consumable (single-use), expendable (disposable).. Valid values are `rotable|repairable|consumable|expendable`',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level threshold that triggers a replenishment order. Calculated based on lead time demand and safety stock requirements.',
    `serial_number_tracking_flag` BOOLEAN COMMENT 'Indicates whether individual units of this spare part are tracked by unique serial numbers for traceability and warranty management.',
    `shelf_life_months` STRING COMMENT 'Maximum storage duration in months before the part degrades or becomes unusable. Critical for consumables, lubricants, and rubber components.',
    `standard_unit_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit of measure for inventory valuation and maintenance cost estimation. Excludes freight and taxes.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for inventory tracking and consumption reporting (e.g., EA=Each, KG=Kilogram, L=Litre, M=Metre). [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|SET|BOX|ROLL|PAIR — 10 candidates stripped; promote to reference product]',
    `warranty_expiry_date` DATE COMMENT 'Date when manufacturer warranty coverage expires for this spare part. Used for warranty claim management and cost recovery.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Unit weight of the spare part in kilograms. Used for logistics planning, freight cost calculation, and handling requirements.',
    CONSTRAINT pk_spare_part PRIMARY KEY(`spare_part_id`)
) COMMENT 'Master record for a maintainable spare part or consumable stocked for maintenance purposes. Captures part number, description, manufacturer, OEM part number, unit of measure, criticality classification (insurance/critical/non-critical), lead time, reorder point, minimum/maximum stock levels, storage location, hazardous material flag, interchangeable part references, and warranty expiry date. Distinct from general procurement inventory — this is the maintenance-specific view of parts required to sustain asset reliability. Supports spare parts criticality analysis, obsolescence management, and rotable pool tracking. Sourced from Infor EAM and Pronto Xi.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`parts_consumption` (
    `parts_consumption_id` BIGINT COMMENT 'Unique identifier for the parts consumption transaction record.',
    `asset_id` BIGINT COMMENT 'Reference to the asset or equipment for which the part was consumed during maintenance.',
    `chemical_register_id` BIGINT COMMENT 'Foreign key linking to hse.chemical_register. Business justification: Parts consumption tracking chemical usage (lubricants, cleaning agents, solvents). Required for chemical usage reporting, inventory reconciliation, and regulatory threshold monitoring (NOHSC, EPA) in ',
    `component_register_id` BIGINT COMMENT 'Foreign key linking to equipment.component_register. Business justification: Parts are consumed to repair or replace specific registered components. Linking parts_consumption to component_register enables component-level cost tracking essential for rebuild cost accumulation, w',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Spare parts consumption is charged to cost centres for materials OPEX tracking and inventory cost reporting. Mining finance teams require this for materials cost centre analysis. Replaces denormalized',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Parts consumption is posted to GL accounts for inventory expense recognition and materials cost reporting. Mining finance requires this for GL-level materials cost analysis and inventory accounting. R',
    `goods_issue_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_issue. Business justification: When maintenance consumes a spare part, a formal goods issue is posted in the inventory system. Linking parts_consumption to goods_issue enables audit trail reconciliation between maintenance consumpt',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Parts consumption transactions must reference the material master for correct GL valuation, goods issue posting, and inventory depletion in mining ERP systems. This link enables cost-per-material repo',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Parts issued to work orders are often received from specific purchase orders. Mining operations track this for warranty claim validation (parts must be from approved PO), cost allocation to correct GL',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to maintenance.spare_part. Business justification: parts_consumption currently has part_number (STRING) but no FK to spare_part master. One spare_part can be consumed many times across work orders. Adding spare_part_id FK enables JOIN to spare_part ma',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Parts consumption records track supplier for each part issue. Mining operations need this link for supplier invoice reconciliation, warranty claims (linking consumption to supplier contracts), supplie',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Parts consumed on capital projects are charged to WBS elements for capitalization and project cost tracking - required for proper accounting of materials in asset under construction.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order against which this part was consumed.',
    `work_order_task_id` BIGINT COMMENT 'Reference to the specific task within the work order where this part was consumed, if applicable.',
    `aisc_allocation_flag` BOOLEAN COMMENT 'Indicates whether this parts consumption cost is included in the All-In Sustaining Cost calculation for the mine site.',
    `batch_number` STRING COMMENT 'Batch or lot number of the part issued, used for traceability and quality control.',
    `bin_location` STRING COMMENT 'Specific bin or shelf location within the store from which the part was picked.',
    `core_charge_flag` BOOLEAN COMMENT 'Indicates whether a core charge applies to this part, requiring return of the old component.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the parts consumption record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost values (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `issue_date` DATE COMMENT 'Date on which the part was issued from stores and consumed against the work order.',
    `issue_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the part was issued from stores, including time of day.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the parts consumption record was last updated or modified.',
    `material_document_number` STRING COMMENT 'System-generated material document number from the ERP system recording the goods movement.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the parts consumption transaction.',
    `opex_category` STRING COMMENT 'Classification of the parts consumption cost within the OPEX structure (maintenance, operations, sustaining, growth, exploration).. Valid values are `maintenance|operations|sustaining|growth|exploration`',
    `part_number` STRING COMMENT 'Unique part number or material code identifying the spare part or consumable item issued.',
    `quantity_issued` DECIMAL(18,2) COMMENT 'Actual quantity of the part issued from stores and consumed against the work order.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of the part originally requested for the work order.',
    `requisition_number` STRING COMMENT 'Material requisition number or document reference that authorized the part issue.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this consumption transaction has been reversed or cancelled.',
    `reversal_reason` STRING COMMENT 'Reason for reversing or cancelling the parts consumption transaction, if applicable.',
    `rotable_return_flag` BOOLEAN COMMENT 'Indicates whether the part is a rotable component that was returned for repair or refurbishment after removal.',
    `serial_number` STRING COMMENT 'Serial number of the individual part issued, used for tracking serialized components.',
    `store_location_code` STRING COMMENT 'Code identifying the warehouse or store location from which the part was issued.',
    `store_location_name` STRING COMMENT 'Name or description of the warehouse or store location from which the part was issued.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the parts consumed, calculated as quantity issued multiplied by unit cost.',
    `transaction_type` STRING COMMENT 'Type of inventory transaction (issue, return, adjustment, transfer, scrap).. Valid values are `issue|return|adjustment|transfer|scrap`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the part at the time of issue, used for calculating total consumption cost.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the part quantity (e.g., EA for each, KG for kilograms, L for liters, M for meters).',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether this part consumption is covered under warranty and may be claimed from the supplier or manufacturer.',
    CONSTRAINT pk_parts_consumption PRIMARY KEY(`parts_consumption_id`)
) COMMENT 'Transactional record of spare parts and materials issued or consumed against a maintenance work order. Captures work order reference, part number, quantity requested, quantity issued, unit cost, total cost, issue date, store location, requisition number, and whether the part was a rotable return. Provides the SSOT for maintenance material cost tracking and supports OPEX reporting, spare parts demand forecasting, and AISC cost allocation.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`labour_record` (
    `labour_record_id` BIGINT COMMENT 'Unique identifier for the labour record. Primary key.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: External contractor labor is a major maintenance cost in mining. Labour records denormalize contractor_company; structured FK enables contractor invoice reconciliation, contractor safety performance t',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Maintenance labour costs (direct and contractor) are posted to cost centres for payroll allocation and OPEX budget reporting. Mining finance requires this for labour cost centre analysis. Replaces den',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Labour costs are posted to GL accounts for payroll expense recognition and financial reporting. Mining finance requires this FK for GL-level labour cost analysis and period-end accruals. Replaces deno',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Labour on capital projects is charged to WBS elements for project cost tracking and capitalization - required for proper accounting of internal labour in asset construction.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order against which this labour time was booked.',
    `work_order_task_id` BIGINT COMMENT 'Reference to the specific task within the work order that this labour was performed against. Nullable if labour is booked at work order header level.',
    `approval_status` STRING COMMENT 'Current approval status of the labour timesheet entry. Approved entries are posted to cost accounting.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the supervisor or manager who approved this labour record.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the labour record was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this labour record was first created in the source system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the labour cost (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `end_time` TIMESTAMP COMMENT 'The timestamp when the worker completed work on this task.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'The hourly labour rate applied to this record. May be standard employee rate or contractor rate.',
    `labour_cost` DECIMAL(18,2) COMMENT 'Total labour cost for this record, calculated as (regular_hours * hourly_rate) + (overtime_hours * overtime_rate).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this labour record was last modified or updated.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours booked against this labour record.',
    `overtime_rate` DECIMAL(18,2) COMMENT 'The hourly overtime rate applied to overtime hours. Typically a multiplier of the regular hourly rate.',
    `performance_rating` STRING COMMENT 'Supervisor assessment of the quality and efficiency of the labour performed. Used for contractor performance evaluation and workforce management.. Valid values are `excellent|good|satisfactory|poor`',
    `permit_reference` STRING COMMENT 'Reference to the safety permit or work permit under which this labour was performed, if applicable.',
    `purchase_order_reference` STRING COMMENT 'Reference to the purchase order under which contractor labour services were procured. Applicable for contractor labour only.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular working hours booked against this labour record, excluding overtime.',
    `shift_code` STRING COMMENT 'Code identifying the shift during which the labour was performed (e.g., Day, Night, Swing).',
    `source_type` STRING COMMENT 'Indicates whether the labour was performed by an internal employee or an external contractor.. Valid values are `employee|contractor`',
    `start_time` TIMESTAMP COMMENT 'The timestamp when the worker started work on this task.',
    `timesheet_entry_number` STRING COMMENT 'Unique timesheet entry number from the source system (Infor EAM or SAP HR) for traceability and reconciliation.',
    `total_hours` DECIMAL(18,2) COMMENT 'Total labour hours booked (regular hours plus overtime hours).',
    `trade_craft` STRING COMMENT 'The trade or craft skill of the worker performing the labour (e.g., Electrician, Fitter, Boilermaker, Diesel Mechanic, Welder).',
    `work_date` DATE COMMENT 'The calendar date on which the labour was performed.',
    `work_description` STRING COMMENT 'Detailed description of the work performed by the worker during this labour booking.',
    `worker_name` STRING COMMENT 'Full name of the worker who performed the labour.',
    CONSTRAINT pk_labour_record PRIMARY KEY(`labour_record_id`)
) COMMENT 'Transactional record of labour time booked against a maintenance work order by internal tradespeople or external contractors. Captures worker ID, source type (employee/contractor), trade/craft, work order reference, task reference, date worked, start time, end time, regular hours, overtime hours, hourly rate, total labour cost, work description, contractor company (if applicable), purchase order reference, and performance rating. Consolidates all human resource cost tracking against maintenance work orders — both internal workforce and contracted services. Sourced from Infor EAM timesheet module, SAP HR/CO, and contractor management systems. Supports maintenance cost tracking, workforce utilisation analysis, contractor performance evaluation, and OPEX reporting.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`equipment_downtime` (
    `equipment_downtime_id` BIGINT COMMENT 'Unique identifier for the equipment downtime event record. Primary key for the equipment downtime transactional entity.',
    `asset_id` BIGINT COMMENT 'Reference to the maintainable asset that experienced the downtime event. Links to the asset master register in the equipment domain.',
    `cargo_shipment_id` BIGINT COMMENT 'Foreign key linking to sales.cargo_shipment. Business justification: Downtime on ship loaders, conveyors, or port equipment directly delays cargo shipment loading, triggering demurrage liability and customer notifications. Port operations teams link specific downtime e',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Equipment downtime costs are allocated to cost centres for production loss costing and AISC unit cost reporting. Mining finance requires this for downtime cost centre attribution in monthly management',
    `drill_program_id` BIGINT COMMENT 'Foreign key linking to exploration.drill_program. Business justification: Equipment downtime events directly impact drill program KPIs (metreage achieved, program completion date). Mining operations track downtime hours against drill programs for program performance reporti',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Downtime events caused by HSE incidents (emergency shutdowns, safety isolations, environmental releases). Critical for production loss attribution, incident cost calculation, and LTIFR/TRIFR reporting',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Downtime events are attributed to specific orebodies to calculate production loss tonnage by ore source, enabling accurate mine planning adjustments and orebody-specific availability metrics for produ',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Downtime events in mining are attributed to specific product campaigns (iron ore fines vs lump, copper concentrate grades). Critical for product-specific OEE calculation, production planning, and unde',
    `shutdown_plan_id` BIGINT COMMENT 'Foreign key linking to maintenance.shutdown_plan. Business justification: Equipment downtime events that occur during a planned maintenance shutdown should be linked to the shutdown_plan master record. This enables shutdown performance reporting: total downtime hours per sh',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Downtime events for TSF equipment (pumps, conveyors, thickeners). Critical for tracking TSF operational availability, production impact (inability to deposit tailings), and reliability metrics for reg',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Mining operations track equipment downtime by facility for production impact and cost reporting. Dozers, compactors, and haul trucks operating at WRDs experience downtime events attributed to that spe',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order associated with this downtime event, if applicable. Null for unplanned breakdowns without immediate work order creation.',
    `action_code` STRING COMMENT 'Standardized code identifying the corrective action taken to restore the equipment to operational status (e.g., repair, replace, adjust, clean, reset). Used for maintenance strategy analysis and cost tracking.',
    `actual_repair_cost` DECIMAL(18,2) COMMENT 'Actual total cost in local currency incurred to repair or resolve the downtime event, including labour, parts, contractor services, and equipment hire. Captured upon work order completion and cost reconciliation.',
    `cause_code` STRING COMMENT 'Standardized code identifying the root cause of the failure or downtime event (e.g., wear and tear, operator error, design defect, inadequate maintenance, environmental factors). Used for reliability improvement and preventive maintenance optimization.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this downtime event record was first created in the source system. Represents the initial data capture moment for audit and data lineage purposes.',
    `downtime_category` STRING COMMENT 'High-level classification of the downtime event distinguishing between planned maintenance activities, unplanned equipment failures, operational delays, and other causes. Critical for OEE (Overall Equipment Effectiveness) availability calculation.. Valid values are `planned_maintenance|unplanned_breakdown|standby|operational_delay|weather_delay|no_operator`',
    `downtime_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the downtime event measured in hours, calculated as the difference between downtime end and start timestamps. Used for OEE availability percentage, MTTR (Mean Time To Repair), and production loss calculations.',
    `downtime_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the equipment was restored to operational status and became available for production. Represents the end of the downtime period. Null for ongoing downtime events.',
    `downtime_event_number` STRING COMMENT 'Business identifier for the downtime event, typically auto-generated by CMMS or FMS. Used for tracking and reporting purposes.',
    `downtime_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the equipment became unavailable or non-operational. Represents the beginning of the downtime period. Critical for MTBF (Mean Time Between Failures) and availability calculations.',
    `downtime_status` STRING COMMENT 'Current lifecycle status of the downtime event record indicating whether the event is ongoing, under repair, resolved and equipment returned to service, or administratively closed.. Valid values are `open|in_progress|resolved|closed|cancelled`',
    `downtime_type` STRING COMMENT 'Detailed classification of the downtime event providing granular categorization within the downtime category (e.g., mechanical failure, electrical failure, hydraulic failure, scheduled inspection, component replacement).',
    `environmental_impact_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the downtime event resulted in an environmental impact such as spill, emission, or breach of environmental controls requiring regulatory notification.',
    `estimated_repair_cost` DECIMAL(18,2) COMMENT 'Estimated total cost in local currency to repair or resolve the downtime event, including labour, parts, and contractor costs. Captured at the time of work order creation or initial assessment.',
    `failure_description` STRING COMMENT 'Free-text narrative describing the nature of the failure, symptoms observed, and conditions leading to the downtime event. Captured by operators or maintenance technicians for detailed incident documentation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this downtime event record was last updated or modified in the source system. Used for change tracking and data synchronization control.',
    `location_code` STRING COMMENT 'Geographic or functional location code where the downtime event occurred (e.g., pit location, processing plant area, workshop). Supports spatial analysis of equipment reliability and maintenance resource deployment.',
    `primary_failure_code` STRING COMMENT 'Standardized code identifying the primary system, component, or subsystem that failed or required maintenance. Typically follows equipment taxonomy hierarchy (e.g., engine, hydraulics, electrical, structural). Used for failure mode analysis and spare parts planning.',
    `priority_code` STRING COMMENT 'Urgency classification of the downtime event determining the response sequence and resource allocation. Critical priority indicates production-stopping events requiring immediate attention.. Valid values are `critical|high|medium|low`',
    `production_impact_tonnes` DECIMAL(18,2) COMMENT 'Estimated production loss in tonnes of ore or material that could not be processed or moved due to this downtime event. Calculated based on equipment rated capacity and downtime duration. Critical for production planning and financial impact assessment.',
    `repair_time_minutes` DECIMAL(18,2) COMMENT 'Active repair or maintenance time in minutes, excluding waiting time, parts procurement delays, or administrative delays. Represents hands-on work duration. Used for MTTR (Mean Time To Repair) calculation and technician productivity analysis.',
    `reported_by` STRING COMMENT 'Name or identifier of the operator, supervisor, or technician who first reported the downtime event. Used for incident tracking and communication audit.',
    `reported_timestamp` TIMESTAMP COMMENT 'The date and time when the downtime event was formally reported or logged in the CMMS or FMS. May differ from downtime start timestamp if there was a delay in reporting.',
    `resolution_notes` STRING COMMENT 'Free-text narrative documenting the actions taken to resolve the downtime event, parts replaced, adjustments made, and final equipment condition. Captured by maintenance technicians upon completion.',
    `response_time_minutes` DECIMAL(18,2) COMMENT 'Time elapsed in minutes between the downtime event being reported and the first maintenance response or technician arrival on site. Key performance indicator for maintenance service level.',
    `responsible_department` STRING COMMENT 'The operational or maintenance department accountable for the asset and the downtime event (e.g., mining operations, processing, haulage, maintenance). Used for departmental performance reporting and cost allocation.',
    `safety_incident_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the downtime event involved or resulted in a safety incident, near-miss, or hazardous condition requiring HSE (Health Safety and Environment) investigation.',
    `shift` STRING COMMENT 'The operational shift during which the downtime event was initiated or primarily occurred. Used for shift performance analysis and crew accountability.. Valid values are `day|night|swing|roster_a|roster_b`',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated or recorded the downtime event (Infor EAM for maintenance-initiated events, Caterpillar MineStar for FMS-detected events, SCADA for process control events).. Valid values are `infor_eam|caterpillar_minestar|manual_entry|scada`',
    `work_centre` STRING COMMENT 'The maintenance work centre or crew responsible for responding to and resolving the downtime event. Used for workload balancing, resource planning, and accountability tracking.',
    CONSTRAINT pk_equipment_downtime PRIMARY KEY(`equipment_downtime_id`)
) COMMENT 'Transactional record capturing planned and unplanned equipment downtime events for maintainable assets. Records asset ID, downtime start and end timestamps, downtime duration (hours), downtime category (planned maintenance, unplanned breakdown, standby, operational delay), primary failure code, secondary failure code, work order reference, production impact (tonnes lost), and responsible work centre. SSOT for OEE, MTBF, and MTTR calculations. Sourced from Infor EAM and Caterpillar MineStar.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`failure_report` (
    `failure_report_id` BIGINT COMMENT 'Unique identifier for the failure report record. Primary key for the failure report entity.',
    `asset_id` BIGINT COMMENT 'Reference to the asset that experienced the failure. Identifies the specific equipment unit or component that failed.',
    `component_register_id` BIGINT COMMENT 'Foreign key linking to equipment.component_register. Business justification: Failure reports in mining RCM analysis are attributed to specific components (e.g., engine bearing, hydraulic pump). Linking failure_report to component_register enables component-level MTBF calculati',
    `condition_monitoring_id` BIGINT COMMENT 'Foreign key linking to maintenance.condition_monitoring. Business justification: A failure report is frequently initiated as a result of a condition monitoring reading that identified a defect (condition_monitoring.defect_identified_flag = true, follow_up_work_order_flag = true). ',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.corrective_action. Business justification: RCA findings from failure reports directly generate HSE corrective actions in mining. Regulatory and internal audit requirements mandate traceability from failure report RCA to corrective action imple',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Failure cost reporting for AISC calculation and root cause analysis requires cost centre attribution of failure costs. Mining reliability engineers and finance teams use failure cost by cost centre fo',
    `equipment_downtime_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment_downtime. Business justification: failure_report should optionally reference the equipment_downtime event that triggered the failure investigation. One equipment_downtime event can have one failure_report (1:1). Adding equipment_downt',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: failure_report has functional_location (STRING) but no FK to functional_location master. One functional_location can have many failure reports. Adding functional_location_id FK enables linking failure',
    `geotechnical_instrument_id` BIGINT COMMENT 'Foreign key linking to tailings.geotechnical_instrument. Business justification: Failure reports for geotechnical instruments. Critical for tracking instrument reliability, identifying systematic issues, and ensuring data quality for dam safety monitoring. Drives instrument replac',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Equipment failures triggering HSE incidents (pressure vessel rupture, conveyor fire, structural collapse). Essential for integrated RCA, incident investigation, and regulatory reporting in Mining oper',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to laboratory.instrument. Business justification: Instrument failures (e.g., ICP spectrometer breakdown, XRF detector failure) require formal failure reports in accredited mining labs. This link enables instrument reliability analysis (MTBF), support',
    `downtime_event_id` BIGINT COMMENT 'Foreign key linking to equipment.downtime_event. Business justification: Failure reports document root cause analysis for equipment downtime events. Mining reliability engineering requires traceability from RCA findings back to the originating downtime event for MTBF impro',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_schedule. Business justification: A failure report may be directly linked to the PM schedule that was being executed when the failure was discovered (e.g., during a scheduled inspection PM, a failure is found and a failure report is r',
    `previous_failure_report_id` BIGINT COMMENT 'Reference to the prior failure report if this is a repeat failure. Enables tracking of failure recurrence patterns.',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Failure reports for TSF equipment and infrastructure. Essential for reliability engineering, root cause analysis, FMEA updates, and demonstrating continuous improvement in TSF management for regulator',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Failure reports for equipment and infrastructure at waste rock dumps must be attributed to the specific WRD for geotechnical risk management and regulatory reporting. failure_report already links to t',
    `work_order_id` BIGINT COMMENT 'Reference to the corrective maintenance work order that documented this failure event. Links the failure report to the maintenance execution record.',
    `work_order_task_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order_task. Business justification: Failure reports are often raised at the task level within a work order — a specific inspection or repair task identifies the failure mode. failure_report already has work_order_id linking to the paren',
    `action_completed_date` DATE COMMENT 'Actual date when the recommended preventive actions were completed and verified.',
    `action_due_date` DATE COMMENT 'Target completion date for implementing the recommended preventive actions. Used to track closure of reliability improvement initiatives.',
    `action_status` STRING COMMENT 'Current status of the recommended action implementation. Tracks progress of reliability improvement initiatives.. Valid values are `open|in_progress|completed|cancelled|deferred`',
    `corrective_action_taken` STRING COMMENT 'Description of the immediate corrective action performed to restore the asset to service (e.g., replaced bearing, repaired weld, cleaned filter, reset system).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the failure report record was created in the system.',
    `detection_method` STRING COMMENT 'Method by which the failure was discovered. Indicates whether failure was detected proactively or reactively. [ENUM-REF-CANDIDATE: operator_observation|condition_monitoring|scheduled_inspection|predictive_maintenance|breakdown|alarm_notification|routine_testing — 7 candidates stripped; promote to reference product]',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the failure was detected or reported. May differ from failure timestamp if failure was latent or gradual.',
    `environmental_incident_flag` BOOLEAN COMMENT 'Indicates whether this failure resulted in an environmental release or impact requiring environmental incident reporting.',
    `estimated_mtbf_gain_hours` DECIMAL(18,2) COMMENT 'Estimated improvement in Mean Time Between Failures (MTBF) expected from implementing the recommended actions, measured in hours. Used to quantify reliability improvement potential.',
    `event_classification` STRING COMMENT 'Classification of the failure event for reliability program tracking (e.g., breakdown for unplanned stoppage, bad actor for high-cost repeat offender, FMEA finding for risk-based analysis result). [ENUM-REF-CANDIDATE: breakdown|bad_actor|repeat_failure|chronic_failure|fmea_finding|reliability_improvement|critical_failure — 7 candidates stripped; promote to reference product]',
    `failure_cause` STRING COMMENT 'Root cause or contributing factor that led to the failure (e.g., inadequate lubrication, material fatigue, operator error, design deficiency, environmental conditions).',
    `failure_cause_code` STRING COMMENT 'Standardized code classifying the failure cause according to the organizations cause taxonomy or ISO 14224 standard.',
    `failure_cost` DECIMAL(18,2) COMMENT 'Total cost of the failure including repair costs, lost production value, and consequential costs. Used for bad actor analysis and reliability investment justification.',
    `failure_description` STRING COMMENT 'Detailed narrative description of the failure event including symptoms observed, conditions at time of failure, and sequence of events leading to failure.',
    `failure_effect` STRING COMMENT 'Description of the consequence or impact of the failure on operations (e.g., complete shutdown, reduced capacity, safety hazard, environmental release, quality degradation).',
    `failure_mode` STRING COMMENT 'Description of how the asset failed (e.g., bearing seizure, belt tear, hydraulic leak, electrical short, structural crack). Describes the physical manifestation of the failure.',
    `failure_mode_code` STRING COMMENT 'Standardized code classifying the failure mode according to the organizations failure taxonomy or ISO 14224 standard.',
    `failure_report_number` STRING COMMENT 'Human-readable business identifier for the failure report. Used for external reference and communication.',
    `failure_severity` STRING COMMENT 'Severity classification of the failure based on operational impact, safety risk, and cost. Used for prioritizing reliability improvement efforts.. Valid values are `critical|major|moderate|minor`',
    `failure_timestamp` TIMESTAMP COMMENT 'Date and time when the failure event occurred. Critical for downtime calculation and reliability analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the failure report record was last updated.',
    `production_loss_tonnes` DECIMAL(18,2) COMMENT 'Estimated production loss in tonnes caused by this failure event. Used to quantify the operational impact of the failure.',
    `rca_findings` STRING COMMENT 'Summary of the root cause analysis investigation findings, including identified root causes, contributing factors, and failure mechanism analysis.',
    `rca_method` STRING COMMENT 'Methodology used to conduct the root cause analysis (e.g., 5 Whys, Fishbone Diagram, Fault Tree Analysis, FMEA). [ENUM-REF-CANDIDATE: 5_whys|fishbone_diagram|fault_tree_analysis|failure_mode_effects_analysis|pareto_analysis|barrier_analysis|change_analysis — 7 candidates stripped; promote to reference product]',
    `rca_performed_flag` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis investigation was conducted for this failure event. Typically performed for critical or repeat failures.',
    `recommended_actions` STRING COMMENT 'Preventive or improvement actions recommended to prevent recurrence of this failure (e.g., design modification, procedure change, training, preventive maintenance task addition, material upgrade).',
    `repeat_failure_flag` BOOLEAN COMMENT 'Indicates whether this failure is a recurrence of a previous failure on the same asset with the same or similar failure mode. Used to identify chronic reliability issues.',
    `report_status` STRING COMMENT 'Current workflow status of the failure report. Tracks the lifecycle of the failure investigation and action closure process.. Valid values are `draft|submitted|under_investigation|rca_in_progress|actions_assigned|closed`',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether this failure resulted in a safety incident or near-miss event requiring HSE (Health Safety and Environment) investigation.',
    CONSTRAINT pk_failure_report PRIMARY KEY(`failure_report_id`)
) COMMENT 'Detailed failure analysis and reliability event record linked to corrective maintenance work orders. Captures failure date and time, asset ID, functional location, failure mode, failure cause, failure effect, detection method (operator, condition monitoring, inspection), corrective action taken, root cause analysis (RCA) findings, event classification (breakdown, bad actor, repeat failure, FMEA finding, reliability improvement), repeat failure flag, reliability engineer assigned, recommended actions, action due date, action status, estimated reliability improvement (MTBF gain), and recommendations to prevent recurrence. Supports reliability engineering programs, FMEA, bad actor analysis, and reliability improvement tracking. Sourced from Infor EAM failure codes and RCA workflow.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`shutdown_plan` (
    `shutdown_plan_id` BIGINT COMMENT 'Unique identifier for the planned maintenance shutdown or major overhaul event. Primary key.',
    `capex_budget_id` BIGINT COMMENT 'Foreign key linking to finance.capex_budget. Business justification: Shutdowns involve significant capital expenditure tracked against approved capex budgets. Mining finance requires direct shutdown-to-capex-budget linkage for capital budget vs actual reporting and AFE',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Shutdown budgets and actuals are tracked against cost centres for major maintenance cost control, variance analysis, and annual shutdown budget planning in mining operations.',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Major shutdowns require emergency response plan activation, readiness verification, and emergency equipment testing. Regulatory requirement and critical safety planning process for planned shutdowns i',
    `expenditure_commitment_id` BIGINT COMMENT 'Foreign key linking to tenement.expenditure_commitment. Business justification: Shutdown costs (capital and operating) count toward the minimum annual expenditure commitment required under the mining licence. Linking shutdown plans directly to the expenditure commitment record en',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Major shutdowns in mining often involve capitalisation of overhaul costs as fixed asset additions (e.g., mill reline, crusher rebuild). shutdown_plan has capex_amount; linking to fixed_asset enables t',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: shutdown_plan has functional_location (STRING) but no FK to functional_location master. One functional_location can have many shutdown plans. Adding functional_location_id FK enables linking shutdown ',
    `heritage_clearance_id` BIGINT COMMENT 'Foreign key linking to tenement.heritage_clearance. Business justification: Shutdown activities involving ground disturbance require a valid heritage clearance before work can proceed. Shutdown plans must reference the applicable heritage clearance to confirm regulatory acces',
    `mine_site_id` BIGINT COMMENT 'Identifier of the mine site or processing plant where the shutdown will occur.',
    `offtake_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.offtake_agreement. Business justification: Mine planners must align major shutdowns with offtake delivery windows to avoid contractual penalties or force majeure triggers. This link enables commercial risk assessment during shutdown scheduling',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Major plant shutdowns are scheduled around orebody extraction plans to minimize impact on high-value ore processing campaigns. Critical for integrated mine-mill planning and production loss attributio',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_purchase_order. Business justification: Major mining shutdowns require dedicated purchase orders for bulk contractor services and materials distinct from individual work order POs. Linking shutdown_plan to procurement_purchase_order enables',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Shutdown planning requires compliance with specific regulatory conditions on the tenement licence (e.g., environmental permit conditions, noise/blast restrictions, operating hour limits). Maintenance ',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Mining shutdown plans require a formal risk assessment before execution — this is a regulatory requirement under mining safety legislation in all major jurisdictions. The existing plain-text risk_asse',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Shutdown plans track production_loss_tonnes but have no FK identifying WHICH saleable product is impacted. Mining operations reporting (e.g., iron ore vs copper shutdown impact analysis, production ',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Major shutdowns occur within specific tenement boundaries. Required for regulatory authority notification, surface rights coordination, native title consultation, and ensuring shutdown activities comp',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Planned shutdowns for major TSF maintenance (raise construction, major pump replacements, spillway repairs). Essential for coordinating production impact, contractor mobilization, and regulatory notif',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Shutdown plans are raised for WRD infrastructure maintenance (drainage system overhauls, liner inspections, batter re-profiling). shutdown_plan already links to tsf_id but WRD-scoped shutdowns require',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Capital shutdowns (plant expansions, major equipment installations during shutdown windows) are tracked via WBS elements for capex project accounting and asset capitalization.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Total actual duration of the shutdown in hours, calculated from actual start to actual end timestamps, enabling schedule variance analysis.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shutdown was completed and equipment returned to service, enabling performance analysis against planned schedule.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shutdown commenced, recorded when equipment was isolated and work began.',
    `approval_status` STRING COMMENT 'Status of management approval for the shutdown plan: pending (awaiting review), approved (authorized to proceed), rejected (not approved), or conditional (approved with conditions).. Valid values are `pending|approved|rejected|conditional`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the shutdown plan was formally approved, marking the authorization to proceed with detailed planning and execution preparation.',
    `capex_amount` DECIMAL(18,2) COMMENT 'Portion of shutdown cost classified as capital expenditure for asset improvements, upgrades, or life extension projects that increase asset value or extend useful life.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Overall completion percentage of the shutdown plan, calculated from the status of individual scope items and work packages, used for progress tracking and reporting.',
    `contractor_involvement_flag` BOOLEAN COMMENT 'Indicates whether external contractors are engaged for any work packages within the shutdown, triggering contractor management and coordination requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the shutdown plan record was first created in the system, establishing the audit trail for plan initiation.',
    `critical_path_duration_hours` DECIMAL(18,2) COMMENT 'Duration of the longest sequence of dependent activities (critical path) that determines the minimum shutdown duration, used for schedule optimization and risk management.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in the shutdown plan (e.g., USD, AUD, CAD, ZAR).. Valid values are `^[A-Z]{3}$`',
    `environmental_permit_required_flag` BOOLEAN COMMENT 'Indicates whether the shutdown requires environmental permits or notifications for activities such as emissions, waste disposal, or water discharge.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the shutdown plan record was last updated, enabling change tracking and version control.',
    `lessons_learned_summary` STRING COMMENT 'Post-shutdown summary of key lessons learned, best practices identified, and improvement opportunities for future shutdown planning and execution.',
    `opex_amount` DECIMAL(18,2) COMMENT 'Portion of shutdown cost classified as operating expenditure for routine maintenance, repairs, and inspections that maintain current asset condition and performance.',
    `planned_duration_hours` DECIMAL(18,2) COMMENT 'Total planned duration of the shutdown in hours, from start to completion, used for resource planning and production impact forecasting.',
    `planned_end_date` DATE COMMENT 'Scheduled date when the shutdown is planned to conclude, marking the completion of all work and return to normal operations.',
    `planned_start_date` DATE COMMENT 'Scheduled date when the shutdown is planned to commence, marking the beginning of equipment isolation and work execution.',
    `production_loss_tonnes` DECIMAL(18,2) COMMENT 'Estimated production volume loss in tonnes during the shutdown period, used for production planning and revenue impact assessment.',
    `project_code` STRING COMMENT 'SAP PS project code or WBS element linking the shutdown to capital project tracking, enabling integration with project accounting and progress reporting.',
    `safety_permit_required_flag` BOOLEAN COMMENT 'Indicates whether the shutdown requires special safety permits such as hot work permits, confined space entry permits, or isolation certificates.',
    `scope_description` STRING COMMENT 'Comprehensive narrative describing the overall scope of work, objectives, and deliverables for the shutdown event, including major work packages and critical activities.',
    `shutdown_name` STRING COMMENT 'Descriptive name of the shutdown event, such as Annual Plant Shutdown 2024 or SAG Mill Major Overhaul Q2.',
    `shutdown_number` STRING COMMENT 'Business identifier for the shutdown event, typically a human-readable code used across planning, execution, and reporting systems.',
    `shutdown_status` STRING COMMENT 'Current lifecycle status of the shutdown plan: draft (initial planning), planned (scope defined), approved (authorized for execution), in_progress (shutdown underway), completed (all work finished), cancelled (shutdown not proceeding), or on_hold (temporarily suspended). [ENUM-REF-CANDIDATE: draft|planned|approved|in_progress|completed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `shutdown_type` STRING COMMENT 'Classification of the shutdown event by purpose and scope: annual shutdown (routine yearly maintenance), major overhaul (extensive equipment rebuild), statutory inspection (regulatory compliance), emergency shutdown (unplanned critical event), planned outage (scheduled downtime), or turnaround (comprehensive facility maintenance).. Valid values are `annual_shutdown|major_overhaul|statutory_inspection|emergency_shutdown|planned_outage|turnaround`',
    `total_actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred during shutdown execution, aggregated from all work orders, purchase orders, and contractor invoices, enabling cost variance analysis.',
    `total_actual_labour_hours` DECIMAL(18,2) COMMENT 'Aggregate of all actual labour hours consumed across all work packages during shutdown execution, enabling productivity and efficiency analysis.',
    `total_planned_cost` DECIMAL(18,2) COMMENT 'Total estimated cost for the shutdown including labour, materials, contractor services, and equipment hire, used for budget approval and financial planning.',
    `total_planned_labour_hours` DECIMAL(18,2) COMMENT 'Aggregate of all estimated labour hours across all work packages and scope items within the shutdown plan, used for workforce planning and resource levelling.',
    CONSTRAINT pk_shutdown_plan PRIMARY KEY(`shutdown_plan_id`)
) COMMENT 'Master record for a planned maintenance shutdown or major overhaul event at a mine site or processing plant, including all scope items and work packages. Header captures shutdown name, type (annual shutdown, major overhaul, statutory inspection), planned and actual start/end dates, scope description, responsible superintendent, total planned duration and cost (CAPEX/OPEX), shutdown status, and project code. Scope line items capture individual work packages: scope item number, description, asset/functional location, trade required, estimated hours and cost, priority, critical path flag, predecessor items, and completion status. Enables shutdown scope management, resource levelling, and critical path scheduling. Sourced from Infor EAM and SAP PS.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`condition_monitoring` (
    `condition_monitoring_id` BIGINT COMMENT 'Unique identifier for the condition monitoring record.',
    `asset_id` BIGINT COMMENT 'Reference to the asset being monitored. Links to the equipment asset register.',
    `component_register_id` BIGINT COMMENT 'Foreign key linking to equipment.component_register. Business justification: Condition monitoring (vibration analysis, oil sampling, thermography, ultrasonic testing) targets specific serialized components (engines, gearboxes, final drives, hydraulic pumps). Mining predictive ',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Mining operations engage specialist CM contractors (vibration analysts, thermography firms, oil sampling labs). Tracking which contractor performed each monitoring activity is required for contractor ',
    `geotechnical_instrument_id` BIGINT COMMENT 'Foreign key linking to tailings.geotechnical_instrument. Business justification: Condition monitoring of geotechnical instruments themselves (not readings from them). Tracks instrument health, drift, calibration status. Essential for ensuring reliability of dam safety monitoring d',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to hse.hazard. Business justification: Condition monitoring readings that identify defects (e.g., gas detection, vibration anomalies, thermal imaging) are directly linked to specific hazards in the mining hazard register. This supports pro',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_schedule. Business justification: Condition monitoring readings and inspection rounds are typically triggered by and executed against a PM schedule (e.g., a vibration analysis PM or thermographic inspection PM). Linking condition_moni',
    `regulatory_condition_id` BIGINT COMMENT 'Foreign key linking to tenement.regulatory_condition. Business justification: Statutory condition monitoring activities (geotechnical monitoring, environmental monitoring, TSF surveillance) are mandated by specific regulatory conditions on the tenement licence. Linking conditio',
    `safety_observation_id` BIGINT COMMENT 'Foreign key linking to hse.safety_observation. Business justification: Safety observations triggering condition monitoring (abnormal vibration, temperature, noise observed during rounds). Real business process: proactive hazard identification and predictive maintenance i',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to maintenance.strategy. Business justification: Condition monitoring activities are mandated by a maintenance strategy (e.g., a Condition-Based Maintenance strategy specifies vibration monitoring at defined intervals). Linking condition_monitoring ',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: TSF condition monitoring includes non-instrument-based observations (visual dam face inspections, freeboard checks, seepage visual surveys) that are recorded directly against the TSF facility. conditi',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Condition monitoring programs at WRDs include slope stability visual checks, drainage condition assessments, and ARD seepage observations recorded against the dump facility. Direct WRD attribution ena',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created as a result of this condition monitoring finding, if applicable.',
    `alarm_threshold` DECIMAL(18,2) COMMENT 'Critical threshold value that triggers an alarm or immediate action when exceeded.',
    `alert_level` STRING COMMENT 'Current alert status based on measured value compared to thresholds (normal, warning, critical).. Valid values are `normal|warning|critical`',
    `baseline_value` DECIMAL(18,2) COMMENT 'Baseline or normal operating value for this measurement type on this asset, used for comparison and trend analysis.',
    `comments` STRING COMMENT 'Additional comments, observations, or notes recorded by the technician during the condition monitoring activity.',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard that this inspection satisfies (e.g., MSHA 30 CFR Part 56, AS 2550 Cranes, AS 3788 Pressure Equipment).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this condition monitoring record was first created in the system.',
    `data_source_system` STRING COMMENT 'Source system from which the condition monitoring data was captured (e.g., OSIsoft PI System, SKF Microlog, Infor EAM, inspection round template).',
    `defect_description` STRING COMMENT 'Detailed description of the defect, anomaly, or condition issue identified during monitoring.',
    `defect_identified_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a defect or anomaly was identified during this monitoring activity.',
    `defect_severity` STRING COMMENT 'Severity classification of the identified defect (low, medium, high, critical) based on impact to asset reliability and safety.. Valid values are `low|medium|high|critical`',
    `follow_up_work_order_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a follow-up work order should be or has been created based on this monitoring result.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this condition monitoring record was last updated or modified.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric value of the measurement taken during condition monitoring (e.g., vibration amplitude, temperature, wear depth, oil contamination level).',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the condition monitoring measurement or inspection was performed.',
    `monitoring_frequency` STRING COMMENT 'Scheduled frequency for this type of condition monitoring on this asset (daily, weekly, monthly, quarterly, annual, on condition).. Valid values are `daily|weekly|monthly|quarterly|annual|on_condition`',
    `monitoring_location` STRING COMMENT 'Specific location or measurement point on the asset where the reading was taken (e.g., motor drive end bearing, gearbox input shaft).',
    `monitoring_status` STRING COMMENT 'Current status of the condition monitoring activity (scheduled, in progress, completed, cancelled, overdue).. Valid values are `scheduled|in_progress|completed|cancelled|overdue`',
    `monitoring_type` STRING COMMENT 'Type of condition monitoring technique applied (vibration analysis, thermography, oil analysis, ultrasonic testing, visual inspection, wear measurement).. Valid values are `vibration_analysis|thermography|oil_analysis|ultrasonic|visual_inspection|wear_measurement`',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next condition monitoring inspection or measurement based on frequency requirements and current condition.',
    `pass_fail_result` STRING COMMENT 'Pass or fail result for inspection-based monitoring where numeric measurement is not applicable (pass, fail, conditional, not applicable).. Valid values are `pass|fail|conditional|not_applicable`',
    `pf_interval_days` STRING COMMENT 'Estimated number of days between potential failure detection (P) and functional failure (F) based on current condition trend, used for predictive maintenance scheduling.',
    `recommended_action` STRING COMMENT 'Recommended corrective or preventive action based on the monitoring results (e.g., schedule maintenance, replace component, increase monitoring frequency).',
    `statutory_inspection_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this monitoring activity fulfills a statutory or regulatory inspection requirement (e.g., pressure vessel inspection, lifting equipment certification).',
    `trend_direction` STRING COMMENT 'Direction of the condition trend compared to previous measurements (improving, stable, degrading, unknown).. Valid values are `improving|stable|degrading|unknown`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the measured value (e.g., mm/s for vibration, degrees Celsius for temperature, ppm for oil contamination, mm for wear).',
    `warning_threshold` DECIMAL(18,2) COMMENT 'Warning threshold value that indicates elevated risk and requires increased monitoring frequency.',
    CONSTRAINT pk_condition_monitoring PRIMARY KEY(`condition_monitoring_id`)
) COMMENT 'Record of condition monitoring readings, predictive measurements, and inspection rounds performed on an asset to support predictive and condition-based maintenance. Captures asset ID, monitoring type (vibration analysis, thermography, oil analysis, ultrasonic, visual inspection, wear measurement, operator inspection round), measurement date, measured value or pass/fail result, unit of measure, baseline value, alarm threshold, alert level (normal/warning/critical), technician/inspector ID, instrument used, trend direction, defects identified, defect severity, and recommended action or follow-up work order flag. Sourced from OSIsoft PI System, SKF Microlog, Infor EAM condition monitoring module, and inspection round templates. Feeds predictive maintenance triggers, supports P-F interval tracking, and ensures statutory inspection compliance for pressure vessels, lifting equipment, and electrical systems.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`work_order_cost` (
    `work_order_cost_id` BIGINT COMMENT 'Unique identifier for the work order cost record. Primary key for this entity.',
    `asset_id` BIGINT COMMENT 'Reference to the asset on which the maintenance work was performed. Enables cost rollup and analysis at the asset level for lifecycle costing.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Maintenance cost performance reporting requires linking actual work order costs to cost centres for budget vs actual variance analysis. Mining controllers use this for period-end OPEX reporting. Repla',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Work order costs are posted to specific GL accounts for financial statement preparation and AISC cost categorisation. Mining finance requires this FK for journal entry reconciliation and GL-level main',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Capital work order costs post to WBS elements for project accounting, asset under construction tracking, and capex budget consumption - required for proper capitalization of maintenance work.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent maintenance work order for which costs are being tracked. Links this cost record to the originating work order in Infor EAM.',
    `aisc_allocation_flag` BOOLEAN COMMENT 'Indicates whether this work order cost is included in the All-In Sustaining Cost calculation. True if the cost is part of sustaining operations; false if excluded (e.g., growth capital).',
    `approval_status` STRING COMMENT 'Current approval status of the work order cost record. Tracks whether the cost has been reviewed and approved by authorized personnel before posting.. Valid values are `pending|approved|rejected|cancelled`',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the work order cost record. Provides audit trail for cost approval authority.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the work order cost record was approved. Records the approval event in the cost lifecycle.',
    `budget_reference` STRING COMMENT 'Reference to the maintenance budget line item or project budget against which this work order cost is tracked. Links cost actuals to budget planning.',
    `c1_allocation_flag` BOOLEAN COMMENT 'Indicates whether this work order cost is included in the C1 cash cost calculation. True if the cost is part of direct operating costs; false if excluded (e.g., royalties, depreciation).',
    `contractor_cost` DECIMAL(18,2) COMMENT 'Total actual cost of external contractor services engaged for the work order. Includes labour, equipment, and services provided by third-party vendors.',
    `cost_capture_timestamp` TIMESTAMP COMMENT 'Date and time when the cost record was initially captured in the system. Represents the business event time for cost recording.',
    `cost_notes` STRING COMMENT 'Free-text notes and comments related to the work order cost record. Provides additional context, explanations, or justifications for cost variances.',
    `cost_posting_date` DATE COMMENT 'Date on which the work order costs were posted to the general ledger. Determines the financial period for cost recognition and reporting.',
    `cost_record_number` STRING COMMENT 'Business identifier for the work order cost record. Externally visible reference number used in financial reporting and cost reconciliation processes.. Valid values are `^WOC-[0-9]{8}$`',
    `cost_status` STRING COMMENT 'Current lifecycle status of the cost record in the approval and posting workflow. Tracks progression from draft through approval to final posting in the general ledger.. Valid values are `draft|submitted|approved|rejected|posted|closed`',
    `cost_type` STRING COMMENT 'Classification of the work order cost as operating expenditure (OPEX), capital expenditure (CAPEX), sustaining capital, or project capital. Critical for financial reporting and AISC/C1 cost allocation.. Valid values are `opex|capex|sustaining_capex|project_capex`',
    `cost_variance` DECIMAL(18,2) COMMENT 'Difference between total actual cost and total estimated cost. Positive values indicate cost overruns; negative values indicate cost savings. Key metric for maintenance cost control.',
    `cost_variance_percentage` DECIMAL(18,2) COMMENT 'Cost variance expressed as a percentage of the total estimated cost. Calculated as (cost_variance / total_estimated_cost) * 100. Used for performance reporting and trend analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work order cost record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all cost amounts are denominated. Ensures consistent currency interpretation for multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `equipment_hire_cost` DECIMAL(18,2) COMMENT 'Total actual cost of hired or rented equipment used during work order execution. Includes cranes, specialized tools, and temporary equipment not owned by the operation.',
    `labour_cost` DECIMAL(18,2) COMMENT 'Total actual labour cost incurred for the work order, including wages, overtime, and labour burden. Sourced from time sheets and labour rate tables in Infor EAM.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified the work order cost record. Provides accountability for data changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the work order cost record was last updated. Tracks the most recent change to the cost data.',
    `parts_materials_cost` DECIMAL(18,2) COMMENT 'Total actual cost of spare parts, consumables, and materials consumed during work order execution. Includes inventory withdrawals and direct purchases.',
    `rejection_reason` STRING COMMENT 'Explanation provided when a work order cost record is rejected during the approval process. Captures the rationale for non-approval.',
    `sap_co_order_reference` STRING COMMENT 'SAP CO internal order number used for detailed cost tracking and project accounting. Links the work order cost to SAP controlling module for OPEX and CAPEX classification.. Valid values are `^[0-9]{10,12}$`',
    `total_actual_cost` DECIMAL(18,2) COMMENT 'Sum of all actual cost components for the work order: labour, parts, contractor, equipment hire, and other costs. Represents the final actual expenditure for the maintenance activity.',
    `total_estimated_cost` DECIMAL(18,2) COMMENT 'Sum of all estimated cost components for the work order at the time of planning. Used for budget comparison and variance analysis against actual costs.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the work order cost record. Provides accountability for data entry.',
    CONSTRAINT pk_work_order_cost PRIMARY KEY(`work_order_cost_id`)
) COMMENT 'Aggregated cost summary record for a maintenance work order, capturing all cost components: labour cost, parts/materials cost, contractor cost, equipment hire cost, and total actual cost versus total estimated cost. Tracks cost centre, GL account code, SAP CO order reference, cost variance, and approval status. Provides the SSOT for maintenance OPEX cost reporting and AISC/C1 cost allocation at the work order level. Sourced from Infor EAM cost module and SAP CO.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`standard_job` (
    `standard_job_id` BIGINT COMMENT 'Unique identifier for the standard job plan template. Primary key.',
    `asset_class_id` BIGINT COMMENT 'Reference to the asset class or equipment category to which this job plan is applicable. Determines which assets can use this template.',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to hse.hazard. Business justification: Standard job plans in mining embed JSEA/hazard identification as part of the job plan. Linking standard_job directly to the hazard register (beyond the risk_assessment link) enables hazard-specific sa',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Standard job plans incorporate controls from risk assessments (LOTO procedures, confined space entry protocols, working at heights controls). Essential for safe work method development in Mining opera',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to maintenance.strategy. Business justification: Standard job plans (SJPs) are developed as part of a maintenance strategy — a CBM strategy defines specific inspection job plans, a time-based strategy defines periodic overhaul job plans. Linking sta',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this job plan is currently active and available for selection in new work orders and PM schedules.',
    `approval_status` STRING COMMENT 'Current approval state of the job plan. Only approved plans can be used in active PM schedules and work orders.. Valid values are `draft|pending_review|approved|rejected|obsolete|archived`',
    `approved_by` STRING COMMENT 'User ID or name of the maintenance manager or supervisor who approved this job plan for production use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this job plan was approved and made available for use in work orders and PM schedules.',
    `competency_requirements` STRING COMMENT 'List of required certifications, licenses, or competency levels that technicians must hold to execute this job plan (e.g., high voltage license, confined space entry certification).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this job plan record was first created in the CMMS.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all cost estimates in this job plan.. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'Date from which this job plan version becomes active and available for use in work orders and PM schedules.',
    `effective_to_date` DATE COMMENT 'Date after which this job plan version is no longer valid for new work orders. Nullable for currently active plans.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether execution of this job plan has potential environmental impacts requiring special handling, waste management, or environmental monitoring.',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Expected duration of asset or production downtime when this job plan is executed. Used for production planning and OEE (Overall Equipment Effectiveness) impact analysis.',
    `frequency_code` STRING COMMENT 'Recommended or typical execution frequency for this job plan when used in preventive maintenance schedules. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annual|annual|biennial|condition_based — 8 candidates stripped; promote to reference product]',
    `isolation_required_flag` BOOLEAN COMMENT 'Indicates whether equipment isolation (lockout/tagout) is required as part of this job plan to ensure worker safety.',
    `job_plan_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the standard job plan in the CMMS. Used for lookup and reference across PM schedules and work orders.. Valid values are `^[A-Z0-9]{4,20}$`',
    `job_plan_description` STRING COMMENT 'Detailed narrative description of the maintenance activity covered by this standard job plan, including scope, objectives, and expected outcomes.',
    `job_plan_type` STRING COMMENT 'Classification of the maintenance activity type that this job plan supports.. Valid values are `preventive|predictive|corrective|inspection|calibration|overhaul`',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last updated this job plan record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this job plan record was last modified.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether a safety work permit (e.g., hot work, confined space, electrical isolation) is required before executing this job plan.',
    `primary_trade_code` STRING COMMENT 'Code identifying the primary trade or craft required to execute this job plan (e.g., ELEC for electrician, MECH for mechanic, INST for instrument technician).. Valid values are `^[A-Z0-9]{2,10}$`',
    `primary_trade_description` STRING COMMENT 'Full name or description of the primary trade required for this job plan.',
    `priority_code` STRING COMMENT 'Default priority level assigned to work orders created from this job plan. Influences scheduling and resource allocation.. Valid values are `critical|high|medium|low`',
    `revision_date` DATE COMMENT 'Date when the current revision of the job plan was created or last modified.',
    `revision_number` STRING COMMENT 'Sequential version number of the job plan. Incremented each time the plan is updated and re-approved to maintain change history.',
    `safety_instructions` STRING COMMENT 'Detailed safety procedures, hazard warnings, and Personal Protective Equipment (PPE) requirements that must be followed when executing this job plan.',
    `short_description` STRING COMMENT 'Abbreviated title or summary of the job plan for display in lists, dropdowns, and mobile interfaces.',
    `shutdown_required_flag` BOOLEAN COMMENT 'Indicates whether the asset or production line must be shut down to execute this job plan.',
    `standard_operating_procedure_reference` STRING COMMENT 'Reference number or hyperlink to the detailed Standard Operating Procedure (SOP) document that provides step-by-step instructions for this job plan.',
    `task_sequence_count` STRING COMMENT 'Total number of sequential tasks defined in this job plan. Each task represents a discrete step in the maintenance procedure.',
    `total_estimated_cost` DECIMAL(18,2) COMMENT 'Total estimated cost for executing this job plan, including labor, materials, and contractor costs. Used for budgeting and cost control.',
    `total_estimated_hours` DECIMAL(18,2) COMMENT 'Sum of estimated labor hours across all tasks and trades defined in this job plan. Used for scheduling and resource planning.',
    `usage_count` STRING COMMENT 'Total number of times this job plan has been used to generate work orders or PM schedules. Indicates plan popularity and effectiveness.',
    `created_by` STRING COMMENT 'User ID or name of the maintenance planner or engineer who originally created this job plan.',
    CONSTRAINT pk_standard_job PRIMARY KEY(`standard_job_id`)
) COMMENT 'Standard job plan (SJP) template defining the pre-approved sequence of tasks, required trades, estimated hours, required parts, and safety instructions for a recurring maintenance activity. Captures job plan code, description, asset class applicability, revision number, approval status, total estimated hours, and associated safety requirements. Sourced from Infor EAM job plan library. Reused across PM schedules and work orders to ensure consistency and reduce planning time.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`functional_location` (
    `functional_location_id` BIGINT COMMENT 'Unique identifier for the functional location record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'FK to finance.cost_centre',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Functional locations in mining (processing plants, tailings storage, crusher stations) operate under specific environmental permits with conditions governing maintenance activities. Environmental comp',
    `hazard_id` BIGINT COMMENT 'Foreign key linking to hse.hazard. Business justification: Functional locations in mining carry inherent area-specific hazards (confined space, high voltage, fall from height, explosive atmosphere). Linking functional_location to hazard supports area hazard r',
    `heritage_clearance_id` BIGINT COMMENT 'Foreign key linking to tenement.heritage_clearance. Business justification: Functional locations in heritage-sensitive areas must reference their applicable heritage clearance to ensure all maintenance activities at that location are conducted within cleared boundaries. Maint',
    `mine_site_id` BIGINT COMMENT 'FK to mine.mine_site',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Processing circuits and crushing plants are often dedicated to specific orebodies (e.g., high-grade vs low-grade, oxide vs sulphide). Links equipment maintenance planning to ore source for metallurgic',
    `parent_fl_functional_location_id` BIGINT COMMENT 'Reference to the parent functional location in the hierarchy. Enables roll-up of maintenance costs and performance metrics. Null for top-level site locations.',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Functional locations in mining (e.g., Copper Concentrator Train 1, Iron Ore Screening Plant) are dedicated to producing a specific saleable product. Maintenance cost allocation by product line, AI',
    `surface_right_id` BIGINT COMMENT 'Foreign key linking to tenement.surface_right. Business justification: A functional location physically occupies land governed by a surface right agreement. Knowing which surface right covers a functional location is essential for land tenure compliance, access managemen',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Physical infrastructure and functional locations (plants, processing facilities, mine sites) are situated on specific tenements. Essential for access rights management, regulatory reporting, expenditu',
    `abc_indicator` STRING COMMENT 'ABC classification indicator for criticality and maintenance priority. A = critical to production, B = important, C = non-critical. Drives preventive maintenance frequency and spare parts stocking strategy.. Valid values are `A|B|C`',
    `building_structure_reference` STRING COMMENT 'Reference to the physical building or structure housing this functional location (e.g., crusher building, mill house, workshop). Used for facility management and capital asset tracking.',
    `commissioning_date` DATE COMMENT 'Date when the functional location was commissioned and became operational. Used for lifecycle tracking and Capital Expenditure (CAPEX) capitalization.',
    `company_code` STRING COMMENT 'SAP company code for financial reporting and consolidation. Enables multi-entity financial tracking and International Financial Reporting Standards (IFRS) compliance.. Valid values are `^[A-Z0-9]{4}$`',
    `construction_type` STRING COMMENT 'Construction type or design specification of the functional location (e.g., steel frame, concrete structure, underground excavation type). Relevant for structural integrity and maintenance planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the functional location record was first created in the CMMS or ERP system. Audit trail for data governance and master data management.',
    `decommissioning_date` DATE COMMENT 'Date when the functional location was decommissioned or taken out of service. Relevant for mine closure planning and rehabilitation provision tracking per Life of Mine (LOM) plan.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation above sea level in meters for the functional location. Critical for underground mine levels and surface topography mapping.',
    `environmental_sensitive_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this functional location is environmentally sensitive (e.g., Tailings Storage Facility - TSF, water treatment plant, chemical storage) requiring enhanced monitoring and compliance reporting per ISO 14001 and Environmental Impact Statement (EIS) requirements.',
    `external_reference_code` STRING COMMENT 'External system reference identifier for cross-system integration and data synchronization. Enables traceability back to the source operational system.',
    `fl_code` STRING COMMENT 'Hierarchical alphanumeric code representing the functional location within the mine or plant structure. Typically follows a structured format (e.g., SITE-AREA-SYSTEM-SUBSYSTEM). Sourced from Infor EAM and SAP PM functional location hierarchy.. Valid values are `^[A-Z0-9]{4,20}$`',
    `fl_description` STRING COMMENT 'Full business description of the functional location, providing context on the physical or logical position within the mine or plant where assets are installed and maintained.',
    `fl_type` STRING COMMENT 'Classification of the functional location within the hierarchy. Defines the level of granularity (e.g., site, area, system, sub-system, component position, zone).. Valid values are `site|area|system|sub_system|component_position|zone`',
    `isolation_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether equipment at this functional location requires Lock Out Tag Out (LOTO) isolation procedures before maintenance work can commence.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the functional location record was last modified. Tracks data currency and supports change management processes.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the functional location. Used for spatial analysis and Geographic Information System (GIS) integration.',
    `linear_unit` STRING COMMENT 'Unit of measure for linear dimensions at this functional location (e.g., m for meters, ft for feet, km for kilometers). Used for spatial calculations and engineering drawings.. Valid values are `m|ft|km`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the functional location. Used for spatial analysis and Geographic Information System (GIS) integration.',
    `maintenance_planner_group` STRING COMMENT 'Code identifying the maintenance planner group responsible for work orders and preventive maintenance activities at this functional location. Links to workforce planning and scheduling.. Valid values are `^[A-Z0-9]{2,10}$`',
    `maintenance_plant_code` STRING COMMENT 'Maintenance plant code for work execution and spare parts inventory management. Links to Computerized Maintenance Management System (CMMS) organizational hierarchy.. Valid values are `^[A-Z0-9]{2,6}$`',
    `operational_status` STRING COMMENT 'Current operational status of the functional location. Indicates whether the location is actively used for maintenance planning and asset operations.. Valid values are `active|inactive|decommissioned|under_construction|planned`',
    `permit_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether work at this functional location requires special permits (e.g., hot work permit, confined space entry, isolation permit) per Standard Operating Procedure (SOP) and safety protocols.',
    `planning_plant_code` STRING COMMENT 'SAP PM planning plant code associated with this functional location. Used for maintenance planning scope and organizational assignment in Enterprise Resource Planning (ERP) systems.. Valid values are `^[A-Z0-9]{2,6}$`',
    `plant_area` STRING COMMENT 'Specific plant area or operational zone within the mine site (e.g., crushing plant, concentrator, ROM pad, tailings storage facility, underground level).',
    `room_floor_reference` STRING COMMENT 'Specific room, floor, or level reference within a building or underground mine level. Provides granular spatial context for asset location and maintenance access planning.',
    `safety_critical_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this functional location contains safety-critical equipment requiring enhanced inspection and maintenance protocols per Mine Safety and Health Administration (MSHA) and ISO 45001 standards.',
    `scada_tag_prefix` STRING COMMENT 'SCADA tag prefix used to identify real-time process data and telemetry streams from equipment installed at this functional location. Enables integration with OSIsoft PI System and Manufacturing Execution System (MES).',
    `sort_field` STRING COMMENT 'Additional sorting or grouping field used for custom reporting and functional location list displays in CMMS and ERP systems.',
    `source_system` STRING COMMENT 'Identifies the source system of record for this functional location (e.g., Infor EAM, SAP PM, Hexagon MinePlan, manual entry). Critical for data lineage and reconciliation in lakehouse architecture.. Valid values are `infor_eam|sap_pm|hexagon_mineplan|manual`',
    `weight_unit` STRING COMMENT 'Unit of measure for weight-related attributes at this functional location (e.g., kg for kilograms, t for metric tonnes, lb for pounds). Used for load calculations and structural capacity planning.. Valid values are `kg|t|lb`',
    CONSTRAINT pk_functional_location PRIMARY KEY(`functional_location_id`)
) COMMENT 'Hierarchical functional location (FL) master representing the physical or logical position within the mine or plant where an asset is installed and maintained. Captures FL code, description, FL type (site, area, system, sub-system, component position), parent FL, mine site, plant area, GPS coordinates, operational status, and maintenance planner group. Sourced from Infor EAM and SAP PM functional location hierarchy. Provides the spatial context for all maintenance activities, asset performance reporting, and maintenance cost roll-up. Note: distinct from the equipment master (owned by equipment domain) — this entity owns the WHERE, while equipment owns the WHAT.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`strategy` (
    `strategy_id` BIGINT COMMENT 'Unique identifier for the maintenance strategy record. Primary key.',
    `asset_class_id` BIGINT COMMENT 'Reference to the asset class to which this maintenance strategy applies. Links to the asset classification hierarchy.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Maintenance strategies carry annual cost estimates budgeted against cost centres for long-term maintenance planning and OPEX budget preparation. Mining planners use this to align strategy costs with c',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Maintenance strategies in mining are developed through RCM analysis underpinned by formal risk assessments. The existing rcm_analysis_reference and fmea_reference are plain text; a proper FK to risk_a',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: TSF-specific maintenance strategies are a regulatory requirement under MAC/ANCOLD dam safety frameworks. A maintenance strategy scoped to a specific TSF (e.g., instrumentation monitoring strategy, emb',
    `approval_date` DATE COMMENT 'Date on which the maintenance strategy was formally approved for implementation by the asset management authority.',
    `compliance_framework` STRING COMMENT 'Regulatory or industry compliance framework that this maintenance strategy is designed to satisfy, such as MSHA, ISO 45001, or environmental regulations. [ENUM-REF-CANDIDATE: iso_45001|iso_14001|msha|jorc|icmm|local_mining_act — promote to reference product]',
    `condition_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this strategy includes condition monitoring techniques such as vibration analysis, thermography, or oil analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance strategy record was first created in the system.',
    `criticality_rating` STRING COMMENT 'Criticality classification of the assets covered by this strategy, determining the intensity and frequency of maintenance activities.. Valid values are `critical|high|medium|low`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all cost estimates associated with this maintenance strategy.. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'Date from which this maintenance strategy becomes active and applicable to the designated asset class or assets.',
    `effective_to_date` DATE COMMENT 'Date on which this maintenance strategy ceases to be active. Null indicates an open-ended strategy.',
    `estimated_annual_cost` DECIMAL(18,2) COMMENT 'Estimated total annual cost in base currency for executing this maintenance strategy, including labour, parts, and contractor costs.',
    `fmea_reference` STRING COMMENT 'Reference identifier to the FMEA study that informed the failure modes and maintenance tasks for this strategy.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this maintenance strategy record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date on which this maintenance strategy was last reviewed and validated for continued effectiveness.',
    `maintenance_philosophy` STRING COMMENT 'The overarching maintenance approach applied: run-to-failure (reactive), time-based (preventive), condition-based (CBM), predictive (PdM), reliability-centred maintenance (RCM), or risk-based maintenance (RBM).. Valid values are `run_to_failure|time_based|condition_based|predictive|rcm|risk_based`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this maintenance strategy.',
    `performance_kpi_definition` STRING COMMENT 'Definition of the key performance indicators used to measure the success and effectiveness of this maintenance strategy.',
    `pm_schedule_count` STRING COMMENT 'Number of preventive maintenance schedules or task lists associated with this maintenance strategy.',
    `predictive_analytics_flag` BOOLEAN COMMENT 'Indicates whether this strategy leverages predictive analytics or machine learning models to forecast failures and optimize maintenance timing.',
    `rcm_analysis_reference` STRING COMMENT 'Reference identifier to the RCM analysis document or study that underpins this maintenance strategy, if applicable.',
    `review_cycle_months` STRING COMMENT 'Frequency in months at which this maintenance strategy is reviewed and updated to ensure continued effectiveness and alignment with asset performance.',
    `risk_mitigation_approach` STRING COMMENT 'Description of how this maintenance strategy mitigates operational, safety, and environmental risks associated with asset failure.',
    `shutdown_strategy_flag` BOOLEAN COMMENT 'Indicates whether this strategy is specifically designed for major shutdowns or turnarounds requiring extended downtime.',
    `spare_parts_strategy` STRING COMMENT 'Approach to spare parts inventory management for assets covered by this strategy: stock on hand, just-in-time, vendor-managed inventory, or consignment.. Valid values are `stock_on_hand|just_in_time|vendor_managed|consignment`',
    `strategy_code` STRING COMMENT 'Business identifier code for the maintenance strategy, used for external reference and integration with CMMS systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `strategy_description` STRING COMMENT 'Detailed narrative describing the maintenance strategy objectives, scope, key activities, and expected outcomes.',
    `strategy_name` STRING COMMENT 'Descriptive name of the maintenance strategy that clearly identifies the approach and scope.',
    `strategy_status` STRING COMMENT 'Current lifecycle status of the maintenance strategy indicating whether it is in use, under development, or retired.. Valid values are `draft|active|under_review|suspended|obsolete`',
    `strategy_type` STRING COMMENT 'Classification of the maintenance strategy by execution type: preventive (scheduled), predictive (condition-triggered), corrective (planned repair), breakdown (emergency), shutdown (major overhaul), or project (capital upgrade).. Valid values are `preventive|predictive|corrective|breakdown|shutdown|project`',
    `target_mtbf_hours` DECIMAL(18,2) COMMENT 'Target Mean Time Between Failures in hours that this maintenance strategy aims to achieve for the asset class.',
    `target_mttr_hours` DECIMAL(18,2) COMMENT 'Target Mean Time To Repair in hours that this maintenance strategy aims to achieve, minimizing downtime.',
    `target_oee_percent` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness percentage that this maintenance strategy is designed to support or improve.',
    `version_number` STRING COMMENT 'Version number of the maintenance strategy document, tracking revisions and updates over time.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_strategy PRIMARY KEY(`strategy_id`)
) COMMENT 'Maintenance strategy master defining the overall maintenance approach applied to an asset class or individual asset. Captures strategy code, strategy name, maintenance philosophy (run-to-failure, time-based, condition-based, reliability-centred maintenance), applicable asset class, review cycle, responsible reliability engineer, approval date, and associated PM schedules. Supports RCM (Reliability Centred Maintenance) programs and asset management planning per ISO 55001.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` (
    `job_plan_parts_list_id` BIGINT COMMENT 'Primary key for the job_plan_parts_list association',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to the spare part master record required by this job plan.',
    `standard_job_id` BIGINT COMMENT 'Foreign key linking to the standard job plan template that requires this spare part.',
    `criticality_classification` STRING COMMENT 'The criticality classification of this spare part in the context of this specific job plan execution (e.g., critical, insurance, non-critical). May differ from the spare parts general criticality_classification on the spare_part master, as a part may be critical for one job plan but non-critical for another.',
    `parts_list_attached_flag` BOOLEAN COMMENT 'Indicates whether a Bill of Materials (BOM) or parts list is attached to this job plan, specifying required spare parts and consumables. [Moved from standard_job: This BOOLEAN flag on standard_job indicates whether a parts list exists. Once the job_plan_parts_list association table is created, the existence of records in that table makes this flag redundant and derivable. It should be deprecated from standard_job in favour of the association table.]',
    `quantity_required` DECIMAL(18,2) COMMENT 'The quantity of this spare part required to execute one instance of the standard job plan. Belongs to the job-part relationship, not to either entity alone — the same part may be required in different quantities on different job plans.',
    `sequence_number` BIGINT COMMENT 'The order in which this part should be staged or kitted when preparing materials for job execution. Used by stores and kitting teams to assemble parts in the correct sequence for the job plan. Belongs to the relationship, not to the part or job plan independently.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity_required field (e.g., EA, KG, L, M). Defined at the job-plan-part level as the UOM may differ from the spare parts default stocking UOM in specific job contexts.',
    CONSTRAINT pk_job_plan_parts_list PRIMARY KEY(`job_plan_parts_list_id`)
) COMMENT 'This association product represents the pre-approved Bill of Materials (BOM) for a Standard Job Plan in the CMMS. It captures the specific spare parts required to execute a standard job plan, along with the quantity, unit of measure, staging sequence, and criticality context for each part-job combination. Each record links one standard_job to one spare_part and carries attributes that exist only in the context of that specific job-part pairing. This entity drives parts reservation, kitting, and procurement planning for scheduled and preventive maintenance activities. Sourced from Infor EAM job plan material lines.. Existence Justification: In CMMS/EAM systems like Infor EAM, a Standard Job Plan (SJP) has a pre-approved Bill of Materials (parts list) that maintenance planners actively manage — adding, removing, and adjusting quantities of spare parts per job plan. A single standard job plan requires many spare parts, and a single spare part appears on many different standard job plans. This is the Standard Job Parts List or Job Plan Material List, a first-class operational entity that drives parts reservation, kitting, and procurement planning for scheduled maintenance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `mining_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_standard_job_id` FOREIGN KEY (`standard_job_id`) REFERENCES `mining_ecm`.`maintenance`.`standard_job`(`standard_job_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_standard_job_id` FOREIGN KEY (`standard_job_id`) REFERENCES `mining_ecm`.`maintenance`.`standard_job`(`standard_job_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_standard_job_id` FOREIGN KEY (`standard_job_id`) REFERENCES `mining_ecm`.`maintenance`.`standard_job`(`standard_job_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `mining_ecm`.`maintenance`.`strategy`(`strategy_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ADD CONSTRAINT `fk_maintenance_asset_bom_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `mining_ecm`.`maintenance`.`spare_part`(`spare_part_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `mining_ecm`.`maintenance`.`spare_part`(`spare_part_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_work_order_task_id` FOREIGN KEY (`work_order_task_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order_task`(`work_order_task_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ADD CONSTRAINT `fk_maintenance_labour_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ADD CONSTRAINT `fk_maintenance_labour_record_work_order_task_id` FOREIGN KEY (`work_order_task_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order_task`(`work_order_task_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_shutdown_plan_id` FOREIGN KEY (`shutdown_plan_id`) REFERENCES `mining_ecm`.`maintenance`.`shutdown_plan`(`shutdown_plan_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_condition_monitoring_id` FOREIGN KEY (`condition_monitoring_id`) REFERENCES `mining_ecm`.`maintenance`.`condition_monitoring`(`condition_monitoring_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_equipment_downtime_id` FOREIGN KEY (`equipment_downtime_id`) REFERENCES `mining_ecm`.`maintenance`.`equipment_downtime`(`equipment_downtime_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `mining_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_previous_failure_report_id` FOREIGN KEY (`previous_failure_report_id`) REFERENCES `mining_ecm`.`maintenance`.`failure_report`(`failure_report_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_work_order_task_id` FOREIGN KEY (`work_order_task_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order_task`(`work_order_task_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `mining_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `mining_ecm`.`maintenance`.`strategy`(`strategy_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ADD CONSTRAINT `fk_maintenance_work_order_cost_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ADD CONSTRAINT `fk_maintenance_standard_job_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `mining_ecm`.`maintenance`.`strategy`(`strategy_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_parent_fl_functional_location_id` FOREIGN KEY (`parent_fl_functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` ADD CONSTRAINT `fk_maintenance_job_plan_parts_list_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `mining_ecm`.`maintenance`.`spare_part`(`spare_part_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` ADD CONSTRAINT `fk_maintenance_job_plan_parts_list_standard_job_id` FOREIGN KEY (`standard_job_id`) REFERENCES `mining_ecm`.`maintenance`.`standard_job`(`standard_job_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`maintenance` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `mining_ecm`.`maintenance` SET TAGS ('dbx_domain' = 'maintenance');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `drill_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Program Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `geological_domain_id` SET TAGS ('dbx_business_glossary_term' = 'Geological Domain Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `geotechnical_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `heritage_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Audit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `production_drillhole_id` SET TAGS ('dbx_business_glossary_term' = 'Production Drillhole Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `standard_job_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Job Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `surface_right_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Right Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_labour_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labour Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `completion_code` SET TAGS ('dbx_business_glossary_term' = 'Completion Code');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `contractor_cost` SET TAGS ('dbx_business_glossary_term' = 'Contractor Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `contractor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `cost_variance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `equipment_hire_cost` SET TAGS ('dbx_business_glossary_term' = 'Equipment Hire Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `equipment_hire_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `estimated_labour_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labour Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `labour_cost` SET TAGS ('dbx_business_glossary_term' = 'Labour Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `labour_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `originating_source` SET TAGS ('dbx_business_glossary_term' = 'Originating Source');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `parts_materials_cost` SET TAGS ('dbx_business_glossary_term' = 'Parts and Materials Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `parts_materials_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Order Priority');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `safety_permit_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `sap_co_order_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Controlling (CO) Order Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `shutdown_flag` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `total_actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Cost (OPEX)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `total_actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost (OPEX)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `trade_craft_required` SET TAGS ('dbx_business_glossary_term' = 'Trade or Craft Required');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_centre` SET TAGS ('dbx_business_glossary_term' = 'Work Centre');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{8}$');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'preventive|corrective|predictive|condition_based|breakdown|project');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `work_order_task_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Task Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `standard_job_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Job Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `action_code` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Code');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Task Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `actual_labour_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labour Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause Code');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Task Completion Notes');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Equipment Downtime Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Task Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `estimated_labour_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labour Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Code');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `isolation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Isolation Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Task Priority Code');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `safety_instructions` SET TAGS ('dbx_business_glossary_term' = 'Safety Instructions');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence Number');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Task Number');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `trade_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Code');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `trade_description` SET TAGS ('dbx_business_glossary_term' = 'Trade Description');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'asset_planning');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `component_register_id` SET TAGS ('dbx_business_glossary_term' = 'Component Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `geotechnical_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `opex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Opex Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `standard_job_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Job Plan ID');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `strategy_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `auto_generate_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Generate Work Order Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `compliance_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'PM Compliance Target Percentage');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Effective End Date');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Effective Start Date');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance PM Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated PM Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated PM Duration in Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `frequency_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Frequency Type');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `frequency_type` SET TAGS ('dbx_value_regex' = 'calendar|runtime-hours|cycles|condition-triggered|meter-based|event-based');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `interval_unit` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval Unit of Measure');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `interval_value` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval Value');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `isolation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Isolation Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `last_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Last PM Completion Date');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last PM Schedule Review Date');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'PM Lead Time in Days');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next PM Due Date');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next PM Schedule Review Date');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Notes');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'PM Plan Description');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `pm_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Plan Code');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `pm_plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Priority Code');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Review Cycle in Months');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical PM Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'PM Schedule Status');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|suspended|inactive|under-review|obsolete');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `shutdown_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Shutdown Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` SET TAGS ('dbx_subdomain' = 'asset_planning');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `asset_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bill of Materials (BOM) Identifier');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset Identifier');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `primary_component_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Component Asset Identifier');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `bom_level` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Level');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_business_glossary_term' = 'BOM Record Status');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `bom_status` SET TAGS ('dbx_value_regex' = 'active|inactive|superseded|obsolete|pending');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'BOM Record Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Component Criticality Rating');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective From Date');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'BOM Effective To Date');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `engineering_change_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Change Number (ECN)');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `engineering_change_number` SET TAGS ('dbx_value_regex' = '^ECN-[0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `environmental_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Critical Component Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `interchangeable_flag` SET TAGS ('dbx_business_glossary_term' = 'Interchangeable Component Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'BOM Record Last Modified By');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'BOM Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `material_specification` SET TAGS ('dbx_business_glossary_term' = 'Component Material Specification');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `mean_time_between_failures` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF)');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `mean_time_to_repair` SET TAGS ('dbx_business_glossary_term' = 'Mean Time To Repair (MTTR)');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Component Part Number');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `position_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Component Position Tag Number');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `position_tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `quantity_required` SET TAGS ('dbx_business_glossary_term' = 'Component Quantity Required');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `rotable_flag` SET TAGS ('dbx_business_glossary_term' = 'Rotable Component Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Component Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'BOM Sequence Number');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `serialized_flag` SET TAGS ('dbx_business_glossary_term' = 'Serialized Component Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'BOM Source System');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Infor EAM|SAP PM|Manual Entry|Data Migration');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Component Warranty Period (Months)');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'BOM Record Created By');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` SET TAGS ('dbx_subdomain' = 'asset_planning');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `chemical_register_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `bill_of_materials_flag` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `criticality_classification` SET TAGS ('dbx_business_glossary_term' = 'Criticality Classification');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `criticality_classification` SET TAGS ('dbx_value_regex' = 'insurance|critical|non-critical');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `dimensions` SET TAGS ('dbx_business_glossary_term' = 'Dimensions');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `economic_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Economic Order Quantity (EOQ)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `interchangeable_part_number` SET TAGS ('dbx_business_glossary_term' = 'Interchangeable Part Number');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `last_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Issue Date');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `material_specification` SET TAGS ('dbx_business_glossary_term' = 'Material Specification');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `minimum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Level');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `obsolescence_status` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Status');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `obsolescence_status` SET TAGS ('dbx_value_regex' = 'active|obsolete|phase-out|discontinued');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `oem_part_number` SET TAGS ('dbx_business_glossary_term' = 'Original Equipment Manufacturer (OEM) Part Number');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `part_category` SET TAGS ('dbx_business_glossary_term' = 'Part Category');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `part_description` SET TAGS ('dbx_business_glossary_term' = 'Part Description');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `part_status` SET TAGS ('dbx_business_glossary_term' = 'Part Status');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `part_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|blocked');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `part_type` SET TAGS ('dbx_business_glossary_term' = 'Part Type');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `part_type` SET TAGS ('dbx_value_regex' = 'rotable|repairable|consumable|expendable');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `serial_number_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Tracking Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Months)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `standard_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `standard_unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `parts_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Parts Consumption ID');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `chemical_register_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `component_register_id` SET TAGS ('dbx_business_glossary_term' = 'Component Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `work_order_task_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Task ID');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `aisc_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Allocation Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `bin_location` SET TAGS ('dbx_business_glossary_term' = 'Bin Location');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `core_charge_flag` SET TAGS ('dbx_business_glossary_term' = 'Core Charge Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `opex_category` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Category');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `opex_category` SET TAGS ('dbx_value_regex' = 'maintenance|operations|sustaining|growth|exploration');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `quantity_issued` SET TAGS ('dbx_business_glossary_term' = 'Quantity Issued');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `rotable_return_flag` SET TAGS ('dbx_business_glossary_term' = 'Rotable Return Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `store_location_code` SET TAGS ('dbx_business_glossary_term' = 'Store Location Code');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `store_location_name` SET TAGS ('dbx_business_glossary_term' = 'Store Location Name');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'issue|return|adjustment|transfer|scrap');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `labour_record_id` SET TAGS ('dbx_business_glossary_term' = 'Labour Record ID');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `work_order_task_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Task ID');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Labour End Time');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `labour_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Labour Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `labour_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `overtime_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime Rate');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `overtime_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|poor');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `permit_reference` SET TAGS ('dbx_business_glossary_term' = 'Permit Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `purchase_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Labour Source Type');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'employee|contractor');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Labour Start Time');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `timesheet_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Entry Number');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `trade_craft` SET TAGS ('dbx_business_glossary_term' = 'Trade or Craft');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `worker_name` SET TAGS ('dbx_business_glossary_term' = 'Worker Name');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `worker_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `worker_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `equipment_downtime_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Downtime ID');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `cargo_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Shipment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `drill_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Program Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `shutdown_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `action_code` SET TAGS ('dbx_business_glossary_term' = 'Action Code');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `actual_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Repair Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'Cause Code');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `downtime_category` SET TAGS ('dbx_business_glossary_term' = 'Downtime Category');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `downtime_category` SET TAGS ('dbx_value_regex' = 'planned_maintenance|unplanned_breakdown|standby|operational_delay|weather_delay|no_operator');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `downtime_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Duration Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `downtime_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime End Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `downtime_event_number` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Number');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `downtime_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Downtime Start Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `downtime_status` SET TAGS ('dbx_business_glossary_term' = 'Downtime Status');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `downtime_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|cancelled');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `downtime_type` SET TAGS ('dbx_business_glossary_term' = 'Downtime Type');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `estimated_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `failure_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Description');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `primary_failure_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Failure Code');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `production_impact_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Production Impact Tonnes');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `repair_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Repair Time Minutes');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Response Time Minutes');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing|roster_a|roster_b');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'infor_eam|caterpillar_minestar|manual_entry|scada');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `work_centre` SET TAGS ('dbx_business_glossary_term' = 'Work Centre');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Report ID');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `component_register_id` SET TAGS ('dbx_business_glossary_term' = 'Component Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `condition_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Monitoring Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `equipment_downtime_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Downtime Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `geotechnical_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `downtime_event_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Downtime Event Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `previous_failure_report_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Failure Report ID');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `work_order_task_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Task Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Action Completed Date');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Due Date');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|cancelled|deferred');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `environmental_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `estimated_mtbf_gain_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Mean Time Between Failures (MTBF) Gain Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `event_classification` SET TAGS ('dbx_business_glossary_term' = 'Event Classification');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_cause` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause Code');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_cost` SET TAGS ('dbx_business_glossary_term' = 'Failure Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Description');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_effect` SET TAGS ('dbx_business_glossary_term' = 'Failure Effect');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_mode_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Code');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_report_number` SET TAGS ('dbx_business_glossary_term' = 'Failure Report Number');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_severity` SET TAGS ('dbx_business_glossary_term' = 'Failure Severity');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_severity` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Failure Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `production_loss_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Production Loss Tonnes');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `rca_findings` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Findings');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `rca_method` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Method');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `rca_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Performed Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `recommended_actions` SET TAGS ('dbx_business_glossary_term' = 'Recommended Actions');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `repeat_failure_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Failure Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_investigation|rca_in_progress|actions_assigned|closed');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` SET TAGS ('dbx_subdomain' = 'asset_planning');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Plan ID');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `capex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `expenditure_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Commitment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `heritage_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `offtake_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Offtake Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `capex_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Amount');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `contractor_involvement_flag` SET TAGS ('dbx_business_glossary_term' = 'Contractor Involvement Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `critical_path_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Duration Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `environmental_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `lessons_learned_summary` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned Summary');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `opex_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Amount');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `planned_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Duration Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `production_loss_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Production Loss Tonnes');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `safety_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_name` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Name');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_number` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Number');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_status` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Status');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_type` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Type');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_type` SET TAGS ('dbx_value_regex' = 'annual_shutdown|major_overhaul|statutory_inspection|emergency_shutdown|planned_outage|turnaround');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `total_actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `total_actual_labour_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Labour Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `total_planned_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `total_planned_labour_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Labour Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` SET TAGS ('dbx_subdomain' = 'asset_planning');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `condition_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Monitoring ID');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `component_register_id` SET TAGS ('dbx_business_glossary_term' = 'Component Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `geotechnical_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `regulatory_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Condition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `safety_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Strategy Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `alarm_threshold` SET TAGS ('dbx_business_glossary_term' = 'Alarm Threshold');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `alert_level` SET TAGS ('dbx_business_glossary_term' = 'Alert Level');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `alert_level` SET TAGS ('dbx_value_regex' = 'normal|warning|critical');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `defect_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Defect Identified Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `defect_severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `defect_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `follow_up_work_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Work Order Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual|on_condition');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `monitoring_location` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Location');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Status');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `monitoring_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|overdue');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Type');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_value_regex' = 'vibration_analysis|thermography|oil_analysis|ultrasonic|visual_inspection|wear_measurement');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_business_glossary_term' = 'Pass Fail Result');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `pass_fail_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|not_applicable');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `pf_interval_days` SET TAGS ('dbx_business_glossary_term' = 'P-F (Potential to Functional Failure) Interval Days');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `statutory_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Statutory Inspection Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'improving|stable|degrading|unknown');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `warning_threshold` SET TAGS ('dbx_business_glossary_term' = 'Warning Threshold');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `work_order_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Cost ID');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `aisc_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Allocation Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `budget_reference` SET TAGS ('dbx_business_glossary_term' = 'Budget Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `c1_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'C1 Cash Cost Allocation Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `contractor_cost` SET TAGS ('dbx_business_glossary_term' = 'Contractor Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cost Capture Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Notes');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Posting Date');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_record_number` SET TAGS ('dbx_business_glossary_term' = 'Cost Record Number');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_record_number` SET TAGS ('dbx_value_regex' = '^WOC-[0-9]{8}$');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Status');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|posted|closed');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'opex|capex|sustaining_capex|project_capex');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Percentage');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `equipment_hire_cost` SET TAGS ('dbx_business_glossary_term' = 'Equipment Hire Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `labour_cost` SET TAGS ('dbx_business_glossary_term' = 'Labour Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `parts_materials_cost` SET TAGS ('dbx_business_glossary_term' = 'Parts and Materials Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `sap_co_order_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Controlling (CO) Order Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `sap_co_order_reference` SET TAGS ('dbx_value_regex' = '^[0-9]{10,12}$');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `total_actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` SET TAGS ('dbx_subdomain' = 'asset_planning');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `standard_job_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Job Plan (SJP) ID');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Strategy Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|obsolete|archived');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `competency_requirements` SET TAGS ('dbx_business_glossary_term' = 'Competency Requirements');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `frequency_code` SET TAGS ('dbx_business_glossary_term' = 'Frequency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `isolation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Isolation Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `job_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Code');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `job_plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `job_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Description');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `job_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Type');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `job_plan_type` SET TAGS ('dbx_value_regex' = 'preventive|predictive|corrective|inspection|calibration|overhaul');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `primary_trade_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Trade Code');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `primary_trade_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `primary_trade_description` SET TAGS ('dbx_business_glossary_term' = 'Primary Trade Description');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `safety_instructions` SET TAGS ('dbx_business_glossary_term' = 'Safety Instructions');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `shutdown_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `standard_operating_procedure_reference` SET TAGS ('dbx_business_glossary_term' = 'Standard Operating Procedure (SOP) Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `task_sequence_count` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence Count');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `total_estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` SET TAGS ('dbx_subdomain' = 'asset_planning');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location (FL) ID');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `hazard_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `heritage_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `parent_fl_functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Functional Location (FL) ID');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `surface_right_id` SET TAGS ('dbx_business_glossary_term' = 'Surface Right Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `building_structure_reference` SET TAGS ('dbx_business_glossary_term' = 'Building Structure Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `construction_type` SET TAGS ('dbx_business_glossary_term' = 'Construction Type');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `decommissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Decommissioning Date');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Meters)');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `environmental_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Sensitive Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `fl_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Location (FL) Code');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `fl_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `fl_description` SET TAGS ('dbx_business_glossary_term' = 'Functional Location (FL) Description');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `fl_type` SET TAGS ('dbx_business_glossary_term' = 'Functional Location (FL) Type');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `fl_type` SET TAGS ('dbx_value_regex' = 'site|area|system|sub_system|component_position|zone');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `isolation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Isolation Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `linear_unit` SET TAGS ('dbx_business_glossary_term' = 'Linear Unit of Measure');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `linear_unit` SET TAGS ('dbx_value_regex' = 'm|ft|km');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `maintenance_planner_group` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Planner Group');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `maintenance_planner_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `maintenance_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Plant Code');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `maintenance_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|under_construction|planned');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `planning_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Planning Plant Code');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `planning_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `plant_area` SET TAGS ('dbx_business_glossary_term' = 'Plant Area');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `room_floor_reference` SET TAGS ('dbx_business_glossary_term' = 'Room Floor Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `scada_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Tag Prefix');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `sort_field` SET TAGS ('dbx_business_glossary_term' = 'Sort Field');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'infor_eam|sap_pm|hexagon_mineplan|manual');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'kg|t|lb');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` SET TAGS ('dbx_subdomain' = 'asset_planning');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy ID');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Strategy Approval Date');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `condition_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Condition Monitoring Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `estimated_annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Maintenance Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `estimated_annual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `fmea_reference` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode and Effects Analysis (FMEA) Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `maintenance_philosophy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Philosophy');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `maintenance_philosophy` SET TAGS ('dbx_value_regex' = 'run_to_failure|time_based|condition_based|predictive|rcm|risk_based');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `performance_kpi_definition` SET TAGS ('dbx_business_glossary_term' = 'Performance Key Performance Indicator (KPI) Definition');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `pm_schedule_count` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Count');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `predictive_analytics_flag` SET TAGS ('dbx_business_glossary_term' = 'Predictive Analytics Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `rcm_analysis_reference` SET TAGS ('dbx_business_glossary_term' = 'Reliability Centred Maintenance (RCM) Analysis Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `risk_mitigation_approach` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Approach');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `shutdown_strategy_flag` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Strategy Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `spare_parts_strategy` SET TAGS ('dbx_business_glossary_term' = 'Spare Parts Strategy');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `spare_parts_strategy` SET TAGS ('dbx_value_regex' = 'stock_on_hand|just_in_time|vendor_managed|consignment');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Code');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `strategy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `strategy_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Description');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `strategy_name` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Name');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `strategy_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Status');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `strategy_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|suspended|obsolete');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Type');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `strategy_type` SET TAGS ('dbx_value_regex' = 'preventive|predictive|corrective|breakdown|shutdown|project');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `target_mtbf_hours` SET TAGS ('dbx_business_glossary_term' = 'Target Mean Time Between Failures (MTBF) Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `target_mttr_hours` SET TAGS ('dbx_business_glossary_term' = 'Target Mean Time To Repair (MTTR) Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `target_oee_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Overall Equipment Effectiveness (OEE) Percent');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Strategy Version Number');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` SET TAGS ('dbx_subdomain' = 'asset_planning');
ALTER TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` SET TAGS ('dbx_association_edges' = 'maintenance.standard_job,maintenance.spare_part');
ALTER TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` ALTER COLUMN `job_plan_parts_list_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Parts List - Job Plan Parts List Id');
ALTER TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Parts List - Spare Part Id');
ALTER TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` ALTER COLUMN `standard_job_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Parts List - Standard Job Id');
ALTER TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` ALTER COLUMN `criticality_classification` SET TAGS ('dbx_business_glossary_term' = 'Job-Context Criticality');
ALTER TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` ALTER COLUMN `parts_list_attached_flag` SET TAGS ('dbx_business_glossary_term' = 'Parts List Attached Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` ALTER COLUMN `quantity_required` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity');
ALTER TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Parts Staging Sequence');
ALTER TABLE `mining_ecm`.`maintenance`.`job_plan_parts_list` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
