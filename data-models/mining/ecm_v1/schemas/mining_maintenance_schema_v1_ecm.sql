-- Schema for Domain: maintenance | Business: Mining | Version: v1_ecm
-- Generated on: 2026-05-05 10:54:40

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`maintenance` COMMENT 'Manages the full asset maintenance lifecycle including preventive, predictive, and corrective maintenance work orders, BOM, spare parts consumption, shutdown planning, and equipment downtime tracking via CMMS (Infor EAM). Owns work execution and cost history against each asset.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the maintenance work order. Primary key.',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Maintenance activities (blasting, heavy equipment, road closures) directly impact communities. Mining operations track affected stakeholders for consultation obligations, notification requirements, an',
    `asset_id` BIGINT COMMENT 'Reference to the asset or equipment unit against which this maintenance work order is executed.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Mining maintenance work orders frequently execute project-driven modifications, upgrades, or commissioning support. Operations track which capital project funded/authorized work orders for cost alloca',
    `commitment_id` BIGINT COMMENT 'Foreign key linking to community.community_commitment. Business justification: Specific maintenance work (rehabilitation, dust suppression upgrades, noise barriers, road improvements) fulfills community commitments from impact assessments or benefit-sharing agreements. Link enab',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Mining sites contract specialized maintenance work (mill relining, crusher rebuilds) to external counterparties. Work orders currently denormalize contractor_company; structured FK enables contractor ',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.corrective_action. Business justification: HSE corrective actions requiring maintenance execution (install machine guarding, implement engineering controls, modify equipment). Essential for HSE action tracking and closure verification in Minin',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: work_order should reference the functional_location where the work is performed. One functional_location can have many work_orders. This link enables location-based work order reporting, cost allocati',
    `geotechnical_instrument_id` BIGINT COMMENT 'Foreign key linking to tailings.geotechnical_instrument. Business justification: Work orders for instrument maintenance, calibration, repair, and replacement. Essential for maintaining instrument reliability, tracking calibration compliance, and ensuring data quality for dam safet',
    `grievance_id` BIGINT COMMENT 'Foreign key linking to community.grievance. Business justification: Work orders are frequently raised in response to community grievances (noise complaints, dust issues, access problems). Link enables tracking of corrective actions, grievance resolution verification, ',
    `audit_id` BIGINT COMMENT 'Foreign key linking to hse.audit. Business justification: Audit findings generating corrective work orders (install missing guarding, repair damaged safety equipment, implement engineering controls). Essential for audit closure workflow and compliance tracki',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Work orders raised to remediate HSE incidents (spill cleanup, post-incident equipment repairs, safety hazard elimination). Critical for incident closure workflow and cost attribution in Mining operati',
    `management_of_change_id` BIGINT COMMENT 'Foreign key linking to hse.management_of_change. Business justification: MOC-driven work orders implementing new safety controls, equipment modifications, or process changes. Essential for MOC implementation tracking and pre-startup safety review (PSSR) in Mining operation',
    `mining_block_id` BIGINT COMMENT 'FK to mine.mining_block.mining_block_id — Enables determination of WHERE maintenance occurred in the mine — essential for spatial maintenance analytics and pit-level cost allocation',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Mining operations allocate maintenance costs and track equipment performance by orebody for mine-to-mill optimization, production reconciliation, and orebody-specific AISC calculation. Essential for c',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key linking to maintenance.pm_schedule. Business justification: work_order should optionally reference the pm_schedule that generated it (for PM-originated work orders). One pm_schedule generates many work_orders over time. This link enables PM compliance tracking',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: When maintenance work requires materials or services not in stock, work orders trigger purchase orders. Mining operations track this link for cost reconciliation, delivery coordination, and budget var',
    `programme_of_work_id` BIGINT COMMENT 'Foreign key linking to tenement.programme_of_work. Business justification: Work orders executing approved Programme of Work activities must reference the PoW for regulatory compliance tracking, expenditure validation, and demonstrating adherence to environmental management c',
    `project_contract_id` BIGINT COMMENT 'Foreign key linking to project.project_contract. Business justification: Contractor-executed maintenance work during shutdowns or major overhauls is governed by project contracts. Mining sites link work orders to contracts for payment certification, scope verification, var',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Mining work orders track which product grade was being processed during equipment failure or maintenance. Essential for product quality root cause analysis, production loss attribution by product type',
    `standard_job_id` BIGINT COMMENT 'Foreign key linking to maintenance.standard_job. Business justification: work_order should optionally reference the standard_job (job plan template) that was used to create it. One standard_job can be instantiated into many work_orders. This link enables traceability from ',
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
    `cost_centre` STRING COMMENT 'Cost centre code to which the work order costs are allocated for financial reporting and cost control.',
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
    `crew_id` BIGINT COMMENT 'Foreign key reference to the maintenance crew or team assigned to execute this task. Used when tasks require multi-person coordination.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to hse.corrective_action. Business justification: Granular tracking of which specific maintenance task implements which HSE corrective action. Required for HSE action verification, sign-off, and effectiveness review in Mining operations.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the primary technician or maintenance worker assigned to execute this task.',
    `schedule_activity_id` BIGINT COMMENT 'Foreign key linking to project.schedule_activity. Business justification: During commissioning and pre-production phases, maintenance tasks (lubrication, alignment checks, run-in procedures) are scheduled as project activities. Mining operations link tasks to project schedu',
    `standard_job_id` BIGINT COMMENT 'Foreign key linking to maintenance.standard_job. Business justification: work_order_task has standard_job_code (STRING) but no FK to standard_job. One standard_job can be used by many work_order_tasks. Adding standard_job_id FK enables linking task execution back to the st',
    `task_plan_standard_job_id` BIGINT COMMENT 'Foreign key reference to the master task plan template from which this task instance was generated. Links to preventive maintenance schedules.',
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
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: New assets delivered by capital projects require preventive maintenance schedules. Mining maintenance planners link PM schedules to originating projects to track warranty periods, design life assumpti',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: PM schedules have budgeted costs allocated to cost centres for preventive maintenance planning, annual budget preparation, and maintenance cost forecasting in mining operations.',
    `employee_id` BIGINT COMMENT 'Reference to the reliability engineer or maintenance planner responsible for maintaining and optimizing this PM schedule. Accountable for schedule effectiveness and continuous improvement.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: pm_schedule should reference the functional_location for the preventive maintenance plan. One functional_location can have many PM schedules. This link enables location-based PM planning and supports ',
    `geotechnical_instrument_id` BIGINT COMMENT 'Foreign key linking to tailings.geotechnical_instrument. Business justification: Calibration and maintenance schedules for geotechnical instruments. Regulatory requirement for demonstrating systematic instrument maintenance. Ensures data quality and compliance with dam safety moni',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: PM schedules designed to mitigate specific hazards identified in risk assessments (guarding inspections, LOTO verification, safety-critical equipment checks). Core to risk-based maintenance planning i',
    `standard_job_id` BIGINT COMMENT 'Reference to the standard job plan that defines the detailed task list, labor requirements, spare parts, tools, and safety procedures for this PM schedule. Ensures consistency and standardization of maintenance execution.',
    `strategy_id` BIGINT COMMENT 'FK to maintenance.maintenance_strategy',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Preventive maintenance schedules for TSF infrastructure (pumps, valves, spillways, pipelines). Regulatory requirement for demonstrating systematic maintenance of critical tailings infrastructure. Driv',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: PM schedules for dump infrastructure (drainage inspections, road grading, erosion control). Required for demonstrating systematic maintenance of waste rock facilities and compliance with geotechnical ',
    `work_centre_id` BIGINT COMMENT 'Reference to the work centre or maintenance crew responsible for executing this PM schedule. Used for resource planning and work order assignment.',
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
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Bill of materials for new/modified assets are established during capital projects. Mining operations link BOMs to projects to trace design basis, spare parts provisioning decisions, engineering change',
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
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Initial spare parts provisioning is a capital project deliverable. Mining operations link spare parts to projects to track first-fill inventory, warranty spares, project-funded stock, and OEM recommen',
    `chemical_register_id` BIGINT COMMENT 'Foreign key linking to hse.chemical_register. Business justification: Spare parts containing hazardous chemicals (lubricants, hydraulic fluids, solvents, batteries). Required for chemical inventory management, SDS tracking, and regulatory reporting (NOHSC, GHS) in Minin',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Spare parts are cataloged by commodity application (copper circuit components, iron ore crushing wear parts, coal handling equipment). Essential for commodity-specific maintenance cost allocation, inv',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Spare parts inventory is valued and posted to specific GL accounts for inventory accounting, balance sheet reporting, and inventory valuation - required for SAP MM-FI integration.',
    `procurement_vendor_id` BIGINT COMMENT 'Reference to the preferred or primary supplier for procurement of this spare part.',
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
    `storage_location_code` STRING COMMENT 'Warehouse or storage bin location code where the spare part is physically stored. Supports warehouse management and picking operations.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for inventory tracking and consumption reporting (e.g., EA=Each, KG=Kilogram, L=Litre, M=Metre). [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|SET|BOX|ROLL|PAIR — 10 candidates stripped; promote to reference product]',
    `warranty_expiry_date` DATE COMMENT 'Date when manufacturer warranty coverage expires for this spare part. Used for warranty claim management and cost recovery.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Unit weight of the spare part in kilograms. Used for logistics planning, freight cost calculation, and handling requirements.',
    CONSTRAINT pk_spare_part PRIMARY KEY(`spare_part_id`)
) COMMENT 'Master record for a maintainable spare part or consumable stocked for maintenance purposes. Captures part number, description, manufacturer, OEM part number, unit of measure, criticality classification (insurance/critical/non-critical), lead time, reorder point, minimum/maximum stock levels, storage location, hazardous material flag, interchangeable part references, and warranty expiry date. Distinct from general procurement inventory — this is the maintenance-specific view of parts required to sustain asset reliability. Supports spare parts criticality analysis, obsolescence management, and rotable pool tracking. Sourced from Infor EAM and Pronto Xi.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`parts_consumption` (
    `parts_consumption_id` BIGINT COMMENT 'Unique identifier for the parts consumption transaction record.',
    `asset_id` BIGINT COMMENT 'Reference to the asset or equipment for which the part was consumed during maintenance.',
    `chemical_register_id` BIGINT COMMENT 'Foreign key linking to hse.chemical_register. Business justification: Parts consumption tracking chemical usage (lubricants, cleaning agents, solvents). Required for chemical usage reporting, inventory reconciliation, and regulatory threshold monitoring (NOHSC, EPA) in ',
    `employee_id` BIGINT COMMENT 'Reference to the stores employee who issued the part.',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Parts issued to work orders are often received from specific purchase orders. Mining operations track this for warranty claim validation (parts must be from approved PO), cost allocation to correct GL',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to maintenance.spare_part. Business justification: parts_consumption currently has part_number (STRING) but no FK to spare_part master. One spare_part can be consumed many times across work orders. Adding spare_part_id FK enables JOIN to spare_part ma',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Parts consumption records track supplier for each part issue. Mining operations need this link for supplier invoice reconciliation, warranty claims (linking consumption to supplier contracts), supplie',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Parts consumed on capital projects are charged to WBS elements for capitalization and project cost tracking - required for proper accounting of materials in asset under construction.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order against which this part was consumed.',
    `work_order_task_id` BIGINT COMMENT 'Reference to the specific task within the work order where this part was consumed, if applicable.',
    `aisc_allocation_flag` BOOLEAN COMMENT 'Indicates whether this parts consumption cost is included in the All-In Sustaining Cost calculation for the mine site.',
    `batch_number` STRING COMMENT 'Batch or lot number of the part issued, used for traceability and quality control.',
    `bin_location` STRING COMMENT 'Specific bin or shelf location within the store from which the part was picked.',
    `core_charge_flag` BOOLEAN COMMENT 'Indicates whether a core charge applies to this part, requiring return of the old component.',
    `cost_centre_code` STRING COMMENT 'Cost centre to which the parts consumption cost is allocated for financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the parts consumption record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost values (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the parts consumption cost is posted.',
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
    `crew_id` BIGINT COMMENT 'Identifier for the maintenance crew or team to which the worker was assigned during this labour booking.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the worker who performed the labour. May be employee number or contractor identifier depending on source type.',
    `training_record_id` BIGINT COMMENT 'Foreign key linking to hse.training_record. Business justification: Labour records verify workers have required HSE training (confined space, working at heights, LOTO) before task assignment. Critical for competency verification and permit-to-work compliance in Mining',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Labour on capital projects is charged to WBS elements for project cost tracking and capitalization - required for proper accounting of internal labour in asset construction.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order against which this labour time was booked.',
    `work_order_task_id` BIGINT COMMENT 'Reference to the specific task within the work order that this labour was performed against. Nullable if labour is booked at work order header level.',
    `approval_status` STRING COMMENT 'Current approval status of the labour timesheet entry. Approved entries are posted to cost accounting.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the supervisor or manager who approved this labour record.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the labour record was approved.',
    `cost_centre` STRING COMMENT 'The cost centre to which this labour cost is allocated for financial reporting and OPEX tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this labour record was first created in the source system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the labour cost (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `end_time` TIMESTAMP COMMENT 'The timestamp when the worker completed work on this task.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this labour cost is posted.',
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
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Planned downtime for project tie-ins or equipment cutover is tracked against the capital project. Mining operations link downtime events to projects for production loss attribution, project performanc',
    `grievance_id` BIGINT COMMENT 'Foreign key linking to community.grievance. Business justification: Unplanned equipment failures trigger community complaints through emergency flaring, alarm activation, extended operating hours, or environmental releases. Link supports integrated incident investigat',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Downtime events caused by HSE incidents (emergency shutdowns, safety isolations, environmental releases). Critical for production loss attribution, incident cost calculation, and LTIFR/TRIFR reporting',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Downtime events are attributed to specific orebodies to calculate production loss tonnage by ore source, enabling accurate mine planning adjustments and orebody-specific availability metrics for produ',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Downtime events in mining are attributed to specific product campaigns (iron ore fines vs lump, copper concentrate grades). Critical for product-specific OEE calculation, production planning, and unde',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Downtime events for TSF equipment (pumps, conveyors, thickeners). Critical for tracking TSF operational availability, production impact (inability to deposit tailings), and reliability metrics for reg',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order associated with this downtime event, if applicable. Null for unplanned breakdowns without immediate work order creation.',
    `action_code` STRING COMMENT 'Standardized code identifying the corrective action taken to restore the equipment to operational status (e.g., repair, replace, adjust, clean, reset). Used for maintenance strategy analysis and cost tracking.',
    `actual_repair_cost` DECIMAL(18,2) COMMENT 'Actual total cost in local currency incurred to repair or resolve the downtime event, including labour, parts, contractor services, and equipment hire. Captured upon work order completion and cost reconciliation.',
    `cause_code` STRING COMMENT 'Standardized code identifying the root cause of the failure or downtime event (e.g., wear and tear, operator error, design defect, inadequate maintenance, environmental factors). Used for reliability improvement and preventive maintenance optimization.',
    `cost_centre` STRING COMMENT 'Financial cost centre to which the downtime-related costs (labour, parts, production loss) are allocated. Used for financial reporting and departmental cost control.',
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
    `secondary_failure_code` STRING COMMENT 'Standardized code identifying the specific component or part within the primary failure system that failed. Provides granular detail for root cause analysis and component reliability tracking.',
    `shift` STRING COMMENT 'The operational shift during which the downtime event was initiated or primarily occurred. Used for shift performance analysis and crew accountability.. Valid values are `day|night|swing|roster_a|roster_b`',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated or recorded the downtime event (Infor EAM for maintenance-initiated events, Caterpillar MineStar for FMS-detected events, SCADA for process control events).. Valid values are `infor_eam|caterpillar_minestar|manual_entry|scada`',
    `work_centre` STRING COMMENT 'The maintenance work centre or crew responsible for responding to and resolving the downtime event. Used for workload balancing, resource planning, and accountability tracking.',
    CONSTRAINT pk_equipment_downtime PRIMARY KEY(`equipment_downtime_id`)
) COMMENT 'Transactional record capturing planned and unplanned equipment downtime events for maintainable assets. Records asset ID, downtime start and end timestamps, downtime duration (hours), downtime category (planned maintenance, unplanned breakdown, standby, operational delay), primary failure code, secondary failure code, work order reference, production impact (tonnes lost), and responsible work centre. SSOT for OEE, MTBF, and MTTR calculations. Sourced from Infor EAM and Caterpillar MineStar.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`failure_report` (
    `failure_report_id` BIGINT COMMENT 'Unique identifier for the failure report record. Primary key for the failure report entity.',
    `asset_id` BIGINT COMMENT 'Reference to the asset that experienced the failure. Identifies the specific equipment unit or component that failed.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Early-life failures of project-delivered assets trigger failure reports linked to the project for warranty claims, design review, and lessons learned. Mining operations track project-related failures ',
    `equipment_downtime_id` BIGINT COMMENT 'Foreign key linking to maintenance.equipment_downtime. Business justification: failure_report should optionally reference the equipment_downtime event that triggered the failure investigation. One equipment_downtime event can have one failure_report (1:1). Adding equipment_downt',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: failure_report has functional_location (STRING) but no FK to functional_location master. One functional_location can have many failure reports. Adding functional_location_id FK enables linking failure',
    `geotechnical_instrument_id` BIGINT COMMENT 'Foreign key linking to tailings.geotechnical_instrument. Business justification: Failure reports for geotechnical instruments. Critical for tracking instrument reliability, identifying systematic issues, and ensuring data quality for dam safety monitoring. Drives instrument replac',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Equipment failures triggering HSE incidents (pressure vessel rupture, conveyor fire, structural collapse). Essential for integrated RCA, incident investigation, and regulatory reporting in Mining oper',
    `downtime_event_id` BIGINT COMMENT 'Foreign key linking to equipment.downtime_event. Business justification: Failure reports document root cause analysis for equipment downtime events. Mining reliability engineering requires traceability from RCA findings back to the originating downtime event for MTBF impro',
    `previous_failure_report_id` BIGINT COMMENT 'Reference to the prior failure report if this is a repeat failure. Enables tracking of failure recurrence patterns.',
    `employee_id` BIGINT COMMENT 'Reference to the reliability engineer assigned to investigate this failure and develop preventive recommendations.',
    `quaternary_failure_last_modified_by_employee_id` BIGINT COMMENT 'Reference to the user who last modified the failure report record.',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Failure analysis correlates equipment failures with product characteristics (abrasiveness, moisture content, sizing). Essential for reliability engineering to identify product-driven failure modes and',
    `tertiary_failure_created_by_employee_id` BIGINT COMMENT 'Reference to the user who created the failure report record in the system.',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Failure reports for TSF equipment and infrastructure. Essential for reliability engineering, root cause analysis, FMEA updates, and demonstrating continuous improvement in TSF management for regulator',
    `work_order_id` BIGINT COMMENT 'Reference to the corrective maintenance work order that documented this failure event. Links the failure report to the maintenance execution record.',
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
    `functional_location` STRING COMMENT 'Hierarchical location code identifying where the asset is installed within the mine site structure (e.g., pit, processing plant, conveyor system). Used for spatial failure analysis.',
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
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Major mining shutdowns are frequently driven by capital projects (plant expansions, equipment replacements, brownfield modifications). The shutdown enables project execution; linking tracks project de',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Shutdown budgets and actuals are tracked against cost centres for major maintenance cost control, variance analysis, and annual shutdown budget planning in mining operations.',
    `emergency_response_plan_id` BIGINT COMMENT 'Foreign key linking to hse.emergency_response_plan. Business justification: Major shutdowns require emergency response plan activation, readiness verification, and emergency equipment testing. Regulatory requirement and critical safety planning process for planned shutdowns i',
    `engagement_plan_id` BIGINT COMMENT 'Foreign key linking to community.engagement_plan. Business justification: Major shutdowns require coordinated community engagement due to employment impacts, contractor mobilization, traffic increases, and service demand changes. Mining sites integrate shutdown planning wit',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: shutdown_plan has functional_location (STRING) but no FK to functional_location master. One functional_location can have many shutdown plans. Adding functional_location_id FK enables linking shutdown ',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Major plant shutdowns are scheduled around orebody extraction plans to minimize impact on high-value ore processing campaigns. Critical for integrated mine-mill planning and production loss attributio',
    `stakeholder_id` BIGINT COMMENT 'Foreign key linking to community.stakeholder. Business justification: Shutdowns significantly affect local communities through workforce fluctuations, contractor accommodation demand, and local business impacts. Tracking primary affected stakeholder enables targeted com',
    `employee_id` BIGINT COMMENT 'Identifier of the maintenance superintendent or shutdown manager accountable for planning, coordinating, and executing the shutdown event.',
    `quaternary_shutdown_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the shutdown plan record, establishing accountability for the most recent changes.',
    `site_id` BIGINT COMMENT 'Identifier of the mine site or processing plant where the shutdown will occur.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Major shutdowns occur within specific tenement boundaries. Required for regulatory authority notification, surface rights coordination, native title consultation, and ensuring shutdown activities comp',
    `tertiary_shutdown_created_by_employee_id` BIGINT COMMENT 'Identifier of the user who created the shutdown plan record, establishing accountability for plan origination.',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Planned shutdowns for major TSF maintenance (raise construction, major pump replacements, spillway repairs). Essential for coordinating production impact, contractor mobilization, and regulatory notif',
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
    `risk_assessment_reference` STRING COMMENT 'Reference number or document identifier for the risk assessment conducted for the shutdown, linking to detailed hazard analysis and mitigation plans.',
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

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` (
    `maintenance_shutdown_scope_id` BIGINT COMMENT 'Unique identifier for the shutdown scope item. Primary key for the shutdown scope entity.',
    `asset_id` BIGINT COMMENT 'Reference to the specific asset or equipment that this scope item applies to. Links the work to the physical asset register.',
    `contractor_id` BIGINT COMMENT 'Reference to the contractor or service provider assigned to execute this scope item. Links to the contractor master data for commercial tracking.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Individual shutdown scope items often directly support capital project deliverables (tie-ins, equipment installation, commissioning prep). Mining operations track which project each scope item serves ',
    `employee_id` BIGINT COMMENT 'Reference to the maintenance supervisor or coordinator responsible for overseeing execution of this scope item.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: shutdown_scope has functional_location (STRING) but no FK to functional_location master. One functional_location can have many shutdown scope items. Adding functional_location_id FK enables linking sc',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Major shutdown scope items (long-lead equipment, specialized contractor services, critical spares) require dedicated procurement tracked via purchase orders. Mining operations link shutdown scope to P',
    `project_contract_id` BIGINT COMMENT 'Foreign key linking to project.project_contract. Business justification: Shutdown scope items executed by contractors are governed by project contracts. Mining operations link scope to contracts for payment claims, variation orders, performance measurement, and scope verif',
    `shutdown_plan_id` BIGINT COMMENT 'Reference to the parent shutdown plan that this scope item belongs to. Links the scope item to the overall shutdown event.',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Specific TSF work scope within shutdowns. Links shutdown work packages to TSF facilities for cost tracking, resource planning, and demonstrating completion of planned TSF maintenance activities.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Capital scope items within shutdowns (equipment upgrades, plant modifications) charge to WBS elements for project accounting and proper opex/capex classification.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created to execute this scope item. Links shutdown planning to work execution in the CMMS.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Actual date and time when work on this scope item was completed. Used for duration analysis and future shutdown planning accuracy.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred for this scope item. Captured for financial reconciliation and variance analysis against budget.',
    `actual_labour_hours` DECIMAL(18,2) COMMENT 'Actual total labour hours consumed to complete this scope item. Captured for cost tracking and future estimation accuracy.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work on this scope item commenced. Captured for schedule variance analysis and performance tracking.',
    `approval_status` STRING COMMENT 'Current approval status of the scope item. Indicates whether the scope has been reviewed and authorized for inclusion in the shutdown plan.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this scope item for inclusion in the shutdown plan. Provides accountability and audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this scope item was approved. Used for governance and audit trail of shutdown planning decisions.',
    `bill_of_materials_reference` STRING COMMENT 'Reference to the bill of materials listing all spare parts and consumables required for this scope item. Used for procurement and inventory planning.',
    `completion_notes` STRING COMMENT 'Free-text notes documenting the outcome of the scope item execution, including any deviations, issues encountered, or follow-up actions required.',
    `cost_centre` STRING COMMENT 'Cost centre code to which the costs of this scope item will be charged. Used for financial reporting and budget tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this scope item record was first created in the system. Provides audit trail for scope planning lifecycle.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this scope item is on the critical path of the shutdown schedule. True if any delay will extend the overall shutdown duration.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this scope item (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Total estimated cost for this scope item including labour, materials, and contractor services. Used for shutdown budget planning and approval.',
    `estimated_labour_hours` DECIMAL(18,2) COMMENT 'Planned total labour hours required to complete this scope item. Used for resource levelling and cost estimation.',
    `isolation_required_flag` BOOLEAN COMMENT 'Indicates whether equipment isolation (lockout/tagout) is required for this scope item. True if work involves energized equipment or hazardous energy sources.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this scope item record was last updated. Tracks changes throughout the shutdown planning and execution lifecycle.',
    `predecessor_scope_items` STRING COMMENT 'Comma-separated list of scope item numbers that must be completed before this scope item can commence. Defines task dependencies for scheduling.',
    `priority_code` STRING COMMENT 'Priority classification of this scope item within the shutdown plan. Determines scheduling precedence and resource allocation urgency.. Valid values are `critical|high|medium|low`',
    `safety_permit_required_flag` BOOLEAN COMMENT 'Indicates whether a safety work permit is required before commencing this scope item. True if hot work, confined space, or other high-risk activities are involved.',
    `scheduled_completion_date` DATE COMMENT 'Planned date when work on this scope item is scheduled to be completed. Used for critical path analysis and shutdown duration planning.',
    `scheduled_start_date` DATE COMMENT 'Planned date when work on this scope item is scheduled to commence. Used for resource scheduling and shutdown timeline management.',
    `scope_description` STRING COMMENT 'Detailed description of the work to be performed for this scope item. Includes technical specifications, objectives, and deliverables.',
    `scope_item_number` STRING COMMENT 'Business identifier for the scope item within the shutdown plan. Typically a hierarchical or sequential numbering scheme used for tracking and reporting.',
    `scope_status` STRING COMMENT 'Current lifecycle status of the scope item. Tracks progression from planning through execution to completion or cancellation.. Valid values are `planned|approved|in_progress|completed|cancelled|deferred`',
    `scope_type` STRING COMMENT 'Classification of the scope item by maintenance type. Determines the nature of work to be executed during the shutdown.. Valid values are `preventive_maintenance|corrective_maintenance|inspection|overhaul|replacement|upgrade`',
    `sequence_number` STRING COMMENT 'Execution sequence order of this scope item within the shutdown plan. Used for scheduling and resource levelling.',
    `standard_job_code` STRING COMMENT 'Reference to a standard job plan or procedure that defines the detailed steps for this scope item. Ensures consistency and quality.',
    `trade_code` STRING COMMENT 'Code identifying the primary trade or craft skill required to execute this scope item (e.g., mechanical, electrical, instrumentation, civil).',
    `trade_description` STRING COMMENT 'Full description of the trade or craft skill required for this scope item. Provides clarity for resource planning and allocation.',
    CONSTRAINT pk_maintenance_shutdown_scope PRIMARY KEY(`maintenance_shutdown_scope_id`)
) COMMENT 'Individual scope item or work package within a shutdown plan, representing a discrete unit of work to be executed during the shutdown. Captures shutdown plan reference, scope item number, description, asset/functional location, trade required, estimated hours, estimated cost, priority, critical path flag, predecessor scope items, and completion status. Enables shutdown scope management, resource levelling, and critical path scheduling for major overhauls.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`condition_monitoring` (
    `condition_monitoring_id` BIGINT COMMENT 'Unique identifier for the condition monitoring record.',
    `asset_id` BIGINT COMMENT 'Reference to the asset being monitored. Links to the equipment asset register.',
    `commissioning_activity_id` BIGINT COMMENT 'Foreign key linking to project.commissioning_activity. Business justification: Commissioning activities include baseline condition monitoring (vibration signatures, oil analysis, thermography). Mining operations link monitoring records to commissioning activities to establish pe',
    `component_register_id` BIGINT COMMENT 'Foreign key linking to equipment.component_register. Business justification: Condition monitoring (vibration analysis, oil sampling, thermography, ultrasonic testing) targets specific serialized components (engines, gearboxes, final drives, hydraulic pumps). Mining predictive ',
    `employee_id` BIGINT COMMENT 'Reference to the technician or inspector who performed the condition monitoring activity.',
    `geotechnical_instrument_id` BIGINT COMMENT 'Foreign key linking to tailings.geotechnical_instrument. Business justification: Condition monitoring of geotechnical instruments themselves (not readings from them). Tracks instrument health, drift, calibration status. Essential for ensuring reliability of dam safety monitoring d',
    `inspection_round_id` BIGINT COMMENT 'Foreign key linking to maintenance.inspection_round. Business justification: condition_monitoring has inspection_route_id (STRING) which is a route template, but no FK to the actual inspection_round instance. One inspection_round can have many condition_monitoring readings. Ad',
    `inspection_route_id` BIGINT COMMENT 'Identifier of the inspection route or round template used for operator inspection rounds.',
    `instrument_id` BIGINT COMMENT 'Identifier of the measurement instrument or device used to capture the reading (e.g., vibration analyzer serial number, thermal camera ID).',
    `safety_observation_id` BIGINT COMMENT 'Foreign key linking to hse.safety_observation. Business justification: Safety observations triggering condition monitoring (abnormal vibration, temperature, noise observed during rounds). Real business process: proactive hazard identification and predictive maintenance i',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Condition monitoring thresholds vary by product being processed (vibration limits differ for fine ore vs lump, temperature profiles vary by moisture content). Critical for predictive maintenance accur',
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

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`request` (
    `request_id` BIGINT COMMENT 'Unique identifier for the maintenance request. Primary key.',
    `asset_id` BIGINT COMMENT 'Reference to the asset or equipment requiring maintenance. Links to the asset register in the equipment domain.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Maintenance requests during commissioning or early operation of project assets are linked to the project for defect tracking and contractor rectification. Mining operations use this for punch list clo',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that was created from this maintenance request after approval. Null if request has not yet been converted or was rejected.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Incidents prompting immediate maintenance requests (equipment damage, safety hazard identification, environmental release containment). Real business process: reactive maintenance initiation from HSE ',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person who raised the maintenance request, used for accountability and follow-up communication.',
    `requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.requisition. Business justification: Maintenance requests that identify material requirements not in stock trigger procurement requisitions. Mining operations track this link to monitor procurement lead time impact on maintenance backlog',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Maintenance requests for TSF issues (pump failures, pipeline leaks, seepage observations). Initiates reactive maintenance workflow. Critical for tracking response times to TSF issues and demonstrating',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Maintenance requests for dump infrastructure issues (drainage blockages, road damage, erosion). Initiates reactive maintenance. Essential for tracking dump maintenance responsiveness and demonstrating',
    `approved_by` STRING COMMENT 'Name or employee ID of the person who formally approved the maintenance request for conversion to a work order.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance request was formally approved and authorized for work order creation.',
    `attachment_count` STRING COMMENT 'Number of supporting documents, photos, or files attached to the maintenance request (e.g., photos of damage, inspection reports, technical drawings).',
    `converted_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance request was converted into a formal work order in the CMMS.',
    `cost_centre` STRING COMMENT 'Financial cost centre code to which the maintenance work will be charged if approved and executed.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the maintenance request record was first created in the CMMS database.',
    `date_raised` DATE COMMENT 'Calendar date when the maintenance request was created and submitted into the system.',
    `date_required` DATE COMMENT 'Target date by which the requestor needs the maintenance work to be completed, used for planning and scheduling prioritization.',
    `department` STRING COMMENT 'Organizational department or work area that originated the maintenance request (e.g., Mining Operations, Processing Plant, Haulage).',
    `estimated_downtime_hours` DECIMAL(18,2) COMMENT 'Requestor or planner estimate of equipment downtime hours required to complete the maintenance work, used for production planning and scheduling.',
    `failure_mode` STRING COMMENT 'Classification of the observed failure or defect mode (e.g., mechanical wear, electrical fault, hydraulic leak, structural damage). May reference ISO 14224 failure mode taxonomy.',
    `fault_description` STRING COMMENT 'Detailed narrative description of the observed fault, defect, or required maintenance work as reported by the requestor. Captures symptoms, abnormal conditions, or specific work requirements.',
    `functional_location` STRING COMMENT 'Hierarchical location code identifying where the asset is installed or where the maintenance work is required (e.g., MINE-PIT1-CRUSHER-01). Used for spatial organization and work planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent update to any field in the maintenance request record, used for change tracking and audit trail.',
    `planner_notes` STRING COMMENT 'Additional comments or planning notes added by the maintenance planner during review, including scope clarification, resource requirements, or scheduling considerations.',
    `production_impact_flag` BOOLEAN COMMENT 'Indicator whether the fault or required maintenance is currently impacting or will impact production output. True indicates production loss or risk.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the reviewer or approver for why the maintenance request was rejected or declined. Null if request was approved or still pending.',
    `request_number` STRING COMMENT 'Human-readable business identifier for the maintenance request, typically system-generated with a prefix and sequential number.. Valid values are `^MR-[0-9]{8}$`',
    `request_status` STRING COMMENT 'Current lifecycle state of the maintenance request. Open indicates newly created; under_review indicates supervisor assessment; approved indicates ready for work order conversion; rejected indicates declined request; converted indicates work order has been created; cancelled indicates request withdrawn.. Valid values are `open|under_review|approved|rejected|converted|cancelled`',
    `request_type` STRING COMMENT 'Classification of the maintenance request indicating the nature of work required: corrective (breakdown), preventive (scheduled), predictive (condition-based), inspection, modification, or emergency.. Valid values are `corrective|preventive|predictive|inspection|modification|emergency`',
    `requestor_contact_number` STRING COMMENT 'Phone number or radio call sign of the requestor for clarification or follow-up on the maintenance request.',
    `requestor_name` STRING COMMENT 'Full name of the person who initiated the maintenance request, typically an equipment operator, supervisor, or maintenance planner.',
    `reviewed_by` STRING COMMENT 'Name or employee ID of the supervisor or maintenance planner who reviewed and assessed the maintenance request for approval or rejection.',
    `reviewed_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance request was reviewed and a decision (approve/reject) was made.',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicator whether the maintenance request involves a safety-critical issue that poses immediate risk to personnel, environment, or operations. True indicates safety-critical condition requiring urgent attention.',
    `source_system` STRING COMMENT 'System or channel through which the maintenance request was originated (e.g., Infor EAM service request module, mobile maintenance app, SCADA alarm integration, operator logbook, inspection system).. Valid values are `infor_eam|mobile_app|scada_alarm|operator_logbook|inspection_system`',
    `urgency_level` STRING COMMENT 'Priority classification indicating how quickly the maintenance work must be addressed. Critical indicates immediate safety or production impact; high indicates significant operational impact; medium and low indicate routine work.. Valid values are `critical|high|medium|low`',
    CONSTRAINT pk_request PRIMARY KEY(`request_id`)
) COMMENT 'Operator or supervisor-initiated request for maintenance action before it is approved and converted into a formal work order. Captures request number, requestor name, asset ID, functional location, description of fault or required work, urgency level, date raised, date required, status (open/approved/rejected/converted), and rejection reason. Represents the demand-side intake for the maintenance workflow. Sourced from Infor EAM service request module.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`work_order_cost` (
    `work_order_cost_id` BIGINT COMMENT 'Unique identifier for the work order cost record. Primary key for this entity.',
    `asset_id` BIGINT COMMENT 'Reference to the asset on which the maintenance work was performed. Enables cost rollup and analysis at the asset level for lifecycle costing.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Work order costs during commissioning or project-driven modifications are capitalized to the project. Mining operations link costs to projects for CAPEX/OPEX classification, project budget tracking, a',
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
    `cost_centre` STRING COMMENT 'Cost centre code to which the work order costs are allocated. Represents the organizational unit or operational area responsible for the maintenance expenditure.. Valid values are `^[A-Z0-9]{4,10}$`',
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
    `gl_account_code` STRING COMMENT 'General ledger account code to which the work order costs are posted. Determines the financial statement line item for the maintenance expenditure.. Valid values are `^[0-9]{6,10}$`',
    `labour_cost` DECIMAL(18,2) COMMENT 'Total actual labour cost incurred for the work order, including wages, overtime, and labour burden. Sourced from time sheets and labour rate tables in Infor EAM.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified the work order cost record. Provides accountability for data changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the work order cost record was last updated. Tracks the most recent change to the cost data.',
    `other_cost` DECIMAL(18,2) COMMENT 'Miscellaneous actual costs not classified under labour, parts, contractor, or equipment hire categories. Includes permits, travel, accommodation, and incidental expenses.',
    `parts_materials_cost` DECIMAL(18,2) COMMENT 'Total actual cost of spare parts, consumables, and materials consumed during work order execution. Includes inventory withdrawals and direct purchases.',
    `rejection_reason` STRING COMMENT 'Explanation provided when a work order cost record is rejected during the approval process. Captures the rationale for non-approval.',
    `sap_co_order_reference` STRING COMMENT 'SAP CO internal order number used for detailed cost tracking and project accounting. Links the work order cost to SAP controlling module for OPEX and CAPEX classification.. Valid values are `^[0-9]{10,12}$`',
    `total_actual_cost` DECIMAL(18,2) COMMENT 'Sum of all actual cost components for the work order: labour, parts, contractor, equipment hire, and other costs. Represents the final actual expenditure for the maintenance activity.',
    `total_estimated_cost` DECIMAL(18,2) COMMENT 'Sum of all estimated cost components for the work order at the time of planning. Used for budget comparison and variance analysis against actual costs.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the work order cost record. Provides accountability for data entry.',
    CONSTRAINT pk_work_order_cost PRIMARY KEY(`work_order_cost_id`)
) COMMENT 'Aggregated cost summary record for a maintenance work order, capturing all cost components: labour cost, parts/materials cost, contractor cost, equipment hire cost, and total actual cost versus total estimated cost. Tracks cost centre, GL account code, SAP CO order reference, cost variance, and approval status. Provides the SSOT for maintenance OPEX cost reporting and AISC/C1 cost allocation at the work order level. Sourced from Infor EAM cost module and SAP CO.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`permit` (
    `permit_id` BIGINT COMMENT 'Unique identifier for the maintenance permit record. Primary key.',
    `asset_id` BIGINT COMMENT 'Reference to the specific equipment or asset on which the permitted work will be performed. Enables asset-specific safety protocol enforcement.',
    `commissioning_activity_id` BIGINT COMMENT 'Foreign key linking to project.commissioning_activity. Business justification: Commissioning work requires maintenance permits (hot work, confined space, energization). Mining operations link permits to commissioning activities for safety compliance tracking, audit trails, and h',
    `cultural_heritage_site_id` BIGINT COMMENT 'Foreign key linking to community.cultural_heritage_site. Business justification: Mining work permits require cultural heritage clearance when activities occur near registered sites. Regulatory compliance and traditional owner agreements mandate heritage checks before ground distur',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to hse.environmental_permit. Business justification: Maintenance permits cross-referencing environmental permits (discharge permit for dewatering, air permit for painting/blasting). Real business process: integrated permitting and environmental complian',
    `heritage_clearance_id` BIGINT COMMENT 'Foreign key linking to tenement.heritage_clearance. Business justification: Permits for work in heritage-sensitive areas must reference specific heritage clearance records to demonstrate compliance with traditional owner agreements, verify clearance validity, and ensure work ',
    `incident_id` BIGINT COMMENT 'Foreign key linking to hse.incident. Business justification: Incidents occurring during permitted work (hot work fire, confined space injury, electrical shock). Required for permit system audit, incident investigation, and permit-to-work process improvement in ',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person who cancelled the permit. Links to workforce records for accountability and audit trails.',
    `permit_issuing_authority_employee_id` BIGINT COMMENT 'Employee identifier of the person who issued the permit. Links to workforce records for competency verification and audit trails.',
    `permit_site_supervisor_employee_id` BIGINT COMMENT 'Employee identifier of the site supervisor. Links to workforce records for accountability and competency verification.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Work permits must identify the tenement for verifying surface rights, determining regulatory authority jurisdiction, ensuring native title compliance, and validating that permitted activities align wi',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Work permits for TSF maintenance activities (confined space entry, hot work, isolation). Critical for TSF safety management, demonstrating permit compliance, and linking safety controls to high-risk T',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order that this permit authorizes. Links the permit to the specific maintenance activity being performed.',
    `atmospheric_testing_required_flag` BOOLEAN COMMENT 'Indicates whether atmospheric testing for oxygen levels, flammable gases, or toxic substances is required before and during work. Mandatory for confined space entry permits.',
    `authorized_personnel` STRING COMMENT 'List of employee names or identifiers who are authorized to perform work under this permit. Only listed personnel may execute the permitted activity.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the permit was cancelled before work completion. May include changes in work scope, unsafe conditions identified, or work postponement.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the permit was cancelled. Used for compliance reporting and incident investigation if cancellation was due to safety concerns.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the permit was formally closed after work completion and area clearance. Marks the end of the permits lifecycle.',
    `closure_signature` STRING COMMENT 'Digital or scanned signature confirming that work has been completed, all isolation points have been restored, and the work area has been inspected and cleared.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this permit record was first created in the system. Supports audit trails and lifecycle tracking.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the permit expires and work must cease. Enforces time-bound safety controls and requires permit renewal if work continues beyond this point.',
    `extension_count` STRING COMMENT 'Number of times this permit has been extended beyond its original end timestamp. Tracks permit lifecycle complexity and potential safety control degradation.',
    `fire_watch_required_flag` BOOLEAN COMMENT 'Indicates whether a dedicated fire watch person must be present during and after hot work activities. Mandatory for welding, cutting, grinding, and other spark-producing operations.',
    `functional_location` STRING COMMENT 'Hierarchical location code identifying the physical area or plant section where the work will be performed. Used for zone-based safety management.. Valid values are `^[A-Z0-9]{2,4}-[A-Z0-9]{2,4}-[A-Z0-9]{2,6}$`',
    `hazard_identification` STRING COMMENT 'Comprehensive list of identified hazards associated with the permitted work activity. Includes physical, chemical, biological, ergonomic, and psychosocial hazards.',
    `isolation_points` STRING COMMENT 'Detailed description of all energy isolation points (electrical, mechanical, hydraulic, pneumatic) that must be locked out or tagged out before work commences. Critical for LOTO compliance.',
    `issued_timestamp` TIMESTAMP COMMENT 'Date and time when the permit was formally issued by the authorized issuing authority. Marks the official approval of the permit.',
    `issuer_signature` STRING COMMENT 'Digital or scanned signature of the permit issuer confirming that all safety requirements have been reviewed and the permit is authorized.',
    `issuing_authority` STRING COMMENT 'Name or identifier of the authorized person or role who issued the permit. Must be a qualified competent person per site safety standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this permit record was last updated. Tracks changes to permit details, status transitions, or sign-off records.',
    `permit_number` STRING COMMENT 'Externally visible unique permit number assigned by the issuing authority. Used for audit trails and compliance reporting.. Valid values are `^PTW-[A-Z0-9]{8,12}$`',
    `permit_status` STRING COMMENT 'Current lifecycle state of the permit. Tracks progression from initial creation through active work execution to final closure or cancellation.. Valid values are `draft|issued|active|suspended|closed|cancelled`',
    `permit_type` STRING COMMENT 'Classification of the permit based on the nature of hazardous work being authorized. Determines the specific safety controls and sign-off requirements.. Valid values are `isolation|confined_space_entry|hot_work|working_at_heights|electrical_isolation|excavation`',
    `receiver_signature` STRING COMMENT 'Digital or scanned signature of the person receiving the permit, acknowledging understanding of hazards, controls, and responsibilities.',
    `required_ppe` STRING COMMENT 'Mandatory personal protective equipment that all workers must wear during the permitted activity. May include hard hat, safety glasses, gloves, respirator, fall protection, etc.',
    `rescue_plan_reference` STRING COMMENT 'Reference to the emergency rescue plan document that must be in place before work commences. Required for confined space entry and working at heights permits.',
    `risk_assessment_reference` STRING COMMENT 'Reference number or identifier of the formal risk assessment document that supports this permit. Links to detailed risk analysis and control measures.',
    `site_supervisor_name` STRING COMMENT 'Name of the on-site supervisor responsible for overseeing the permitted work and ensuring compliance with safety controls.',
    `source_system` STRING COMMENT 'Identifies the operational system from which this permit record originated. Supports data lineage and reconciliation between Infor EAM and IsoMetrix.. Valid values are `Infor_EAM|IsoMetrix|Manual`',
    `special_precautions` STRING COMMENT 'Additional safety precautions or site-specific requirements that must be observed during the permitted work. May include environmental controls, traffic management, or simultaneous operations restrictions.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the permit becomes active and work is authorized to commence. Marks the beginning of the permitted work window.',
    CONSTRAINT pk_permit PRIMARY KEY(`permit_id`)
) COMMENT 'Safety permit to work (PTW) record associated with a maintenance work order. Captures permit number, permit type (isolation, confined space entry, hot work, working at heights, electrical isolation), issuing authority, asset/functional location, permit start and end datetime, isolation points, hazard identification, required PPE, permit status (draft/issued/active/closed/cancelled), and sign-off records. Ensures safe work execution compliance with ISO 45001 and site safety standards. Sourced from Infor EAM and IsoMetrix.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`standard_job` (
    `standard_job_id` BIGINT COMMENT 'Unique identifier for the standard job plan template. Primary key.',
    `asset_class_id` BIGINT COMMENT 'Reference to the asset class or equipment category to which this job plan is applicable. Determines which assets can use this template.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to hse.risk_assessment. Business justification: Standard job plans incorporate controls from risk assessments (LOTO procedures, confined space entry protocols, working at heights controls). Essential for safe work method development in Mining opera',
    `work_centre_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_centre. Business justification: Standard jobs are executed by specific work centres (maintenance shops, trade groups). N:1 relationship - many standard jobs assigned to one work centre. Currently standard_job has work_centre_code as',
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
    `parts_list_attached_flag` BOOLEAN COMMENT 'Indicates whether a Bill of Materials (BOM) or parts list is attached to this job plan, specifying required spare parts and consumables.',
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
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: New functional locations (plant areas, processing circuits) are created by capital projects. Mining sites link FLs to projects to track asset register updates, commissioning boundaries, handover scope',
    `cost_centre_id` BIGINT COMMENT 'FK to finance.cost_centre',
    `mine_site_id` BIGINT COMMENT 'FK to mine.mine_site',
    `cultural_heritage_site_id` BIGINT COMMENT 'Foreign key linking to community.cultural_heritage_site. Business justification: Functional locations (plants, dumps, roads) must maintain regulatory buffer zones from cultural heritage sites. Spatial planning, access control, and work authorization depend on proximity assessment.',
    `orebody_id` BIGINT COMMENT 'Foreign key linking to geology.orebody. Business justification: Processing circuits and crushing plants are often dedicated to specific orebodies (e.g., high-grade vs low-grade, oxide vs sulphide). Links equipment maintenance planning to ore source for metallurgic',
    `parent_fl_functional_location_id` BIGINT COMMENT 'Reference to the parent functional location in the hierarchy. Enables roll-up of maintenance costs and performance metrics. Null for top-level site locations.',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Physical infrastructure and functional locations (plants, processing facilities, mine sites) are situated on specific tenements. Essential for access rights management, regulatory reporting, expenditu',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Functional location hierarchy includes TSF as a major facility node. Essential for asset hierarchy, work planning, cost allocation, and organizing maintenance activities by TSF facility.',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Functional location hierarchy includes waste rock dumps as major facility nodes. Essential for asset hierarchy, work planning, cost allocation, and organizing maintenance activities by dump facility.',
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
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Capital projects often trigger new maintenance strategies (condition-based monitoring for new technology, RCM for critical assets). Mining reliability engineers link strategies to projects to document',
    `employee_id` BIGINT COMMENT 'Reference to the manager or authority who approved this maintenance strategy for deployment.',
    `strategy_employee_id` BIGINT COMMENT 'Reference to the reliability engineer or asset management specialist responsible for maintaining and optimizing this strategy.',
    `approval_date` DATE COMMENT 'Date on which the maintenance strategy was formally approved for implementation by the asset management authority.',
    `compliance_framework` STRING COMMENT 'Regulatory or industry compliance framework that this maintenance strategy is designed to satisfy, such as MSHA, ISO 45001, or environmental regulations. [ENUM-REF-CANDIDATE: iso_45001|iso_14001|msha|jorc|icmm|local_mining_act — promote to reference product]',
    `condition_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this strategy includes condition monitoring techniques such as vibration analysis, thermography, or oil analysis.',
    `cost_centre` STRING COMMENT 'Cost centre code to which maintenance costs for this strategy are allocated in the financial system.',
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

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`contractor_service` (
    `contractor_service_id` BIGINT COMMENT 'Unique identifier for the contractor service record. Primary key.',
    `asset_id` BIGINT COMMENT 'Reference to the primary asset or equipment on which the contractor service was performed. Nullable if service applies to multiple assets or facility-wide scope.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to customer.counterparty. Business justification: Contractor service records are the primary transaction record for external maintenance work delivery. Mining operations require structured link to counterparty for invoice matching, performance rating',
    `contractor_id` BIGINT COMMENT 'Foreign key linking to workforce.contractor. Business justification: Contractor service records must link to contractor master for rate verification, insurance/safety clearance validation, performance tracking, and invoice reconciliation. Mining operations require cont',
    `local_employment_commitment_id` BIGINT COMMENT 'Foreign key linking to community.local_employment_commitment. Business justification: Mining companies enforce local employment targets in contractor agreements as part of benefit-sharing obligations. Verification of commitment compliance requires linking contractor services to specifi',
    `maintenance_shutdown_scope_id` BIGINT COMMENT 'Foreign key linking to maintenance.shutdown_scope. Business justification: contractor_service has shutdown_event_reference (STRING) but no FK to shutdown_scope. One shutdown_scope can have many contractor_service records. Adding shutdown_scope_id FK enables linking contracto',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Contractor services are procured via purchase orders in mining operations. The contractor_service table has purchase_order_reference (text) which should be replaced by proper FK for cost reconciliatio',
    `project_contract_id` BIGINT COMMENT 'Foreign key linking to project.project_contract. Business justification: Contractor services during maintenance shutdowns are often governed by project contracts (especially for brownfield work). Mining operations link services to contracts for payment reconciliation, scop',
    `training_record_id` BIGINT COMMENT 'Foreign key linking to hse.training_record. Business justification: Contractor personnel must complete site HSE induction and task-specific training before work commencement. Regulatory requirement and standard contractor safety management practice in Mining operation',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Contractor services on capital projects charge to WBS elements for project cost tracking and capitalization - required for proper accounting of external labour in asset construction.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order against which this contractor service was executed.',
    `work_order_task_id` BIGINT COMMENT 'Reference to the specific work order task or scope item that this contractor service supports. Nullable if service applies to the entire work order.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred for this contractor service, including labour, materials supplied by contractor, and any additional charges.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Total actual hours worked by the contractor on this service, as recorded in timesheets or service completion records.',
    `approval_status` STRING COMMENT 'Approval status of the contractor service record and associated costs for financial posting.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the contractor service record and costs.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the contractor service record was approved.',
    `completion_notes` STRING COMMENT 'Free-text notes documenting the completion of the contractor service, including any issues, deviations, or observations.',
    `contracted_hours` DECIMAL(18,2) COMMENT 'Total hours contracted or estimated for the contractor service as per the purchase order or scope agreement.',
    `contracted_rate` DECIMAL(18,2) COMMENT 'Hourly or daily rate agreed in the purchase order or contract for this contractor service.',
    `cost_centre` STRING COMMENT 'Cost centre code to which the contractor service cost is allocated for financial reporting and cost control.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this contractor service record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contracted rate and actual cost (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `demobilisation_date` DATE COMMENT 'Date when the contractor demobilised from site and completed work. Nullable if service is still in progress.',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting the contractor service cost in the financial system.',
    `invoice_reference` STRING COMMENT 'Invoice number or reference submitted by the contractor for payment of this service.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this contractor service record was last updated or modified.',
    `mobilisation_date` DATE COMMENT 'Date when the contractor mobilised to site and commenced work.',
    `payment_status` STRING COMMENT 'Status of payment processing for the contractor service invoice.. Valid values are `pending|paid|disputed|cancelled`',
    `performance_rating` STRING COMMENT 'Performance rating assigned to the contractor for this service delivery, based on quality, safety, timeliness, and adherence to scope.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `permit_reference` STRING COMMENT 'Reference number of the work permit or safety permit issued for this contractor service (e.g., hot work permit, confined space permit, isolation permit).',
    `rate_unit` STRING COMMENT 'Unit of measure for the contracted rate (e.g., hourly, daily, fixed price).. Valid values are `hourly|daily|fixed_price`',
    `safety_induction_date` DATE COMMENT 'Date when the contractor completed the mandatory site safety induction.',
    `safety_induction_expiry_date` DATE COMMENT 'Expiry date of the contractors safety induction certification, after which re-induction is required.',
    `safety_induction_status` STRING COMMENT 'Status of the contractors site safety induction and compliance with Health Safety and Environment (HSE) requirements.. Valid values are `completed|pending|expired|not_required`',
    `service_description` STRING COMMENT 'Detailed description of the contractor service scope and work performed.',
    `service_status` STRING COMMENT 'Current lifecycle status of the contractor service engagement.. Valid values are `planned|in_progress|completed|cancelled|on_hold`',
    `service_type` STRING COMMENT 'Type of maintenance service provided by the contractor (e.g., preventive maintenance, corrective maintenance, shutdown support, project work, inspection, commissioning). [ENUM-REF-CANDIDATE: preventive_maintenance|corrective_maintenance|shutdown_support|project_work|inspection|commissioning|emergency_response — 7 candidates stripped; promote to reference product]',
    `shutdown_event_reference` STRING COMMENT 'Reference to the planned shutdown or turnaround event if this contractor service is part of a major shutdown scope.',
    `trade_category` STRING COMMENT 'Classification of the contractor trade or craft discipline (e.g., mechanical, electrical, instrumentation, civil, structural, piping, rigging, scaffolding). [ENUM-REF-CANDIDATE: mechanical|electrical|instrumentation|civil|structural|piping|rigging|scaffolding|insulation|painting|welding|fabrication|hvac|plumbing — 14 candidates stripped; promote to reference product]',
    CONSTRAINT pk_contractor_service PRIMARY KEY(`contractor_service_id`)
) COMMENT 'Record of contractor services engaged and executed against a maintenance work order or shutdown scope item. Captures contractor company name, purchase order reference, service description, trade category, mobilisation date, demobilisation date, contracted hours, actual hours, contracted rate, actual cost, performance rating, and safety induction status. Distinct from the procurement contract (owned by procurement domain) — this is the maintenance-domain view of contractor service delivery and cost. Sourced from Infor EAM and SAP MM.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`inspection_round` (
    `inspection_round_id` BIGINT COMMENT 'Unique identifier for the inspection round record. Primary key.',
    `asset_id` BIGINT COMMENT 'Reference to the specific asset that was inspected during this round.',
    `commissioning_activity_id` BIGINT COMMENT 'Foreign key linking to project.commissioning_activity. Business justification: Pre-commissioning and commissioning inspections are formal activities in project handover. Mining operations link inspection rounds to commissioning activities for sign-off evidence, defect tracking, ',
    `employee_id` BIGINT COMMENT 'Reference to the maintenance technician, operator, or inspector who performed the inspection round.',
    `work_order_id` BIGINT COMMENT 'Reference to the primary corrective work order created to address defects identified during this inspection round.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: inspection_round has functional_location_code (STRING) but no FK to functional_location master. One functional_location can have many inspection rounds. Adding functional_location_id FK enables linkin',
    `inspection_route_id` BIGINT COMMENT 'Foreign key linking to maintenance.inspection_route. Business justification: Inspection rounds are executed instances of inspection routes. N:1 relationship - many rounds execute the same route over time. This FK links the transactional execution record (round) to the master r',
    `inspection_template_id` BIGINT COMMENT 'Reference to the inspection template or checklist that defines the inspection points and criteria for this round.',
    `safety_observation_id` BIGINT COMMENT 'Foreign key linking to hse.safety_observation. Business justification: Inspection rounds documenting safety observations (missing guarding, housekeeping deficiencies, unsafe conditions). Standard practice: integrated asset and safety inspections by maintenance technician',
    `tsf_id` BIGINT COMMENT 'Foreign key linking to tailings.tsf. Business justification: Routine TSF inspections (daily walkarounds, weekly checks). Regulatory requirement for demonstrating systematic TSF surveillance. Links inspection findings to facilities and triggers maintenance reque',
    `waste_rock_dump_id` BIGINT COMMENT 'Foreign key linking to tailings.waste_rock_dump. Business justification: Routine dump inspections (weekly geotechnical checks, erosion monitoring). Regulatory requirement for demonstrating systematic dump surveillance. Links inspection findings to facilities and triggers m',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this inspection round requires supervisory or engineering approval before closure, typically for statutory or critical inspections.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection round was formally approved and closed.',
    `approved_by` STRING COMMENT 'Name or identifier of the supervisor, engineer, or manager who reviewed and approved the inspection round results.',
    `checkpoints_failed` STRING COMMENT 'Number of inspection checkpoints that did not meet acceptance criteria and failed inspection.',
    `checkpoints_observation` STRING COMMENT 'Number of inspection checkpoints that resulted in an observation or advisory note without constituting a failure.',
    `checkpoints_passed` STRING COMMENT 'Number of inspection checkpoints that met the acceptance criteria and passed inspection.',
    `compliance_status` STRING COMMENT 'Assessment of whether the inspected asset or location meets the applicable regulatory or statutory requirements.. Valid values are `compliant|non_compliant|conditional|not_applicable`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection round record was first created in the system.',
    `critical_defects_count` STRING COMMENT 'Number of defects classified as critical severity, requiring immediate corrective action or asset shutdown.',
    `defects_identified_count` STRING COMMENT 'Total number of defects, anomalies, or non-conformances identified during the inspection round.',
    `environmental_conditions` STRING COMMENT 'Description of environmental factors such as temperature, humidity, dust levels, or other conditions that may affect inspection results or asset condition.',
    `highest_defect_severity` STRING COMMENT 'The most severe defect classification identified during the inspection, used for prioritization and escalation.. Valid values are `critical|major|minor|none`',
    `inspection_completion_timestamp` TIMESTAMP COMMENT 'The precise date and time when the inspector completed the inspection round.',
    `inspection_date` DATE COMMENT 'The calendar date on which the inspection round was performed.',
    `inspection_notes` STRING COMMENT 'Free-text field for the inspector to record observations, context, recommendations, or any additional information relevant to the inspection round.',
    `inspection_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the inspector began the inspection round.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection round record.. Valid values are `scheduled|in_progress|completed|cancelled|overdue`',
    `inspection_type` STRING COMMENT 'Classification of the inspection round based on its purpose and regulatory or operational requirements.. Valid values are `routine|statutory|condition_based|pre_operational|post_maintenance|safety_critical`',
    `inspector_certification_number` STRING COMMENT 'Professional certification or license number of the inspector, required for statutory inspections of pressure vessels, lifting equipment, and electrical systems.',
    `inspector_name` STRING COMMENT 'Full name of the person who conducted the inspection round, captured for audit and accountability purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection round record was last updated or modified.',
    `major_defects_count` STRING COMMENT 'Number of defects classified as major severity, requiring corrective action within a defined timeframe.',
    `minor_defects_count` STRING COMMENT 'Number of defects classified as minor severity, to be addressed during planned maintenance activities.',
    `next_inspection_due_date` DATE COMMENT 'Calculated or manually set date when the next inspection round is required, based on frequency rules or regulatory intervals.',
    `overall_condition_rating` STRING COMMENT 'Summary assessment of the asset or location condition based on the inspection findings, used to trigger condition-based maintenance decisions.. Valid values are `excellent|good|fair|poor|critical`',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulation, standard, or legal requirement that mandates this inspection.',
    `round_number` STRING COMMENT 'Business identifier or sequence number for the inspection round, often used for tracking and reporting purposes.',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether this inspection round covers safety-critical equipment or systems requiring heightened compliance and documentation.',
    `shift_code` STRING COMMENT 'Identifier for the operational shift during which the inspection was performed.',
    `source_system` STRING COMMENT 'Identifier of the operational system from which this inspection round record originated, such as Infor EAM or a mobile inspection application.',
    `statutory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this inspection is required by law or regulation, such as pressure vessel, lifting equipment, or electrical system inspections.',
    `total_checkpoints` STRING COMMENT 'Total number of inspection checkpoints or items defined in the inspection template for this round.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of inspection, relevant for outdoor equipment and environmental compliance inspections.',
    `work_order_raised_flag` BOOLEAN COMMENT 'Indicates whether one or more corrective or follow-up work orders were generated as a result of this inspection.',
    CONSTRAINT pk_inspection_round PRIMARY KEY(`inspection_round_id`)
) COMMENT 'Transactional record of a completed asset inspection round performed by a maintenance technician or operator. Captures round template reference, asset or functional location, inspection date and time, inspector ID, overall condition rating, individual check results (pass/fail/observation), defects identified, defect severity, and follow-up work order raised flag. Supports statutory inspection compliance (pressure vessels, lifting equipment, electrical) and condition-based maintenance triggers.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`reliability_event` (
    `reliability_event_id` BIGINT COMMENT 'Unique identifier for the reliability engineering event record. Primary key for the reliability event entity.',
    `asset_class_id` BIGINT COMMENT 'Reference to the asset class or equipment type. Used for reliability benchmarking and identifying systemic issues across similar assets.',
    `asset_id` BIGINT COMMENT 'Reference to the asset that experienced the reliability event. Links to the equipment asset register.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to project.capital_project. Business justification: Reliability events (repeat failures, design deficiencies) on project-delivered assets are tracked against the project for warranty claims and design feedback. Mining operations link events to projects',
    `employee_id` BIGINT COMMENT 'Reference to the reliability engineer assigned to investigate and manage this event. Links to the workforce or employee register.',
    `failure_report_id` BIGINT COMMENT 'Foreign key linking to maintenance.failure_report. Business justification: reliability_event is a strategic/summary view of reliability incidents, while failure_report is the detailed corrective maintenance record. One failure_report can be referenced by one reliability_even',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order created to implement the reliability improvement action. Links to the work order management system.',
    `action_completion_date` DATE COMMENT 'Actual date when the recommended reliability improvement action was completed and verified.',
    `action_due_date` DATE COMMENT 'Target completion date for implementing the recommended reliability improvement action. Used for tracking and accountability in the reliability improvement program.',
    `action_priority` STRING COMMENT 'Priority classification for implementing the recommended action based on risk assessment, operational impact, and resource availability.. Valid values are `immediate|urgent|high|medium|low`',
    `action_status` STRING COMMENT 'Current implementation status of the recommended reliability improvement action. Tracks progress from planning through execution and completion.. Valid values are `not_started|planned|in_progress|completed|deferred|cancelled`',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred to implement the reliability improvement action. Used for cost tracking, variance analysis, and return on investment calculations for the reliability program.',
    `actual_mtbf_improvement_hours` DECIMAL(18,2) COMMENT 'Measured improvement in Mean Time Between Failures in hours, achieved after implementing the reliability improvement action. Captured through post-implementation monitoring and used to validate the effectiveness of reliability initiatives.',
    `cost_centre` STRING COMMENT 'Cost centre code responsible for the asset and associated reliability improvement costs. Used for financial tracking and accountability.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated and actual cost amounts (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the reliability event record was first created in the system. Used for audit trail and data lineage tracking.',
    `downtime_hours` DECIMAL(18,2) COMMENT 'Total equipment downtime in hours associated with this reliability event. Used to quantify operational impact and calculate Overall Equipment Effectiveness (OEE) losses.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the reliability event resulted in or had potential for environmental impact requiring environmental incident reporting and remediation.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost to implement the recommended reliability improvement action including labour, materials, contractor services, and equipment hire.',
    `estimated_mtbf_improvement_hours` DECIMAL(18,2) COMMENT 'Projected improvement in Mean Time Between Failures measured in hours, expected to result from implementing the recommended action. Used to quantify the reliability benefit and justify investment in the improvement program.',
    `event_date` DATE COMMENT 'The date when the reliability event occurred or was identified. This is the principal business event timestamp for the reliability incident.',
    `event_description` STRING COMMENT 'Detailed narrative description of the reliability event including symptoms, failure modes observed, operational context, and initial assessment findings.',
    `event_number` STRING COMMENT 'Business identifier for the reliability event, typically following a standardized numbering scheme for tracking and reporting purposes.. Valid values are `^RE-[0-9]{6,10}$`',
    `event_status` STRING COMMENT 'Current lifecycle status of the reliability event. Tracks progression from identification through investigation, action assignment, implementation, and closure. [ENUM-REF-CANDIDATE: open|under_investigation|action_assigned|in_progress|completed|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `event_type` STRING COMMENT 'Classification of the reliability event. Bad actor identifies assets with disproportionate failure rates; repeat failure indicates recurring issues; reliability improvement captures proactive enhancement opportunities; FMEA finding represents Failure Mode and Effects Analysis outcomes; chronic failure indicates persistent reliability problems; performance degradation captures declining asset performance trends.. Valid values are `bad_actor|repeat_failure|reliability_improvement|fmea_finding|chronic_failure|performance_degradation`',
    `failure_mode` STRING COMMENT 'Technical description of how the asset failed or degraded. Describes the manner in which the failure manifested (e.g., bearing seizure, hydraulic leak, electrical short, structural crack).',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified the reliability event record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the reliability event record was last updated. Used for audit trail and tracking changes to event status and actions.',
    `notes` STRING COMMENT 'Additional free-text notes and observations related to the reliability event, investigation findings, lessons learned, or implementation details not captured in structured fields.',
    `production_loss_tonnes` DECIMAL(18,2) COMMENT 'Estimated production loss in tonnes attributable to this reliability event. Quantifies the operational impact in terms of lost throughput.',
    `recommended_action` STRING COMMENT 'Detailed description of the corrective or improvement action recommended by the reliability engineer to address the event and prevent recurrence. May include design modifications, maintenance strategy changes, operational procedure updates, or component replacements.',
    `repeat_failure_count` STRING COMMENT 'Number of times this specific failure mode has occurred on this asset or asset class. Used to identify chronic reliability issues and bad actors requiring focused improvement efforts.',
    `root_cause` STRING COMMENT 'Identified underlying cause of the reliability event determined through root cause analysis. May include design deficiencies, maintenance inadequacies, operational practices, or environmental factors.',
    `safety_impact_flag` BOOLEAN COMMENT 'Indicates whether the reliability event had actual or potential safety implications requiring additional safety review and controls.',
    `severity_level` STRING COMMENT 'Assessment of the reliability event severity based on impact to operations, safety, production, and asset lifecycle. Critical events require immediate action; high severity events significantly impact operations; medium and low severity events have progressively less operational impact.. Valid values are `critical|high|medium|low`',
    `site_location_code` STRING COMMENT 'Code identifying the mine site or facility where the reliability event occurred. Used for site-level reliability performance tracking and benchmarking.',
    `source_system` STRING COMMENT 'Identifier of the source system from which the reliability event record originated (e.g., Infor EAM, CMMS, manual entry, reliability analysis tool).',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the reliability event record in the system.',
    CONSTRAINT pk_reliability_event PRIMARY KEY(`reliability_event_id`)
) COMMENT 'Reliability engineering event record capturing significant asset reliability incidents including bad actor identification, repeat failures, and reliability improvement actions. Captures event date, asset ID, event type (bad actor, repeat failure, reliability improvement, FMEA finding), description, reliability engineer assigned, recommended action, action due date, action status, and estimated reliability improvement (MTBF gain). Supports the reliability improvement program and asset lifecycle management.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`inspection_route` (
    `inspection_route_id` BIGINT COMMENT 'Primary key for inspection_route',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved this inspection route for operational use.',
    `asset_class_id` BIGINT COMMENT 'Reference to the asset class or equipment type category that this inspection route covers.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: Inspection routes cover specific functional locations or areas within the mine site. N:1 relationship - each route is primarily associated with one functional location (though may span multiple checkp',
    `inspection_template_id` BIGINT COMMENT 'Foreign key linking to maintenance.inspection_template. Business justification: Inspection routes follow standardized templates/checklists. N:1 relationship - many routes can use the same template. This FK allows routes to inherit template structure (checklist items, required cer',
    `owner_employee_id` BIGINT COMMENT 'Reference to the employee who owns and maintains this inspection route definition.',
    `site_id` BIGINT COMMENT 'Reference to the mining site or facility where this inspection route is executed.',
    `work_centre_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_centre. Business justification: Inspection routes are managed and executed by specific work centres (e.g., reliability team, operations crew). N:1 relationship - many routes assigned to one work centre. This FK establishes ownership',
    `parent_inspection_route_id` BIGINT COMMENT 'Self-referencing FK on inspection_route (parent_inspection_route_id)',
    `approval_status` STRING COMMENT 'Current approval state of the inspection route in the review and authorization workflow.',
    `approved_date` DATE COMMENT 'Date when the inspection route was formally approved for use.',
    `checkpoint_count` STRING COMMENT 'Total number of inspection checkpoints or stops included in this route.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection route record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date when this inspection route is no longer active or has been retired.',
    `effective_start_date` DATE COMMENT 'Date when this inspection route becomes active and available for scheduling.',
    `estimated_duration_minutes` STRING COMMENT 'Expected time in minutes required to complete the full inspection route.',
    `frequency_unit` STRING COMMENT 'Unit of measure for the inspection frequency value (e.g., daily, weekly, monthly).',
    `frequency_value` STRING COMMENT 'Numeric value representing how often the inspection route should be executed.',
    `last_review_date` DATE COMMENT 'Date when the inspection route was last reviewed and validated for accuracy and relevance.',
    `mobile_enabled` BOOLEAN COMMENT 'Indicates whether this inspection route can be executed using mobile devices or tablets.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection route record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of the inspection route definition.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the inspection route.',
    `priority_level` STRING COMMENT 'Priority classification of the inspection route determining scheduling precedence and resource allocation.',
    `regulatory_requirement` STRING COMMENT 'Reference to specific regulatory or compliance requirement mandating this inspection route.',
    `required_certification` STRING COMMENT 'Specific certifications or qualifications required for inspectors performing this route.',
    `required_skill_level` STRING COMMENT 'Minimum competency level required for personnel assigned to execute this inspection route.',
    `requires_lockout_tagout` BOOLEAN COMMENT 'Indicates whether lockout/tagout procedures are required for equipment isolation during inspection.',
    `requires_permit` BOOLEAN COMMENT 'Indicates whether a work permit is required before executing this inspection route.',
    `requires_shutdown` BOOLEAN COMMENT 'Indicates whether equipment or process shutdown is required to perform the inspection route.',
    `route_code` STRING COMMENT 'Business identifier code for the inspection route, used for external reference and reporting.',
    `route_description` STRING COMMENT 'Detailed description of the inspection route including scope, objectives, and special instructions.',
    `route_name` STRING COMMENT 'Human-readable name of the inspection route describing its purpose or coverage area.',
    `route_status` STRING COMMENT 'Current lifecycle status of the inspection route indicating whether it is in use or available for scheduling.',
    `route_type` STRING COMMENT 'Classification of the inspection route based on its execution pattern and purpose.',
    `safety_classification` STRING COMMENT 'Safety risk category of the inspection route determining required safety protocols and permits.',
    `version_number` STRING COMMENT 'Version identifier for the inspection route definition tracking changes and revisions.',
    CONSTRAINT pk_inspection_route PRIMARY KEY(`inspection_route_id`)
) COMMENT 'Master reference table for inspection_route. Referenced by inspection_route_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`inspection_template` (
    `inspection_template_id` BIGINT COMMENT 'Primary key for inspection_template',
    `department_id` BIGINT COMMENT 'Reference to the maintenance department or organizational unit responsible for this inspection template.',
    `site_id` BIGINT COMMENT 'Reference to the mining site or facility where this inspection template is primarily used.',
    `parent_inspection_template_id` BIGINT COMMENT 'Self-referencing FK on inspection_template (parent_inspection_template_id)',
    `approved_by` STRING COMMENT 'Name or identifier of the authority who approved this inspection template for operational use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection template was formally approved.',
    `asset_class` STRING COMMENT 'The class or type of mining assets this inspection template is designed for (e.g., haul trucks, crushers, conveyors, draglines).',
    `checklist_item_count` STRING COMMENT 'Total number of inspection points or checklist items included in this template.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost in local currency to execute one inspection using this template including labor and materials.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection template record was first created in the system.',
    `effective_from_date` DATE COMMENT 'Date from which this inspection template version becomes valid and available for use.',
    `effective_to_date` DATE COMMENT 'Date until which this inspection template version remains valid. Null indicates no expiration.',
    `equipment_type` STRING COMMENT 'Specific equipment type or model family this template applies to within the asset class.',
    `estimated_duration_minutes` STRING COMMENT 'Expected time in minutes required to complete an inspection using this template for resource planning.',
    `inspection_category` STRING COMMENT 'Primary category of inspection work covered by this template.',
    `inspection_frequency_days` STRING COMMENT 'Recommended frequency in days between inspections when using this template for time-based maintenance scheduling.',
    `inspection_frequency_hours` STRING COMMENT 'Recommended frequency in operating hours between inspections for usage-based maintenance scheduling.',
    `last_modified_by` STRING COMMENT 'Name or identifier of the person who last modified this inspection template.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection template record was last updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this inspection template.',
    `notes` STRING COMMENT 'Additional notes, instructions, or contextual information about the inspection template for users.',
    `priority_level` STRING COMMENT 'Business priority classification for scheduling and resource allocation of inspections using this template.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this inspection is mandated by regulatory or statutory requirements.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation, standard, or statutory requirement this inspection template addresses.',
    `required_certifications` STRING COMMENT 'Comma-separated list of mandatory certifications or qualifications required to perform this inspection.',
    `required_skill_level` STRING COMMENT 'Minimum competency level required for personnel performing inspections using this template.',
    `requires_permit_flag` BOOLEAN COMMENT 'Indicates whether a work permit or isolation certificate is required before performing this inspection.',
    `requires_shutdown_flag` BOOLEAN COMMENT 'Indicates whether the inspection requires equipment shutdown or can be performed during operation.',
    `review_frequency_months` STRING COMMENT 'Frequency in months at which this inspection template should be reviewed and updated to ensure continued relevance.',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether this inspection template covers safety-critical equipment or processes requiring heightened compliance.',
    `inspection_template_status` STRING COMMENT 'Current lifecycle status of the inspection template indicating its availability for use.',
    `template_code` STRING COMMENT 'Unique business identifier code for the inspection template used for external reference and system integration.',
    `template_description` STRING COMMENT 'Detailed description of the inspection template including its objectives, scope, and application context.',
    `template_name` STRING COMMENT 'Human-readable name of the inspection template describing its purpose and scope.',
    `template_type` STRING COMMENT 'Classification of the inspection template by maintenance strategy type.',
    `version_number` STRING COMMENT 'Version identifier for the inspection template following semantic versioning to track template evolution.',
    `created_by` STRING COMMENT 'Name or identifier of the person who created this inspection template.',
    CONSTRAINT pk_inspection_template PRIMARY KEY(`inspection_template_id`)
) COMMENT 'Master reference table for inspection_template. Referenced by inspection_template_id.';

CREATE OR REPLACE TABLE `mining_ecm`.`maintenance`.`work_centre` (
    `work_centre_id` BIGINT COMMENT 'Primary key for work_centre',
    `calendar_id` BIGINT COMMENT 'Reference to the work calendar defining working days, holidays, and shutdown periods for this work centre.',
    `cost_centre_id` BIGINT COMMENT 'Reference to the financial cost centre used for charging maintenance labor and overhead costs incurred by this work centre.',
    `department_id` BIGINT COMMENT 'Reference to the maintenance department or organizational unit that owns and operates this work centre.',
    `functional_location_id` BIGINT COMMENT 'Foreign key linking to maintenance.functional_location. Business justification: Work centres are physically located at functional locations within the mine site. N:1 relationship - many work centres can exist at one functional location. This FK provides the physical/logical posit',
    `site_id` BIGINT COMMENT 'Reference to the mining site or facility where this work centre is located.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who supervises and manages the work centre operations and workforce.',
    `parent_work_centre_id` BIGINT COMMENT 'Self-referencing FK on work_centre (parent_work_centre_id)',
    `backlog_hours` DECIMAL(18,2) COMMENT 'Current backlog of planned maintenance work hours assigned to this work centre but not yet completed.',
    `capacity_hours_per_day` DECIMAL(18,2) COMMENT 'Total available productive hours per day for this work centre based on crew size and shift patterns.',
    `cmms_system_code` STRING COMMENT 'Work centre identifier in the source CMMS system (Infor EAM) for integration and reconciliation purposes.',
    `contractor_company_name` STRING COMMENT 'Name of the contracting company managing this work centre if contractor-managed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work centre record was first created in the system.',
    `crew_size` STRING COMMENT 'Number of maintenance personnel assigned to this work centre on a standard shift.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial amounts associated with this work centre.',
    `work_centre_description` STRING COMMENT 'Detailed description of the work centres purpose, capabilities, and scope of maintenance activities performed.',
    `effective_from_date` DATE COMMENT 'Date from which this work centre became operational and available for work order assignment.',
    `effective_to_date` DATE COMMENT 'Date on which this work centre ceased operations or was decommissioned. Null for active work centres.',
    `equipment_asset_class` STRING COMMENT 'Primary asset class or equipment type that this work centre is specialized to maintain (e.g., haul trucks, crushers, conveyors).',
    `is_contractor_managed` BOOLEAN COMMENT 'Indicates whether this work centre is operated by external contractors rather than internal maintenance personnel.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this work centre record was last updated or modified.',
    `work_centre_name` STRING COMMENT 'Human-readable name of the work centre describing its function or location within the maintenance organization.',
    `planning_group` STRING COMMENT 'Maintenance planning group responsible for scheduling and coordinating work orders assigned to this work centre.',
    `safety_certification_required` STRING COMMENT 'List of mandatory safety certifications or qualifications required for personnel working in this work centre.',
    `shift_pattern` STRING COMMENT 'Operating shift pattern for the work centre defining when maintenance activities can be performed.',
    `standard_hourly_rate` DECIMAL(18,2) COMMENT 'Standard labor cost rate per hour for work performed by this work centre, used for maintenance cost estimation and actuals.',
    `work_centre_status` STRING COMMENT 'Current operational status of the work centre indicating its availability for work order assignment and execution.',
    `trade_specialization` STRING COMMENT 'Specific trade skills or technical specialization of the work centre workforce (e.g., hydraulics, welding, conveyor systems).',
    `utilization_target_percent` DECIMAL(18,2) COMMENT 'Target utilization percentage for productive maintenance work hours as a proportion of available capacity.',
    `work_centre_code` STRING COMMENT 'Externally-known unique business identifier for the work centre used in maintenance planning and work order assignment.',
    `work_centre_type` STRING COMMENT 'Classification of the work centre based on the primary maintenance discipline or trade specialization.',
    CONSTRAINT pk_work_centre PRIMARY KEY(`work_centre_id`)
) COMMENT 'Master reference table for work_centre. Referenced by work_centre_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `mining_ecm`.`maintenance`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ADD CONSTRAINT `fk_maintenance_work_order_standard_job_id` FOREIGN KEY (`standard_job_id`) REFERENCES `mining_ecm`.`maintenance`.`standard_job`(`standard_job_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_standard_job_id` FOREIGN KEY (`standard_job_id`) REFERENCES `mining_ecm`.`maintenance`.`standard_job`(`standard_job_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_task_plan_standard_job_id` FOREIGN KEY (`task_plan_standard_job_id`) REFERENCES `mining_ecm`.`maintenance`.`standard_job`(`standard_job_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ADD CONSTRAINT `fk_maintenance_work_order_task_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_standard_job_id` FOREIGN KEY (`standard_job_id`) REFERENCES `mining_ecm`.`maintenance`.`standard_job`(`standard_job_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_strategy_id` FOREIGN KEY (`strategy_id`) REFERENCES `mining_ecm`.`maintenance`.`strategy`(`strategy_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ADD CONSTRAINT `fk_maintenance_pm_schedule_work_centre_id` FOREIGN KEY (`work_centre_id`) REFERENCES `mining_ecm`.`maintenance`.`work_centre`(`work_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ADD CONSTRAINT `fk_maintenance_asset_bom_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `mining_ecm`.`maintenance`.`spare_part`(`spare_part_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_spare_part_id` FOREIGN KEY (`spare_part_id`) REFERENCES `mining_ecm`.`maintenance`.`spare_part`(`spare_part_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ADD CONSTRAINT `fk_maintenance_parts_consumption_work_order_task_id` FOREIGN KEY (`work_order_task_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order_task`(`work_order_task_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ADD CONSTRAINT `fk_maintenance_labour_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ADD CONSTRAINT `fk_maintenance_labour_record_work_order_task_id` FOREIGN KEY (`work_order_task_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order_task`(`work_order_task_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ADD CONSTRAINT `fk_maintenance_equipment_downtime_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_equipment_downtime_id` FOREIGN KEY (`equipment_downtime_id`) REFERENCES `mining_ecm`.`maintenance`.`equipment_downtime`(`equipment_downtime_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_previous_failure_report_id` FOREIGN KEY (`previous_failure_report_id`) REFERENCES `mining_ecm`.`maintenance`.`failure_report`(`failure_report_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ADD CONSTRAINT `fk_maintenance_failure_report_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ADD CONSTRAINT `fk_maintenance_shutdown_plan_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ADD CONSTRAINT `fk_maintenance_maintenance_shutdown_scope_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ADD CONSTRAINT `fk_maintenance_maintenance_shutdown_scope_shutdown_plan_id` FOREIGN KEY (`shutdown_plan_id`) REFERENCES `mining_ecm`.`maintenance`.`shutdown_plan`(`shutdown_plan_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ADD CONSTRAINT `fk_maintenance_maintenance_shutdown_scope_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_inspection_round_id` FOREIGN KEY (`inspection_round_id`) REFERENCES `mining_ecm`.`maintenance`.`inspection_round`(`inspection_round_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_inspection_route_id` FOREIGN KEY (`inspection_route_id`) REFERENCES `mining_ecm`.`maintenance`.`inspection_route`(`inspection_route_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ADD CONSTRAINT `fk_maintenance_condition_monitoring_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`request` ADD CONSTRAINT `fk_maintenance_request_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ADD CONSTRAINT `fk_maintenance_work_order_cost_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ADD CONSTRAINT `fk_maintenance_permit_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ADD CONSTRAINT `fk_maintenance_standard_job_work_centre_id` FOREIGN KEY (`work_centre_id`) REFERENCES `mining_ecm`.`maintenance`.`work_centre`(`work_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ADD CONSTRAINT `fk_maintenance_functional_location_parent_fl_functional_location_id` FOREIGN KEY (`parent_fl_functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ADD CONSTRAINT `fk_maintenance_contractor_service_maintenance_shutdown_scope_id` FOREIGN KEY (`maintenance_shutdown_scope_id`) REFERENCES `mining_ecm`.`maintenance`.`maintenance_shutdown_scope`(`maintenance_shutdown_scope_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ADD CONSTRAINT `fk_maintenance_contractor_service_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ADD CONSTRAINT `fk_maintenance_contractor_service_work_order_task_id` FOREIGN KEY (`work_order_task_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order_task`(`work_order_task_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_inspection_route_id` FOREIGN KEY (`inspection_route_id`) REFERENCES `mining_ecm`.`maintenance`.`inspection_route`(`inspection_route_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ADD CONSTRAINT `fk_maintenance_inspection_round_inspection_template_id` FOREIGN KEY (`inspection_template_id`) REFERENCES `mining_ecm`.`maintenance`.`inspection_template`(`inspection_template_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_failure_report_id` FOREIGN KEY (`failure_report_id`) REFERENCES `mining_ecm`.`maintenance`.`failure_report`(`failure_report_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ADD CONSTRAINT `fk_maintenance_reliability_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `mining_ecm`.`maintenance`.`work_order`(`work_order_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` ADD CONSTRAINT `fk_maintenance_inspection_route_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` ADD CONSTRAINT `fk_maintenance_inspection_route_inspection_template_id` FOREIGN KEY (`inspection_template_id`) REFERENCES `mining_ecm`.`maintenance`.`inspection_template`(`inspection_template_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` ADD CONSTRAINT `fk_maintenance_inspection_route_work_centre_id` FOREIGN KEY (`work_centre_id`) REFERENCES `mining_ecm`.`maintenance`.`work_centre`(`work_centre_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` ADD CONSTRAINT `fk_maintenance_inspection_route_parent_inspection_route_id` FOREIGN KEY (`parent_inspection_route_id`) REFERENCES `mining_ecm`.`maintenance`.`inspection_route`(`inspection_route_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_template` ADD CONSTRAINT `fk_maintenance_inspection_template_parent_inspection_template_id` FOREIGN KEY (`parent_inspection_template_id`) REFERENCES `mining_ecm`.`maintenance`.`inspection_template`(`inspection_template_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_centre` ADD CONSTRAINT `fk_maintenance_work_centre_functional_location_id` FOREIGN KEY (`functional_location_id`) REFERENCES `mining_ecm`.`maintenance`.`functional_location`(`functional_location_id`);
ALTER TABLE `mining_ecm`.`maintenance`.`work_centre` ADD CONSTRAINT `fk_maintenance_work_centre_parent_work_centre_id` FOREIGN KEY (`parent_work_centre_id`) REFERENCES `mining_ecm`.`maintenance`.`work_centre`(`work_centre_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`maintenance` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `mining_ecm`.`maintenance` SET TAGS ('dbx_domain' = 'maintenance');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Community Commitment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `geotechnical_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Grievance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Audit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `management_of_change_id` SET TAGS ('dbx_business_glossary_term' = 'Management Of Change Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Pm Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `programme_of_work_id` SET TAGS ('dbx_business_glossary_term' = 'Programme Of Work Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `project_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Project Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `standard_job_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Job Id (Foreign Key)');
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
ALTER TABLE `mining_ecm`.`maintenance`.`work_order` ALTER COLUMN `cost_centre` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre');
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
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Crew Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `schedule_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Activity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `standard_job_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Job Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_task` ALTER COLUMN `task_plan_standard_job_id` SET TAGS ('dbx_business_glossary_term' = 'Task Plan Identifier (ID)');
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
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'planning_strategy');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Reliability Engineer ID');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `geotechnical_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `standard_job_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Job Plan ID');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `strategy_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`pm_schedule` ALTER COLUMN `work_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Work Centre ID');
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
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` SET TAGS ('dbx_subdomain' = 'asset_configuration');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `asset_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bill of Materials (BOM) Identifier');
ALTER TABLE `mining_ecm`.`maintenance`.`asset_bom` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
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
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` SET TAGS ('dbx_subdomain' = 'asset_configuration');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `chemical_register_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `procurement_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
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
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `warranty_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiry Date');
ALTER TABLE `mining_ecm`.`maintenance`.`spare_part` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (Kilograms)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `parts_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Parts Consumption ID');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `chemical_register_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issued By Employee ID');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `work_order_task_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Task ID');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `aisc_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'All-In Sustaining Cost (AISC) Allocation Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `bin_location` SET TAGS ('dbx_business_glossary_term' = 'Bin Location');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `core_charge_flag` SET TAGS ('dbx_business_glossary_term' = 'Core Charge Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Code');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`maintenance`.`parts_consumption` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
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
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Training Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `work_order_task_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Task ID');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `cost_centre` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Labour End Time');
ALTER TABLE `mining_ecm`.`maintenance`.`labour_record` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
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
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` SET TAGS ('dbx_subdomain' = 'reliability_performance');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `equipment_downtime_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Downtime ID');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `grievance_id` SET TAGS ('dbx_business_glossary_term' = 'Related Grievance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `action_code` SET TAGS ('dbx_business_glossary_term' = 'Action Code');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `actual_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Repair Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'Cause Code');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `cost_centre` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre');
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
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `secondary_failure_code` SET TAGS ('dbx_business_glossary_term' = 'Secondary Failure Code');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing|roster_a|roster_b');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'infor_eam|caterpillar_minestar|manual_entry|scada');
ALTER TABLE `mining_ecm`.`maintenance`.`equipment_downtime` ALTER COLUMN `work_centre` SET TAGS ('dbx_business_glossary_term' = 'Work Centre');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` SET TAGS ('dbx_subdomain' = 'reliability_performance');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `failure_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Report ID');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `equipment_downtime_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Downtime Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `geotechnical_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `downtime_event_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Downtime Event Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `previous_failure_report_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Failure Report ID');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Engineer ID');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `quaternary_failure_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `quaternary_failure_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `quaternary_failure_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `tertiary_failure_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `tertiary_failure_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `tertiary_failure_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
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
ALTER TABLE `mining_ecm`.`maintenance`.`failure_report` ALTER COLUMN `functional_location` SET TAGS ('dbx_business_glossary_term' = 'Functional Location');
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
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` SET TAGS ('dbx_subdomain' = 'planning_strategy');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `shutdown_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Plan ID');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `engagement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Plan Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `stakeholder_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Affected Stakeholder Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Superintendent ID');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `quaternary_shutdown_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By ID');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `quaternary_shutdown_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `quaternary_shutdown_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `tertiary_shutdown_created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By ID');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `tertiary_shutdown_created_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `tertiary_shutdown_created_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
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
ALTER TABLE `mining_ecm`.`maintenance`.`shutdown_plan` ALTER COLUMN `risk_assessment_reference` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Reference');
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
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` SET TAGS ('dbx_subdomain' = 'planning_strategy');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `maintenance_shutdown_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Scope Item Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Contractor Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Supervisor Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `project_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Project Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `shutdown_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Plan Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `actual_labour_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labour Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `bill_of_materials_reference` SET TAGS ('dbx_business_glossary_term' = 'Bill of Materials (BOM) Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `cost_centre` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `estimated_labour_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labour Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `isolation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Isolation Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `predecessor_scope_items` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Scope Items');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `safety_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Description');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `scope_item_number` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Number');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Status');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_value_regex' = 'planned|approved|in_progress|completed|cancelled|deferred');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `scope_type` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Type');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `scope_type` SET TAGS ('dbx_value_regex' = 'preventive_maintenance|corrective_maintenance|inspection|overhaul|replacement|upgrade');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `standard_job_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Job Code');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `trade_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Code');
ALTER TABLE `mining_ecm`.`maintenance`.`maintenance_shutdown_scope` ALTER COLUMN `trade_description` SET TAGS ('dbx_business_glossary_term' = 'Trade Description');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` SET TAGS ('dbx_subdomain' = 'reliability_performance');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `condition_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Monitoring ID');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `commissioning_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `component_register_id` SET TAGS ('dbx_business_glossary_term' = 'Component Register Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `geotechnical_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Geotechnical Instrument Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `inspection_round_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Round Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `inspection_route_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Route ID');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument ID');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `safety_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`condition_monitoring` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
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
ALTER TABLE `mining_ecm`.`maintenance`.`request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`request` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request ID');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee ID');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `converted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Converted Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `cost_centre` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `date_raised` SET TAGS ('dbx_business_glossary_term' = 'Date Raised');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `date_required` SET TAGS ('dbx_business_glossary_term' = 'Date Required');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `estimated_downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Downtime Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `fault_description` SET TAGS ('dbx_business_glossary_term' = 'Fault Description');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `functional_location` SET TAGS ('dbx_business_glossary_term' = 'Functional Location');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `planner_notes` SET TAGS ('dbx_business_glossary_term' = 'Planner Notes');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `production_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Production Impact Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Number');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^MR-[0-9]{8}$');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'open|under_review|approved|rejected|converted|cancelled');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Type');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|predictive|inspection|modification|emergency');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `requestor_contact_number` SET TAGS ('dbx_business_glossary_term' = 'Requestor Contact Number');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `requestor_contact_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `requestor_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `requestor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'infor_eam|mobile_app|scada_alarm|operator_logbook|inspection_system');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `mining_ecm`.`maintenance`.`request` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `work_order_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Cost ID');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
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
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_centre` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `cost_centre` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
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
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `labour_cost` SET TAGS ('dbx_business_glossary_term' = 'Labour Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `other_cost` SET TAGS ('dbx_business_glossary_term' = 'Other Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `parts_materials_cost` SET TAGS ('dbx_business_glossary_term' = 'Parts and Materials Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `sap_co_order_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Controlling (CO) Order Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `sap_co_order_reference` SET TAGS ('dbx_value_regex' = '^[0-9]{10,12}$');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `total_actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `total_estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`work_order_cost` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Permit ID');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `commissioning_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `cultural_heritage_site_id` SET TAGS ('dbx_business_glossary_term' = 'Cultural Heritage Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `heritage_clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Heritage Clearance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By Employee ID');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `permit_issuing_authority_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Employee ID');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `permit_issuing_authority_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `permit_issuing_authority_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `permit_site_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Site Supervisor Employee ID');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `permit_site_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `permit_site_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `atmospheric_testing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Atmospheric Testing Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `authorized_personnel` SET TAGS ('dbx_business_glossary_term' = 'Authorized Personnel');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `closure_signature` SET TAGS ('dbx_business_glossary_term' = 'Permit Closure Signature');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit End Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `extension_count` SET TAGS ('dbx_business_glossary_term' = 'Permit Extension Count');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `fire_watch_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Fire Watch Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `functional_location` SET TAGS ('dbx_business_glossary_term' = 'Functional Location');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `functional_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-[A-Z0-9]{2,4}-[A-Z0-9]{2,6}$');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `hazard_identification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identification');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `isolation_points` SET TAGS ('dbx_business_glossary_term' = 'Isolation Points');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issued Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `issuer_signature` SET TAGS ('dbx_business_glossary_term' = 'Permit Issuer Signature');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work (PTW) Number');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_value_regex' = '^PTW-[A-Z0-9]{8,12}$');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'draft|issued|active|suspended|closed|cancelled');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'isolation|confined_space_entry|hot_work|working_at_heights|electrical_isolation|excavation');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `receiver_signature` SET TAGS ('dbx_business_glossary_term' = 'Permit Receiver Signature');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `required_ppe` SET TAGS ('dbx_business_glossary_term' = 'Required Personal Protective Equipment (PPE)');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `rescue_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Rescue Plan Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `risk_assessment_reference` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `site_supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Site Supervisor Name');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Infor_EAM|IsoMetrix|Manual');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `special_precautions` SET TAGS ('dbx_business_glossary_term' = 'Special Precautions');
ALTER TABLE `mining_ecm`.`maintenance`.`permit` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Start Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` SET TAGS ('dbx_subdomain' = 'planning_strategy');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `standard_job_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Job Plan (SJP) ID');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `work_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Work Centre Id (Foreign Key)');
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
ALTER TABLE `mining_ecm`.`maintenance`.`standard_job` ALTER COLUMN `parts_list_attached_flag` SET TAGS ('dbx_business_glossary_term' = 'Parts List Attached Flag');
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
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` SET TAGS ('dbx_subdomain' = 'asset_configuration');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location (FL) ID');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `cultural_heritage_site_id` SET TAGS ('dbx_business_glossary_term' = 'Nearest Cultural Heritage Site Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `orebody_id` SET TAGS ('dbx_business_glossary_term' = 'Orebody Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `parent_fl_functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Functional Location (FL) ID');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`functional_location` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
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
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` SET TAGS ('dbx_subdomain' = 'planning_strategy');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy ID');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `strategy_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Reliability Engineer ID');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `strategy_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `strategy_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Strategy Approval Date');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `condition_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Condition Monitoring Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`strategy` ALTER COLUMN `cost_centre` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre');
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
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` SET TAGS ('dbx_subdomain' = 'work_execution');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `contractor_service_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Service ID');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Counterparty Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `contractor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `local_employment_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Local Employment Commitment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `maintenance_shutdown_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Scope Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `project_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Project Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Training Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `work_order_task_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Task ID');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `contracted_hours` SET TAGS ('dbx_business_glossary_term' = 'Contracted Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `cost_centre` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `demobilisation_date` SET TAGS ('dbx_business_glossary_term' = 'Demobilisation Date');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Invoice Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `mobilisation_date` SET TAGS ('dbx_business_glossary_term' = 'Mobilisation Date');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|disputed|cancelled');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `permit_reference` SET TAGS ('dbx_business_glossary_term' = 'Permit Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'hourly|daily|fixed_price');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `safety_induction_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Induction Date');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `safety_induction_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Induction Expiry Date');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `safety_induction_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Induction Status');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `safety_induction_status` SET TAGS ('dbx_value_regex' = 'completed|pending|expired|not_required');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|on_hold');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `shutdown_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Shutdown Event Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`contractor_service` ALTER COLUMN `trade_category` SET TAGS ('dbx_business_glossary_term' = 'Trade Category');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` SET TAGS ('dbx_subdomain' = 'reliability_performance');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_round_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Round ID');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `commissioning_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Activity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_route_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Route Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_template_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Template ID');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `safety_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `tsf_id` SET TAGS ('dbx_business_glossary_term' = 'Tsf Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `waste_rock_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Rock Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `checkpoints_failed` SET TAGS ('dbx_business_glossary_term' = 'Checkpoints Failed');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `checkpoints_observation` SET TAGS ('dbx_business_glossary_term' = 'Checkpoints with Observation');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `checkpoints_passed` SET TAGS ('dbx_business_glossary_term' = 'Checkpoints Passed');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|not_applicable');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `critical_defects_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Defects Count');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `defects_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Defects Identified Count');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `environmental_conditions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Conditions');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `highest_defect_severity` SET TAGS ('dbx_business_glossary_term' = 'Highest Defect Severity');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `highest_defect_severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|none');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completion Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|overdue');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|statutory|condition_based|pre_operational|post_maintenance|safety_critical');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `major_defects_count` SET TAGS ('dbx_business_glossary_term' = 'Major Defects Count');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `minor_defects_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Defects Count');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `overall_condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Condition Rating');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `overall_condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `round_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Round Number');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `statutory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Statutory Compliance Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `total_checkpoints` SET TAGS ('dbx_business_glossary_term' = 'Total Checkpoints');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_round` ALTER COLUMN `work_order_raised_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Order Raised Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` SET TAGS ('dbx_subdomain' = 'reliability_performance');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `reliability_event_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Event ID');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Engineer ID');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `failure_report_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Report Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Action Completion Date');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Due Date');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `action_priority` SET TAGS ('dbx_business_glossary_term' = 'Action Priority');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `action_priority` SET TAGS ('dbx_value_regex' = 'immediate|urgent|high|medium|low');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'not_started|planned|in_progress|completed|deferred|cancelled');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `actual_mtbf_improvement_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Mean Time Between Failures (MTBF) Improvement Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `cost_centre` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `downtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Downtime Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `estimated_mtbf_improvement_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Mean Time Between Failures (MTBF) Improvement Hours');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Reliability Event Number');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^RE-[0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'bad_actor|repeat_failure|reliability_improvement|fmea_finding|chronic_failure|performance_degradation');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `production_loss_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Production Loss Tonnes');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `repeat_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Repeat Failure Count');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `safety_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Flag');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `site_location_code` SET TAGS ('dbx_business_glossary_term' = 'Site Location Code');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `mining_ecm`.`maintenance`.`reliability_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` SET TAGS ('dbx_subdomain' = 'reliability_performance');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` ALTER COLUMN `inspection_route_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Route Identifier');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` ALTER COLUMN `inspection_template_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Template Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` ALTER COLUMN `work_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Work Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_route` ALTER COLUMN `parent_inspection_route_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_template` SET TAGS ('dbx_subdomain' = 'reliability_performance');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_template` ALTER COLUMN `inspection_template_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Template Identifier');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_template` ALTER COLUMN `parent_inspection_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`inspection_template` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`work_centre` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`maintenance`.`work_centre` SET TAGS ('dbx_subdomain' = 'asset_configuration');
ALTER TABLE `mining_ecm`.`maintenance`.`work_centre` ALTER COLUMN `work_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Work Centre Identifier');
ALTER TABLE `mining_ecm`.`maintenance`.`work_centre` ALTER COLUMN `functional_location_id` SET TAGS ('dbx_business_glossary_term' = 'Functional Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`maintenance`.`work_centre` ALTER COLUMN `parent_work_centre_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`maintenance`.`work_centre` ALTER COLUMN `standard_hourly_rate` SET TAGS ('dbx_confidential' = 'true');
